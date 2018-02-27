#!/bin/bash
#Change NDK to your Android NDK location
NDK=/Users/alex/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-16/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
/Users/alex/Desktop/ffmpeg-3.3.6
GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm"

#support h264\ h265
MODULES="\
--disable-debug \
--disable-encoders \
--disable-decoders \
--enable-decoder=hevc \
--enable-hwaccels \
--disable-muxers \
--disable-demuxers \
--enable-muxer=hevc \
--enable-demuxer=hevc \
--disable-parsers \
--enable-parser=hevc \
--disable-network \
--disable-protocols \
--disable-devices \
--disable-indevs \
--disable-outdevs \
--disable-yasm \
--enable-asm \
--enable-neon \
--disable-programs \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-doc \
--disable-htmlpages \
--disable-manpages \
--disable-podpages \
--disable-txtpages \
--enable-cross-compile"

function build_ARMv6
{
  ./configure \
  --target-os=linux \
  --prefix=./android/armeabi \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-shared \
  --disable-static \

--extra-cflags=" -O3 -fpic -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -marm -march=armv6" \
--extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \

# --enable-zlib \

  ${MODULES} \
  --disable-doc \
  --enable-neon

  make clean
  make
  make install
}



build_ARMv6

echo Android ARMEABI builds finished
