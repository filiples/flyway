FROM alpine

ENV FLYWAY_VERSION=5.1.4

ENV FLYWAY_HOME=/opt/flyway/$FLYWAY_VERSION \
 FLYWAY_PKGS="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz"

RUN apk add --update \
 openjdk8-jre \
 wget \
 bash \
 git

RUN wget --no-check-certificate $FLYWAY_PKGS &&\
 mkdir -p $FLYWAY_HOME && \
 mkdir -p /var/flyway/data && \
 tar -xzf flyway-commandline-$FLYWAY_VERSION.tar.gz -C $FLYWAY_HOME --strip-components=1

RUN chgrp -R 0 $FLYWAY_HOME && \
    chmod -R g=u $FLYWAY_HOME

RUN chgrp -R 0 $FLYWAY_HOME/sql && \
    chmod -R g=u $FLYWAY_HOME/sql