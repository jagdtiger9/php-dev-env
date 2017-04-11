#!/bin/bash
#set -e

echo "INIT1"
tfile="/var/tmp/init1"
#if [[ ! -f "$tfile" ]]; then
if [[ -f "$tfile" ]]; then
    echo "INIT2"
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user mysql > /dev/null
    echo 'INSTALL'
    MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}
    MYSQL_DATABASE=${MYSQL_DATABASE:-""}
    MYSQL_USER=${MYSQL_USER:-""}
    MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}


    cat << EOF > $tfile
INSTALL PLUGIN pinba SONAME 'libpinba_engine.so';
CREATE DATABASE pinba;
EOF

    /usr/sbin/mysqld --bootstrap --verbose=0 < $tfile
    #rm -f $tfile

    #TERM=dumb mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD} pinba < /usr/local/share/pinba_engine/default_tables.sql
    /usr/sbin/mysqld --bootstrap --verbose=0 < /usr/local/share/pinba_engine/default_tables.sql

    CONF_FILE="/etc/mysql/conf.d/pinba-server.cnf"
    cat <<EOF>$CONF_FILE
[mysqld]
pinba_stats_gathering_period=${PINBA_STATS_GATHERING_PERIOD:-10000}
pinba_stats_history=${PINBA_STATS_HISTORY:-900}
pinba_temp_pool_size=${PINBA_TEMP_POOL_SIZE:-10000}
pinba_request_pool_size=${PINBA_REQUEST_POOL_SIZE:-1000000}
SET explicit_defaults_for_timestamp=1
EOF

fi

#exec /usr/sbin/mysqld
#mysqld --user=mysql
/usr/bin/mysqld_safe --datadir="/var/lib/mysql"
# --plugin-load=libpinba_engine.so \
#&& mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SOURCE /usr/share/mysql/innodb_memcached_config.sql;"
