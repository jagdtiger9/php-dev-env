#!/bin/sh

# Handlersocket plugin install
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "install plugin handlersocket soname 'handlersocket.so';"