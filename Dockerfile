FROM node:8-alpine

LABEL maintainer="angristan"
LABEL source="https://github.com/angristan/docker-riot"

ARG RIOT_VER=v0.16.3

RUN apk update \
    && apk add --no-cache \
        curl \
        git \
        libevent \
        libffi \
        libjpeg-turbo \
        libssl1.0 \
        sqlite-libs \
        unzip \
    && npm config set unsafe-perm true \
    && npm install -g webpack http-server \
    && curl -L https://github.com/vector-im/riot-web/archive/$RIOT_VER.zip -o riot.zip \
    && unzip riot.zip \
    && rm riot.zip \
    && mv riot-web-* riot-web \
    && cd riot-web \
    && npm install \
    && npm run build \
    && apk del \
        git \
        unzip \
    && rm -rf /var/lib/apk/* /var/cache/apk/*

WORKDIR /riot-web/webapp

EXPOSE 8765

CMD ["http-server", "-p", "8765", "-A", "0.0.0.0"]
