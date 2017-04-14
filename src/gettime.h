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

#ifndef GETTIME_HEADER
#define GETTIME_HEADER

#include "irrlichttypes.h"

/*
	Get a millisecond counter value.
	Precision depends on implementation.
	Overflows at any value above 10000000.

	Implementation of this is done in:
		Normal build: main.cpp
		Server build: servermain.cpp
*/
enum TimePrecision
{
	PRECISION_SECONDS = 0,
	PRECISION_MILLI,
	PRECISION_MICRO,
	PRECISION_NANO
};

extern u32 getTimeMs();
extern u32 getTime(TimePrecision prec);

/*
	Timestamp stuff
*/

#include <string>
#include <time.h>

inline std::string getTimestamp()
{
	time_t t = time(NULL);
	// This is not really thread-safe but it won't break anything
	// except its own output, so just go with it.
	struct tm *tm = localtime(&t);
	char cs[20]; // YYYY-MM-DD HH:MM:SS + '\0'
	strftime(cs, 20, "%Y-%m-%d %H:%M:%S", tm);
	return cs;
}

#endif
