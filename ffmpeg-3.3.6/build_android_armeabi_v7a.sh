#!/bin/bash
#Change NDK to your Android NDK location
NDK=/Users/alex/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-16/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm"


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


function build_ARMv7
{
  ./configure \
  --target-os=linux \
  --prefix=./android/armeabi-v7a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-shared \
  --disable-static \

--extra-cflags="-DANDROID -fPIC -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300" \
--extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \

#--enable-zlib \

  ${MODULES} \
  --disable-doc \
  --enable-neon

  make clean
  make
  make install
}

build_ARMv7
echo Android ARMv7-a builds finished
