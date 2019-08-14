#!/bin/sh

# Create default Magicpro database if not exists
#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS `magicpro` CHARACTER SET utf8 COLLATE utf8_general_ci;"
#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';"
#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON database.* TO 'user'@'localhost';"

# MySQL InnoDB-memcached plugin
#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SOURCE /usr/share/mysql/innodb_memcached_config.sql;"
#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SOURCE /usr/share/mysql/InnoDB-memcached.sql;"
#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "INSTALL PLUGIN daemon_memcached SONAME 'libmemcached.so';"

# Handlersocket plugin install
##mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "install plugin handlersocket soname 'handlersocket.so';"
