#!/bin/bash
CORES=$(nproc)
rm -rf u-boot
#git clone https://github.com/starfive-tech/u-boot.git
git clone --depth 1 -b JH7110_VisionFive2_devel https://github.com/starfive-tech/u-boot.git
cd u-boot || exit 1
#git checkout -b JH7110_VisionFive2_devel origin/JH7110_VisionFive2_devel
#git pull
make starfive_visionfive2_defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- -j "${CORES}"
make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- -j "${CORES}"
ls -l u-boot.bin arch/riscv/dts/starfive_visionfive2.dtb spl/u-boot-spl.bin

