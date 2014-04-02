#!/bin/sh
pkill store
rm -f /var/lib/rpm/__db.00*
rpm --rebuilddb

