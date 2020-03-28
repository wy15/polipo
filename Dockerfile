#
# Dockerfile for polipo
#

FROM alpine
MAINTAINER kev <noreply@easypi.pro>
MAINTAINER mq83

ENV SS socksParentProxy=ss:1080

RUN set -xe \
    && apk add --no-cache build-base openssl tini \
    && wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
    && unzip polipo.zip \
    && cd polipo-master \
    && make \
    && install polipo /usr/local/bin/ \
    && cd .. \
    && rm -rf polipo.zip polipo-master \
    && mkdir -p /usr/share/polipo/www /var/cache/polipo \
    && apk del build-base openssl

EXPOSE 8123

ENTRYPOINT ["tini", "--"]
CMD ["polipo", "proxyAddress=0.0.0.0", "proxyPort=8123", $SS]
