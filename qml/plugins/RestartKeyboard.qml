import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Restart keyboard"
    actionName: qsTrId("sailfish-tools-restart-keyboard")
    deviceLockRequired: false
    //% "Restart keyboard if it gets stuck."
    description: qsTrId("sailfish-utilities-restart-keyboard-desc")

    function action(on_reply, on_error) {
        UtilTools.restartKeyboard(on_reply, on_error)
    }
}
