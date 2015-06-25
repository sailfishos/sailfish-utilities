import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Clean tracker dabatase"
    actionName: qsTrId("sailfish-tools-clean-tracker-db")
    //% "Tracker dabatabase cleaning can help in cases with "
    //% "missing images, audio files etc. Processes using tracker "
    //% "will be closed, tracker reindexing will be started. "
    //% "More information can be found "
    //% "<a href='https://together.jolla.com/question/4337/refresh-tracker/'>here</a>."
    description: qsTrId("sailfish-utilities-me-clean-tracker-db-desc")
    deviceLockRequired: false

    function action(on_reply, on_error) {
        tools.request("cleanTrackerDb", {}, {
            on_reply: on_reply, on_error: on_error
        });
    }
}
