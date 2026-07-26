
# Developper documentation

## Setup environment

### Requirements

Install `docker` on your machine before starting.

```bash
make install-docker # easy install on debian
```

### .env setup

The following .env file needs to be filled before building the docker images :

```bash
MYSQL_ROOT_PASSWORD=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=

DOMAIN_NAME=
WP_TITLE=
WP_ADMIN_USER=
WP_ADMIN_PASSWORD=
WP_ADMIN_EMAIL=

WP_USER=
WP_USER_EMAIL=
WP_USER_PASSWORD=
```

## Build the docker containers

Easy build with makefile on Linux/MacOS : 

```bash
make install
```

Else :

- Create a directory at /home/<login>/data/mysql
- Create a directory at /home/<login>/data/wordpress
- Build the images with 
    - `sudo docker build -t mariadb srcs/requirements/mariadb`
    - `sudo docker build -t wordpress srcs/requirements/wordpress`
    - `sudo docker build -t nginx srcs/requirements/nginx`

## Start the docker containers

```bash
docker compose -f srcs/docker-compose.yml up
```

You can stop-it with CTRL+C.

## Containers management

### Shell access

Drop into a container's shell using `docker exec -it $$(docker compose -f srcs/docker-compose.yml ps -q <container_name>) /bin/bash`

### Kill all containers

```bash
docker rm $$(docker ps -aq)
```
... or `make clear_containers`

### Destroy all volumes

```bash
docker volume rm srcs_db-data
rm -rf $(VOLUMES_LOCATION)/mysql
docker volume rm srcs_wp-data
rm -rf $(VOLUMES_LOCATION)/wordpress
```
... or `make clear_volumes`. It's needed that the containers using this volume have been killed.

### Containers data storage

The data of the containers is stored in the /home/<login>/data folder. It is persistant thanks to the named volume creation inside the docker compose file.

