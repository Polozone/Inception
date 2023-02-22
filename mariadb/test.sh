#!/bin/bash

if [ ! -d /var/lib/mysql/${WORDPRESS_DB_NAME} ]
then
    service mysql start
    sleep 3
    mysql -e "CREATE DATABASE ${WORDPRESS_DB_NAME};"
    mysql -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PWD}';"
    mysql -e "GRANT ALL ON *.* to '${USERNAME_WP}'@localhost IDENTIFIED BY '${MARIADB_PWD}';"
    mysql -e "GRANT ALL ON *.* to '${USERNAME_WP}'@'%' IDENTIFIED BY '${MARIADB_PWD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PWD}';"
    mysql -e "FLUSH PRIVILEGES;"
    service mysql stop
fi

tail -f /dev/null