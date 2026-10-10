/**
 * @file MainPage.qml
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.settings.system 1.0
import Nemo.Notifications 1.0
import Nemo.DBus 2.0
import org.nemomobile.devicelock 1.0

Page {
    id: mainPage

    property bool inProgress

    backNavigation: !inProgress

    property var _authorizedAction

    function cancelAuthentication() {
        var pending = _authorizedAction !== undefined
        _authorizedAction = undefined
        authenticator.cancel()
        if (pending)
            pageStack.pop(mainPage)
    }

    Authenticator {
        id: authenticator

        onAuthenticated: {
            var action = mainPage._authorizedAction
            mainPage._authorizedAction = undefined
            if (action) {
                pageStack.pop(mainPage)
                action()
            }
        }
        onAborted: mainPage.cancelAuthentication()
    }

    Connections {
        target: deviceLockSettings.authorization
        onChallengeIssued: {
            if (mainPage._authorizedAction) {
                authenticator.authenticate(deviceLockSettings.authorization.challengeCode,
                                           deviceLockSettings.authorization.allowedMethods)
            }
        }
        onChallengeDeclined: mainPage.cancelAuthentication()
        onChallengeExpired: mainPage.cancelAuthentication()
    }

    Component.onDestruction: {
        _authorizedAction = undefined
        authenticator.cancel()
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
        _authorizedAction = on_ok
        if (deviceLockSettings.authorization.status === Authorization.NoChallenge) {
            deviceLockSettings.authorization.requestChallenge()
        } else if (deviceLockSettings.authorization.status === Authorization.ChallengeIssued) {
            authenticator.authenticate(deviceLockSettings.authorization.challengeCode,
                                       deviceLockSettings.authorization.allowedMethods)
        } else {
            cancelAuthentication()
        }
    }

    function actionIsDone(category, message) {
        console.log("Notify", message)
        //% "Sailfish Utilities"
        notification.previewBody = qsTrId("sailfish-utilities-me-name")
        notification.previewSummary = message
        notification.close()
        notification.publish()
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
                var message = qsTrId("sailfish-utilities-me-notification-ok").arg(name)
                mainPage.actionIsDone("info", message)
            }
            onError: {
                console.log(error)
                //% "%1: failed"
                var message = qsTrId("sailfish-utilities-me-notification-err").arg(name)
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
