FROM alpine:3.19

RUN apk update && \
    apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
    mkdir -p /scripts

COPY ./tools/docker-entrypoint.sh /scripts/docker-entrypoint.sh

RUN chmod +x /scripts/docker-entrypoint.sh

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]