-- Placeholders are replaced by the entrypoint script

DROP DATABASE IF EXISTS `database_name`;
CREATE DATABASE `database_name` CHARACTER SET utf8 COLLATE utf8_general_ci;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'database_pass';

CREATE USER IF NOT EXISTS 'database_user'@'%' IDENTIFIED BY 'database_pass';
GRANT ALL PRIVILEGES ON `database_name`.* TO 'database_user'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'database_user'@'%' IDENTIFIED BY 'database_pass' WITH GRANT OPTION;


FLUSH PRIVILEGES;

