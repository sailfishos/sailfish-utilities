import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Restart Home Screen"
    actionName: qsTrId("sailfish-tools-restart-ui")
    deviceLockRequired: false
    //% "Restart Home Screen, closing all runnning applications. "
    //% "It'd be helpful if some application is hanged or can't be started, or "
    //% "user experience any issues with keyboard, clipboard, home screen etc."
    description: qsTrId("sailfish-utilities-restart-ui-desc")

    function action(on_reply, on_error) {
        tools.request("restartLipstick", {}, {
            on_reply: on_reply, on_error: on_error
        });
    }
}
