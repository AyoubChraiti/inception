#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# # Start MariaDB in the background and wait for it to be ready
mysqld_safe &

# # Wait until MariaDB is ready
sleep 3

# # Create the database and user
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS $DB_USER@'%' IDENTIFIED BY "$DB_PASSWORD";
GRANT ALL PRIVILEGES ON *.* TO $DB_USER@'%' WITH GRANT OPTION;;
FLUSH PRIVILEGES;
EOF

# # Set the root password safely
# mariadb -u root <<EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY "$DB_ROOT_PASSWORD";
# EOF

# # Shutdown MariaDB to apply changes
mysqladmin -u root Shutdown

# # Restart MariaDB in the foreground
mysqld_safe