#!/bin/bash

set -ux

stamp() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') 0 [info] inception:"
}

echo "$(stamp) Starting MariaDB"

# For debugging, print some env vars
# echo "$(stamp) MariaDB root password: $MYSQL_ROOT_PASSWORD"
# echo "$(stamp) MariaDB password: $MYSQL_PASSWORD"
# echo "$(stamp) MariaDB user: $MYSQL_USER"
# echo "$(stamp) MariaDB database: $MYSQL_DATABASE"


#############################################################
# NOTE                                                      #
# ----                                                      #
# MariaDB is a fork of MySQL so you may see some references #
# to MySQL in the code. This is normal for MariaDB.         #
#############################################################

# Create /var/lib/mysql directory and set owner to mysql user.
if [ -d /var/lib/mysql/mysql ]; then
	echo "$(stamp) MariaDB directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
    echo "$(stamp) MariaDB data directory not found, creating initial DBs"
	chown -R mysql:mysql /var/lib/mysql

    mysql_install_db --user=mysql --datadir=/var/lib/mysql # > /dev/null

	tempfile=`mktemp`
	if [ ! -f "$tempfile" ]; then
	    return 1
	fi

	cat << EOF > $tempfile
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES ;
EOF

	if [ "$MYSQL_DATABASE" != "" ]; then
	    echo "$(stamp) Creating database: $MYSQL_DATABASE"
		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tempfile
		echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tempfile
	fi
	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tempfile
	rm -f $tempfile
	echo "$(stamp) MySQL init process done. Ready for start up."

fi

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@