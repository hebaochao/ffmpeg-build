# ffmpeg-build
ffmpeg-build

1、修改FFmpeg 中configure文件

将

   SLIBNAME_WITH_MAJOR='$(SLIBNAME).$(LIBMAJOR)'

   LIB_INSTALL_EXTRA_CMD='$$(RANLIB)"$(LIBDIR)/$(LIBNAME)"'

   SLIB_INSTALL_NAME='$(SLIBNAME_WITH_VERSION)'

   SLIB_INSTALL_LINKS='$(SLIBNAME_WITH_MAJOR)$(SLIBNAME)'

改成

   SLIBNAME_WITH_MAJOR='$(SLIBPREF)$(FULLNAME)-$(LIBMAJOR)$(SLIBSUF)'

   LIB_INSTALL_EXTRA_CMD='$$(RANLIB)"$(LIBDIR)/$(LIBNAME)"'

   SLIB_INSTALL_NAME='$(SLIBNAME_WITH_MAJOR)'

   SLIB_INSTALL_LINKS='$(SLIBNAME)'


2、下载并安装ndk ,配置ndk

3、配置build_android*.sh 等脚本的ndk路径

4、 cd  ffmpeg-3.3.6

5、./build_android_all.sh 生成Android所有平台的so

