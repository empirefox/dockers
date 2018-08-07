#! /bin/bash
set -e

if [ ! -f ./configure ]; then
	echo "Can't find ./configure. Wrong directory or haven't run autogen.sh?" >&2
	exit 1
fi

if [ "x$ARCH" = 'x' ]; then
	echo "You shouldn't use arch-build.sh directly, use install.sh instead" >&2
	exit 1
fi

source $ARM_BUILD_UTILS_DIR/host_compiler.sh

export TOOLCHAIN_DIR="$TOOLCHAINS_DIR/$ARCH"
export HOST_COMPILER=$(host_compiler $ARCH)
export PREFIX="$TOOLCHAIN_DIR/$HOST_COMPILER/libc/usr"
export CC=${CC:-"$HOST_COMPILER-gcc"}
export CXX=${CXX:-"$HOST_COMPILER-g++"}
export PATH="$TOOLCHAIN_DIR/bin:$PATH"

# https://autotools.io/pkgconfig/cross-compiling.html
SYSROOT=$TOOLCHAIN_DIR/$HOST_COMPILER/libc
export PKG_CONFIG_DIR
export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=${SYSROOT}

source $ARM_BUILD_UTILS_DIR/source-${LIB_BUILD_NAME}.sh

case $ARCH in
arm)
	TARGET_ARCH=armv7-a
	export CFLAGS="-O3 -fPIC -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb -marm -march=$TARGET_ARCH $LIB_EXT_CFLAGS"
	export CXXFLAGS="-O3 -fPIC -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb -marm -march=$TARGET_ARCH $LIB_EXT_CXXFLAGS"
	;;
arm64)
	TARGET_ARCH=armv8-a+crc
	export CFLAGS="-O3 -mtune=cortex-a53 -mcpu=cortex-a53+crypto -march=$TARGET_ARCH $LIB_EXT_CFLAGS"
	export CXXFLAGS="-O3 -mtune=cortex-a53 -mcpu=cortex-a53+crypto -march=$TARGET_ARCH $LIB_EXT_CXXFLAGS"
	;;
esac

./configure $LIB_CONFIGURE_FLAGS || (cat config.log && exit 1)

NPROCESSORS=$(getconf NPROCESSORS_ONLN 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null)
PROCESSORS=${NPROCESSORS:-3}

make clean
make -j$PROCESSORS
make install
echo "$LIB_BUILD_NAME-$ARCH has been installed into $PREFIX"
