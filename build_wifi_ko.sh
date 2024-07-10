#!/bin/bash

#Usage:
#Compile all: ./build_wifi_ko.sh
#Compile separately, such as compiling bcmdhd: ./build_wifi_ko.sh bcmdhd

export PATH=../prebuilts/clang/host/linux-x86/clang-r487747c/bin:$PATH

LOCAL_KERNEL_PATH=kernel-6.1
ADDON_ARGS="CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 LLVM_IAS=1"

cd ../../$LOCAL_KERNEL_PATH && make $ADDON_ARGS ARCH=arm64 -C . M=../external/wifi_driver/$1 clean && cd -
cd ../../$LOCAL_KERNEL_PATH && make $ADDON_ARGS ARCH=arm64 -C . M=../external/wifi_driver/$1 -j8 && cd -
