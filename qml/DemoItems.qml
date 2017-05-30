/**
 * @file DemoItems.qml
 * @brief Dummy Items demostrating capabilities
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import Sailfish.Utilities 1.0

Column {

    width: parent.width
    spacing: Theme.paddingLarge

    signal done(string name)
    signal error(string name, string error)

    PageHeader {
        title: "Sailfish Tools"
    }

    ActionItem {
        actionName: "SHOW ERROR"
        description: "SOME ERROR"

        function action(on_reply, on_error) {
            on_error("GOT EXPECTED ERROR");
        }
    }

    ActionItem {
        actionName: "SHOW OK"
        description: "SOME DUMMY ACTION"

        function action(on_reply, on_error) {
            on_reply("IT WAS OK");
        }
    }

    ActionItem {
        actionName: "SHOW ERROR"
        description: "SOME ERROR w/o security code"
        deviceLockRequired: false

        function action(on_reply, on_error) {
            on_error("GOT EXPECTED ERROR w/o code");
        }
    }

    ActionItem {
        actionName: "SHOW OK"
        description: "SOME DUMMY ACTION /w remorse"
        remorseText: "Executing something dummy"

        function action(on_reply, on_error) {
            on_reply("IT WAS OK");
        }
    }

}
