/**
 * @file ActionList.qml
 * @brief List of available actions
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

Column {

    width: parent.width
    spacing: Theme.paddingLarge

    signal done(string name)
    signal error(string name, string error)

    PageHeader {
        //% "Sailfish Tools"
        title: qsTrId("sailfish-tools-he-tools")
    }

    ActionItem {
        //% "Restart Alien Dalvik"
        actionName: qsTrId("sailfish-tools-restart-dalvik")
        deviceLockRequired: false
        description: "Restart subsystem providing support to run "
            + "Android applications. Try to use it if Android applications can't be "
            + " started or stuck etc."

        function action(on_reply, on_error) {
            tools.request("restartAlien", {}, {
                on_reply: on_reply, on_error: on_error
            });
        }
    }

    ActionItem {
        //% "Restart network"
        actionName: qsTrId("sailfish-tools-restart-network")
        deviceLockRequired: false
        description: "Restart network subsystem if anything wrong happened with "
            + "connectivity (WLAN, mobile data)"

        function action(on_reply, on_error) {
            tools.request("restartNetwork", {}, {
                on_reply: on_reply, on_error: on_error
            });
        }
    }

    ActionItem {
        //% "Clean backup storage"
        actionName: qsTrId("sailfish-tools-clean-backup")
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
        //% "Clean package cache"
        actionName: qsTrId("sailfish-tools-clean-pkg-cache")
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
        //% "Clean tracker dabatase"
        actionName: qsTrId("sailfish-tools-clean-tracker-db")
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
