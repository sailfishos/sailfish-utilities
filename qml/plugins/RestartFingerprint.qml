import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Fingerprint"
    title: qsTrId("sailfish-tools-he-fingerprint")
    //% "Restart"
    actionName: qsTrId("sailfish-tools-bt-fingerprint_restart")
    deviceLockRequired: false
    //% "Restart fingerprint service. In some circumstancces this can "
    //% "resolve issues where valid fingerprints are no longer being "
    //% "recognised."
    description: qsTrId("sailfish-utilities-restart-fingerprint_desc")

    function action(on_reply, on_error) {
        UtilTools.restartFingerprint(on_reply, on_error)
    }
}
