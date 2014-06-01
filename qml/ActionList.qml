import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

Column {

    width: parent.width
    spacing: Theme.paddingLarge

    signal done(string name)
    signal error(string name, string error)

    PageHeader {
        title: "Sailfish Tools"
    }

    ActionItem {
        actionName: "Clean backup storage"
        description: "Clean backup storage to free space occupied by backups."
            + " All backups will be removed"
        remorseText: "Removing backups"

        function action(on_reply, on_error) {
            tools.request("removeBackups", {}, {
                on_reply: on_reply, on_error: on_error
            });
        }
    }

    ActionItem {
        actionName: "Clean package cache"
        description: "Package cache cleaning can be tried if there are " +
            "problems with store, e.g. 'Critical problem with the app registry' error"
        url: "https://together.jolla.com/question/7988/problem-with-store-unable-to-install/"
        requiresReboot: true

        function action(on_reply, on_error) {
            tools.request("cleanRpmDb", {}, {
                on_reply: on_reply, on_error: on_error
            });
        }
    }

    ActionItem {
        actionName: "Clean tracker dabatase"
        description: "Clean tracker dabatabase. It can help in cases with " +
            "with missing images, audio files etc. Processes using tracker " +
            "will be closed, tracker reindexing will be started"
        url: "https://together.jolla.com/question/4337/refresh-tracker/"
        deviceLockRequired: false

        function action(on_reply, on_error) {
            tools.request("cleanTrackerDb", {}, {
                on_reply: on_reply, on_error: on_error
            });
        }
    }
}
