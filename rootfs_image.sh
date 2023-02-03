#!/bin/bash
if [ -f mnt/rootfs.tar.xz ]; then
    docker build -t visionfive2:rootfs -f Dockerfile.rootfs . --no-cache
else
    echo "rootfs missing, build it with: build_rootfs.sh"
fi

