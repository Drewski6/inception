#!/bin/sh

fdate() {
	echo $(date '+%Y-%m-%d %H:%M:%S')
}

echo "$(fdate) [info] Starting MariaDB"

#############################################################
# NOTE                                                      #
# ----                                                      #
# MariaDB is a fork of MySQL so you may see some references #
# to MySQL in the code. This is normal for MariaDB.         #
#############################################################

# Create /run/mysqld directory and set owner to mysql user.
if [ -d "/run/mysqld" ]; then
	echo "$(fdate) [info] mysqld already present, skipping creation"
	chown -R mysql:mysql /run/mysqld
else
	echo "$(fdate) [info] mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# Create /var/lib/mysql directory and set owner to mysql user.
if [ -d /var/lib/mysql/mysql ]; then
	echo "$(fdate) [info] MariaDB directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
    echo "$(fdate) [info] MariaDB data directory not found, creating initial DBs"
	chown -R mysql:mysql /var/lib/mysql

    mysql_install_db --user=mysql --datadir=/var/lib/mysql # > /dev/null

    echo "$(fdate) [info] MariaDB root password: $MYSQL_ROOT_PASSWORD"
    echo "$(fdate) [info] MariaDB password: $MYSQL_PASSWORD"
    echo "$(fdate) [info] MariaDB user: $MYSQL_USER"
    echo "$(fdate) [info] MariaDB database: $MYSQL_DATABASE"
fi

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@