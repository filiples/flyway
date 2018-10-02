FROM alpine

USER root

RUN apk add --update shadow openjdk8-jre wget bash git && \
    useradd -m -d /home/flyway -u 1001 -g 0 flyway

USER 1001

ENV FLYWAY_VERSION=5.1.4

ENV FLYWAY_HOME=/home/flyway/$FLYWAY_VERSION \
    FLYWAY_PKGS="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz"

RUN mkdir -p $FLYWAY_HOME && \
    chgrp -R 0 $FLYWAY_HOME && \
    chmod -R 755 $FLYWAY_HOME
    
RUN cd $HOME && \
    wget --no-check-certificate $FLYWAY_PKGS && \
    tar -xzf $HOME/flyway-commandline-$FLYWAY_VERSION.tar.gz -C $FLYWAY_HOME --strip-components=1
