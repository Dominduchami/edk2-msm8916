#!/bin/bash
# based on the instructions from edk2-platform
set -e
#. build_common.sh
# Hardcoded bad bad bad
export PACKAGES_PATH=$PWD/../htcleo/edk2:$PWD/../htcleo/edk2-platforms:$PWD
export WORKSPACE=$PWD/workspace
. ../htcleo/edk2/edksetup.sh

# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p MSM8909Pkg/Devices/surnia.dsc

#dtc -I dts -O dtb device_specific/surnia.dts -o device_specific/surnia.dtb

cd BootShim
make UEFI_BASE=0x80200000 UEFI_SIZE=0x00100000
rm BootShim.elf
cd ..

cat BootShim/BootShim.bin workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd device_specific/msm8916-motorola-surnia.dtb > uefi.img
