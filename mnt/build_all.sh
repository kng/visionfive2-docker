#!/bin/bash
build_u-boot.sh || exit 1
build_opensbi.sh || exit 1
build_spl.sh || exit 1
build_kernel.sh || exit 1

