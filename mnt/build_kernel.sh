#!/bin/bash
CORES=$(nproc)
ROOTFS=/mnt/boot
git clone --depth 1 -b JH7110_VisionFive2_devel https://github.com/starfive-tech/linux.git
cd linux || exit 1
make starfive_visionfive2_defconfig CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv || exit 2
#make CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv menuconfig
make CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv -j "${CORES}" || exit 3
mkdir -p ${ROOTFS}
make CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv INSTALL_PATH=${ROOTFS} zinstall || exit 4
ls -l arch/riscv/boot/Image.gz
ls -l arch/riscv/boot/dts/starfive/*.dtb
ls -l ${ROOTFS}

