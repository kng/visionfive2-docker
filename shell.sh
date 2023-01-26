#!/bin/bash
docker run --rm \
    -v "$(pwd)"/mnt:/mnt \
    -it visionfive2:latest "$@"

