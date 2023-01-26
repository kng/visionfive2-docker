#!/bin/bash
docker run --rm \
    -v $(pwd)/mnt:/mnt \
    -it knegge/versionfive2:latest $@

