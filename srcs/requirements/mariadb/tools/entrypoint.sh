#!/bin/bash

echo "Initializing mariaDB"

if test -d "/var/lib/mysql/mysql"; then
	echo "MariaDB already initialized"
else
	mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db
	echo "Creating database..."
	mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASS';
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF
	echo "Database \" $DB_NAME \" has been created successfully"
fi

echo "Starting mariadb"
exec mysqld --user=mysql

