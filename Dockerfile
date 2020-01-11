FROM alpine:3.11

ENV MYDUMPER_VERSION=0.9.5

RUN apk --no-cache add mariadb-connector-c glib zlib pcre \
  && apk --no-cache --update add --virtual build-pkgs cmake mariadb-connector-c-dev glib-dev zlib-dev pcre-dev build-base \
  && cd /tmp \
  && wget "https://github.com/maxbube/mydumper/archive/v${MYDUMPER_VERSION}.tar.gz" -O mydumper.tar.gz \
  && tar -zxf mydumper.tar.gz \
  && cd mydumper* \
  && cmake . \
  && make \
  && make install \
  && apk del build-pkgs \
  && (rm -rf /tmp/* 2>/dev/null || true) \
  && (rm -rf /var/cache/apk/* 2>/dev/null || true)

ENTRYPOINT ["mydumper"]

CMD ["-V"]
