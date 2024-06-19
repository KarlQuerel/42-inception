# Container's OS
FROM debian:bullseye

# Dependencies installation
RUN apt update && apt upgrade -y
RUN apt install nginx -y
RUN apt install vim -y 
RUN apt install curl -y
RUN apt install openssl -y

# SSL certificates attribution
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=[kquerel.42.fr](http://kquerel.42.fr/)/UID=kquerel"

# Putting nginx.conf in the right directory
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

# Giving necessary rights to user in appropriate folder
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Exposing port 443 of our container
EXPOSE 443

# Launching nginx 
CMD [ "nginx", "-g", "daemon off;" ]
