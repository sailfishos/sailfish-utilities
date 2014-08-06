/**
 * @file Main.qml
 * @brief To run utilities as application
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    initialPage: MainPage {}

    cover: CoverBackground {
        id: mainCover
        anchors.fill: parent
        Text {
            anchors.centerIn: parent
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeMedium
            //% "Utilities"
            text: qsTrId("sailfish-tools-utilities")
        }
    }
}
