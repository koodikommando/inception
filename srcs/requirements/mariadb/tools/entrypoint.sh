#!/bin/sh

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    echo "Initializing database and tables..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld &

    until mysqladmin ping --silent; do
        echo "Waiting for service..."
        sleep 2
    done

    echo "Creating database..."
    sed -i "s/database_name/$DB_NAME/g" /etc/mysql/init.sql
    sed -i "s/database_user/$DB_USER/g" /etc/mysql/init.sql
    sed -i "s/database_pass/$DB_PASS/g" /etc/mysql/init.sql
    sed -i "s/database_root_pass/$DB_ROOT_PASS/g" /etc/mysql/init.sql
    mysql -u root < /etc/mysql/init.sql

    mysqladmin -u root shutdown
else
    echo "MariaDB is already setup."
fi

echo "Starting the database..."
exec mysqld