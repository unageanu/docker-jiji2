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
  6f64048c64d1        dockerjiji2_nginx   "nginx -g 'daemon off"   22 seconds ago      Up 18 seconds           80/tcp, 0.0.0.0:8443->443/tcp   jiji_nginx
  acc18e111906        dockerjiji2_jiji    "pumactl -S /var/run/"   25 seconds ago      Up 22 seconds           8080/tcp                        jiji_jiji
  407fa85328b4        mongo:3.0.7         "/entrypoint.sh mongo"   27 seconds ago      Up 25 seconds           0.0.0.0:27018->27017/tcp        jiji_mongodb
```

- port 8443  .. jiji
- port 27018 .. mongodb
