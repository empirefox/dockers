export CROSS="$HOST_COMPILER-"
LIB_EXT_CFLAGS=""
LIB_EXT_CXXFLAGS=""

# fix for arch
arch=$ARCH
case $arch in
arm)
	arch=armv7
	;;
arm64)
	arch=arm64
	;;
esac

LIB_CONFIGURE_FLAGS=" \
    --target=$arch-linux-gcc \
	--prefix=$PREFIX \
    --disable-shared \
    --enable-static \
    --disable-examples \
    --disable-tools \
    --disable-docs \
    --disable-unit-tests"
