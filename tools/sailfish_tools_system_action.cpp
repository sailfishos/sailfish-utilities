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

int repair_rpm_db(int, char *[])
{
    return system((application_dir + "/repair_rpm_db.sh").c_str());
}

static char buf[512];
static const int max_len = sizeof(buf) - 1;

int restart_service(char const *name)
{
    int rc = snprintf(buf, max_len, "systemctl restart %s.service", name);
    if (rc == max_len)
        error(1, EINVAL, "Buffer is too small for %s", name);
    std::cerr << "Executing " << buf << std::endl;
    return system(buf);
}

static struct {
    char const *name;
    action_type fn;
} actions[] = {
    { "repair_rpm_db", repair_rpm_db },
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
    char const *action = argv[1];
    for (size_t i = 0; i != sizeof(actions)/sizeof(actions[0]); ++i) {
        if (!strcmp(action, actions[i].name)) {
            auto rc = actions[i].fn(argc, argv);
            if (rc)
                perror("Executing action");
            return rc;
        }
    }
    error(1, EINVAL, "Unknown action: %s", action);
    return 1; // just for compiler, error exits ^
}
