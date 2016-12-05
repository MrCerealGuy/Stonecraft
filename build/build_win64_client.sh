#!/bin/bash
set -e

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set directories
platform="win-x86_64"
mkdir -p $platform
builddir="$( cd "$platform" && pwd )"
stonecraftdir="$( cd .. && pwd)"
libdir=$stonecraftdir/libs/mingw-$platform
cd $builddir


# Library versions
toolchain_file=$dir/toolchain_mingw64.cmake
irrlicht_version=1.8.4
ogg_version=1.3.2
vorbis_version=1.3.5
curl_version=7.50.3
gettext_version=0.18.2
freetype_version=2.7
sqlite3_version=3.14.2
luajit_version=2.0.3
leveldb_version=1.18
zlib_version=1.2.8
mingw32_version=5.3.1


# Get stonecraft
cd $builddir

cp $stonecraftdir/CMakeLists.txt ./
cp -R $stonecraftdir/builtin ./
cp -R $stonecraftdir/client ./
cp -R $stonecraftdir/cmake ./
cp -R $stonecraftdir/doc ./
cp -R $stonecraftdir/fonts ./
cp -R $stonecraftdir/games ./
cp -R $stonecraftdir/misc ./
cp -R $stonecraftdir/po ./
cp -R $stonecraftdir/locale ./
cp -R $stonecraftdir/src ./
cp -R $stonecraftdir/textures ./

rm ./src/cmake_config*.h


# Build the thing
[ -d _build ] && rm -Rf _build/
mkdir _build
cd _build

# LEVELDB disabled, see issue 4665 -> https://github.com/minetest/minetest/issues/4665

cmake .. \
	-DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
	-DCMAKE_INSTALL_PREFIX=/tmp \
	-DBUILD_CLIENT=1 -DBUILD_SERVER=0 \
	\
	-DENABLE_SOUND=1 \
	-DENABLE_CURL=1 \
	-DENABLE_GETTEXT=1 \
	-DENABLE_FREETYPE=1 \
	-DENABLE_LEVELDB=0 \
	\
	-DIRRLICHT_INCLUDE_DIR=$libdir/irrlicht-$irrlicht_version/include \
	-DIRRLICHT_LIBRARY=$libdir/irrlicht-$irrlicht_version/lib/Win64-gcc/libIrrlicht.dll.a \
	-DIRRLICHT_DLL=$libdir/irrlicht-$irrlicht_version/bin/Win64-gcc/Irrlicht.dll \
	\
	-DZLIB_INCLUDE_DIR=$libdir/zlib-$zlib_version/include \
	-DZLIB_LIBRARIES=$libdir/zlib-$zlib_version/lib/libz.dll.a \
	-DZLIB_DLL=$libdir/zlib-$zlib_version/bin/zlib1.dll \
	\
	-DLUA_INCLUDE_DIR=$libdir/luajit-$luajit_version/include \
	-DLUA_LIBRARY=$libdir/luajit-$luajit_version/libluajit.a \
	\
	-DOGG_INCLUDE_DIR=$libdir/libogg-$ogg_version/include \
	-DOGG_LIBRARY=$libdir/libogg-$ogg_version/lib/libogg.dll.a \
	-DOGG_DLL=$libdir/libogg-$ogg_version/bin/libogg-0.dll \
	\
	-DVORBIS_INCLUDE_DIR=$libdir/libvorbis-$vorbis_version/include \
	-DVORBIS_LIBRARY=$libdir/libvorbis-$vorbis_version/lib/libvorbis.dll.a \
	-DVORBIS_DLL=$libdir/libvorbis-$vorbis_version/bin/libvorbis-0.dll \
	-DVORBISFILE_LIBRARY=$libdir/libvorbis-$vorbis_version/lib/libvorbisfile.dll.a \
	-DVORBISFILE_DLL=$libdir/libvorbis-$vorbis_version/bin/libvorbisfile-3.dll \
	\
	-DOPENAL_INCLUDE_DIR=$libdir/openal_stripped/include/AL \
	-DOPENAL_LIBRARY=$libdir/openal_stripped/lib/libOpenAL32.dll.a \
	-DOPENAL_DLL=$libdir/openal_stripped/bin/OpenAL32.dll \
	\
	-DCURL_DLL=$libdir/curl-$curl_version/bin/libcurl-4.dll \
	-DCURL_INCLUDE_DIR=$libdir/curl-$curl_version/include \
	-DCURL_LIBRARY=$libdir/curl-$curl_version/lib/libcurl.dll.a \
	\
	-DCUSTOM_GETTEXT_PATH=$libdir/gettext-$gettext_version \
	-DGETTEXT_MSGFMT=`which msgfmt` \
	-DGETTEXT_DLL=$libdir/gettext-$gettext_version/bin/libintl-8.dll \
	-DGETTEXT_ICONV_DLL=$libdir/gettext-$gettext_version/bin/libiconv-2.dll \
	-DGETTEXT_INCLUDE_DIR=$libdir/gettext-$gettext_version/include \
	-DGETTEXT_LIBRARY=$libdir/gettext-$gettext_version/lib/libintl.dll.a \
	\
	-DFREETYPE_INCLUDE_DIR_freetype2=$libdir/freetype2-$freetype_version/include/freetype2 \
	-DFREETYPE_INCLUDE_DIR_ft2build=$libdir/freetype2-$freetype_version/include/freetype2 \
	-DFREETYPE_LIBRARY=$libdir/freetype2-$freetype_version/lib/libfreetype.dll.a \
	-DFREETYPE_DLL=$libdir/freetype2-$freetype_version/bin/libfreetype-6.dll \
	\
	-DSQLITE3_INCLUDE_DIR=$libdir/sqlite3-$sqlite3_version/include \
	-DSQLITE3_LIBRARY=$libdir/sqlite3-$sqlite3_version/lib/libsqlite3.dll.a \
	-DSQLITE3_DLL=$libdir/sqlite3-$sqlite3_version/bin/libsqlite3-0.dll \
	\
	-DLEVELDB_INCLUDE_DIR=$libdir/leveldb-$leveldb_version/include \
	-DLEVELDB_LIBRARY=$libdir/leveldb-$leveldb_version/lib/libleveldb.dll.a \
	-DLEVELDB_DLL=$libdir/leveldb-$leveldb_version/bin/libleveldb.dll

make package -j$(grep -c processor /proc/cpuinfo)

# Copy dll files into bin dir
cd ../bin

cp $libdir/mingw32-$mingw32_version/* ./
cp $libdir/irrlicht-$irrlicht_version/bin/Win64-gcc/Irrlicht.dll ./
cp $libdir/zlib-$zlib_version/bin/zlib1.dll ./
cp $libdir/libogg-$ogg_version/bin/libogg-0.dll ./
cp $libdir/libvorbis-$vorbis_version/bin/libvorbis-0.dll ./
cp $libdir/libvorbis-$vorbis_version/bin/libvorbisfile-3.dll ./
cp $libdir/openal_stripped/bin/OpenAL32.dll ./
cp $libdir/curl-$curl_version/bin/libcurl-4.dll ./
cp $libdir/gettext-$gettext_version/bin/libintl-8.dll ./
cp $libdir/gettext-$gettext_version/bin/libiconv-2.dll ./
cp $libdir/freetype2-$freetype_version/bin/libfreetype-6.dll ./
cp $libdir/sqlite3-$sqlite3_version/bin/libsqlite3-0.dll ./
cp $libdir/leveldb-$leveldb_version/bin/libleveldb.dll ./


# EOF
