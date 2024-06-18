# OS version
FROM	debian:bullseye

# Dependencies installation
RUN		apt update && apt upgrade -y && apt install -y \
		nginx	\
		openssl	\
		sudo	\
		vim		\
		curl

# SSL certificate
RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=kquerel.42.fr/UID=kquerel"

# Stock config files
RUN		mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf

# Giving necessary rights to user
RUN		mkdir -p /var/www/html
RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# Exposing port 443
EXPOSE	443

# Launching NGINX
CMD		[ "nginx", "-g", "daemon off;" ]