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

host_compiler() {
	case $ARCH in
	arm) echo arm-linux-androideabi ;;
	arm64) echo aarch64-linux-android ;;
	x86) echo i686-linux-android ;;
	x86_64) echo x86_64-linux-android ;;
	esac
}

export TOOLCHAIN_DIR="$TOOLCHAINS_DIR/$ARCH"
export PREFIX="$TOOLCHAIN_DIR/sysroot/usr"
export HOST_COMPILER=$(host_compiler $ARCH)
export CC=${CC:-"$HOST_COMPILER-clang"}
export CXX=${CXX:-"$HOST_COMPILER-clang++"}
export PATH="$TOOLCHAIN_DIR/bin:$PATH"

# https://autotools.io/pkgconfig/cross-compiling.html
SYSROOT=$TOOLCHAIN_DIR/sysroot
export PKG_CONFIG_DIR
export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=${SYSROOT}

# dirname is NDK_BUILD_UTILS_DIR, so inject
NDK_BUILD_SOURCES_ROOT=${NDK_BUILD_SOURCES_ROOT:-"."}
source $NDK_BUILD_SOURCES_ROOT/source-${LIB_BUILD_NAME}.sh

case $ARCH in
arm)
	TARGET_ARCH=armv7-a
	export CFLAGS="-Os -mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb -marm -march=$TARGET_ARCH $LIB_EXT_CFLAGS"
	export CXXFLAGS="-Os -mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb -marm -march=$TARGET_ARCH $LIB_EXT_CXXFLAGS"
	;;
arm64)
	TARGET_ARCH=armv8-a
	export CFLAGS="-Os -march=$TARGET_ARCH $LIB_EXT_CFLAGS"
	export CXXFLAGS="-Os -march=$TARGET_ARCH $LIB_EXT_CXXFLAGS"
	;;
x86)
	TARGET_ARCH=i686
	export CFLAGS="-Os -march=$TARGET_ARCH $LIB_EXT_CFLAGS"
	export CXXFLAGS="-Os -march=$TARGET_ARCH $LIB_EXT_CXXFLAGS"
	;;
x86_64)
	TARGET_ARCH=westmere
	export CFLAGS="-Os -march=$TARGET_ARCH $LIB_EXT_CFLAGS"
	export CXXFLAGS="-Os -march=$TARGET_ARCH $LIB_EXT_CXXFLAGS"
	;;
esac

./configure $LIB_CONFIGURE_FLAGS || (cat config.log && exit 1)

NPROCESSORS=$(getconf NPROCESSORS_ONLN 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null)
PROCESSORS=${NPROCESSORS:-3}

make clean
make -j$PROCESSORS
make install
echo "$LIB_BUILD_NAME-$ARCH has been installed into $PREFIX"
