#!/bin/bash

set -ux

echo "..Running config_wordpress.sh.."

echo "..MariaDB is up and running!"

############################################################################################

# Making sure the [www-data] user and group exists
addgroup -g 82 -s www-data 2>/dev/null
adduser -u 82 -D -S -G www-data www-data 2>/dev/null

# Setting up wordpress config file and setting up new WP user
# First check if wordpress is already installed. Necessary when container restarts
if ! $(wp core is-installed --allow-root --path=/var/www/html/wordpress); then

	echo "..Installing WordPress.."
	# Creating directory for wordpress
	mkdir -p /var/www/html/wordpress
	cd /var/www/html/wordpress

	# Downloading WordPress files
	wp core download --allow-root --path=/var/www/html/wordpress

	# Creating wp-config.php file which will be used to access the database
	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=${MYSQL_HOST} \
		--path=/var/www/html/wordpress

	# Installing WordPress Core. This will create the WP user and password as well as the database tables
	wp core install --allow-root \
		--url=https://${DOMAIN_NAME} \
		--title="${SITE_TITLE}" \
		--skip-email \
		--path=/var/www/html/wordpress \
		--admin_user=${PRIV_USER} \
		--admin_password=${PRIV_PASSWORD} \
		--admin_email=${PRIV_EMAIL}
	
	wp user create --allow-root \
		${PUB_USER} \
		${PUB_EMAIL} \
		--role=author \
		--user_pass=${PUB_PASSWORD}

else
	echo "..WordPress is already installed and configured!"
fi

echo "..Starting php-fpm..."

exec /usr/sbin/php-fpm83 -F -R
