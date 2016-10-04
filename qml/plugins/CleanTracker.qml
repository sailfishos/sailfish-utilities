import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Tracker database"
    title: qsTrId("sailfish-tools-he-tracker_database")
    //% "Clean"
    actionName: qsTrId("sailfish-tools-bt-clean")
    //% "Tracker dabatabase cleaning can help in cases with "
    //% "missing images, audio files etc. Processes using tracker "
    //% "will be closed, tracker reindexing will be started. "
    //% "More information can be found "
    //% "<a href='https://together.jolla.com/question/4337/refresh-tracker/'>here</a>."
    description: qsTrId("sailfish-utilities-me-clean-tracker-db-desc")
    deviceLockRequired: false

    function action(on_reply, on_error) {
        UtilTools.cleanTrackerDb(on_reply, on_error)
    }
}
