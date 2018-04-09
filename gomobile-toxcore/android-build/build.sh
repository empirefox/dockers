#! /bin/bash

if [ ! -f ./configure ]; then
	echo "Can't find ./configure. Wrong directory or haven't run autogen.sh?" >&2
	exit 1
fi

if [ "x$TARGET_ARCH" = 'x' ] || [ "x$ARCH" = 'x' ] || [ "x$HOST_COMPILER" = 'x' ]; then
	echo "You shouldn't use android-build.sh directly, use [arch].sh instead" >&2
	exit 1
fi

export TOOLCHAIN_DIR="${TOOLCHAINS_DIR}/${ARCH}"
export PREFIX="${TOOLCHAIN_DIR}/sysroot/usr"
export PATH="${PATH}:${TOOLCHAIN_DIR}/bin"

export CC=${CC:-"${HOST_COMPILER}-clang"}

if [ "x$SET_DEPENDENCY_SEARCH" == "xyes" ]; then
	WITH_DEPENDENCY_SEARCH="--with-dependency-search=${TOOLCHAINS_DIR}/${ARCH}/sysroot/usr"
else
	WITH_DEPENDENCY_SEARCH=""
fi

./configure \
	--disable-soname-versions \
	${LIB_CONFIGURE_OPTIONS} \
	${WITH_DEPENDENCY_SEARCH} \
	--host="${HOST_COMPILER}" \
	--prefix="${PREFIX}" \
	--with-sysroot="${TOOLCHAIN_DIR}/sysroot" || (cat config.log && exit 1)


NPROCESSORS=$(getconf NPROCESSORS_ONLN 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null)
PROCESSORS=${NPROCESSORS:-3}

make clean &&
	make -j${PROCESSORS} install &&
	echo "$1-${ARCH} has been installed into ${PREFIX}"
