#!/bin/bash
#Change NDK to your Android NDK location
NDK=/Users/alex/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-21/arch-arm64/
PREBUILT=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=aarch64 \
--cc=$PREBUILT/bin/aarch64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/aarch64-linux-android- \
--nm=$PREBUILT/bin/aarch64-linux-android-nm"

MODULES="\
--enable-gpl"



function build_arm64
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./android/arm64-v8a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-shared \
  --disable-static \
  --disable-doc \
  --enable-zlib \
  ${MODULES}

  make clean
  make
  make install
}

build_arm64


echo Android ARM64 builds finished