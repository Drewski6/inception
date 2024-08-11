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

clean:
	docker container prune -f &&\
	docker image prune -af &&\
	docker volume prune -af &&\
	docker network prune -f

re: down clean all

#############################################
# TESTS										#
#############################################

serv_test:
	docker compose -f ./srcs/docker-compose.yml exec serv sh

db_test:
	docker compose -f ./srcs/docker-compose.yml exec db sh

.PHONY: all, down, status, clean, re, serv_test, db_test