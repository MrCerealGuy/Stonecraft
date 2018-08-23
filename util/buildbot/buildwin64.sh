#!/bin/bash
set -e

platform="win-x86_64"

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ $# -ne 1 ]; then
	echo "Usage: $0 <build directory>"
	exit 1
fi

# Set directories
builddir=$1
mkdir -p $builddir
builddir="$( cd "$builddir" && pwd )"
libdir=$builddir/stonecraft/lib/mingw-$platform


# Library versions
toolchain_file=$dir/toolchain_mingw64.cmake
irrlicht_version=1.8.4
ogg_version=1.3.2
vorbis_version=1.3.5
curl_version=7.54.0
gettext_version=0.19.8.1
freetype_version=2.8
sqlite3_version=3.19.2
luajit_version=2.1.0-beta3-gc64 # uses own build, see https://github.com/MrCerealGuy/LuaJIT-2.1.0-beta3-GC64
leveldb_version=1.19
zlib_version=1.2.11


# Get stonecraft
cd $builddir
if [ ! "x$EXISTING_STONECRAFT_DIR" = "x" ]; then
	ln -s $EXISTING_STONECRAFT_DIR stonecraft
else
	[ -d stonecraft ] && (cd stonecraft && git pull) || (git clone https://github.com/MrCerealGuy/Stonecraft.git stonecraft)
fi

cd stonecraft
git_hash=$(git rev-parse --short HEAD)


# Get stonecraft windows libraries
cd lib

if [ -d libdev-win ]; then
	cd libdev-win && git pull
else
	git clone https://github.com/MrCerealGuy/Stonecraft-libdev-win.git libdev-win
	mv ./libdev-win/* ./
	rm -Rf ./libdev-win
fi

cd $builddir


# Build the thing
cd stonecraft
[ -d _build ] && rm -Rf _build/
mkdir _build
cd _build
cmake .. \
	-DCMAKE_INSTALL_PREFIX=/tmp \
	-DVERSION_EXTRA=$git_hash \
	-DBUILD_CLIENT=1 -DBUILD_SERVER=0 \
	-DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
	\
	-DENABLE_SOUND=1 \
	-DENABLE_CURL=1 \
	-DENABLE_GETTEXT=1 \
	-DENABLE_FREETYPE=1 \
	-DENABLE_LEVELDB=1 \
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
	-DLEVELDB_INCLUDE_DIR=$libdir/libleveldb-$leveldb_version/include \
	-DLEVELDB_LIBRARY=$libdir/libleveldb-$leveldb_version/lib/libleveldb.dll.a \
	-DLEVELDB_DLL=$libdir/libleveldb-$leveldb_version/bin/libleveldb.dll

make package -j2

[ "x$NO_PACKAGE" = "x" ] && make package

exit 0
# EOF
