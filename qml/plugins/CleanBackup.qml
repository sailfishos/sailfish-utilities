import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    //% "Clean backup storage"
    actionName: qsTrId("sailfish-tools-clean-backup")
    //% "Clean backup storage to free space occupied by backups."
    //% " All backups will be removed"
    description: qsTrId("sailfish-utilities-me-clean-backups-desc")
    //% "Removing backups"
    remorseText: qsTrId("sailfish-utilities-me-remorse-removing-backups")

    function action(on_reply, on_error) {
        tools.request("removeBackups", {}, {
            on_reply: on_reply, on_error: on_error
        });
    }
}
