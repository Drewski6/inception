FROM alpine:3.19

RUN apk update && \
# openrc for rc-service, and mariadb
    apk add openrc mariadb mariadb-client mariadb-server-utils && \
    mkdir -p /run/openrc && \
    touch /run/openrc/softlevel
    # mkdir -p /var/lib/mysql && \
    # chown -R mysql:mysql /var/lib/mysql && \
    # mkdir -p /run/mysqld && \
    # chown -R mysql:mysql /run/mysqld

#COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
# COPY ./conf/mariadb-server.cnf /etc/my.cnf

# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# CMD ["rc-service", "mariadb", "start"]