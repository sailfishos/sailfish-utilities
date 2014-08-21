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

    signal done(string name)
    signal error(string name, string error)

    PageHeader {
        //% "Utilities"
        title: qsTrId("sailfish-tools-utilities")
    }

    Column {
        width: parent.width
        spacing: Theme.paddingLarge
        ActionItem {
            //% "Restart Alien Dalvik"
            actionName: qsTrId("sailfish-tools-bt-restart-dalvik")
            deviceLockRequired: false
            //% "Restart subsystem providing support to run "
            //% "Android applications. Try to use it if Android applications can't be "
            //% " started or stuck etc."
            description: qsTrId("sailfish-utilities-restart-alien-desc")

            function action(on_reply, on_error) {
                tools.request("restartAlien", {}, {
                    on_reply: on_reply, on_error: on_error
                });
            }
        }

        ActionItem {
            //% "Restart network"
            actionName: qsTrId("sailfish-tools-bt-restart-network")
            deviceLockRequired: false
            //% "Restart network subsystem if anything wrong happened with "
            //% "connectivity (WLAN, mobile data)."
            //% "Ignore the warning asking you to restart phone because "
            //% "SIM is removed. This is the side effect of the network "
            //% "stack beeing restarted"
            description: qsTrId("sailfish-utilities-restart-network-desc")

            function action(on_reply, on_error) {
                tools.request("restartNetwork", {}, {
                    on_reply: on_reply, on_error: on_error
                });
            }
        }

        ActionItem {
            //% "Clear backup storage"
            actionName: qsTrId("sailfish-tools-bt-clear-backup")
            //% "Clear backup storage to free space occupied by backups."
            //% " All backups will be removed"
            description: qsTrId("sailfish-utilities-clear-backups-desc")
            //% "Removing backups"
            remorseText: qsTrId("sailfish-utilities-remorse-removing-backups")

            function action(on_reply, on_error) {
                tools.request("removeBackups", {}, {
                    on_reply: on_reply, on_error: on_error
                });
            }
        }

        ActionItem {
            //% "Clear package cache"
            actionName: qsTrId("sailfish-tools-bt-clear-pkg-cache")
            //% "You can try to clear package cache if there are "
            //% "problems with store, e.g. 'Critical problem with the app registry' error. "
            //% "More information can be found "
            //% "<a href='https://together.jolla.com/question/7988/problem-with-store-unable-to-install/'>here</a>."
            description: qsTrId("sailfish-utilities-clear-pkg-cache-desc")
            requiresReboot: true

            function action(on_reply, on_error) {
                tools.request("cleanRpmDb", {}, {
                    on_reply: on_reply, on_error: on_error
                });
            }
        }

        ActionItem {
            //% "Clear tracker dabatase"
            actionName: qsTrId("sailfish-tools-bt-clear-tracker-db")
            //% "Tracker dabatabase clearing can be helpful if you "
            //% "missed some images, audio files etc. Processes using tracker "
            //% "will be closed, tracker reindexing will be started. "
            //% "More information can be found "
            //% "<a href='https://together.jolla.com/question/4337/refresh-tracker/'>here</a>."
            description: qsTrId("sailfish-utilities-clear-tracker-db-desc")
            deviceLockRequired: false

            function action(on_reply, on_error) {
                tools.request("cleanTrackerDb", {}, {
                    on_reply: on_reply, on_error: on_error
                });
            }
        }
    }
}
