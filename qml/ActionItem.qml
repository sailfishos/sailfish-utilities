import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

Column {
    id: self
    width: parent.width

    property string actionName: ""
    property string description: ""
    property string remorseText: ""
    property string url: ""
    property bool requiresReboot: false

    function executeAction() {
        var on_reply = function() {
            console.log("Done:", actionName);
            if (requiresReboot)
                dsmeDbus.call("req_reboot", []);
        };
        var on_error = function(e) {
            // TODO show error message
            console.log(actionName, " error:", err);
        };
        action(on_reply, on_error);
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
        height: Theme.itemSizeMedium
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: remorseText
            ? remorseAction(remorseText, executeAction, 5000)
            : executeAction()
    }
    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        visible: requiresReboot
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeExtraSmall
        text: "This action requires reboot"
    }
    TextArea {
        readOnly: true
        width: parent.width
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        text: description
    }
    TextArea {
        visible: url !== ""
        readOnly: true
        width: parent.width
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        inputMethodHints: Qt.ImhUrlCharactersOnly
        text: url
        onClicked: Qt.openUrlExternally(text)
    }
}
