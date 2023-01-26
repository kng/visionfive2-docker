#!/bin/bash
chmod 777 $(pwd)/mnt
podman run --rm \
    -v $(pwd)/mnt:/mnt \
    -it localhost/visionfive2:latest $@

