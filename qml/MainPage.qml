/**
 * @file MainPage.qml
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.settings.system 1.0
import Nemo.Notifications 1.0
import org.nemomobile.devicelock 1.0
import Nemo.DBus 2.0

Page {
    id: mainPage

    property bool inProgress: false

    backNavigation: !inProgress

    DeviceLockQuery {
        id: deviceLockQuery
    }

    DeviceLockSettings {
        id: deviceLockSettings
    }

    DBusInterface {
        id: dsmeDbus
        bus: DBus.SystemBus
        service: "com.nokia.dsme"
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

    function requestSecurityCode(on_ok) {
        deviceLockQuery.authenticate(deviceLockSettings.authorization,
                                     function(authenticationToken) {
                                         console.log("Security code is ok or not used")
                                         pageStack.pop(mainPage)
                                         on_ok()
                                     }, function () {
                                         pageStack.pop(mainPage)
                                     })
    }

    function actionIsDone(category, message) {
        console.log("Notify", message);
        //% "Sailfish Utilities"
        notification.previewBody = qsTrId("sailfish-utilities-me-name");
        notification.previewSummary = message;
        notification.close();
        notification.publish();
    }

    SilicaFlickable {
        id: mainView
        anchors.fill: parent
        contentHeight: actionList.height + Theme.paddingLarge

        VerticalScrollDecorator { flickable: mainView }

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
        icon: "icon-m-health"
    }

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: mainPage.inProgress
    }
}
