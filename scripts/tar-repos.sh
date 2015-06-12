#!/bin/bash
#
# This script builds .tar.bz2 files which can be used to overlay
# repositories into the appliance's /srv/tftpboot/repos directory
# at appliance build-time.  One .tar.bz2 is created per repo.

ALL_REPOS=(
    SLES11-SP3-Pool SLES11-SP3-Updates SLE11-HAE-SP3-Pool SLE11-HAE-SP3-Updates SUSE-Cloud-5-Pool SUSE-Cloud-5-Updates Products Updates 
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
        root)
            : ${MIRROR_DIR:=/data/install/smt/repo/mini}
            : ${DEST_DIR:=/data/install/smt/tars}
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

        #mirror="$MIRROR_DIR/$repo/sle-11-x86_64"
        #for subdir in "${required_subdirs[@]}"; do
        #    if ! [ -d "$mirror/$subdir" ]; then
        #        warn "$mirror/$subdir is missing; is '$repo' really mirrored?  Skipping."
        #        continue 2
        #    fi
        #done

        if ! cd "$MIRROR_DIR" 2>/dev/null; then
            warn "Failed to cd to $mirror; skipping."
            continue
        fi

        # The .tar needs to be an overlay which gets unpacked from /
        prefix="/$repo/"

        if $repo == Products; then
           tar_file="SLE-12-Server-Pool.tar.bz2"
        elif $repo == Updates; then
           tar_file="SLE-12-Server-Updates.tar.bz2"      
        else
           tar_file="$repo.tar.bz2"
        fi
        tar_path="$DEST_DIR/$tar_file"
        #subdirs=( $( find * -maxdepth 0 -type d ) )
        #echo tar --exclude=*delta* --transform="s,^,$prefix," -jcvf "$tar_path" "$repo"
        echo tar --exclude=*delta* -jcvf "$tar_path" "$repo"
        if ! tar --exclude=*delta* -jcvf "$tar_path" "$repo"; then
            warn "Failed to create $tar_path"
        fi
        echo "Wrote $tar_path"
    done
}

main "$@"
