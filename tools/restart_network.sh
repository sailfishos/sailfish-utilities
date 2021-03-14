#!/bin/sh

warning() {
    printf "%s: Warning: %s\n" "$(basename $0)" "$*" 1>&2
}

service_do() {
    if systemctl "$1" "$2"; then
        return 0;
    else
        warning "Status $? on" "${@}"
        return 1;
    fi
}

service_do stop connman.service
service_do stop wpa_supplicant.service
service_do restart wlan-module-load.service
service_do start wpa_supplicant.service
service_do start connman.service
