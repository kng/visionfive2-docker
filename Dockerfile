FROM ubuntu:bionic
MAINTAINER sa2kng <knegge@gmail.com>

RUN apt-get -y update &&\
    apt -y upgrade &&\
    apt-get -y install \
        bc \
        bison \
        ca-certificates \
        device-tree-compiler \
        flex \
        gcc \
        gcc-riscv64-linux-gnu \
        git \
        kmod \
        libncurses-dev \
        libssl-dev \
        make &&\
    rm -rf /var/lib/apt/lists/*

ENV PATH="/mnt:${PATH}"
WORKDIR /mnt
CMD "bash"

