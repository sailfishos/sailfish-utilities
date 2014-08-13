#!/bin/sh
if ls /usr/libexec/pk-rpm-db-clean; then
    echo "Leave request to rebuild rpm db on restart"
    mkdir -p /var/lib/PackageKit
    touch /var/lib/PackageKit/scheduled-rebuilddb
else
    echo "Manually rebuild db and reboot"
    pkill store
    pkill packagekitd
    sleep 4
    pkill -9 store
    pkill -9 packagekitd
    rm -f /var/lib/rpm/__db.00*
    rpm --rebuilddb
fi

