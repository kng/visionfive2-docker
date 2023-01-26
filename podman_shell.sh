#!/bin/bash
# if not running privileged
# either: chmod 777 $(pwd)/mnt
# or: -v $(pwd)/mnt:/mnt:Z \
podman run --rm \
    -v "$(pwd)"/mnt:/mnt \
    --privileged \
    -it localhost/visionfive2:latest "$@"

