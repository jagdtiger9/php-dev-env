CREATE USER ${MYSQL_REPL_USER}@'%' IDENTIFIED BY {$MYSQL_REPL_PASS};
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO ${MYSQL_REPL_USER}@'%';
GRANT SELECT, INSERT, DELETE, UPDATE ON *.* TO ${MYSQL_REPL_USER}@'%';
FLUSH PRIVILEGES;