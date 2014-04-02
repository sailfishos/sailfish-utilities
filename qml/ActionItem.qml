import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

Item {
    id: self
    width: parent.width
    height: dataArea.height

    property string actionName: ""
    property string description: ""
    property string remorseText: ""
    property string url: ""
    property bool requiresReboot: false
    property bool inProgress: false

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: inProgress
    }

    function executeAction() {
        inProgress = true;
        var on_reply = function() {
            inProgress = false;
            console.log("Done:", actionName);
            if (requiresReboot)
                dsmeDbus.call("req_reboot", []);
        };
        var on_error = function(e) {
            inProgress = false;
            // TODO show error message
            console.log(actionName, " error:", err);
        };
        action(on_reply, on_error);
    }

    Column {
        id: dataArea
        spacing: Theme.paddingSmall
        opacity: inProgress ? 0.0 : 1.0
        Behavior on opacity { FadeAnimation {} }
        anchors {
            left: parent.left
            right: parent.right
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
        }

        Text {
            width: parent.width
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraSmall
            wrapMode: Text.Wrap
            text: description
        }
        Text {
            width: parent.width
            id: urlText
            visible: url !== ""
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraSmall
            font.underline: true
            wrapMode: Text.Wrap
            text: "Click for more information..."
            MouseArea {
                anchors.fill: parent
                onClicked: Qt.openUrlExternally(url)
            }
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: requiresReboot
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeExtraSmall
            text: "This action requires reboot"
        }
        Button {
            id: btn
            Component {
                id: remorseComponent
                RemorseItem { }
            }

            function remorseAction(text, action, timeout) {
                // null parent because a reference is held by RemorseItem until
                // it either triggers or is cancelled.
                var remorse = remorseComponent.createObject(null)
                remorse.execute(self, text, action, timeout)
            }

            text: actionName
            height: Theme.itemSizeSmall
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 200
            onClicked: remorseText
                ? remorseAction(remorseText, executeAction, 5000)
                : executeAction()
        }
    }
}
