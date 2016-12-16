#!/bin/sh

# Handlersocket plugin install
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "install plugin handlersocket soname 'handlersocket.so';"

# MySQL InnoDB-memcached plugin
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "INSTALL PLUGIN daemon_memcached SONAME 'libmemcached.so';"

#mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SOURCE /usr/share/mysql/innodb_memcached_config.sql;"



