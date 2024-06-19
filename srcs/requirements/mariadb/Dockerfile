# Container's OS
FROM debian:bullseye

# Dependencies installation
RUN apt update && apt upgrade -y
RUN apt install mariadb-server -y
RUN apt install vim -y 

# Giving necessary rights to user in appropriate folder
RUN mkdir -p /var/run/mysqld
RUN chmod 777 /var/run/mysqld 
RUN chown -R mysql:mysql /var/run/mysqld

# Copying nginx.conf in the appropriate directory
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copying our initialisation script in the container
COPY ./tools/mariadb.sh   mariadb.sh
RUN  chmod +x mariadb.sh

# Exposing port 3306 of our container
EXPOSE 3306

# Running the initialisation script that will run mariadb service in the end
CMD ["./mariadb.sh"]
