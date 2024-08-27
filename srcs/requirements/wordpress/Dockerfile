# Penultimate version of alpine linux
FROM alpine:3.19

# Get bash, wget (for wordpress cli) and the php stuff
RUN apk update && \
    apk add bash wget php php-fpm php-mysqli php-phar

# Use wget to get the wp-cli, add exec and move to wp bin
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Get the mariadb client and wordpress
RUN apk add mariadb-client
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

# Give the ownership of the files to the user www-data
# RUN chown -R www-data:www-data /var/www/*
# RUN chmod -R 755 /var/www/*

# Copy the wp-config.php file

# Move the script into the container
COPY ./tools/docker-entrypoint.sh /scripts/docker-entrypoint.sh

ENTRYPOINT [ "bash", "/scripts/docker-entrypoint.sh" ]