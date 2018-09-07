FROM node:8-alpine

LABEL maintainer="angristan"
LABEL source="https://github.com/angristan/docker-riot"

ARG RIOT_VER=v0.16.3

RUN apk update \
    && apk add --no-cache \
        curl \
        git \
        unzip \
    && npm config set unsafe-perm true \
    && npm install -g http-server \
    && curl -L https://github.com/vector-im/riot-web/archive/$RIOT_VER.zip -o riot.zip \
    && unzip riot.zip \
    && rm riot.zip \
    && mv riot-web-* riot \
    && cd riot \
    && npm install \
    && npm run build \
    && apk del \
        git \
        unzip \
        curl \
    && rm -rf /var/lib/apk/* /var/cache/apk/*

WORKDIR /riot/webapp

EXPOSE 8080

CMD ["http-server", "-p", "8765", "-A", "0.0.0.0"]
