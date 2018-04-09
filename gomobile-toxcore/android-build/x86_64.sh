#!/bin/bash

source $(dirname "$0")/source.sh

export TARGET_ARCH=westmere
export CFLAGS="-Os -march=${TARGET_ARCH} ${LIB_EXT_CFLAGS}"
NDK_PLATFORM=android-21 ARCH=x86_64 HOST_COMPILER=x86_64-linux-android "$(dirname "$0")/build.sh" $1
