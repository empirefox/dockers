LIB_EXT_CFLAGS=""
LIB_EXT_CXXFLAGS=""
LIB_CONFIGURE_FLAGS=" \
	--host=$HOST_COMPILER \
	--prefix=$PREFIX \
    --disable-shared \
    --enable-static \
    --disable-extra-programs \
    --disable-doc"
