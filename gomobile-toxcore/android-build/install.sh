#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

archs=(arm arm64 x86 x86_64)
# archs=(arm)

check_sha256() {
	if ! (echo "$1  $2" | sha256sum -c --status -); then
		echo "Error: sha256 of $2 doesn't match the known one."
		echo "Expected: $1  $2"
		echo -n "Got: "
		sha256sum "$2"
		exit 1
	else
		echo "sha256 matches the expected one: $1"
	fi
}

apt-get update && apt-get install -q -y --no-install-recommends autoconf automake bsdtar libtool pkg-config python zipmerge

# Sodium
wget -q https://download.libsodium.org/libsodium/releases/libsodium-$SODIUM_VERSION.tar.gz
check_sha256 "$SODIUM_HASH" "libsodium-$SODIUM_VERSION.tar.gz"
bsdtar --no-same-owner --no-same-permissions -xf libsodium*.tar.gz
rm libsodium*.tar.gz
cd libsodium*
cp -r ../android-build .
mv ./android-build/source-libsodium.sh ./android-build/source.sh
./autogen.sh
for arch in ${archs[@]}; do
	./android-build/$arch.sh libsodium
done
cd ..
rm -rf ./libsodium*

# Toxcore
wget -q https://github.com/TokTok/c-toxcore/archive/v$TOXCORE_VERSION.tar.gz -O c-toxcore-$TOXCORE_VERSION.tar.gz
check_sha256 "$TOXCORE_HASH" "c-toxcore-$TOXCORE_VERSION.tar.gz"
bsdtar --no-same-owner --no-same-permissions -xf c-toxcore*.tar.gz
rm c-toxcore*.tar.gz
cd c-toxcore*
cp -r ../android-build .
mv ./android-build/source-toxcore.sh ./android-build/source.sh
./autogen.sh
for arch in ${archs[@]}; do
	# https://autotools.io/pkgconfig/cross-compiling.html
	# SYSROOT=$TOOLCHAINS_DIR/$arch
	# export PKG_CONFIG_DIR
	# export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig
	# export PKG_CONFIG_SYSROOT_DIR=${SYSROOT}
	./android-build/$arch.sh c-toxcore
done
cd ..
rm -rf ./c-toxcore*
