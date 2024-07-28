DOCKER_COMPOSE = docker compose

all: up

build:
	$(DOCKER_COMPOSE) build

# Run the containers in the background (-d)
up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

# adds the Follow flag to logs which will show the logs in real-time
logs:
	$(DOCKER_COMPOSE) logs -f

restart: down up

.PHONY: all build up down logs restart