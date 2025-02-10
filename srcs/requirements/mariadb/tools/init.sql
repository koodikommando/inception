
-- Placeholders are replaced by the entrypoint.sh
DROP DATABASE IF EXISTS `database_name`;
CREATE DATABASE `database_name`;


CREATE USER IF NOT EXISTS 'database_user'@'%' IDENTIFIED BY 'database_pass';
GRANT ALL PRIVILEGES ON `database_name`.* TO 'database_user'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'database_root_pass';
FLUSH PRIVILEGES;




