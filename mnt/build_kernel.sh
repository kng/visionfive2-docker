#!/bin/bash
CORES=4
git clone --depth 1 -b JH7110_VisionFive2_devel https://github.com/starfive-tech/linux.git
cd linux
make starfive_visionfive2_defconfig CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv
#make CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv menuconfig
make CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv -j ${CORES}

