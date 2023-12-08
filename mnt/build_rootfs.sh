#!/bin/bash

# ensure the mknod, cpio, tar behave correctly by invoking this script differently
# by doing so, it also ensures the cpio.gz and the tar.xz preserve the root:root afterwards
# ./podman_shell.sh fakeroot /bin/bash build_rootfs.sh

CORES=$(nproc)
ROOTFS=/mnt/rootfs
BBCONF=/mnt/bb
declare -x ARCH=riscv

rm -rf "$ROOTFS" busybox
mkdir -p "$ROOTFS"/dev "$ROOTFS"/usr "$ROOTFS"/bin "$ROOTFS"/sbin "$ROOTFS"/lib "$ROOTFS"/etc/init.d "$ROOTFS"/proc "$ROOTFS"/tmp "$ROOTFS"/sys "$ROOTFS"/var "$ROOTFS"/root "$ROOTFS"/mnt
git clone https://git.busybox.net/busybox.git
cd busybox || exit 1
cp "$BBCONF"/config .config
make oldconfig
#make CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv menuconfig
make -j "$CORES" all install
cd "$BBCONF" && cp inittab profile fstab passwd group shadow "$ROOTFS"/etc && cp rcS "$ROOTFS"/etc/init.d
cd "$ROOTFS" && ln -s bin/busybox init
cd "$ROOTFS"/dev && mknod -m 666 console c 5 1 && mknod -m 666 null c 1 3
#sudo chmod 777 -R *
cd "$ROOTFS" && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz
cd "$ROOTFS" && tar -Jcf ../rootfs.tar.xz .
cd /mnt && ls -l rootfs.*
