LIB_EXT_CFLAGS=""
LIB_EXT_CXXFLAGS=""
LIB_CONFIGURE_FLAGS=" \
	--host=$HOST_COMPILER \
	--prefix=$PREFIX \
	--with-sysroot=$SYSROOT \
    --disable-shared \
	--disable-soname-versions"
