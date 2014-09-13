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

namespace {

struct action_ctx {};

struct Error : public std::exception
{
    Error(std::string const &msg) : res(errno), msg_(msg) {}
    virtual ~Error() noexcept(true) {}

    virtual const char* what() const noexcept(true)
    {
        return (msg_ + ". errno=" + ::strerror(res)).c_str();
    }

    int res;
    std::string msg_;
};

void system(std::string const &cmd)
{
    std::cerr << "Executing " << cmd << std::endl;
    if (::system(cmd.c_str()))
        throw Error(cmd);
}

void service_do(const std::string &name, const std::string &action)
{
    std::stringstream cmd_line;
    cmd_line << "systemctl " << action << " " << name << ".service";
    system(cmd_line.str());
}

void execute_own_utility(std::string const &file_name)
{
    system((application_dir + "/" + file_name));
}

typedef void (*action_type)(action_ctx const*);

std::map<std::string, action_type> actions = {
    { "repair_rpm_db", [](action_ctx const *) {
            execute_own_utility("repair_rpm_db.sh");
        }},
    { "restart_dalvik", [](action_ctx const *) {
            service_do("aliendalvik", "restart");
        }},
    { "stop_dalvik", [](action_ctx const *) {
            service_do("aliendalvik", "stop");
        }},
    { "restart_network", [](action_ctx const *) {
            return execute_own_utility("restart_network.sh");
        }}
};

class BecomeRoot
{
public:
    BecomeRoot() : uid_(escalate()) { }
    ~BecomeRoot() {
        if (uid_)
            ::setuid(uid_);
    }
private:

    static uid_t escalate()
    {
        auto uid = ::getuid();
        if (uid) {
            if (::setuid(0) < 0)
                throw Error("Error setting root uid");
        }
        return uid;
    }

    uid_t uid_;
};

int exit_usage(std::string const &prog_name, int rc)
{
    std::stringstream s;
    s << "Usage: " << prog_name << " [-h|--help|ACTION]\n\tACTION is one of:";
    for (auto const &name_action : actions)
        s << " " << name_action.first;

    std::cerr << s.str() << std::endl;
    exit(rc);
    return rc;
}

}

int main(int argc, char *argv[])
{
    int rc = 1;
    if (argc < 2 || !argv[1]) {
        return exit_usage(argv[0], 1);
    }
    const std::string name(argv[1]);

    if (name == "-h" || name == "--help")
        return exit_usage(argv[0], 0);

    auto execute = [](action_type const &action) {
        BecomeRoot root;
        action(nullptr);
    };

    auto it = actions.find(name);
    if (it == actions.end()) {
        return exit_usage(argv[0], 1);
    }
    try {
        execute(it->second);
    } catch (std::exception const &e) {
        std::cerr << "Error " << e.what()
                  << ". While executing action: " << name.c_str()
                  << std::endl;
    } catch (...) {
        std::cerr << "Unknown error "
                  << ". While executing action: " << name.c_str()
                  << std::endl;
    }
    rc = 0;
    return rc;
}

}

int main(int argc, char *argv[])
{
    return utilities::main(argc, argv);
}

