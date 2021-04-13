import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Utilities 1.0

ActionItem {
    visible: UtilTools.dirExists("/home/.android")
    //% "Android™ App Support"
    title: qsTrId("sailfish-tools-he-android_app_support")
    //% "Reset"
    actionName: qsTrId("sailfish-tools-bt-reset")
    //% "Completely reset Android App support, removing "
    //% "all settings, apps and app data. Android data in "
    //% "your home directory will not be removed, and any "
    //% "Android apps installed from the Jolla store will "
    //% "be reinstalled. You can also use this utility to clean "
    //% "your Android data from your device after uninstalling "
    //% "Android App Support.
    description: qsTrId("sailfish-utilities-me-clean_aas_desc")
    //% "Resetting Android™ App Support"
    remorseText: qsTrId("sailfish-utilities-me-clean_aas_remorse")
    deviceLockRequired: false

    function action(on_reply, on_error) {
        UtilTools.resetAliendalvik(on_reply, on_error)
    }
}
