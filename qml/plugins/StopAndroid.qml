import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Stop Android™ runtime"
    actionName: qsTrId("sailfish-tools-bt-stop-android")
    deviceLockRequired: false
    //% "Stop Android™ runtime to conserve memory and/or power."
    //% " All Android™ applications (including background"
    //% " services, e.g. instant messaging applications) will be stopped."
    //% " See also <a href='https://together.jolla.com/question/20472/why-not-shutdown-aliendalvik-after-closing-last-android-app/'>here</a>."
    description: qsTrId("sailfish-utilities-stop-alien-desc")

    function action(on_reply, on_error) {
        tools.request("stopAlien", {}, {
            on_reply: on_reply, on_error: on_error
        });
    }
}
