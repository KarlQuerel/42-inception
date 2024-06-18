# OS version
FROM	debian:bullseye

# Dependencies installation
RUN		apt update && apt upgrade -y && apt install -y	\
		wget		\
		php7.4		\
		php-fpm		\
		php-mysql	\
		mariadb-client

# Wordpress installation using wget
RUN		wget https://fr.wordpress.org/wordpress-6.4-fr_FR.tar.gz -P /var/www
RUN		cd /var/www && tar -xzf wordpress-6.4-fr_FR.tar.gz && rm wordpress-6.4-fr_FR.tar.gz  
RUN		cp -r /var/www/wordpress/. /var/www/html
RUN		rm -rf /var/www/wordpress
RUN		chown -R root:root /var/www/html

# Copying conf file
COPY	./conf/www.conf  /etc/php/7.4/fpm/pool.d/www.conf

# Wordpress CLI installation
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar

# Copying our configuration script within the container
COPY	./tools/wordpress_config.sh .
RUN		chmod +x wordpress_config.sh

# Folder creation to run PHP
RUN		mkdir -p /run/php

# Exposing port 9000
EXPOSE	9000

# Running script
CMD		[ "./wordpress_config.sh"]
