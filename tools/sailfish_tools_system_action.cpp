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

#include <iostream>
#include <sstream>
#include <map>

namespace utilities {

struct action_ctx {};

static int system(std::string const &cmd)
{
    std::cerr << "Executing " << cmd << std::endl;
    auto rc = ::system(cmd.c_str());
    std::cerr << "got " << rc << std::endl;
    return rc;
}

static int service_do(const std::string &name, const std::string &action)
{
    std::stringstream cmd_line;
    cmd_line << "systemctl " << action << " " << name << ".service";
    return system(cmd_line.str());
}

typedef int (*action_type)(action_ctx const*);

std::map<std::string, action_type> actions = {
    { "repair_rpm_db", [](action_ctx const *) {
            return system((application_dir + "/repair_rpm_db.sh"));
        }},
    { "restart_dalvik", [](action_ctx const *) {
            return service_do("aliendalvik", "restart");
        }},
    { "restart_network", [](action_ctx const *) {
            return service_do("connman", "restart");
        }}
};

class BecomeRoot {
public:
    BecomeRoot()
    {
        uid_ = ::geteuid();
        if (uid_)
            ::setuid(0);
    }
    ~BecomeRoot() {
        if (uid_)
            ::setuid(uid_);
    }
private:
    uid_t uid_;
};

void exit_usage(std::string const &prog_name, int rc)
{
    std::stringstream s;
    s << "Usage: " << prog_name << " [-h|--help|ACTION]\n\tACTION is one of:";
    for (auto const &name_action : actions)
        s << " " << name_action.first;

    std::cerr << s.str() << std::endl;
    exit(rc);
}

int main(int argc, char *argv[])
{
    int rc = 1;
    if (argc < 2 || !argv[1]) {
        exit_usage(argv[0], 1);
    }
    const std::string name(argv[1]);

    if (name == "-h" || name == "--help")
        exit_usage(argv[0], 0);

    auto execute = [](action_type const &action) {
        BecomeRoot root;
        return action(nullptr);
    };

    auto it = actions.find(name);
    if (it != actions.end()) {
        if (!execute(it->second)) {
            rc = 0;
        } else {
            ::error(rc, errno, "Error executing action: %s", name.c_str());
        }
    } else {
        exit_usage(argv[0], 1);
    }
    return rc;
}

}

int main(int argc, char *argv[])
{
    return utilities::main(argc, argv);
}

