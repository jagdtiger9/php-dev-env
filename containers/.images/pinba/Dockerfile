FROM tony2001/pinba

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

# Customize my.cnf
#COPY my.cnf /local/mysql/etc/my.cnf
COPY init.sql /local/mysql/init.sql
RUN chown mysql:mysql /local/mysql/init.sql

# Customize startup script
# default entrypoint is ["/local/mysql/bin/env.sh"]
# default cmd is ["/local/mysql/bin/mysqld", "--basedir=/local/mysql", "--datadir=/local/mysql/data", "--plugin-dir=/local/mysql/lib/plugin", "--user=mysql", "--log-error=/local/mysql/var/mysqld.log", "--pid-file=/local/mysql/data/mysqld.pid", "--socket=/local/mysql/var/mysql.sock"]
COPY env.sh /local/mysql/bin/env.sh

# Persists data into data volume
VOLUME /local/mysql/data

# expose extraport for pinba
EXPOSE 30002 3306
