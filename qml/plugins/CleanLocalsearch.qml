import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Localsearch database"
    title: qsTrId("sailfish-tools-he-localsearch_database")
    //% "Clean"
    actionName: qsTrId("sailfish-tools-bt-clean")
    //: Text surrounded by %1 and %2 becomes a hyperlink: %1 is replaced by <a href="..."> and %2 by </a>.
    //% "Localsearch (formerly known as Tracker) database cleaning can help in cases with "
    //% "missing images, audio files etc. After the cleanup Localsearch reindexing will be started."
    //% "More information can be found "
    //% "%1here%2."
    description: qsTrId("sailfish-utilities-me-clean-localsearch-db-desc-url")
        .arg("<a href='https://docs.sailfishos.org/Support/Help_Articles/Tips_and_Tricks/#refresh-the-tracker-database'>")
        .arg("</a>")
    deviceLockRequired: false

    function action(on_reply, on_error) {
        UtilTools.cleanLocalsearchDb(on_reply, on_error)
    }
}
