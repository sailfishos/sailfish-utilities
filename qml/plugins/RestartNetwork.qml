import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Network"
    title: qsTrId("sailfish-tools-he-network")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart network subsystem if anything wrong happened with "
    //% "connectivity (WLAN, mobile data)."
    description: qsTrId("sailfish-utilities-me-restart-network-desc")

    function action(on_reply, on_error) {
        UtilTools.restartNetwork(on_reply, on_error)
    }
}
