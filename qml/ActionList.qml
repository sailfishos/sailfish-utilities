/**
 * @file ActionList.qml
 * @brief List of available actions
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

Column {
    width: parent.width

    signal done(string name)
    signal error(string name, string error)

    Component.onCompleted: {
        var justLoad = function(name) {
            var info = { name: name, path: "plugins/" + name + ".qml" }
            plugins.append(info)
        }
        var names = [ "RestartNetwork", "RestartOfono", "RestartKeyboard", "RestartUI",
                      "RestartFingerprint", "RestartAudio", "RestartBluetooth",
                      "CleanPackageCache", "CleanLocalsearch"
                    ]
        for (var i = 0; i < names.length; ++i)
            justLoad(names[i])
    }

    ListModel {
        id: plugins
    }

    PageHeader {
        //% "Utilities"
        title: qsTrId("sailfish-tools-utilities")
    }

    Column {
        width: parent.width
        spacing: Theme.paddingLarge
        Repeater {
            model: plugins
            Loader {
                source: path
                width: parent.width
            }
        }
    }
}
