import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Clean package cache"
    actionName: qsTrId("sailfish-tools-clean-pkg-cache")
    //% "Package cache cleaning can be tried if there are "
    //% "problems with store, e.g. 'Critical problem with the app registry' error. "
    //% "More information can be found "
    //% "<a href='https://together.jolla.com/question/7988/problem-with-store-unable-to-install/'>here</a>."
    description: qsTrId("sailfish-utilities-me-clean-pkg-cache-desc")
    requiresReboot: true

    function action(on_reply, on_error) {
        tools.request("cleanRpmDb", {}, {
            on_reply: on_reply, on_error: on_error
        });
    }
}
