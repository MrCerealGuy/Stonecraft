/*
Minetest
Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com>

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
*/

#include "version.h"
#include "config.h"

#if defined(__ANDROID__)
	#include "android_version.h"
	#include "android_version_githash.h"
#elif defined(USE_CMAKE_CONFIG_H)
	#include "cmake_config_githash.h"
#endif

#ifndef VERSION_GITHASH
	#define VERSION_GITHASH VERSION_STRING
#endif


const char *g_version_string = VERSION_STRING;
const char *g_version_hash = VERSION_GITHASH;
const char *g_build_info = "VER=" VERSION_GITHASH " " BUILD_INFO;

