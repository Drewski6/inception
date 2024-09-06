# Penultimate version of alpine linux
FROM alpine:3.19

# Adding "edge" repo for php-fpm
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Get bash, wget (for wordpress cli) and the php stuff
RUN apk update && \
    apk add bash wget php php-fpm php-mysqli php-phar php-iconv

# Use wget to get the wp-cli, add exec and move to wp bin
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

# Check if group exists before creating www-data
RUN getent group nginx || addgroup -S nginx && \
    getent passwd nginx || adduser -S -G nginx nginx

RUN chmod 755 /var/www/html && \
    chown -R nginx:nginx /var/www/html

# Get the mariadb client and wordpress
RUN apk add mariadb-client
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

# Give the ownership of the files to the user nginx
# NOTE for some reason not recognizing the nginx user or group
# RUN chmod -R 755 /var/www/*
# RUN addgroup -g 40 nginx
# RUN adduser -u 40 -g nginx nginx
# RUN chown -R nginx:nginx /var/www/*

# Copy the wp-config.php file
# COPY ./conf/www.conf /etc/php/php-fpm.d/www.conf
COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

# Move the script into the container
COPY ./tools/docker-entrypoint.sh /scripts/docker-entrypoint.sh

ENTRYPOINT [ "bash", "/scripts/docker-entrypoint.sh" ]