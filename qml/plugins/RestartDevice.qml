import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Device"
    title: qsTrId("sailfish-tools-he-device")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Fully restart device, closing all application and "
    //% "stopping all services"
    description: qsTrId("sailfish-utilities-restart-device-desc")

    function action(on_reply, on_error) {
        UtilTools.restartDevice(on_reply, on_error)
    }
}
