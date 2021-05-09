import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Bluetooth"
    title: qsTrId("settings_bluetooth-bluetooth")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart Bluetooth subsystem"
    description: qsTrId("sailfish-utilities-me-restart-bt-desc")

    function action(on_reply, on_error) {
        UtilTools.restartBluetooth(on_reply, on_error)
    }
}
