import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0
import Nemo.DBus 2.0

ActionItem {
    //% "Audio"
    title: qsTrId("sailfish-tools-he-audio")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart Audio subsystem, which may help if you lose audio."
    description: qsTrId("sailfish-utilities-me-restart-audio-desc")

    DBusInterface {
        id: service
        bus: DBus.SessionBus
        service: 'org.freedesktop.systemd1'
        path: '/org/freedesktop/systemd1/unit/pulseaudio_2eservice'
        iface: 'org.freedesktop.systemd1.Unit'
    }

    function action(on_reply, on_error) {
        service.call("Restart", ["replace"], on_reply, on_error)
    }
}
