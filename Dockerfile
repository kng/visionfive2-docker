FROM ubuntu:bionic
MAINTAINER sa2kng <knegge@gmail.com>

RUN apt-get -y update &&\
    apt -y upgrade &&\
    apt-get -y install gcc-riscv64-linux-gnu git make ca-certificates gcc bison flex libssl-dev device-tree-compiler bc libncurses-dev &&\
    rm -rf /var/lib/apt/lists/*

ENV PATH="/mnt:${PATH}"
WORKDIR /mnt
CMD "bash"

