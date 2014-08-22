#!/bin/bash

function list_files_to_exclude() {
    if test $# -ne 1; then
        echo "Require an argument (eg: SLE11-HAE-SP3, SLES11-SP3 or SUSE-Cloud-4)"
        exit 1
    fi

    channel=$1

    for arch in noarch x86_64; do
        pool_directory=${channel}-Pool/sle-11-x86_64/rpm/$arch
        update_directory=${channel}-Updates/sle-11-x86_64/rpm/$arch
        for package_name in $(for package in $update_directory/*; do
                                  package_no_rev=${package%-*}
                                  package_no_version=${package_no_rev%-*}
                                  basename $package_no_version
                              done |sort -u); do
            find $pool_directory -regex "$pool_directory/${package_name}-[^-]*-[^-]*"
            find $update_directory -regex "$update_directory/${package_name}-[^-]*-[^-]*" | sort | head -n -1
        done
    done
}

function create_tar_for_channel() {
    if test $# -ne 1; then
        echo "Require an argument (eg: SLE11-HAE-SP3, SLES11-SP3 or SUSE-Cloud-4)"
        exit 1
    fi

    channel=$1

    list_files_to_exclude $channel > $channel.exclude
    tar cvf $channel.tar $channel-{Pool,Updates} --exclude-from $channel.exclude
}

for channel in SUSE-Cloud-4 SLE11-HAE-SP3 SLES11-SP3; do
    create_tar_for_channel $channel
done
