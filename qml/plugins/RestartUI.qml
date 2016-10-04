import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Home Screen"
    title: qsTrId("sailfish-tools-he-home_screen")
    //% "Restart
    actionName: qsTrId("sailfish-tools-bt-restart")
    deviceLockRequired: false
    //% "Restart Home Screen, closing all runnning applications. "
    //% "It'd be helpful if some application is hanged or can't be started, or "
    //% "user experience any issues with keyboard, clipboard, home screen etc."
    description: qsTrId("sailfish-utilities-restart-ui-desc")

    function action(on_reply, on_error) {
        UtilTools.restartLipstick(on_reply, on_error)
    }
}
