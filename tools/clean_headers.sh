#!/bin/bash
set -eu

export ANDROID_BUILD_TOP="$PWD"

./bionic/libc/kernel/tools/clean_header.py -u \
    "$1/usr/include/asm/signal.h" \
    "$1/usr/include/asm-generic/signal.h"

# Newer 6.1 kernels export struct sched_param in linux/sched/types.h, which
# bionic's <sched.h> defines too.
if [ -f "$1/usr/include/linux/sched/types.h" ]; then
    sed -i '/^struct sched_param {/,/^};/d' "$1/usr/include/linux/sched/types.h"
fi
