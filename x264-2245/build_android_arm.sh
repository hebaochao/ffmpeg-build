#!/bin/bash
NDK=/Users/alex/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-14/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
PREFIX=./android/arm

function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --disable-shared \
  --enable-static \
  --disable-asm \
  --enable-pic \
  --enable-strip \
  --host=arm-linux-androideabi \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --sysroot=$PLATFORM
  --extra-cflags="-Os -fpic  -llog" \
  --extra-ldflags="" \

  make clean
  make
  make install
}

build_one

echo Android ARM builds finished
