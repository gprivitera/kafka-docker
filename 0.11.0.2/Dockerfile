FROM openjdk:8-jre-alpine
MAINTAINER Gianluca Privitera <gpriviter4@gmail.com>

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

ARG DISTRO_NAME=kafka_2.12-0.11.0.2
ARG VERSION=0.11.0.2

RUN set -x \
    && apk add --no-cache --virtual .build-deps \
        gnupg \
    && wget -q "http://www.apache.org/dist/kafka/$VERSION/$DISTRO_NAME.tgz" \
    && wget -q "http://www.apache.org/dist/kafka/$VERSION/$DISTRO_NAME.tgz.asc" \
    && tar -xzf "$DISTRO_NAME.tgz" \
    && rm -r "$DISTRO_NAME.tgz" "$DISTRO_NAME.tgz.asc" \
    && apk del .build-deps

WORKDIR $DISTRO_NAME
VOLUME ["$KAFKA_LOGS_DIR"]

EXPOSE $KAFKA_PORT

ENV PATH=$PATH:/$DISTRO_NAME/bin \
    KAFKACFGDIR=$KAFKA_CONF_DIR

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kafka-server-start.sh", "/config/server.properties"]