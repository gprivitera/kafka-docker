FROM openjdk:8-jre-alpine
MAINTAINER Gianluca Privitera <gianluca.privitera@yahoo.com>

RUN apk add --no-cache \
    bash \
    su-exec

ENV KAFKA_USER=kafka \
    KAFKA_ZOOKEEPER_CONNECT=zookeeper \
    KAFKA_CONF_DIR=/config \
    KAFKA_LOGS_DIR=/kafka-logs \
    KAFKA_BROKER_ID=0 \
    KAFKA_PORT=9092 \
    KAFKA_NUM_PARTITIONS=1 \
    KAFKA_DEFAULT_REPLICATION_FACTOR=1

RUN set -x \
    && adduser -D "$KAFKA_USER" \
    && mkdir -p "$KAFKA_CONF_DIR" "$KAFKA_LOGS_DIR" \
    && chown "$KAFKA_USER:$KAFKA_USER" "$KAFKA_CONF_DIR" "$KAFKA_LOGS_DIR"

ARG GPG_KEY=6370E6D65FE1D8437C4CF905A6ECA8953B417B9B
ARG DISTRO_NAME=kafka_2.11-0.10.1.1
ARG VERSION=0.10.1.1

RUN set -x \
    && apk add --no-cache --virtual .build-deps \
        gnupg \
    && wget -q "http://www.apache.org/dist/kafka/$VERSION/$DISTRO_NAME.tgz" \
    && wget -q "http://www.apache.org/dist/kafka/$VERSION/$DISTRO_NAME.tgz.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-key "$GPG_KEY" \
    && gpg --batch --verify "$DISTRO_NAME.tgz.asc" "$DISTRO_NAME.tgz" \
    && tar -xzf "$DISTRO_NAME.tgz" \
    && rm -r "$GNUPGHOME" "$DISTRO_NAME.tgz" "$DISTRO_NAME.tgz.asc" \
    && apk del .build-deps

WORKDIR $DISTRO_NAME
VOLUME ["$KAFKA_LOGS_DIR"]

EXPOSE $KAFKA_PORT

ENV PATH=$PATH:/$DISTRO_NAME/bin \
    KAFKACFGDIR=$KAFKA_CONF_DIR

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kafka-server-start.sh", "/config/server.properties"]