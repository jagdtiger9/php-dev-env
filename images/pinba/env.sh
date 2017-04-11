#!/bin/bash

LD_PRELOAD=/local/mysql/lib/libjemalloc.so
export LD_PRELOAD

for arg in "$@"
do
  #echo "Arg #$index = $arg"
  let "index+=1"
done

# /local/mysql/bin/mysqld 
#    --basedir=/local/mysql 
#    --datadir=/local/mysql/data 
#    --plugin-dir=/local/mysql/lib/plugin 
#    --user=mysql
#    --log-error=/local/mysql/var/mysqld.log 
#    --pid-file=/local/mysql/data/mysqld.pid 
#    --socket=/local/mysql/var/mysql.sock' 
#    --init-file=/local/mysql/init.sql
START=($@ "--init-file=/local/mysql/init.sql")
echo ${START[@]}

exec ${START[@]}

