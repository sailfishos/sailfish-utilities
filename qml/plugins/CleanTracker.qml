import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Tracker database"
    title: qsTrId("sailfish-tools-he-tracker_database")
    //% "Clean"
    actionName: qsTrId("sailfish-tools-bt-clean")
    //: Text surrounded by %1 and %2 becomes a hyperlink: %1 is replaced by <a href="..."> and %2 by </a>.
    //% "Tracker dabatabase cleaning can help in cases with "
    //% "missing images, audio files etc. Processes using tracker "
    //% "will be closed, tracker reindexing will be started. "
    //% "More information can be found "
    //% "%1here%2."
    description: qsTrId("sailfish-utilities-me-clean-tracker-db-desc-url")
        .arg("<a href='https://together.jolla.com/question/4337/refresh-tracker/'>")
        .arg("</a>")
    deviceLockRequired: false

    function action(on_reply, on_error) {
        UtilTools.cleanTrackerDb(on_reply, on_error)
    }
}
