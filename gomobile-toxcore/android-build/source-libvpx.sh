export CROSS="$HOST_COMPILER-"
LIB_EXT_CFLAGS=""
LIB_EXT_CXXFLAGS=""

# fix for arch
arch=$ARCH
case $arch in
arm)
	arch=armv7
	;;
x86)
	export ASFLAGS=-D__ANDROID__
	;;
esac

LIB_CONFIGURE_FLAGS=" \
    --target=$arch-android-gcc \
	--prefix=$PREFIX \
    --disable-shared \
    --enable-static \
    --disable-examples \
    --disable-tools \
    --disable-docs \
    --disable-unit-tests"
