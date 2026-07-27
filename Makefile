

VOLUMES_LOCATION = /home/gtourdia/data

re: clean install
	docker compose -f srcs/docker-compose.yml down -v
	docker compose -f srcs/docker-compose.yml build wordpress mariadb nginx

install:
	mkdir -p $(VOLUMES_LOCATION)/mysql
	mkdir -p $(VOLUMES_LOCATION)/wordpress
	docker compose -f srcs/docker-compose.yml build

run:
	docker compose -f srcs/docker-compose.yml up

dbshell:
	docker exec -it $$(docker compose -f srcs/docker-compose.yml ps -q mariadb) /bin/bash

clear_containers:
	docker compose -f srcs/docker-compose.yml down
	-docker rm $$(docker ps -aq)

clear_volumes:
	-docker compose -f srcs/docker-compose.yml down
	-docker volume rm srcs_db-data
	rm -rf $(VOLUMES_LOCATION)/mysql
	-docker volume rm srcs_wp-data
	rm -rf $(VOLUMES_LOCATION)/wordpress

install-docker:
	sudo apt update
	sudo apt install -y docker.io docker-compose

clean: clear_containers clear_volumes
