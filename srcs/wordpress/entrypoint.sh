#!/bin/bash

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]
then
	while ! mysql -h mariadb --user=${MARIADB_USER} --password=${MARIADB_PWD} -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name='${WORDPRESS_DB_NAME}'"; do
  		echo "Waiting for database to be created..."
  		sleep 5
	done
	echo "Starting installation wordpress"
	wp core download --allow-root

	wp config create --dbname=${WORDPRESS_DB_NAME} --dbhost=${DB_HOST} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PWD} --locale=ro_RO --allow-root

	wp core install --url=${URL_WP} --admin_user=${ADMIN_USER_WP} --admin_password=${ADMIN_PWD_WP} --title=inception --admin_email=${ADMIN_MAIL_WP} --allow-root

	echo "Wordpress successfully installed"
else
	echo "No need to install wordpress"
fi

service php7.3-fpm start && service php7.3-fpm stop
php-fpm7.3 -F
