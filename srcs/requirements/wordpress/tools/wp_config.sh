#!/bin/bash

# Check if the WordPress configuration file already exists
if [ -f /var/www/html/wp-config.php ]; then
	echo "Database already exists."

else
	sleep 15

	# Create the WordPress configuration file using WP-CLI
	./wp-cli.phar config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path='/var/www/html'

	# Install WordPress core using WP-CLI
	./wp-cli.phar core install --allow-root \
		--url=$DOMAIN_NAME \
		--title=$SITE_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWD \
		--admin_email=$WP_ADMIN_EMAIL \
		--path='/var/www/html'

	# Create a new WordPress user with the role of 'author' using WP-CLI
	./wp-cli.phar user create $WP_SECOND_USER $WP_SECOND_MAIL \
		--user_pass=$WP_SECOND_PASSWD \
		--allow-root \
		--role=author \
		--path='/var/www/html'
fi

# Start PHP-FPM in the foreground
exec /usr/sbin/php-fpm7.4 -F
