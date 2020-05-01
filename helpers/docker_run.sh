#!/bin/bash

APP=${@:-/bin/bash}

IMAGE=verifying-foss-hdl-synthesizers

docker run --rm -it \
    -v $HOME:$HOME -v /tmp:/tmp -v /opt:/opt \
    -w $PWD $IMAGE $APP
