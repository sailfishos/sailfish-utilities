import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //: Title for backup-related recover actions
    //% "Backup"
    title: qsTrId("sailfish-tools-he-backup")
    //% "Clean"
    actionName: qsTrId("sailfish-tools-bt-clean")
    //% "Clean backup storage to free space occupied by backups."
    //% " All backups will be removed"
    description: qsTrId("sailfish-utilities-me-clean-backups-desc")
    //% "Removing backups"
    remorseText: qsTrId("sailfish-utilities-me-remorse-removing-backups")

    function action(on_reply, on_error) {
        UtilTools.removeBackups(on_reply, on_error)
    }
}
