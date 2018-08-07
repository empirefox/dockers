#! /bin/bash
set -e

source $ARM_BUILD_UTILS_DIR/host_compiler.sh

# must be under TOOLCHAINS_DIR
get_toolchain_arch(){
    local arch=$1
    local compiler=$(host_compiler $arch)
    local main_version=${TOOLCHAINS_VERSION:0:1}

    wget -q -O toolchain.tar.xz https://releases.linaro.org/components/toolchain/binaries/latest-$main_version/$compiler/gcc-linaro-${TOOLCHAINS_VERSION}_$compiler.tar.xz
    bsdtar --no-same-owner --no-same-permissions -xf toolchain.tar.xz
    rm toolchain.tar.xz
    mv gcc* $arch
}

mkdir -p $TOOLCHAINS_DIR
cd $TOOLCHAINS_DIR
archs=(arm arm64)
for arch in ${archs[@]}; do
    get_toolchain_arch $arch
done