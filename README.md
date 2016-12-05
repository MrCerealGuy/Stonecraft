# Stonecraft

An InfiniMiner/Minecraft inspired game.

Copyright (c) 2016 Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>
and contributors (see source file comments and the version control log)


## Further documentation

- Website: http://bc547.de/stonecraft
- Wiki: http://bc547.de/stonecraft/wiki
- Github: https://github.com/mrcerealguy/stonecraft


## This game is not finished

- Don't expect it to work as well as a finished game will.
- Please report any bugs. When doing that, debug.txt is useful.


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
E: Inventory menu
Mouse wheel: Select item
0-9: Select item
Z: Zoom (needs zoom privilege)
T: Chat
/: Commad
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


## Command-line options

```
Use --help
```


# Compiling on GNU/Linux

**Install dependencies**. Here's an example for Debian/Ubuntu:
```
$ sudo apt-get install git-core build-essential libirrlicht-dev cmake libbz2-dev libpng12-dev libjpeg-dev libxxf86vm-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev zlib1g-dev libgmp-dev libjsoncpp-dev doxygen mingw-w64
```

**Download source** (this is the URL to the latest of source repository, which might not work at all times) using git:
```
$ git clone --depth 1 https://github.com/mrcerealguy/stonecraft.git
$ cd stonecraft
```

Build a version that **runs directly** from the stonecraft directory:
```
$ cmake . -DBUILD_CLIENT=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LEVELDB=1 -DENABLE_REDIS=1 
$ make -j$(grep -c processor /proc/cpuinfo) 
```
or run build script
```
$ cd build
$ <stonecraft-folder>/build_linux_client.sh
```

Run it:
```
$ <stonecraft-folder>/bin/stonecraft
```

# Cross-Compiling for Windows on GNU/Linux

Please install source and dependencies like above. I've used MinGW-w64 5.3.1 for the Windows builds.

**Download libraries**
Please download the Windows libraries from http://www.megafileupload.com/80wj/stonecraft-master-win-libs.zip and install it in your Stonecraft folder.

**Win 32-Bit**
```
$ <stonecraft-folder>/build/build_win32_client.sh
```

You'll find the build in <stonecraft-foler>/build/win-i686.

**Win 64-Bit**
```
$ <stonecraft-folder>/build/build_win64_client.sh
```

You'll find the build in <stonecraft-foler>/build/win-x86_64.


# Compiling on Windows with MSVC

- **You need**
	* CMake:
		http://www.cmake.org/cmake/resources/software.html
	* Visual Studio 2013
		http://msdn.microsoft.com/en-us/vstudio/default
	* Stonecraft source
		https://github.com/mrcerealguy/stonecraft/
	* Windows libraries
		http://www.megafileupload.com/80wj/stonecraft-master-win-libs.zip

- **Steps**
	- Select a directory called DIR (e.g. Stonecraft) hereafter in which you will operate.
	- Extract stonecraft in DIR
	- Extract Windows libraries in DIR
	- Make sure you have CMake and a compiler installed.
	- You will end up with a directory structure like this (+=dir, -=file):

	+ DIR
		+ bin
		+ builtin
		+ client
		+ ...
		+ libs
			+ msvc2013-win-i686
				+ zlib-1.2.8
					- zlib.h
					+ win32
					+ ...
				+ irrlicht-1.8.3
					+ lib
					+ include
					+ ...
				+ gettext (optional)
					+bin
					+include
					+lib
					+ ...
		+ src
		+ ...

	- Start up the **CMake GUI**
	- Select "Browse Source..." and select DIR
	- Now, if using **MSVC**:
		- Select "Browse Build..." and select **DIR/build/win-msvc2013**
	- Select "Configure"
	- Select your compiler
	- It will warn about missing stuff, ignore that at this point. (later don't)
	- Make sure the configuration is as follows
	  (note that the versions may differ for you):

	```
	BUILD_CLIENT					[X]
	BUILD_SERVER					[ ]
	CMAKE_BUILD_TYPE				Release
	ENABLE_CURL						[X]
	ENABLE_FREETYPE					[X]
	ENABLE_GETTEXT					[X]
	ENABLE_LUAJIT					[X]
	ENABLE_SOUND					[X]
	ENABLE_SPATIAL					[X]
	ENABLE_SYSTEM_GMP				[X]
	RUN_IN_PLACE					[X]
	WARN_ALL						[X]
	CMAKE_INSTALL_PREFIX			DIR/stonecraft-install
	FREETYPE_INCLUDE_DIR_freetype2	DIR/libs/msvc2013-win-i686/freetype-2.3.5-1/include/freetype2
	FREETYPE_INCLUDE_DIR_ft2build	DIR/libs/msvc2013-win-i686/freetype-2.3.5-1/include/
	FREETYPE_LIBRARY				DIR/libs/msvc2013-win-i686/freetype-2.3.5-1/lib/freetype.lib
	GETTEXT_DLL						DIR/libs/msvc2013-win-i686/gettext/bin/libintl3.dll
	GETTEXT_ICONV_DLL				DIR/libs/msvc2013-win-i686/gettext/bin/libiconv2.dll
	GETTEXT_INCLUDE_DIR				DIR/libs/msvc2013-win-i686/gettext/include
	GETTEXT_LIBRARY					DIR/libs/msvc2013-win-i686/gettext/lib/libintl.lib
	GETTEXT_MSGFMT					DIR/libs/msvc2013-win-i686/gettext/bin/msgfmt.exe
	IRRLICHT_DLL					DIR/libs/msvc2013-win-i686/irrlicht-1.8.1/bin/Irrlicht.dll
	IRRLICHT_INCLUDE_DIR			DIR/libs/msvc2013-win-i686/irrlicht-1.8.1/include
	IRRLICHT_LIBRARY				DIR/libs/msvc2013-win-i686/irrlicht-1.8.1/bin/Irrlicht.lib
	LUA_INCLUDE_DIR					DIR/libs/msvc2013-win-i686/LuaJIT-2.0.3/include
	LUA_LIBRARY						DIR/libs/msvc2013-win-i686/LuaJIT-2.0.3/bin/lua51.lib
	OGG_DLL							DIR/libs/msvc2013-win-i686/libogg-1.3.1/bin/libogg.dll
	OGG_INCLUDE_DIR					DIR/libs/msvc2013-win-i686/libogg-1.3.1/include
	OGG_LIBRARY						DIR/libs/msvc2013-win-i686/libogg-1.3.1/bin/libogg.lib
	OPENAL_DLL						DIR/libs/msvc2013-win-i686/openal-soft-1.15.1/bin/OpenAL32.dll
	OPENAL_INCLUDE_DIR				DIR/libs/msvc2013-win-i686/openal-soft-1.15.1/include/AL
	OPENAL_LIBRARY					DIR/libs/msvc2013-win-i686/openal-soft-1.15.1/bin/OpenAL32.lib
	SPATIAL_INCLUDE_DIR				DIR/libs/msvc2013-win-i686/spatialindex-1.8.5/include
	SPATIAL_LIBRARY					DIR/libs/msvc2013-win-i686/spatialindex-1.8.5/bin/spatialindex-32.lib
	SQLITE3_INCLUDE_DIR				DIR/libs/msvc2013-win-i686/sqlite-3.8.7.4/include
	SQLITE3_LIBRARY					DIR/libs/msvc2013-win-i686/sqlite-3.8.7.4/bin/sqlite3.lib
	VORBISFILE_DLL					DIR/libs/msvc2013-win-i686/libvorbis-1.3.3/bin/libvorbisfile.dll
	VORBISFILE_LIBRARY				DIR/libs/msvc2013-win-i686/libvorbis-1.3.3/bin/libvorbisfile.lib
	VORBIS_DLL						DIR/libs/msvc2013-win-i686/libvorbis-1.3.3/bin/libvorbis.dll
	VORBIS_INCLUDE_DIR				DIR/libs/msvc2013-win-i686/libvorbis-1.3.3/include
	VORBIS_LIBRARY					DIR/libs/msvc2013-win-i686/libvorbis-1.3.3/bin/libvorbis.lib
	ZLIB_DLL						DIR/libs/msvc2013-win-i686/zlib-1.2.8/bin/ZlibDllRelease/zlibwapi.dll
	ZLIB_INCLUDE_DIR				DIR/libs/msvc2013-win-i686/zlib-1.2.8/include
	ZLIB_LIBRARIES					DIR/libraries/zlib-1.2.8/bin/ZlibDllRelease/zlibwapi.lib
	```

	- Hit "Configure"
	- Hit "Configure" once again 8)
	- If something is still coloured red, you have a problem.
	- Hit "Generate"

	Now change to **DIR/build/win-msvc2013**
	
	```
		- Open the generated **stonecraft.sln**
		- The project defaults to the "Debug" configuration. Make very sure to
		  select **"Release"**, unless you want to debug some stuff (it's slower
		  and might not even work at all)
		- Add to the stonecraft project under Linker/command line "/NODEFAULTLIB:libcmt.lib"
		- Build the **ALL_BUILD project**
		- You now find **stonecraft.exe** in DIR/bin
		- Build the **INSTALL project** (optional)
		- You should now have a working game with the executable in
			DIR/bin/stonecraft.exe
		- Additionally you may create a zip package by building the **PACKAGE project**.
	```

	**Pre-generated CMakeCache.txt**  
	If you wish, you can use this example file **DIR/build/win-msvc2013/CMakeCache.txt.example**. You only have to rename it to CMakeCache.txt and to adjust the directories by search & replace with a text edtior. After loading it in CMake GUI, you can generate the project files.

# License of Stonecraft textures and sounds

This applies to textures and sounds contained in the main Stonecraft distribution.

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
http://creativecommons.org/licenses/by-sa/3.0/


# Authors of media files


See README.txt in each mod/textures directory for information about other authors.


# License of Stonecraft source code

Stonecraft
Copyright (C) 2016 Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

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
