COMPOSE_FILE   := srcs/docker-compose.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

DATADIR := $(HOME)/data
MARIADB := $(DATADIR)/mariadb
WORDPRESS := $(DATADIR)/wordpress

all: build up

build: $(MARIADB) $(WORDPRESS)
	@$(DOCKER_COMPOSE) build

up: $(MARIADB) $(WORDPRESS)
	@$(DOCKER_COMPOSE) up -d

down:
	@$(DOCKER_COMPOSE) down

re: down up

clean: down
	@$(DOCKER_COMPOSE) down -v --rmi all

fclean: clean
	sudo rm -rf $(DATADIR)

ps:
	@$(DOCKER_COMPOSE) ps

logs:
	@$(DOCKER_COMPOSE) logs

volumes:
	docker volume ls
	docker volume inspect mariadb
	docker volume inspect wordpress

$(MARIADB) $(WORDPRESS):
	mkdir -p $@

.PHONY: all up down re clean fclean ps logs volumes