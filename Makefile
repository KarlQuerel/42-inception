# List of source files required for building Docker images and configurations
SRCS = ./srcs/requirements/nginx/Dockerfile \
					./srcs/requirements/nginx/conf/nginx.conf \
					./srcs/requirements/mariadb/Dockerfile \
					./srcs/requirements/mariadb/conf/50-server.cnf \
					./srcs/requirements/mariadb/tools/mariadb.sh \
					./srcs/requirements/wordpress/Dockerfile \
					./srcs/requirements/wordpress/tools/wp_config.sh \
					./srcs/requirements/wordpress/conf/www.conf \

# Default target 'all': builds Docker containers, sets up volumes, and starts services
all : ${SRCS} env_file create_volumes_repo
			docker compose -f ./srcs/docker-compose.yml up -d --build

# Target 'env_file': copies .env file if it doesn't exist in srcs directory
env_file : 
						@if [ ! -e /srcs/.env ]; \
						then \
							cp /home/kquerel/.env ./srcs/; \
						fi; 

# Target 'create_volumes_repo': creates necessary directories for volumes
create_volumes_repo :
						
						@if [ ! -d /home/kquerel/data/ ]; \
						then \
							mkdir /home/kquerel/data; \
						fi ; \
						if [ ! -d /home/kquerel/data/wordpress ]; \
						then \
							mkdir /home/kquerel/data/wordpress; \
						fi ; \
						if [ ! -d /home/kquerel/data/mariadb ]; \
						then \
							mkdir /home/kquerel/data/mariadb; \
						fi ; 

# Target 'down': stops and removes Docker containers
down	: ${SRCS} env_file
			docker compose -f ./srcs/docker-compose.yml down 

# Target 'clean': stops containers, removes images and volumes, cleans up Docker system
clean : down
				
				@if [ "docker images nginx" ]; \
				then \
					docker rmi -f nginx; \
				fi ; \
				if [ "docker images mariadb" ]; \
				then \
					docker rmi -f mariadb; \
				fi ; \
				if [ "docker images wordpress" ]; \
				then \
					docker rmi -f wordpress; \
				fi ; \
				if [ "docker volume ls -f name=srcs_mariadb" ]; \
				then \
					docker volume rm -f srcs_mariadb; \
				fi ; \
				if [ "docker volume ls -f name=srcs_wordpress" ]; \
				then \
					docker volume rm -f wordpress; \
				fi ; \
				docker system prune -af;

# Target 'fclean': removes all data and volumes related to the project
fclean : clean 
					sudo rm -rf /home/kquerel/data

# Target 're': performs a full clean and rebuild
re : fclean all

# Declare targets as phony to avoid conflicts with files of the same names
.PHONY: all re down clean fclean env_file create_volumes_repo
