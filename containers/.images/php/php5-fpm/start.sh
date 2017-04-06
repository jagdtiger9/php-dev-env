#!/bin/sh
#exec /usr/sbin/php5-fpm --nodaemonize >>/var/log/php5-fpm.log 2>&1
php5-fpm --nodaemonize -p /etc/php5/fpm -y /etc/php5/fpm/php-fpm.conf
