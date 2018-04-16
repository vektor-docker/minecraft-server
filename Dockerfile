FROM javister-docker-docker.bintray.io/javister/javister-docker-openjdk:1.0.java8
MAINTAINER Viktor Verbitsky <vektory79@gmail.com>

ARG SERVER_URL

LABEL minecraft-version=$VERSION

COPY files /

ENV JAVA_XMS="512m" \
    JAVA_XMX="2g" \
    JAVA_OPTS="$JVM_OPTS -Djava.net.preferIPv4Stack=true -Djava.awt.headless=true -XX:+UseShenandoahGC -XX:+UnlockExperimentalVMOptions -XX:ShenandoahGuaranteedGCInterval=30000 -XX:ShenandoahUncommitDelay=10000"

RUN . /usr/local/bin/proxyenv && \
    echo "Server URL: ${SERVER_URL}" && \
    https_proxy=$https_proxy no_proxy=$no_proxy curl -s "${SERVER_URL}" > /app/server.jar && \
    chmod --recursive a+w /app && \
    chmod --recursive +x /etc/my_init.d/*.sh /etc/service /usr/local/bin

WORKDIR /config/minecraft

EXPOSE 25565
