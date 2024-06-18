# OS version
FROM	debian:bullseye

# Dependencies installation
RUN		apt update && apt upgrade -y && apt install -y \
		mariadb-server  \
		vim

# Giving necessary rights to user
RUN		mkdir -p /var/run/mysqld
RUN		chmod 777 /var/run/mysqld
RUN		chown -R mysql:mysql /var/run/mysqld

# Copying NGINX conf
COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copying init script
COPY	./tools/mariadb.sh mariadb.sh
RUN		chmod +x mariadb.sh

# Exposing port 3306
EXPOSE	3306

# Running script
CMD		[ "./mariadb.sh" ]