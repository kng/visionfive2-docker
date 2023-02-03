# visionfive2-docker
Docker build environment for VisionFive 2 SBC

## Building the docker image
Clone this repo and enter it, build the image.
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

## Podman instead of Docker

If you're using podman, simply replace the above `build.sh` with `podman_build.sh` and `shell.sh` with `podman_shell.sh`

