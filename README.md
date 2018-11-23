# Riot

![https://hub.docker.com/r/angristan/riot/](https://img.shields.io/microbadger/image-size/angristan/riot.svg?maxAge=3600&style=flat-square) ![https://hub.docker.com/r/angristan/riot/](https://img.shields.io/microbadger/layers/angristan/riot.svg?maxAge=3600&style=flat-square) ![https://hub.docker.com/r/angristan/riot/](https://img.shields.io/docker/pulls/angristan/riot.svg?maxAge=3600&style=flat-square) ![https://hub.docker.com/r/angristan/riot/](https://img.shields.io/docker/stars/angristan/riot.svg?maxAge=3600&style=flat-square)

[Riot](https://about.riot.im/) is an open-source web client for [Matrix](https://matrix.org/), the open standard for interoperable, decentralised, real-time communication over IP.

This image is automatically built by [GitLab CI](https://gitlab.com/angristan/docker-riot/pipelines) and pushed to the [Docker Hub](https://hub.docker.com/r/angristan/riot/).

Besides manual updates, the images are automatically rebuilt every week to make sure all softwares in the images are up-to-date.

## Features

Note: Riot is not a server. This image only builds static ressources and serves them with Nginx.

- Light! (*see below*)
- Multi-stage build. Build on `node:8-alpine` and copy the built files to `nginx:stable-alpine`.
- Running the latest stable version of [vector-im/riot-web](https://github.com/vector-im/riot-web), built from source

### Build-time variables

- **`RIOT_VER`** : [version of Riot](https://github.com/vector-im/riot-web/releases) (`0.17.7`)

### Running the container

```sh
docker run -d \
  --name riot \
  -p 127.0.0.1:8080:80 \
  angristan/riot:0.17
```

### Docker Compose

A `docker-compose.yml` example:

```yml
version: '3'

services:
  riot:
    image: angristan/riot:0.17
    container_name: riot
    restart: always
    ports:
      - 127.0.0.1:8080:80
```

Then use a reverse proxy to access your riot client on a domain via HTTPS.

If you use Nginx, here is the location block you want to use in your vhost:

```nginx
location / {
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass http://localhost:8080;
}
```

## Credits

This image is based on [silvio/matrix-riot-docker](https://github.com/silvio/matrix-riot-docker).

I made mine because it wasn't updated regularly and I made quite a lot of changes to the repo so that it meet my standards. It's also **much** simpler, and **1/9th the size**.
