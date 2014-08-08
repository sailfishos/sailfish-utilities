/**
 * @file MainPage.qml
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

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

    backNavigation: !inProgress

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
            console.log("Lock code is ok");
            pageStack.pop();
            on_ok();
        }
        if (!deviceLockInterface.isSet) {
            console.log("There is no lock code, do not request it");
            on_ok();
        } else {
            console.log("Requesting lock code");
            var query = pageStack.push(lockQueryPage);
            query.lockCodeConfirmed.connect(lockEntered);
        }
    }

    function actionIsDone(category, message) {
        console.log("Notify", message);
        notification.category = (category === "error")
            ? "x-sailfish.sailfish-utilities.error"
            : "x-sailfish.sailfish-utilities.info";
        //% "Sailfish Utilities"
        notification.previewBody = qsTrId("sailfish-utilities-me-name");
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
            onDone: {
                //% "%1: OK"
                var message = qsTrId("sailfish-utilities-me-notification-ok").arg(name);
                mainPage.actionIsDone("info", message);
            }
            onError: {
                console.log(error);
                //% "%1: failed"
                var message = qsTrId("sailfish-utilities-me-notification-err").arg(name);
                mainPage.actionIsDone("error", message)
            }
        }
    }
    Notification {
        id: notification
        category: "x-sailfish.sailfish-utilities.error"
    }

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: mainPage.inProgress
    }
}
