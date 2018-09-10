FROM node:8-alpine as build

LABEL maintainer="angristan"
LABEL source="https://github.com/angristan/docker-riot"

ARG RIOT_VER=v0.16.4

RUN apk update \
    && apk add --no-cache \
        curl \
        git \
        unzip \
    && curl -L https://github.com/vector-im/riot-web/archive/$RIOT_VER.zip -o riot.zip \
    && unzip riot.zip \
    && rm riot.zip \
    && mv riot-web-* riot \
    && cd riot \
    && npm install \
    && npm run build \
    && npm cache clean --force \
    && cd .. \
    && mv riot/webapp/ app/ \
    && rm -rf riot \
    && apk del \
        curl \
        git \
        unzip \
    && rm -rf /var/lib/apk/* /var/cache/apk/*

FROM nginx:stable-alpine  

COPY --from=build /app /usr/share/nginx/html
