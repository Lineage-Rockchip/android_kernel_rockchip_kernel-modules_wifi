#!/bin/bash

#Usage:
#Compile all: ./build_wifi_ko.sh
#Compile separately, such as compiling bcmdhd: ./build_wifi_ko.sh bcmdhd

export PATH=../prebuilts/clang/host/linux-x86/clang-r487747c/bin:$PATH

source ../../build/envsetup.sh >/dev/null
KERNEL_ARCH=`get_build_var PRODUCT_KERNEL_ARCH`

echo "Build wifi ko $1 for $KERNEL_ARCH"

if [ "$KERNEL_ARCH" = "arm64" ]; then
    CROSS_COMPILE_PREFIX="aarch64-linux-gnu-"
    ARCH="arm64"
elif [ "$KERNEL_ARCH" = "arm" ]; then
    CROSS_COMPILE_PREFIX="arm-linux-gnueabi-"
    ARCH="arm"
else
    echo "Unsupported architecture: $KERNEL_ARCH"
    exit 1
fi

LOCAL_KERNEL_PATH=kernel-6.1
ADDON_ARGS="CROSS_COMPILE=${CROSS_COMPILE_PREFIX} LLVM=1 LLVM_IAS=1"

cd ../../$LOCAL_KERNEL_PATH && make $ADDON_ARGS ARCH=$ARCH -C . M=../external/wifi_driver/$1 clean && cd -
cd ../../$LOCAL_KERNEL_PATH && make $ADDON_ARGS ARCH=$ARCH -C . M=../external/wifi_driver/$1 -j8 && cd -

# strip debug info of ko
find . -type f -name "*.ko" | while read -r ko_file; do
	echo "Stripping debug info of $ko_file"
	llvm-strip --strip-debug "$ko_file"
done
