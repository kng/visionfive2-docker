#!/bin/bash
build_u-boot.sh || exit $?
build_opensbi.sh || exit $?
build_spl.sh || exit $?
build_kernel.sh || exit $?
