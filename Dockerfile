FROM frolvlad/alpine-oraclejdk8

ENV RIENMANN_VERSION=0.2.9
RUN apk -U add curl bash

RUN adduser -D riemann
USER riemann
WORKDIR /home/riemann

RUN curl -o riemann.tar.bz2 https://aphyr.com/riemann/riemann-$RIENMANN_VERSION.tar.bz2 && \
    tar -xj -f riemann.tar.bz2

ADD riemann.config /etc/riemann/riemann.config

## 5555 - Riemann TCP and UDP
## 5556 - Riemann WS
EXPOSE 7777 7776/udp 5556

CMD "./riemann-$RIENMANN_VERSION/bin/riemann"
