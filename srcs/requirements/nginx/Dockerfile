# Penultimate version of alpine linux
FROM alpine:3.19

# Update and install required packages
RUN apk update && \
    apk add nginx openssl bash

# Create directories
RUN mkdir -p /etc/nginx/ssl && \
    mkdir -p /var/www/html/wordpress \
    mkdir -p /run/nginx

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=dpentlan.42.fr/UID=dpentlan"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]