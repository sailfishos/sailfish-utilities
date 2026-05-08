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

global_bluetooth_blocked() {
    rfkill list 2>/dev/null | awk '
        /^[0-9]+: bluetooth: Bluetooth$/ {
            bluetooth = 1
            next
        }
        /^[0-9]+:/ {
            bluetooth = 0
        }
        bluetooth && /Soft blocked: yes/ {
            found = 1
        }
        END {
            exit found ? 0 : 1
        }
    '
}

enable_bluetooth() {
    if systemctl is-active --quiet connman.service &&
            command -v connmanctl >/dev/null 2>&1; then
        connmanctl enable bluetooth >/dev/null 2>&1 && return 0
        warning "Failed to enable Bluetooth through ConnMan"
    fi

    if command -v rfkill >/dev/null 2>&1; then
        rfkill unblock bluetooth >/dev/null 2>&1 && return 0
        warning "Failed to unblock Bluetooth rfkill"
    fi

    return 1
}

global_bluetooth_blocked && enable_bluetooth

service_do restart bluetooth
systemctl is-active --quiet bluetooth-rfkill-event    && service_do restart bluetooth-rfkill-event
systemctl is-active --quiet bluebinder                && service_do restart bluebinder
systemctl is-active --quiet appsupport-bridge-bt      && service_do restart appsupport-bridge-bt
systemctl is-active --quiet appsupport-bridge-bt-aidl && service_do restart appsupport-bridge-bt-aidl

global_bluetooth_blocked && enable_bluetooth
