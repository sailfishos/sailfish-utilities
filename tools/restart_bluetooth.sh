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

service_do restart bluetooth
systemctl is-active --quiet bluetooth-rfkill-event && service_do restart bluetooth-rfkill-event
systemctl is-active --quiet bluebinder             && service_do restart bluebinder
