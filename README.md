# Stonecraft

[![Build Status](https://travis-ci.org/MrCerealGuy/Stonecraft.svg?branch=master)](https://travis-ci.org/MrCerealGuy/Stonecraft)
[![License](https://img.shields.io/badge/license-LGPLv3.0-blue.svg)](https://www.gnu.org/licenses/lgpl.html)

An InfiniMiner/Minecraft inspired game powered by Minetest 0.5.0-dev

Copyright (c) 2016-2018 Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de> and contributors


## Further documentation

- Website: http://mrcerealguy.github.io/stonecraft
- Wiki: http://github.com/mrcerealguy/stonecraft/wiki
- Github: https://github.com/mrcerealguy/stonecraft


## This game is not finished

- Don't expect it to work as well as a finished game will.
- Please report any bugs. When doing that, debug.txt is useful.

Please use the Stonecraft bug report.
https://goo.gl/forms/1MwRnBDntHntkuHg2


## Default Controls

```
Move mouse: Look around
W, A, S, D: Move
Space: Jump/move up
Strg: Sneak/move down
Q: Drop itemstack
Shift + Q: Drop single item
Left mouse button: Dig/punch/take item
Right mouse button: Place/use
Shift + right mouse button: Build (without using)
I: Inventory menu
Mouse wheel: Select item
0-9: Select item
Z: Zoom
T: Chat
/: Command
Esc: Pause menu/abort/exit (pauses only singleplayer game)
R: Enable/disable full range view
+: Increase view range
-: Decrease view range
K: Enable/disable fly mode (needs fly privilege)
J: Enable/disable fast mode (needs fast privilege)
H: Enable/disable noclip mode (needs noclip privilege)
F1: Hide/show HUD
F2: Hide/show chat
F3: Disable/enable fog
F4: Disable/enable camera update (Mapblocks are not updated anymore when disabled, disabled in release builds)
F5: Cycle through debug info screens
F6: Cycle through profiler info screens
F7: Cycle through camera modes
F8: Toggle cinematic mode
F9: Cycle through minimap modes
Shift + F9: Change minimap orientation
F10: Show/hide console
F12: Take screenshot
P: Write stack traces into debug.txt
```

Most controls are settable in the configuration file, see the section below.


## World directory

- Worlds can be found as separate folders in:
```
<stonecraft-folder>/worlds/
```


## Configuration file

- Default location:
```
<stonecraft-folder>/stonecraft.conf
```

- It is created by Stonecraft when it is ran the first time.
- A specific file can be specified on the command line:
```
--config <path-to-file>
```

Command-line options:
---------------------
- Use --help

## Command-line options

```
Use --help
```


# Building GNU/Linux 

## Dependencies

| Dependency | Version | Commentary |
|------------|---------|------------|
| GCC        | 4.9+    | Can be replaced with Clang 3.4+ |
| CMake      | 2.6+    |            |
| Irrlicht   | 1.7.3+  |            |
| SQLite3    | 3.0+    |            |
| LuaJIT     | 2.0+    | Bundled Lua 5.1 is used if not present |
| GMP        | 5.0.0+  | Bundled mini-GMP is used if not present |
| JsonCPP    | 1.0.0+  | Bundled JsonCPP is used if not present |

**Install dependencies for Debian/Ubuntu**
```
$ sudo apt-get install git-core build-essential libirrlicht-dev cmake libstdc++6 libbz2-dev libpng-dev libjpeg-dev libxxf86vm-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev zlib1g-dev libgmp-dev libjsoncpp-dev doxygen mingw-w64 libgd-dev libleveldb-dev libhiredis-dev libncurses5-dev liblua5.2-dev dialog libluajit-5.1-dev clang-format
```

**Download source** (this is the URL to the latest of source repository, which might not work at all times) using git:
```
$ git clone --depth 1 https://github.com/mrcerealguy/stonecraft.git
$ cd stonecraft
```

Build a version that **runs directly** from the stonecraft directory:
```
$ cmake . -DBUILD_CLIENT=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LEVELDB=1 -DENABLE_REDIS=1 -DRUN_IN_PLACE=1
$ make -j$(grep -c processor /proc/cpuinfo) 
```
or run the build script
```
$ cd build
$ <stonecraft-folder>/build/build_linux_client.sh
```

Run it:
```
$ <stonecraft-folder>/bin/stonecraft
```

To build the **dedicated server** without the client, you have to run the script build_linux_server.sh.

- Use `cmake . -LH` to see all CMake options and their current state
- If you want to install it system-wide (or are making a distribution package),
  you will want to use `-DRUN_IN_PLACE=FALSE`
- You can build a bare server by specifying `-DBUILD_SERVER=TRUE`
- You can disable the client build by specifying `-DBUILD_CLIENT=FALSE`
- You can select between Release and Debug build by `-DCMAKE_BUILD_TYPE=<Debug or Release>`
  - Debug build is slower, but gives much more useful output in a debugger
- If you build a bare server, you don't need to have Irrlicht installed.
  - In that case use `-DIRRLICHT_SOURCE_DIR=/the/irrlicht/source`

### CMake options

General options and their default values:

    BUILD_CLIENT=TRUE          - Build Minetest client
    BUILD_SERVER=FALSE         - Build Minetest server
    CMAKE_BUILD_TYPE=Release   - Type of build (Release vs. Debug)
        Release                - Release build
        Debug                  - Debug build
        SemiDebug              - Partially optimized debug build
        RelWithDebInfo         - Release build with Debug information
        MinSizeRel             - Release build with -Os passed to compiler to make executable as small as possible
    ENABLE_CURL=ON             - Build with cURL; Enables use of online mod repo, public serverlist and remote media fetching via http
    ENABLE_CURSES=ON           - Build with (n)curses; Enables a server side terminal (command line option: --terminal)
    ENABLE_FREETYPE=ON         - Build with FreeType2; Allows using TTF fonts
    ENABLE_GETTEXT=ON          - Build with Gettext; Allows using translations
    ENABLE_GLES=OFF            - Search for Open GLES headers & libraries and use them
    ENABLE_LEVELDB=ON          - Build with LevelDB; Enables use of LevelDB map backend
    ENABLE_POSTGRESQL=ON       - Build with libpq; Enables use of PostgreSQL map backend (PostgreSQL 9.5 or greater recommended)
    ENABLE_REDIS=ON            - Build with libhiredis; Enables use of Redis map backend
    ENABLE_SPATIAL=ON          - Build with LibSpatial; Speeds up AreaStores
    ENABLE_SOUND=ON            - Build with OpenAL, libogg & libvorbis; in-game Sounds
    ENABLE_LUAJIT=ON           - Build with LuaJIT (much faster than non-JIT Lua)
    ENABLE_SYSTEM_GMP=ON       - Use GMP from system (much faster than bundled mini-gmp)
    ENABLE_SYSTEM_JSONCPP=OFF  - Use JsonCPP from system
    RUN_IN_PLACE=FALSE         - Create a portable install (worlds, settings etc. in current directory)
    USE_GPROF=FALSE            - Enable profiling using GProf
    VERSION_EXTRA=             - Text to append to version (e.g. VERSION_EXTRA=foobar -> Minetest 0.4.9-foobar)

Library specific options:
    
    BZIP2_INCLUDE_DIR               - Linux only; directory where bzlib.h is located
    BZIP2_LIBRARY                   - Linux only; path to libbz2.a/libbz2.so
    CURL_DLL                        - Only if building with cURL on Windows; path to libcurl.dll
    CURL_INCLUDE_DIR                - Only if building with cURL; directory where curl.h is located
    CURL_LIBRARY                    - Only if building with cURL; path to libcurl.a/libcurl.so/libcurl.lib
    EGL_INCLUDE_DIR                 - Only if building with GLES; directory that contains egl.h
    EGL_LIBRARY                     - Only if building with GLES; path to libEGL.a/libEGL.so
    FREETYPE_INCLUDE_DIR_freetype2  - Only if building with Freetype2; directory that contains an freetype directory with files such as ftimage.h in it
    FREETYPE_INCLUDE_DIR_ft2build   - Only if building with Freetype2; directory that contains ft2build.h
    FREETYPE_LIBRARY                - Only if building with Freetype2; path to libfreetype.a/libfreetype.so/freetype.lib
    FREETYPE_DLL                    - Only if building with Freetype2 on Windows; path to libfreetype.dll
    GETTEXT_DLL                     - Only when building with Gettext on Windows; path to libintl3.dll
    GETTEXT_ICONV_DLL               - Only when building with Gettext on Windows; path to libiconv2.dll
    GETTEXT_INCLUDE_DIR             - Only when building with Gettext; directory that contains iconv.h
    GETTEXT_LIBRARY                 - Only when building with Gettext on Windows; path to libintl.dll.a
    GETTEXT_MSGFMT                  - Only when building with Gettext; path to msgfmt/msgfmt.exe
    IRRLICHT_DLL                    - Only on Windows; path to Irrlicht.dll
    IRRLICHT_INCLUDE_DIR            - Directory that contains IrrCompileConfig.h
    IRRLICHT_LIBRARY                - Path to libIrrlicht.a/libIrrlicht.so/libIrrlicht.dll.a/Irrlicht.lib
    LEVELDB_INCLUDE_DIR             - Only when building with LevelDB; directory that contains db.h
    LEVELDB_LIBRARY                 - Only when building with LevelDB; path to libleveldb.a/libleveldb.so/libleveldb.dll.a
    LEVELDB_DLL                     - Only when building with LevelDB on Windows; path to libleveldb.dll
    PostgreSQL_INCLUDE_DIR          - Only when building with PostgreSQL; directory that contains libpq-fe.h
    POSTGRESQL_LIBRARY              - Only when building with PostgreSQL; path to libpq.a/libpq.so
    REDIS_INCLUDE_DIR               - Only when building with Redis; directory that contains hiredis.h
    REDIS_LIBRARY                   - Only when building with Redis; path to libhiredis.a/libhiredis.so
    SPATIAL_INCLUDE_DIR             - Only when building with LibSpatial; directory that contains spatialindex/SpatialIndex.h
    SPATIAL_LIBRARY                 - Only when building with LibSpatial; path to libspatialindex_c.so/spatialindex-32.lib
    LUA_INCLUDE_DIR                 - Only if you want to use LuaJIT; directory where luajit.h is located
    LUA_LIBRARY                     - Only if you want to use LuaJIT; path to libluajit.a/libluajit.so
    MINGWM10_DLL                    - Only if compiling with MinGW; path to mingwm10.dll
    OGG_DLL                         - Only if building with sound on Windows; path to libogg.dll
    OGG_INCLUDE_DIR                 - Only if building with sound; directory that contains an ogg directory which contains ogg.h
    OGG_LIBRARY                     - Only if building with sound; path to libogg.a/libogg.so/libogg.dll.a
    OPENAL_DLL                      - Only if building with sound on Windows; path to OpenAL32.dll
    OPENAL_INCLUDE_DIR              - Only if building with sound; directory where al.h is located
    OPENAL_LIBRARY                  - Only if building with sound; path to libopenal.a/libopenal.so/OpenAL32.lib
    OPENGLES2_INCLUDE_DIR           - Only if building with GLES; directory that contains gl2.h
    OPENGLES2_LIBRARY               - Only if building with GLES; path to libGLESv2.a/libGLESv2.so
    SQLITE3_INCLUDE_DIR             - Directory that contains sqlite3.h
    SQLITE3_LIBRARY                 - Path to libsqlite3.a/libsqlite3.so/sqlite3.lib
    VORBISFILE_DLL                  - Only if building with sound on Windows; path to libvorbisfile-3.dll
    VORBISFILE_LIBRARY              - Only if building with sound; path to libvorbisfile.a/libvorbisfile.so/libvorbisfile.dll.a
    VORBIS_DLL                      - Only if building with sound on Windows; path to libvorbis-0.dll
    VORBIS_INCLUDE_DIR              - Only if building with sound; directory that contains a directory vorbis with vorbisenc.h inside
    VORBIS_LIBRARY                  - Only if building with sound; path to libvorbis.a/libvorbis.so/libvorbis.dll.a
    XXF86VM_LIBRARY                 - Only on Linux; path to libXXf86vm.a/libXXf86vm.so
    ZLIB_DLL                        - Only on Windows; path to zlib1.dll
    ZLIBWAPI_DLL                    - Only on Windows; path to zlibwapi.dll
    ZLIB_INCLUDE_DIR                - Directory that contains zlib.h
    ZLIB_LIBRARY                    - Path to libz.a/libz.so/zlibwapi.lib



# Building Windows on GNU/Linux (cross-compiling)

Please install source and dependencies like above. I've used **MinGW-w64 7.3-win32 20180312** for cross-compiling. My host system is Ubuntu 18.04.1 LTS (Bionic Beaver).

**Download libraries**  

Please clone the Windows libraries for MinGW via github:
```
$ cd <stonecraft-folder>/lib
$ git clone --depth 1 https://github.com/MrCerealGuy/Stonecraft-libdev-win.git libdev-win
$ mv ./libdev-win/* ../
$ rm -Rf ./libdev-win
```

**Win 32-Bit**
```
$ <stonecraft-folder>/build/build_win32_client.sh
```

You'll find the build in &lt;stonecraft-folder&gt;/build/win-i686 and the ZIP-package in the subdirectory _build.

**Win 64-Bit**
```
$ <stonecraft-folder>/build/build_win64_client.sh
```

You'll find the build in &lt;stonecraft-folder&gt;/build/win-x86_64 and the ZIP-package in the subdirectory _build.

**Create Windows package with InstallForge**

```
$ sudo apt-get install wine-stable
```

Download InstallForge for Windows:
```
https://installforge.net/
```

Install InstallForge with Wine:
```
$ wine IFSetup.exe
```

Now you can run InstallForge:
```
$ wine /home/<USER>/.wine/drive_c/Program Files (x86)/solicus/InstallForge/InstallForge.exe
```

Now select a InstallForge project file from this directory
```
<stonecraft-folder>/util/InstallForge/
```
and build the windows package. Make sure to extract the correct Windows build zip-package in this folder.


# Building Android on GNU/Linux

This is a simple guide on how to build Stonecraft for Android on a Debian-based 64 bit system. Building on 32 bit systems should work too when the URLs and paths are replaced accordingly. This guide covers all preparation needed. Once everything is set up, Stonecraft only needs cd build/android && make to compile.

**Required packages**  
Git, Make, and other basic tools are neccessary: 

```
$ sudo apt-get update
$ sudo apt-get install make m4 subversion git-core build-essential realpath openjdk-8-jdk 
$ sudo apt-get install libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5
```

Gradle is required as well. If your distribution gives you gradle 2.10 or later (like Ubuntu 16.04 does), you may simply do:

```
$ sudo apt-get install gradle
```

If your distribution ships with an older version of gradle, you may grab a recent version of gradle via a PPA:

```
$ sudo add-apt-repository ppa:cwchien/gradle
$ sudo apt-get install gradle-2.13 
```

As your architecture is 64 bit, you need additional packages.

On newer systems do: (Ubuntu 16.04-ish): 

```
$ sudo apt-get install lib32z1 
```

On older systems do:

```
$ sudo apt-get install --force-yes libgd2-xpm ia32-libs ia32-libs-multiarch
```

**Getting the SDK and NDK**  
Both SDK and NDK are needed:

```
$ wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz 
$ wget https://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip 
```
```
$ tar xf android-sdk_r24.4.1-linux.tgz 
$ unzip android-ndk-r11c-linux-x86_64.zip 
```

```
$ android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,android-25,build-tools-25.0.1 
```

The last line will ask for your confirmation multiple times.

**Obtaining and building Stonecraft**  
Clone Stonecraft, and build it:

```
$ git clone --depth 1 https://github.com/mrcerealguy/stonecraft.git
$ cd stonecraft/build/android 
$ make 
```

To install Stonecraft to your android device, type:

```
$ make install_debug
```


The make file will ask you for the paths to your SDK and NDK. It will then download and build all required libraries. Finally it will build Stonecraft and the Java sources and pack everything into a debug-signed APK.
	
# License of Stonecraft textures and sounds

This applies to textures and sounds contained in the main Stonecraft distribution.

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
http://creativecommons.org/licenses/by-sa/3.0/


# Authors of media files


See README.txt in each mod/textures directory for information about other authors.


# License of Stonecraft source code

Stonecraft
Copyright (C) 2016-2017 Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


# License of Minetest Engine source code

Minetest Engine
Copyright (C) 2010-2013 celeron55, Perttu Ahola <celeron55@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


# Irrlicht

This program uses the Irrlicht Engine. http://irrlicht.sourceforge.net/

 The Irrlicht Engine License

Copyright © 2002-2005 Nikolaus Gebhardt

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute
it freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you
      must not claim that you wrote the original software. If you use
      this software in a product, an acknowledgment in the product
      documentation would be appreciated but is not required.
   2. Altered source versions must be plainly marked as such, and must
      not be misrepresented as being the original software.
   3. This notice may not be removed or altered from any source
      distribution.


# JThread

This program uses the JThread library. License for JThread follows:

Copyright (c) 2000-2006  Jori Liesenborgs (jori.liesenborgs@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.


# Lua

Lua is licensed under the terms of the MIT license reproduced below.
This means that Lua is free software and can be used for both academic
and commercial purposes at absolutely no cost.

For details and rationale, see http://www.lua.org/license.html .

Copyright (C) 1994-2008 Lua.org, PUC-Rio.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


# Fonts

DejaVu Sans Mono:

  Fonts are (c) Bitstream (see below). DejaVu changes are in public domain.
  Glyphs imported from Arev fonts are (c) Tavmjong Bah (see below)

Bitstream Vera Fonts Copyright:

  Copyright (c) 2003 by Bitstream, Inc. All Rights Reserved. Bitstream Vera is
  a trademark of Bitstream, Inc.

Arev Fonts Copyright:

  Copyright (c) 2006 by Tavmjong Bah. All Rights Reserved.

Liberation Fonts Copyright:

  Copyright (c) 2007 Red Hat, Inc. All rights reserved. LIBERATION is a trademark of Red Hat, Inc.

DroidSansFallback:

  Copyright (C) 2008 The Android Open Source Project

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
