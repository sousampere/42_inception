
install:
	sudo docker build -t nginx srcs/requirements/nginx
	sudo docker build -t mariadb srcs/requirements/mariadb

run:
	docker compose -f srcs/docker-compose.yaml up

dbshell:
	docker exec -it $$(docker compose -f srcs/docker-compose.yaml ps -q mariadb) /bin/bash

clear_containers:
	docker rm $$(docker ps -aq)

build-nginx:
	sudo docker build -t nginx srcs/requirements/nginx

run-nginx:
	sudo docker run -p 443:443 nginx

install-docker:
	sudo apt update
	sudo apt install -y docker.io docker-compose

clear:
	docker rm -f $$(docker ps -aq)
