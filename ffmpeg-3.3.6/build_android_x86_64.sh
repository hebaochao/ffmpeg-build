#!/bin/bash
#Change NDK to your Android NDK location
NDK=/Users/alex/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-21/arch-x86_64/
PREBUILT=$NDK/toolchains/x86_64-4.9/prebuilt/darwin-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/x86_64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/x86_64-linux-android- \
--nm=$PREBUILT/bin/x86_64-linux-android-nm"

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



function build_x86_64
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./android/x86_64 \
  --arch=x86_64 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
 --extra-cflags="-march=x86-64 -msse4.2 -mpopcnt -m64 -mtune=intel" \
 --enable-shared \
 --disable-static \
 --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib64 -L$PLATFORM/usr/lib64 -nostdlib -lc -lm -ldl -llog" \

#  --enable-zlib \

# --disable-doc \

  ${MODULES}

  make clean
  make
  make install
}

build_x86_64


echo Android X86_64 builds finished
