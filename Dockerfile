FROM frolvlad/alpine-oraclejdk8

ENV RIENMANN_VERSION=0.2.9
ENV RIEMANN_PATH_CONF=/home/riemann
ENV RIEMANN_CONFIG=/home/riemann/riemann.config
RUN apk -U add curl bash

RUN adduser -D riemann
USER riemann
WORKDIR /home/riemann

RUN curl -o riemann.tar.bz2 https://aphyr.com/riemann/riemann-$RIENMANN_VERSION.tar.bz2 && \
    tar -xj -f riemann.tar.bz2

ADD riemann.config riemann.config

## 5555 - Riemann TCP and UDP
## 5556 - Riemann WS
EXPOSE 5555 5555/udp 5556

ENTRYPOINT './riemann-$RIENMANN_VERSION/bin/riemann'
CMD '/home/riemann/riemann.config'
