FROM alpine:3.5

LABEL maintainer="angristan"
LABEL source="https://github.com/angristan/docker-riot"

ARG RIOT_VER=v0.16.1

RUN apk update \
    && apk add --no-cache \
        curl \
        git \
        libevent \
        libffi \
        libjpeg-turbo \
        libssl1.0 \
        nodejs \
        sqlite-libs \
        unzip \
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


COPY start.sh /start.sh

RUN chmod +x start.sh

EXPOSE 8765

ENTRYPOINT ["/start.sh"]
