import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Restart Alien Dalvik"
    actionName: qsTrId("sailfish-tools-restart-dalvik")
    deviceLockRequired: false
    //% "Restart subsystem providing support to run "
    //% "Android applications. Try to use it if Android applications can't be "
    //% " started or stuck etc."
    description: qsTrId("sailfish-utilities-me-restart-alien-desc")

    function action(on_reply, on_error) {
        tools.request("restartAlien", {}, {
            on_reply: on_reply, on_error: on_error
        });
    }
}
