#!/bin/bash
UBOOT=/mnt/u-boot
OPENSBI=/mnt/opensbi
rm -rf Tools
git clone https://github.com/starfive-tech/Tools.git
cd Tools/spl_tool || exit 1
./create_sbl ${UBOOT}/spl/u-boot-spl.bin 0x01010101
ls -l u-boot-spl.bin.normal.out
cd ../uboot_its || exit 2
cp ${OPENSBI}/build/platform/generic/firmware/fw_payload.bin ./
${UBOOT}/tools/mkimage -f visionfive2-uboot-fit-image.its -A riscv -O u-boot -T firmware visionfive2_fw_payload.img
ls -l visionfive2_fw_payload.img

