*This project has been created as part of the 42 curriculum by gtourdia*

# 42 Inception

42 project about creating docker-containers to ship applications executable on any machine

<p align="center">
  <a href="https://gaspardtourdiat.fr">
    <img src="https://github.com/sousampere/sousampere/blob/main/assets/42_inception.png?raw=true" alt="banner" />
  </a>
</p>

# Description

This project is a 42 project that aims to make the student learn how to create Docker containers, use Docker compose and secrets file, by creating a ready-to-deploy website. The student has to configure one docker, a HTTPS nginx server that bridges to a second docker, wordpress server using hosting a PHP-FPM gateway, conneced to a third docker, a mariadb database.

All these dockers are orchestrated using a `docker-compose.yml` file.

# Instructions

Before running the docker, a small configuration is needed. Fill the files at `./secrets/<file>.txt` with the confidential credentials you want for your website, and copy the `.env.example` into a `.env` file, filling again the values you want.

Then, you can start the build of the containers using (on an unix-based OS) :

```bash
make install
```

And then you can run it with :

```bash
make run
```

Also, it is recommanded to run the script on a debian machine, because the default path of where the persistant storage is located is `/home/gtourdia/data`, to comply with the subject.

# Ressources

- [Docker bases](https://www.youtube.com/watch?v=eGz9DS-aIeY)
- [Docker bases 2](https://www.youtube.com/watch?v=ES4BcZcsBdU)
- [Entrypoint / CMD](https://www.youtube.com/watch?v=R0toi5gaYbc)
- [Docker secrets](https://www.youtube.com/watch?v=gpTepRK1z3E)
- AI was used to troubleshoot problems and different Docker notions

# Project description

### Why Docker and not a VM ?

Docker is an easy and lightwheight way of distributing code that will work on any machine, whatever the OS is. It uses directly the kernel of its host instead of simulating components, which is more efficient.

### Why secrets and not a .env variables ?

Secrets are encrypted directly into the docker image. Env vriables are readable from anyone who has access to the file. This is why I put sensitive data into the secrets and normal variables into the .env variables.

### Why docker network and not the host network ?

The docker network is used to make every container being able to access each other if in the same docker network. It's secure, and easy to open to the real host network if needed.

### The difference between docker volumes and bind mounts ?

Volumes are managed by Docker. Bind mounts rely on the host filesystem. 

# Author

- [@sousampere](https://github.com/sousampere)

## 🚀 About Me
I am a student at the 42 Mulhouse school. Most of my public projects will be from this school, while I will keep private most of my other projects.

## Contact me !

 - [LinkedIn](https://fr.linkedin.com/in/gaspardtourdiat)
 - [My website](https://gaspardtourdiat.fr/)
 - [For 42 students (my intra profile)](https://profile.intra.42.fr/users/gtourdia)


![Logo](https://github.com/sousampere/sousampere/blob/main/42mulhouse.png?raw=true)