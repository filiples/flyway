FROM alpine

RUN apk add --update shadow openjdk8-jre wget bash git && \
    groupadd -g 9999 docker && \
    useradd -m -d /home/docker -u 9999 -g docker docker

USER docker

ENV FLYWAY_VERSION=5.1.4

ENV FLYWAY_HOME=/home/docker/flyway/$FLYWAY_VERSION \
    FLYWAY_PKGS="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz"

RUN mkdir -p $FLYWAY_HOME && \
    chgrp -R 9999 $FLYWAY_HOME && \
    chmod -R 755 $FLYWAY_HOME

RUN cd $HOME && \
    wget --no-check-certificate $FLYWAY_PKGS && \
    tar -xzf $HOME/flyway-commandline-$FLYWAY_VERSION.tar.gz -C $FLYWAY_HOME --strip-components=1 && \
    git clone --branch $GIT_BRANCH --single-branch https://$GIT_USERNAME:$GIT_PASSWORD@$GIT_REPO $HOME/flyway-repo && \
    cp -f flyway-repo/sql/* $FLYWAY_HOME/sql && \
    $FLYWAY_HOME/flyway clean migrate -user=$DB_USER -password=$DB_PASS -url=$DB_URL
