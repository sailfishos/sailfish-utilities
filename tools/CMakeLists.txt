configure_file(config.hpp.in config.hpp @ONLY)
add_executable(sailfish_tools_system_action sailfish_tools_system_action.cpp)


install(TARGETS
      sailfish_tools_system_action
      DESTINATION bin
      PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ SETUID
)

install(PROGRAMS
      repair_rpm_db.sh
      DESTINATION share/sailfish-tiny-tools
)
