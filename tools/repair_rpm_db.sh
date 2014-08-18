#!/bin/sh
if [ -f /usr/libexec/pk-rpm-db-clean ]; then
    echo "Leave request to rebuild rpm db on restart"
    mkdir -p /var/lib/PackageKit
    touch /var/lib/PackageKit/scheduled-rebuilddb
else
    echo "Manually rebuild db"
    # does not matter if other "*store*" processes will be terminated.
    # Anyway, device are going to be rebooted after this script is
    # executed
    pkill store
    pkill packagekitd
    # wait a bit and kill if needed. But packagekitd can be started by
    # means of d-bus call by any process
    sleep 4
    pkill -9 store
    pkill -9 packagekitd
    rm -f /var/lib/rpm/__db.00*
    rpm --rebuilddb
fi

