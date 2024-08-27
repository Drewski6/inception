FROM alpine:3.19

RUN apk update && \
    apk add --no-cache bash mariadb mariadb-client mariadb-server-utils && \
    mkdir -p /scripts

COPY ./tools/docker-entrypoint.sh /scripts/docker-entrypoint.sh

RUN chmod +x /scripts/docker-entrypoint.sh

ENTRYPOINT ["bash", "/scripts/docker-entrypoint.sh"]