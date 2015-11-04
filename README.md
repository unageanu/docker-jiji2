# docker-jiji2 (ALPHA)

Make a jiji application environment using the Docker.

### Usage

```sh
  $ git clone https://github.com/unageanu/docker-jiji2
  $ sudo docker build -t jiji2 --rm=true docker-jiji2/
  $ sudo docker run -d -t -p 37017:27017 -p 12812:2812 -p 10080:80 --name jiji2 jiji2
```

- 10080 .. jiji server
- 37017 .. mongodb
- 12812 .. monit web server
