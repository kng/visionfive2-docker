#!/bin/bash
CORES=$(nproc)
declare -x INSTALL_PATH=/mnt/boot
declare -x INSTALL_MOD_PATH=/mnt
declare -x LOCALVERSION="-starfive"
declare -x CROSS_COMPILE=riscv64-linux-gnu-
declare -x ARCH=riscv

rm -rf linux ${INSTALL_PATH}
git clone --depth 1 -b JH7110_VisionFive2_devel https://github.com/starfive-tech/linux.git
cd linux || exit 1
#git checkout arch/riscv/configs/starfive_visionfive2_defconfig
patch -p1 < ../kernel_docker.diff
touch .scmversion
make starfive_visionfive2_defconfig
#make menuconfig
make olddefconfig
make -j "${CORES}"
mkdir -p ${INSTALL_PATH}
make zinstall modules_install
ls -l arch/riscv/boot/Image.gz
ls -l arch/riscv/boot/dts/starfive/*.dtb
ls -l ${INSTALL_PATH}
echo "Kernel installed in ${INSTALL_PATH} and modules in ${INSTALL_MOD_PATH}/lib/modules/"
