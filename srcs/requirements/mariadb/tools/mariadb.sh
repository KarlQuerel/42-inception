#!/bin/bash

# Check if the specified database directory exists
if [ -d /var/lib/mysql/$SQL_DATABASE ]; then
	echo "DATABASE HAS ALREADY BEEN CREATED."

else

	# Start the MariaDB service
	service mariadb start

	sleep 3

	# Create the database if it doesn't already exist
	echo "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;" | mariadb -u root

	# Create a new user with the specified username and password if it doesn't already exist
	echo "CREATE USER IF NOT EXISTS $SQL_USER@'localhost' IDENTIFIED BY '$SQL_PASSWORD';" | mariadb -u root

	# Grant all privileges on the database to the new user
	echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'%' IDENTIFIED BY '$SQL_PASSWORD';" | mariadb -u root

	# Change the root user's password to the specified root password
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';" | mariadb -u root

	# Reload the privilege tables to ensure all changes take effect
	echo "FLUSH PRIVILEGES;" | mariadb -u root -p$SQL_ROOT_PASSWORD

	# Stop the MariaDB service by killing its process
	kill $(cat /var/run/mysqld/mysqld.pid)

fi

sleep 3

# Start the MariaDB server in safe mode
exec mysqld_safe
