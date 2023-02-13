#!/bin/bash
CORES=$(nproc)
rm -rf u-boot
git clone --depth 1 -b JH7110_VisionFive2_devel https://github.com/starfive-tech/u-boot.git
cd u-boot || exit 1
make starfive_visionfive2_defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- -j "${CORES}" || exit 2
make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- -j "${CORES}" || exit 3
ls -l u-boot.bin arch/riscv/dts/starfive_visionfive2.dtb spl/u-boot-spl.bin

