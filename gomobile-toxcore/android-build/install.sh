#!/bin/bash

# install_all $name $version $hash $autogen
source $NDK_BUILD_UTILS_DIR/install_all.sh

# source-$lib_name.sh are here
export NDK_BUILD_SOURCES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# for test
# archs=(arm)

# Opus
wget -q https://archive.mozilla.org/pub/opus/opus-$OPUS_VERSION.tar.gz
install_all "opus" "$OPUS_VERSION" "$OPUS_HASH" "no-autogen"
for arch in ${archs[@]}; do
	opus_prefix=$TOOLCHAINS_DIR/$arch/sysroot/usr
	if [ -f $opus_prefix/include/opus/opus.h ]; then
		mv $opus_prefix/include/opus/* $opus_prefix/include/
		rm -rf $opus_prefix/include/opus/
	fi
done

# VPX
wget -q https://github.com/webmproject/libvpx/archive/$VPX_VERSION.tar.gz -O libvpx-$VPX_VERSION.tar.gz
install_all "libvpx" "$VPX_VERSION" "$VPX_HASH" "no-autogen"

# Sodium
wget -q https://download.libsodium.org/libsodium/releases/libsodium-$SODIUM_VERSION.tar.gz
install_all "libsodium" "$SODIUM_VERSION" "$SODIUM_HASH" "autogen"

# Toxcore
wget -q https://github.com/TokTok/c-toxcore/archive/v$TOXCORE_VERSION.tar.gz -O c-toxcore-$TOXCORE_VERSION.tar.gz
install_all "c-toxcore" "$TOXCORE_VERSION" "$TOXCORE_HASH" "autogen"
