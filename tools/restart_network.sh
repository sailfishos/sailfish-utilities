#!/bin/sh

function warning {
    echo "`basename $0`: Warning: ${@:1}" 1>&2;
}

function service_do {
    if systemctl $1 $2; then
        return 0;
    else
        warning "Status $?" "on $1 $2" ${@:3}
        return 1;
    fi
}

service_do stop connman.service
service_do stop wpa_supplicant.service
service_do restart wlan-module-load.service
service_do start wpa_supplicant.service
service_do start connman.service
