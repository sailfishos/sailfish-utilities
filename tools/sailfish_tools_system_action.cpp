/**
 * @file sailfish_tools_system_action.cpp
 * @brief SUID root actions execution
 * @copyright (C) 2014 Jolla Ltd.
 * @par License: LGPL 2.1 http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
 */

#include "config.hpp"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <error.h>
#include <errno.h>
#include <string.h>

#include <functional>
#include <iostream>

typedef std::function<int (int, char *[])> action_type;

static int restart_service(const std::string &name)
{
    std::string cmd("systemctl restart " + name + ".service");
    std::cerr << "Executing " << cmd << std::endl;
    return system(cmd.c_str());
}

static struct {
    std::string name;
    action_type fn;
} actions[] = {
    { "repair_rpm_db", [](int, char *[]) {
            return system((application_dir + "/repair_rpm_db.sh").c_str());
        }},
    { "restart_dalvik", [](int, char *[]) {
            return restart_service("aliendalvik");
        }},
    { "restart_network", [](int, char *[]) {
            return restart_service("connman");
        }}
};

int main(int argc, char *argv[])
{
    setuid(0);
    if (argc < 2) {
        error(1, EINVAL, "Need to provide action name");
    }

    const std::string cmd(argv[1]);
    for (const auto &action: actions) {
        if (cmd == action.name) {
            auto rc = action.fn(argc, argv);
            if (rc)
                perror("Executing action");
            return rc;
        }
    }

    error(1, EINVAL, "Unknown action: %s", cmd.c_str());
    return 1; // just for compiler, error exits ^
}
