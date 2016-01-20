# docker-jiji2 (BETA)

Make a jiji application environment using the Docker.

### Prerequisites
```sh
  $ sudo docker --version
  Docker version 1.9.0, build 76d6bc9
  $ sudo docker-compose --version
  docker-compose version: 1.5.0
```

### Usage

```sh
  $ git clone https://github.com/unageanu/docker-jiji2
  $ cd docker-jiji2
  $ sudo docker-compose up -d
  $ sudo docker ps
  CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                      NAMES
  0814bcf5680c        dockerjiji2_jiji    "pumactl -S /var/run/"   About a minute ago   Up 3 seconds        0.0.0.0:8080->8080/tcp     jiji_jiji
  123a3904489d        mongo:3.0.7         "/entrypoint.sh mongo"   5 minutes ago        Up 4 seconds        0.0.0.0:27017->27017/tcp   jiji_mongodb
```

- port 8080  .. jiji
- port 27017 .. mongodb
