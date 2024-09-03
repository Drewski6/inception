#############################################
# BASE COMMANDS								#
#############################################

all:
	docker compose -f ./srcs/docker-compose.yml up -d

up: all

down:
	docker compose -f ./srcs/docker-compose.yml down

status:
	docker ps -a && docker images && docker volume ls && docker network ls

clean: down
	docker container prune -f &&\
	docker image prune -af &&\
	docker volume prune -af &&\
	docker network prune -f

fclean: clean
	docker system prune -af

re: fclean all

# fast re (doesnt do docker system prune -af)
fre: clean all

#############################################
# TESTS										#
#############################################

serv_test:
	docker compose -f ./srcs/docker-compose.yml exec nginx bash

db_test:
	docker compose -f ./srcs/docker-compose.yml exec mariadb bash

wp_test:
	docker compose -f ./srcs/docker-compose.yml exec wordpress bash

.PHONY: all, down, status, clean, re, serv_test, db_test