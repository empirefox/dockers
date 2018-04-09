#!/bin/bash

source $(dirname "$0")/source.sh

export TARGET_ARCH=armv8-a
export CFLAGS="-Os -march=${TARGET_ARCH} ${LIB_EXT_CFLAGS}"
NDK_PLATFORM=android-21 ARCH=arm64 HOST_COMPILER=aarch64-linux-android "$(dirname "$0")/build.sh" $1
