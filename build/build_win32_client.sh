#!/bin/bash
set -e

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set directories and delete existing build dir
platform="win-i686"
[ -d $platform ] && rm -Rf $platform
mkdir -p $platform
builddir="$( cd "$platform" && pwd )"
stonecraftdir="$( cd .. && pwd)"
libdir=$stonecraftdir/lib/mingw-$platform
cd $builddir


# Library versions
toolchain_file=$dir/toolchain_mingw.cmake
irrlicht_version=1.8.4
ogg_version=1.3.2
vorbis_version=1.3.5
curl_version=7.54.0
gettext_version=0.19.8.1
freetype_version=2.8
sqlite3_version=3.19.2
#luajit_version=2.0.1-static-win32	# LuaJIT disabled, see issue https://github.com/minetest/minetest/issues/2988
luajit_version=2.1.0-beta3
#leveldb_version=1.19	# LEVELDB disabled, see issue https://github.com/minetest/minetest/issues/4665
zlib_version=1.2.11
mingw32_version=5.3.1


dialog --backtitle "Stonecraft Build" --title "Stonecraft Build" --yesno "Start the build process? All previous generated CMake files will be deleted!" 15 60
antwort=${?}

if [ "$antwort" -eq "255" ]
  then
    echo "Aborted"
    exit 255
fi

if [ "$antwort" -eq "1" ]
  then
    exit 1
fi

if [ "$antwort" -eq "0" ]
  then
    $stonecraftdir/util/remove_generated_cmakefiles.sh
fi


# Get stonecraft
echo -e "\E[34;47mCopy stonecraft files into build dir..."

cd $builddir

rsync --info=progress2 $stonecraftdir/README.md ./
rsync --info=progress2 $stonecraftdir/Manual.pdf ./
rsync --info=progress2 $stonecraftdir/CMakeLists.txt ./
rsync --info=progress2 $stonecraftdir/stonecraft.conf.example ./
rsync -r --info=progress2 $stonecraftdir/builtin ./
rsync -r --info=progress2 $stonecraftdir/client ./
rsync -r --info=progress2 $stonecraftdir/clientmods ./
rsync -r --info=progress2 $stonecraftdir/cmake ./
rsync -r --info=progress2 $stonecraftdir/doc ./
rsync -r --info=progress2 $stonecraftdir/fonts ./
rsync -r --info=progress2 $stonecraftdir/games ./
rsync -r --info=progress2 $stonecraftdir/lib ./
rsync -r --info=progress2 $stonecraftdir/misc ./
rsync -r --info=progress2 $stonecraftdir/mods ./
rsync -r --info=progress2 $stonecraftdir/po ./
rsync -r --info=progress2 $stonecraftdir/src ./
rsync -r --info=progress2 $stonecraftdir/textures ./

rm ./src/cmake_config*.h
echo -e "\E[34;47mdone!"


# Copy dll files into bin dir
echo -e "\E[34;47mCopy dll files into bin dir..."
mkdir -p bin
cp $libdir/mingw32-$mingw32_version/* ./bin
cp $libdir/irrlicht-$irrlicht_version/bin/Win32-gcc/Irrlicht.dll ./bin
cp $libdir/zlib-$zlib_version/bin/zlib1.dll ./bin
cp $libdir/libogg-$ogg_version/bin/libogg-0.dll ./bin
cp $libdir/libvorbis-$vorbis_version/bin/libvorbis-0.dll ./bin
cp $libdir/libvorbis-$vorbis_version/bin/libvorbisfile-3.dll ./bin
cp $libdir/openal_stripped/bin/OpenAL32.dll ./bin
cp $libdir/curl-$curl_version/bin/libcurl-4.dll ./bin
cp $libdir/gettext-$gettext_version/bin/libintl3.dll ./bin
cp $libdir/gettext-$gettext_version/bin/libiconv2.dll ./bin
cp $libdir/freetype2-$freetype_version/bin/libfreetype-6.dll ./bin
cp $libdir/sqlite3-$sqlite3_version/bin/libsqlite3-0.dll ./bin
#cp $libdir/libleveldb-$leveldb_version/bin/libleveldb.dll ./bin
echo -e "\E[34;47mdone!"


# Build the thing
echo -e "\E[34;47mRun cmake..."
[ -d _build ] && rm -Rf _build/
mkdir _build
cd _build

# LEVELDB disabled, see issue https://github.com/minetest/minetest/issues/4665

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
	-DIRRLICHT_LIBRARY=$libdir/irrlicht-$irrlicht_version/lib/Win32-gcc/libIrrlicht.dll.a \
	-DIRRLICHT_DLL=$libdir/irrlicht-$irrlicht_version/bin/Win32-gcc/Irrlicht.dll \
	\
	-DZLIB_INCLUDE_DIR=$libdir/zlib-$zlib_version/include \
	-DZLIB_LIBRARIES=$libdir/zlib-$zlib_version/lib/libz.dll.a \
	-DZLIB_DLL=$libdir/zlib-$zlib_version/bin/zlib1.dll \
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
	-DGETTEXT_DLL=$libdir/gettext-$gettext_version/bin/libintl3.dll \
	-DGETTEXT_ICONV_DLL=$libdir/gettext-$gettext_version/bin/libiconv2.dll \
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
	-DLUA_INCLUDE_DIR=$libdir/luajit-$luajit_version/include \
	-DLUA_LIBRARY=$libdir/luajit-$luajit_version/libluajit.a
	#\
	#-LIBGCC_DLL=$libdir/mingw32-$mingw32_version/libgcc_s_sjlj-1.dll \
	#-LIBSTDCXX_DLL=$libdir/mingw32-$mingw32_version/libstdc++-6.dll \
	#-LIBWINPHTHREAD_DLL=$libdir/mingw32-$mingw32_version/libwinpthread-1.dll
	#\
	#-DLEVELDB_INCLUDE_DIR=$libdir/leveldb-$leveldb_version/include \
	#-DLEVELDB_LIBRARY=$libdir/leveldb-$leveldb_version/lib/libleveldb.dll.a \
	#-DLEVELDB_DLL=$libdir/leveldb-$leveldb_version/bin/libleveldb.dll

echo -e "\E[34;47mdone!"

echo -e "\E[34;47mRun make..."
make package -j$(grep -c processor /proc/cpuinfo)
echo -e "\E[34;47mdone!"

# EOF
