# Penultimate version of alpine linux
FROM alpine:3.19

# Get bash, wget (for wordpress cli) and the php stuff
RUN apk update && \
    apk add bash wget php php-fpm php-mysqli

# Use wget to get the wp-cli, add exec and move to wp bin
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp



# Move the script into the container
COPY ./tools/docker-entrypoint.sh /scripts/docker-entrypoint.sh

ENTRYPOINT [ "bash", "/scripts/docker-entrypoint.sh" ]