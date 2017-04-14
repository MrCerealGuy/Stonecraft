/*
Minetest
Copyright (C) 2017 Loic Blot <loic.blot@unix-experience.fr>

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

#ifndef L_MINIMAP_H_
#define L_MINIMAP_H_

#include "l_base.h"

class Minimap;

class LuaMinimap : public ModApiBase
{
private:
	static const char className[];
	static const luaL_Reg methods[];

	// garbage collector
	static int gc_object(lua_State *L);

	static int l_get_pos(lua_State *L);
	static int l_set_pos(lua_State *L);

	static int l_get_angle(lua_State *L);
	static int l_set_angle(lua_State *L);

	static int l_get_mode(lua_State *L);
	static int l_set_mode(lua_State *L);

	static int l_show(lua_State *L);
	static int l_hide(lua_State *L);

	static int l_set_shape(lua_State *L);
	static int l_get_shape(lua_State *L);

	Minimap *m_minimap;

public:
	LuaMinimap(Minimap *m);
	~LuaMinimap() {}

	static void create(lua_State *L, Minimap *object);

	static LuaMinimap *checkobject(lua_State *L, int narg);
	static Minimap *getobject(LuaMinimap *ref);

	static void Register(lua_State *L);
};

#endif // L_MINIMAP_H_
