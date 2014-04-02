import QtQuick 2.0
import Mer.Cutes 1.1
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import com.jolla.settings.system 1.0
import org.nemomobile.configuration 1.0
import org.nemomobile.systemsettings 1.0

ApplicationWindow {
    initialPage: mainPage

    CutesActor {
        id: tools
        source: "./tools.js"
    }

    cover: CoverBackground {
        id: mainCover
        anchors.fill: parent
        Image {
            anchors.centerIn: parent
            source: "image://theme/icon-m-toy"
        }
    }

    Page {
        id: mainPage


        DeviceLockInterface {
            id: devicelock
            property string cachedPin
        }

        function requestLockCode(on_ok, on_error) {
            if (!devicelock.isSet || devicelock.cachedPin)
                return on_ok();
            //pageStack.push(pinInputComponent, {lockDelay: "5"})
        }

        anchors.fill: parent
        SilicaFlickable {
            id: mainView
            width: parent.width
            ActionList {}
        }
    }
}
