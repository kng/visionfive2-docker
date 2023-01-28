#!/bin/bash
CORES=$(nproc)
declare -x INSTALL_PATH=/mnt/boot
declare -x INSTALL_MOD_PATH=/mnt
declare -x LOCALVERSION="-starfive"
declare -x CROSS_COMPILE=riscv64-linux-gnu-
declare -x ARCH=riscv

rm -rf linux ${INSTALL_PATH} ${INSTALL_MOD_PATH}/lib
git clone --depth 1 https://gitlab.com/a-wai/vf2-linux.git linux
cd linux || exit 1
touch .scmversion
make starfive_visionfive2_defconfig || exit 2
#make menuconfig
make olddefconfig || exit 3
make -j "${CORES}" || exit 4
mkdir -p ${INSTALL_PATH}
make zinstall modules_install || exit 5
ls -l arch/riscv/boot/Image.gz
ls -l arch/riscv/boot/dts/starfive/*.dtb
ls -l ${INSTALL_PATH}
echo "Kernel installed in ${INSTALL_PATH} and modules in ${INSTALL_MOD_PATH}/lib/modules/"

