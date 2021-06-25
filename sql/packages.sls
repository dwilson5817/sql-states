---
# INSTALL MARIADB PACKAGES
# Install MariaDB packages, the server package installs the database daemon while the client package enables running SQL
# commands via the commandline.  The python3-mysqldb package is required to use Salt modules to configure MariaDB.
mariadb_packages:
  pkg.latest:
    - pkgs:
      - mariadb-client
      - mariadb-server
      - python3-mysqldb
