
# User documentation

## Stack services

This composition is made of three different dockers.

### Nginx server

This is the main HTTPS server, where user can connect to it using `https://<server_ip>`. It only accepts TLS v1.2 and TLS v1.3 security.

### Wordpress + PHP-FPM server

This docker is used to host wordpress and translate its code using the PHP-FPM gateway. It runs on port `9000` by default.

### MariaDB database

This docker is where wordpress program stores its data, in the database. It runs on port `3306` by default.

## Starting the containers

To start the docker compose, use the following make command :

Initial installation (only the first time):
```bash
make install
```

Running the containers :
```bash
make run
```

## Accessing the administration pannel

You can manage the wordpress server by going to `https://<server_ip>/wp-admin` and logging-in using the credentials used in the .env file when you created the containers.

## Credentials

The credentials can therefore be modified from the administration at `https://<server_ip>/wp-admin/users.php`.

## Verifying status

You can verify that the dockers are up using the `docker ps` command. All three dockers should have the `Up` status.
