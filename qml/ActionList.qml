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

    ListModel {
        id: plugins
    }
    Component.onCompleted: {
        var justLoad = function(name) {
            var info = { name: name, path: "plugins/" + name + ".qml" }
            plugins.append(info)
        }
        var names = [ "RestartKeyboard", "RestartNetwork", "RestartUI"
                      , "CleanBackup", "CleanPackageCache", "CleanTracker" ]
        for (var i = 0; i < names.length; ++i)
            justLoad(names[i])

        tools.request("isAndroidControlNeeded", {}, {
            on_reply: function(is_show) {
                if (is_show) {
                    justLoad("StopAndroid")
                    justLoad("RestartAndroid")
                }
            }, on_error: function(e) {
                console.log("Error", e)
            }});
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
