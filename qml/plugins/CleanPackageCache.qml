import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Package cache"
    title: qsTrId("sailfish-tools-he-packace_cache")
    //% "Clean"
    actionName: qsTrId("sailfish-tools-bt-clean")
    //: Text surrounded by %1 and %2 becomes a hyperlink: %1 is replaced by <a href="..."> and %2 by </a>.
    //% "Package cache cleaning can be tried if there are "
    //% "problems with store, e.g. 'Critical problem with the app registry' error. "
    //% "More information can be found "
    //% "%1here%2."
    description: qsTrId("sailfish-utilities-me-clean-pkg-cache-desc-url")
        .arg("<a href='https://together.jolla.com/question/7988/problem-with-store-unable-to-install/'>")
        .arg("</a>")
    requiresReboot: true

    function action(on_reply, on_error) {
        UtilTools.cleanRpmDb(on_reply, on_error)
    }
}
