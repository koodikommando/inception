FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-common bash

# Setup directories and permissions
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql

# Copy mariadb config file
COPY ./conf/my.cnf /etc/mysql/
RUN chmod 644 /etc/mysql/my.cnf

# Copy mysql init file
COPY tools/init.sql /etc/mysql/
RUN chmod 644 /etc/mysql/init.sql

COPY ./conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy entrypoint script
COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]
