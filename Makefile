ifneq ("$(wildcard srcs/.env)","")
  include srcs/.env
  export
endif


COMPOSE_FILE   := srcs/docker-compose.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

DATADIR := $(INCEPTION_DATA_DIRECTORY)
MARIADB := $(MARIADB_DATA_DIRECTORY)
WORDPRESS := $(WORDPRESS_DATA_DIRECTORY)


all: up add-hosts

add-hosts:
	@if ! grep -q "${DOMAIN_NAME}" /etc/hosts; then \
		echo "Adding ${DOMAIN_NAME} to /etc/hosts. Please provide your sudo password if prompted."; \
		echo "127.0.0.1 ${DOMAIN_NAME}" | sudo tee -a /etc/hosts > /dev/null; \
		echo "${DOMAIN_NAME} added to /etc/hosts"; \
	fi


up: $(MARIADB) $(WORDPRESS)
	@$(DOCKER_COMPOSE) up --build -d

down:
	@$(DOCKER_COMPOSE) down

re: down up

clean: down
	sudo rm -rf $(DATADIR)

fclean: clean
	@$(DOCKER_COMPOSE) down -v --rmi all

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
	docker volume create $(COMPOSE_PROJECT_NAME)_mariadb_data
	docker volume create $(COMPOSE_PROJECT_NAME)_wordpress_data

.PHONY: all up down re clean fclean ps logs volumes