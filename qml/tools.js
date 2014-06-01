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
