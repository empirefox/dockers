#!/bin/bash

source $(dirname "$0")/source.sh

export TARGET_ARCH=i686
export CFLAGS="-Os -march=${TARGET_ARCH} ${LIB_EXT_CFLAGS}"
ARCH=x86 HOST_COMPILER=i686-linux-android "$(dirname "$0")/build.sh" $1
