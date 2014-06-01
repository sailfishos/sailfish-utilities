import QtQuick 2.0
import Mer.Cutes 1.1
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import com.jolla.settings.system 1.0
import org.nemomobile.notifications 1.0
import org.nemomobile.systemsettings 1.0
import org.nemomobile.dbus 1.0

Page {
    id: mainPage
    property bool inProgress: false

    CutesActor {
        id: tools
        source: "./tools.js"
    }

    DeviceLockInterface {
        id: deviceLockInterface
    }

    DeviceLockSettings {
        id: deviceLockSettings
    }

    Component {
        id: lockQueryPage
        DeviceLockQuery {}
    }

    DBusInterface {
        id: dsmeDbus
        busType: DBusInterface.SystemBus
        destination: "com.nokia.dsme"
        path: "/com/nokia/dsme/request"
        iface: "com.nokia.dsme.request"
    }

    Timer {
        id: rebootTimer
        interval: 1000
        onTriggered: dsmeDbus.call("req_reboot", [])
    }

    function reboot() {
        rebootTimer.start()
    }

    function requestLockCode(on_ok) {
        var lockEntered = function() {
            pageStack.pop();
            on_ok();
        }
        var query = pageStack.push(lockQueryPage);
        query.lockCodeConfirmed.connect(lockEntered);
    }

    function actionIsDone(category, message) {
        console.log("Notify", message);
        notification.category = (category === "error")
            ? "x-sailfish.sailfish-tiny-tools.error"
            : "x-sailfish.sailfish-tiny-tools.info";
        notification.previewBody = "Sailfish Tiny Tools";
        notification.previewSummary = message;
        notification.publish();
    }

    anchors.fill: parent

    SilicaFlickable {
        id: mainView
        anchors.fill: parent
        contentHeight: actionList.height

        ActionList {
            id: actionList
            
            opacity: mainPage.inProgress ? 0.0 : 1.0
            Behavior on opacity { FadeAnimation {} }
            onDone: mainPage.actionIsDone("info", name + ": ok")
            onError: mainPage.actionIsDone("error", name + ": error: " + error.toString())
        }
    }
    Notification {
        id: notification
        category: "x-sailfish.sailfish-tiny-tools.error"
    }

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: mainPage.inProgress
    }
}
