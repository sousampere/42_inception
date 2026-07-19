

start-nginx:
	docker build -t nginx srcs/requirements/nginx

clear:
	docker rm -f $$(docker ps -aq)