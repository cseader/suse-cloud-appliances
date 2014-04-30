#!/bin/bash
#
# This script builds .tar.bz2 files which can be used to overlay
# repositories into the appliance's /srv/tftpboot/repos directory
# at appliance build-time.  One .tar.bz2 is created per repo.

ALL_REPOS=(
    {SLES11,SLE11-HAE}-SP3-{Pool,Updates}
    SUSE-Cloud-3-{Pool,Updates}
)

warn () {
    echo >&2 "$*"
}

die () {
    warn "$*"
    exit 1
}

abort () {
    die "$*; aborting."
}

set_dirs () {
    case "$USER" in
        adam)
            : ${MIRROR_DIR:=/data/install/mirrors}
            : ${DEST_DIR:=/data/install/mirrors/tars}
            ;;
        cseader)
            : ${MIRROR_DIR:=/data/install/smt/repo/\$RCE}
            : ${DEST_DIR:=/data/install/smt}
            ;;
        *)
            : ${MIRROR_DIR:=/srv/www/htdocs/repo/\$RCE}
            : ${DEST_DIR:=/root}
            ;;
    esac
}

main () {
    set_dirs

    if ! [ -d "$DEST_DIR" ]; then
        abort "Destination $DEST_DIR is not a valid directory"
    fi

    if [ $# -gt 0 ]; then
        repos=( "$@" )
    else
        repos=( "${ALL_REPOS[@]}" )
    fi

    required_subdirs=(repodata rpm)

    first=yes

    for repo in "${repos[@]}"; do
        if [ -n "$first" ]; then
            first=
        else
            echo ------------------------------------------
        fi

        mirror="$MIRROR_DIR/$repo/sle-11-x86_64"
        for subdir in "${required_subdirs[@]}"; do
            if ! [ -d "$mirror/$subdir" ]; then
                warn "$mirror/$subdir is missing; is '$repo' really mirrored?  Skipping."
                continue 2
            fi
        done

        if ! cd "$mirror" 2>/dev/null; then
            warn "Failed to cd to $mirror; skipping."
            continue
        fi

        # The .tar.bz2 needs to be an overlay which gets unpacked from /
        prefix="srv/tftpboot/repos/$repo/"

        tar_file="$repo-$subdir.tar.bz2"
        tar_path="$DEST_DIR/$tar_file"
        subdirs=( $( find * -maxdepth 0 -type d ) )
        echo tar --transform="s,^,$prefix," -jcvf "$tar_path" "${subdirs[@]}"
        if ! tar --transform="s,^,$prefix," -jcvf "$tar_path" "${subdirs[@]}"; then
            warn "Failed to create $tar_path"
        fi
        echo "Wrote $tar_path"
    done
}

main "$@"
