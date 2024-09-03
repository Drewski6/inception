#!/bin/bash

set -eux

cd /var/www/html/wordpress

# sleep 10

if ! wp core is-installed; 
then
wp config create --allow-root \
    --dbname=${MYSQL_DATABASE} \
	--dbuser=${MYSQL_USER} \
	--dbpass=${MYSQL_PASSWORD} \
	--dbhost=${MYSQL_HOST} \
	--url=https://${DOMAIN_NAME};

wp core install	--allow-root \
	--url=https://${DOMAIN_NAME} \
	--title=${SITE_TITLE} \
	--admin_user=${ADMIN_USER} \
	--admin_password=${ADMIN_PASSWORD} \
	--admin_email=${ADMIN_EMAIL};

wp user create --allow-root \
	${USER_LOGIN} ${USER_MAIL} \
	--role=author \
	--user_pass=${USER_PASS} ;
fi

# Flush that cache son!
wp cache flush --allow-root

# Set to english (best language)
wp language core install en_US --activate

if [ ! -d /run/php ]; then
	mkdir -p /run/php
fi

chown -R nginx:nginx /var/www/html

exec /usr/sbin/php-fpm82 -F -R
# exec bash