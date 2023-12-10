FROM ubuntu:bionic
MAINTAINER sa2kng <knegge@gmail.com>

RUN apt-get -y update &&\
    apt -y upgrade &&\
    apt-get -y install \
        wget \
        build-essential \
        linux-source \
        bc \
        kmod \
        cpio \
        flex \
        libncurses5-dev \
        libncurses-dev \
        libelf-dev \
        libssl-dev \
        dwarves \
        bison \
        git \
        ca-certificates \
        device-tree-compiler \
        gcc \
        gcc-riscv64-linux-gnu \
        ccache \
        cmake \
        make \
        xz-utils \
       software-properties-common &&\
       add-apt-repository ppa:deadsnakes/ppa  &&\
       apt update &&\
       apt-get -y install python3.8 &&\
       apt-get -y install python3-dev &&\
       apt-get -y install python3-pip &&\
       apt-get -y install python3-venv &&\
       apt-get -y install sudo &&\
       add-apt-repository ppa:ubuntu-toolchain-r/test &&\
       apt update &&\
       wget https://apt.llvm.org/llvm.sh &&\
       chmod +x llvm.sh &&\
       ./llvm.sh all &&\
       rm -rf /var/lib/apt/lists/*

ENV PATH="/mnt:${PATH}"
ENV CC=clang-17
ENV CXX=clang++-17
WORKDIR /mnt
CMD "bash"
