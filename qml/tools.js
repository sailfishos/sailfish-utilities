/**
 * @file tools.js
 * @brief Used by cutes agent to invoke async actions
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

var make_system_action = function(name) {
    return function() {
        var subprocess = require("subprocess");
        subprocess.check_call("sailfish_tools_system_action", [name]);
    };
};

exports.removeBackups = function(msg, ctx) {
    var os = require("os");
    var home = os.home();
    if (!os.path.isDir(home))
        error.raise({message: "No home directory " + home});
    os.rmtree(os.path(home, ".vault"));
};

exports.cleanRpmDb = make_system_action("repair_rpm_db");

exports.cleanTrackerDb = function(msg, ctx) {
    var os = require("os");
    os.system("tracker-control", ["-krs"]);
};

exports.restartKeyboard = function(msg, ctx) {
    var os = require("os");
    os.system("systemctl", ["--user", "restart", "maliit-server.service"]);
};

exports.isAndroidControlNeeded = function(msg, ctx) {
    var os = require("os");
    var rc = os.system("rpm", ["-q", "aliendalvik"]);
    return (rc === 0
            && os.system("rpm", ["-q", "apkd-android-settings"]) !== 0);
};

exports.restartAlien = make_system_action("restart_dalvik");
exports.stopAlien = make_system_action("stop_dalvik");
exports.restartNetwork = make_system_action("restart_network");
exports.restartLipstick = make_system_action("restart_lipstick");
exports.restartDevice = make_system_action("restart_device");
