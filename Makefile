
build-nginx:
	sudo docker build -t nginx srcs/requirements/nginx

run-nginx:
	sudo docker run -p 443:443 nginx

install-docker:
	sudo apt update
	sudo apt install -y docker.io docker-compose

clear:
	docker rm -f $$(docker ps -aq)