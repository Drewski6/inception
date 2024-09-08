#!/bin/bash

# # set -eux
set -ux

# cd /var/www/html/wordpress

# # sleep 10

# if ! wp core is-installed; 
# then
# wp config create --allow-root \
#     --dbname=${MYSQL_DATABASE} \
# 	--dbuser=${MYSQL_USER} \
# 	--dbpass=${MYSQL_PASSWORD} \
# 	--dbhost=${MYSQL_HOST} \
# 	--url=https://${DOMAIN_NAME};

# wp core install	--allow-root \
# 	--url=https://${DOMAIN_NAME} \
# 	--title=${SITE_TITLE} \
# 	--admin_user=${ADMIN_USER} \
# 	--admin_password=${ADMIN_PASSWORD} \
# 	--admin_email=${ADMIN_EMAIL};

# wp user create --allow-root \
# 	${USER_LOGIN} ${USER_MAIL} \
# 	--role=author \
# 	--user_pass=${USER_PASS} ;
# fi

# # Flush that cache son!
# wp cache flush --allow-root

# # Set to english (best language)
# wp language core install en_US --activate

# if [ ! -d /run/php ]; then
# 	mkdir -p /run/php
# fi

# chown -R nginx:nginx /var/www/html

# exec /usr/sbin/php-fpm83 -F -R
# # exec bash




# !/bin/sh
echo "..Running config_wordpress.sh.."

# Waitin for mariadb to start and proper database to be created
# while ! mysql -h ${DB_HOSTNAME} -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_NAME} 2>/dev/null; do
# 	echo "Waiting for ${DB_NAME} to be created..."
# 	sleep 2
# done

echo "..MariaDB is up and running!"

############################################################################################

# Setting up wordpress config file and setting up new WP user
# First check if wordpress is already installed. Necessary when container restarts
if ! $(wp core is-installed --allow-root --path=/var/www/html/wordpress); then
	# Making sure the [www-data] user and group exists
	addgroup -g 82 -s www-data 2>/dev/null
	adduser -u 82 -D -S -G www-data www-data 2>/dev/null

	# Getting adminer.php and adminer.css
	# curl -o /var/www/html/adminer.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php
	# curl -o /var/www/html/adminer.css https://raw.githubusercontent.com/vrana/adminer/master/designs/hever/adminer.css

	echo "..Installing WordPress.."
	# Creating directory for wordpress
	mkdir -p /var/www/html/wordpress
	cd /var/www/html/wordpress

	# Downloading `wp-cli` (WordPress Command Line Interface) tool to manage manual WordPress installation
	# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	# chmod +x wp-cli.phar
	# mv wp-cli.phar /usr/local/bin/wp

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
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL};

else
	echo "..WordPress is already installed and configured!"
fi

############################################################################################

# PHP-FPM must be the main process of the container, and needs to be started in the foreground
# Since we use the latest version of PHP-FPM, we need to find the exact executable name first..

# if [ -z "${PHP_FPM}" ]; then
# 	# Find the php-fpm executable
# 	PHP_FPM=$(find $(echo $PATH | tr ":" " ") -name "php-fpm*" -type f 2>/dev/null -print -quit)

# 	echo "..php-fpm executable: $PHP_FPM"
# fi

# Starting PHP-FPM in `-F` (foreground) mode (this is needed for the container to stay up and running):
echo "..Starting php-fpm..."

exec /usr/sbin/php-fpm83 -F -R