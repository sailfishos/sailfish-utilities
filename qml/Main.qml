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
            text: "Tools"
        }
    }
}
