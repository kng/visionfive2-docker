# visionfive2-docker
Docker build environment for VisionFive 2 SBC

## Building the docker container
Clone this repo and enter it, build the container.
```
git clone https://github.com/kng/visionfive2-docker.git
cd visionfive2-docker
./build.sh
```

If updating this repo or editing the Dockerfile, rebuild the image again.

## Building firmware and kernel
All the scripts in mnt are from the [Technical Reference Manual](https://doc-en.rvspace.org/VisionFive2/PDF/VisionFive2_SW_TRM.pdf)<br>
You do not need to install any packages when running the container, it's all included in the build.<br>
The directory mnt is bind-mounted to the container /mnt<br>
When you run the scripts, the contents of the git pull and build etc will e in the mnt directory.<br>

Enter the build environment with a command prompt with: `./shell.sh`

Build scripts available:<br>
`build_kernel.sh  build_opensbi.sh  build_spl.sh  build_u-boot.sh`<br>
These scripts just removes the directory before fetching it from git, so be aware any local changes in those will be wiped.

Quick build of everything:<br>
`./shell.sh build_all.sh`

or manually for each step, making changes along the way.

u-boot:
`./shell.sh build_u-boot.sh`

OpenSBI:
`./shell.sh build_opensbi.sh`

SPL and payload:
`./shell.sh build_spl.sh`

Linux kernel:
`./shell.sh build_kernel.sh`

Alternatively, linux kernel based on a-wai/vf2-linux, this enables IPv6 and docker:
`./shell.sh build_kernel_vf2.sh`
This also builds modules and installs them in mnt/lib/modules.

## Busybox rootfs

Build the rootfs with:
`./shell.sh build_rootfs.sh`

If you want to test run it, make sure you have the proper qemu installed `docker run --privileged --rm tonistiigi/binfmt:riscv`<br>
First build the image with `./rootfs_image.sh` and then start a container shell with `./rootfs_shell.sh`

## All Build Steps With Podman

Please note we only use `podman_build.sh` to build the podman container holding ubuntu and the pre-requisite packages.

### 1. Clone this repository

```
cd ~
git clone https://github.com/kng/visionfive2-docker.git
cd ~/visionfive2-docker
```

### 2. Prepare the Dockerfile for the Podman Ubuntu Container with the Starfive Pre-Requisite Packages

The **Dockerfile** needs a few python3 packages to work otherwise you get build errors.  In this case **python3.8** as the default for this **ubuntu:bionic**.

Here is what I believe the Dockerfile should contain:

```
cat Dockerfile
FROM ubuntu:bionic
MAINTAINER sa2kng <knegge@gmail.com>

RUN apt-get -y update &&\
    apt -y upgrade &&\
    apt-get -y install \
        bc \
        bison \
        ca-certificates \
        cpio \
        device-tree-compiler \
        flex \
        gcc \
        gcc-riscv64-linux-gnu \
        git \
        kmod \
        libncurses-dev \
        libssl-dev \
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
	rm -rf /var/lib/apt/lists/*

ENV PATH="/mnt:${PATH}"
WORKDIR /mnt
CMD "bash"

```

### 3. Build The Podman Ubuntu Container With Starfive Pre-Requisite Packages

NOTE: this builds the container image named **localhost/visionfive2:latest**

```
cd ~/visionfive2-docker
./podman_build.sh 
```

### 4. Build the rest with that Podman Ubuntu Container

NOTE: Make sure to run the previous step podman_build.sh step which builds container image named **localhost/visionfive2:latest**.
The following steps then use podman_shell.sh command to load up that container image named **localhost/visionfive2:latest** and run their respective build scripts.

```
cd ~/visionfive2-docker
./podman_shell.sh build_u-boot.sh
./podman_shell.sh build_opensbi.sh
./podman_shell.sh build_spl.sh
./podman_shell.sh build_kernel.sh
./podman_shell.sh build_rootfs.sh
```

Voila.  I do hope it works for you.  Cheers.
