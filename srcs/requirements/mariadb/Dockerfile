FROM alpine:3.19

RUN apk update && \
    apk add --no-cache bash mariadb mariadb-client mariadb-server-utils && \
    mkdir -p /scripts

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

COPY ./tools/docker-entrypoint.sh /scripts/docker-entrypoint.sh

RUN chmod +x /scripts/docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/scripts/docker-entrypoint.sh"]