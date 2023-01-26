#!/bin/bash
UBOOT=/mnt/u-boot
rm -rf opensbi
git clone https://github.com/starfive-tech/opensbi.git
cd opensbi
make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- PLATFORM=generic FW_PAYLOAD_PATH=${UBOOT}/u-boot.bin FW_FDT_PATH=${UBOOT}/arch/riscv/dts/starfive_visionfive2.dtb FW_TEXT_START=0x40000000
ls -l build/platform/generic/firmware/fw_payload.bin

