

VOLUMES_LOCATION = /Users/gaspard/data

re: clean install
	docker compose -f srcs/docker-compose.yaml build wordpress mariadb nginx
	docker compose -f srcs/docker-compose.yaml down -v

install:
	mkdir $(VOLUMES_LOCATION)/mysql
	mkdir $(VOLUMES_LOCATION)/wordpress
	sudo docker build -t mariadb srcs/requirements/mariadb
	sudo docker build -t wordpress srcs/requirements/wordpress
	sudo docker build -t nginx srcs/requirements/nginx

run:
	docker compose -f srcs/docker-compose.yaml up

dbshell:
	docker exec -it $$(docker compose -f srcs/docker-compose.yaml ps -q mariadb) /bin/bash

clear_containers:
	-docker rm $$(docker ps -aq)

clear_volumes:
	-docker volume rm srcs_db-data
	rm -rf $(VOLUMES_LOCATION)/mysql
	-docker volume rm srcs_wp-data
	rm -rf $(VOLUMES_LOCATION)/wordpress

install-docker:
	sudo apt update
	sudo apt install -y docker.io docker-compose

clean: clear_containers clear_volumes
