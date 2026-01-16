import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Cellular network"
    title: qsTrId("sailfish-tools-he-cellular_network")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart cellular network subsystem."
    description: qsTrId("sailfish-utilities-me-restart-cell_network-desc")

    function action(on_reply, on_error) {
        UtilTools.restartOfono(on_reply, on_error)
    }
}
