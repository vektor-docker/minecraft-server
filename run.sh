#!/usr/bin/env bash

PROXY_ARGS="--env http_proxy=${http_proxy} \
            --env no_proxy=${no_proxy}"

CURRENT_DIR=$(pwd)

if [ ! -d ${CURRENT_DIR}/tmp ]; then
    mkdir ${CURRENT_DIR}/tmp
fi

docker run -ti --rm -p 25565:25565 -v ${CURRENT_DIR}/tmp:/config -e PUID=$(id -u) -e PGID=$(id -g) -e JAVA_XMX=2g ${PROXY_ARGS} vektory79-docker-docker.bintray.io/vektory79/minecraft-server:18w15a $@
