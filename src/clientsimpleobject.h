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

#ifndef CLIENTSIMPLEOBJECT_HEADER
#define CLIENTSIMPLEOBJECT_HEADER

#include "irrlichttypes_bloated.h"
class ClientEnvironment;

class ClientSimpleObject
{
protected:
public:
	bool m_to_be_removed;

	ClientSimpleObject() : m_to_be_removed(false) {}
	virtual ~ClientSimpleObject() {}
	virtual void step(float dtime) {}
};

#endif
