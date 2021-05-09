import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Bluetooth"
    title: qsTrId("sailfish-tools-he-bluetooth")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart Bluetooth subsystem, which may help if you're "
    //% "having trouble scanning or connecting to a Bluetooth "
    //% "device which worked previously."
    description: qsTrId("sailfish-utilities-me-restart_bluetooth_desc")

    function action(on_reply, on_error) {
        UtilTools.restartBluetooth(on_reply, on_error)
    }
}
