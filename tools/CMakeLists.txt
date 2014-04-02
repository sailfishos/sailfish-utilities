configure_file(repair_rpm_db.c.in repair_rpm_db.c @ONLY)
add_executable(repair_rpm_db repair_rpm_db.c)


install(TARGETS
      repair_rpm_db
      DESTINATION bin
      PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE SETUID
)

install(PROGRAMS
      repair_rpm_db.sh
      DESTINATION share/sailfish-tiny-tools
)
