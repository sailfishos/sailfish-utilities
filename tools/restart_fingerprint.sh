#!/bin/sh

warning() {
    printf "%s: Warning: %s\n" "$(basename $0)" "${@}" 1>&2;
}

service_do() {
    if systemctl "$1" "$2"; then
        return 0;
    else
        warning "Status $? on" "${@}"
        return 1;
    fi
}

service_do restart sailfish-fpd
sleep 3
service_do restart sailfish-fpd
