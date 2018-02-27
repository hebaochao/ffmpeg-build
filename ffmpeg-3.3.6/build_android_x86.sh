#!/bin/bash
#Change NDK to your Android NDK location
NDK=/Users/alex/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-16/arch-x86/
PREBUILT=$NDK/toolchains/x86-4.9/prebuilt/darwin-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/i686-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/i686-linux-android- \
--nm=$PREBUILT/bin/i686-linux-android-nm "

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


function build_x86
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./android/x86 \
  --arch=x86 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
 --extra-cflags=" -O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8" \
 --enable-shared \
 --disable-static \
 --extra-cflags="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32" \
 --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \

#  --enable-zlib \

  --disable-doc \
  ${MODULES}

  make clean
  make
  make install
}

build_x86


echo Android X86 builds finished
