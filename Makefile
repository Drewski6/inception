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

#############################################
# TESTS										#
#############################################

test_serv:
	docker compose -f ./srcs/docker-compose.yml exec serv sh

.PHONY: all, down, status, clean, test_serv