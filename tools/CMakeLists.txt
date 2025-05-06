set(CMAKE_CXX_FLAGS
  "${CMAKE_CXX_FLAGS} -fPIC -W -Wall -Wextra -Werror -g -O2 -std=c++0x")

configure_file(config.hpp.in config.hpp @ONLY)
add_executable(sailfish_tools_system_action sailfish_tools_system_action.cpp)

configure_file(localsearch-reindex.service.in localsearch-reindex.service @ONLY)

install(FILES
  localsearch-reindex.service
  DESTINATION lib/systemd/user
  )

install(TARGETS
      sailfish_tools_system_action
      DESTINATION bin
      PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ SETUID
)

install(PROGRAMS
      repair_rpm_db.sh
      restart_network.sh
      restart_bluetooth.sh
      restart_lipstick.sh
      localsearch_reindex.sh
      restart_fingerprint.sh
      DESTINATION share/sailfish-utilities
)
