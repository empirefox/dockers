#!/bin/bash

source $(dirname "$0")/source.sh

export TARGET_ARCH=armv7-a
export CFLAGS="-Os -mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb -marm -march=${TARGET_ARCH} ${LIB_EXT_CFLAGS}"
ARCH=arm HOST_COMPILER=arm-linux-androideabi "$(dirname "$0")/build.sh" $1
