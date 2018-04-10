LIB_EXT_CFLAGS="-pthread -fvisibility=hidden -fPIC -fPIE -fno-strict-aliasing -fno-strict-overflow -fstack-protector"
LIB_EXT_CXXFLAGS="-pthread -fvisibility=hidden -fPIC -fPIE -fno-strict-aliasing -fno-strict-overflow -fstack-protector"
LIB_CONFIGURE_FLAGS=" \
	--host=$HOST_COMPILER \
	--prefix=$PREFIX \
	--with-sysroot=$TOOLCHAIN_DIR/sysroot
	--disable-soname-versions \
    --disable-shared \
    --disable-rt \
    --disable-testing"
