#!/bin/sh
if systemctl stop connman.service; then
    systemctl restart wlan-module-load.service
    systemctl start connman.service
else
    echo "Can't stop connman"
    exit 1
fi
