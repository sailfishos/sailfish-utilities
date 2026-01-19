import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0
import Nemo.DBus 2.0

ActionItem {
    //% "Keyboard"
    title: qsTrId("sailfish-tools-he-keyboard")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart the keyboard if it becomes unresponsive, keys are missing, "
    //% "or if it behaves otherwise incorrectly."
    description: qsTrId("sailfish-utilities-me-restart-keyboard-desc")

    DBusInterface {
        id: service

        bus: DBus.SessionBus
        service: 'org.freedesktop.systemd1'
        path: '/org/freedesktop/systemd1/unit/maliit_2dserver_2eservice'
        iface: 'org.freedesktop.systemd1.Unit'
    }

    function action(on_reply, on_error) {
        service.call("Restart", ["replace"], on_reply, on_error)
    }
}
