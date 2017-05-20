/*
Minetest
Copyright (C) 2013 kwolekr, Ryan Kwolek <kwolekr@minetest.net>

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


#include "lua_api/l_vmanip.h"
#include "lua_api/l_internal.h"
#include "common/c_content.h"
#include "common/c_converter.h"
#include "emerge.h"
#include "environment.h"
#include "map.h"
#include "server.h"
#include "mapgen.h"
#include "voxelalgorithms.h"

#define MAX_HEAP_ALLOC 128
#define HEAP_FREE_FLAG -1

// garbage collector
int LuaVoxelManip::gc_object(lua_State *L)
{
	LuaVoxelManip *o = *(LuaVoxelManip **)(lua_touserdata(L, 1));
	delete o;

	return 0;
}

int LuaVoxelManip::l_read_from_map(lua_State *L)
{
	MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	v3s16 bp1 = getNodeBlockPos(check_v3s16(L, 2));
	v3s16 bp2 = getNodeBlockPos(check_v3s16(L, 3));
	sortBoxVerticies(bp1, bp2);

	vm->initialEmerge(bp1, bp2);

	push_v3s16(L, vm->m_area.MinEdge);
	push_v3s16(L, vm->m_area.MaxEdge);

	return 2;
}

int LuaVoxelManip::l_get_data(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	bool use_buffer  = lua_istable(L, 2);

	MMVManip *vm = o->vm;

	u32 volume = vm->m_area.getVolume();

	if (use_buffer)
		lua_pushvalue(L, 2);
	else
		lua_newtable(L);

	for (u32 i = 0; i != volume; i++) {
		lua_Integer cid = vm->m_data[i].getContent();
		lua_pushinteger(L, cid);
		lua_rawseti(L, -2, i + 1);
	}

	return 1;
}

void LuaVoxelManip::reserveHeap(MMVManip *vm)
{
	u32 volume;

	if (vm != NULL)
		volume = vm->m_area.getVolume();
	else
	{
		errorstream << "LuaVoxelManip::reserveHeap() getVolume() failed!" << std::endl;
		return;
	}

	data_heap.reserve(MAX_HEAP_ALLOC);

	for (int i=0; i != MAX_HEAP_ALLOC; i++)
	{
		std::vector<lua_Integer> data;

		data_heap.push_back(data);
		data_heap.at(i).reserve(volume);
	}

	param2_data_heap.reserve(MAX_HEAP_ALLOC);

	for (int i=0; i != MAX_HEAP_ALLOC; i++)
	{
		std::vector<lua_Integer> param2_data;

		param2_data_heap.push_back(param2_data);
		param2_data_heap.at(i).reserve(volume);
	}

	if (data_heap.size() != MAX_HEAP_ALLOC || param2_data_heap.size() != MAX_HEAP_ALLOC)
	{
		errorstream << "LuaVoxelManip::reserveHeap() [param2_]data_heap.reserve failed!" << std::endl;
		return;
	}

	is_heap_reserved = true;
}

// MrCerealGuy: call deleteHeap in Game::shutdown()
void LuaVoxelManip::deleteHeap(void)
{
	std::vector<std::vector<lua_Integer> >::iterator row;

	for (row = data_heap.begin(); row != data_heap.end(); row++)
		row->erase(row->begin(), row->end());

	for (row = param2_data_heap.begin(); row != param2_data_heap.end(); row++)
		row->erase(row->begin(), row->end());
}

int LuaVoxelManip::l_load_data_into_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 data_heap_index;

	// if data heap isn't reserved yet
	if (!is_heap_reserved)
		reserveHeap(vm);

	u32 volume = vm->m_area.getVolume();

	// search for not used vector with allocated memory
	for (u32 i = 0; i != (u32)data_heap.size() /*&& !bFound*/; i++)
	{
		if ((u32)data_heap.at(i).size() == volume && data_heap.at(i).at(0) == HEAP_FREE_FLAG && data_heap.at(i).at(data_heap.at(i).size()-1) == HEAP_FREE_FLAG)
		{
			// found not used vector
			data_heap_index = i;

			infostream << "found free heap vector at index: " << i << std::endl;

			// push data into heap
			for (u32 j = 0; j != volume; j++) {
				data_heap.at(data_heap_index).at(j) = (lua_Integer)vm->m_data[j].getContent();
			}

			lua_pushinteger(L, (lua_Integer)data_heap_index);

			return 1;
		}
	}

	// search for reserved empty vector
	for (u32 i = 0; i != (u32)data_heap.size(); i++)
	{
		// found reserved empty vector
		if ((u32)data_heap.at(i).size() == 0 && (u32)data_heap.at(i).capacity() == volume)
		{
			data_heap_index = i;

			// push data into heap
			for (u32 j = 0; j != volume; j++) {
				data_heap.at(i).push_back((lua_Integer)vm->m_data[j].getContent());
			}

			lua_pushinteger(L, (lua_Integer)data_heap_index);

			return 1;
		}
	}

	// heap vector is full, add vector
	std::vector<lua_Integer> data;

	data_heap.push_back(data);
	data_heap_index = data_heap.size()-1;

	data_heap.at(data_heap_index).reserve(volume);

	// push data into heap
	for (u32 i = 0; i != volume; i++) {
		data_heap.at(data_heap_index).push_back((lua_Integer)vm->m_data[i].getContent());
	}

	lua_pushinteger(L, (lua_Integer)data_heap_index);

	return 1;
}

int LuaVoxelManip::l_save_data_from_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 index = luaL_checknumber(L, 2);

	if (index < 0  || (data_heap.size()-1) < index || data_heap.at(index).empty())
	{
		errorstream << "l_save_data_from_heap index: " << index << std::endl;
		return -1;
	}

	for (u32 i = 0; i != data_heap.at(index).size(); i++) {

		content_t c = data_heap.at(index).at(i);

		vm->m_data[i].setContent(c);
	}

	// mark heap vector as free
	data_heap.at(index).at(0) = HEAP_FREE_FLAG;
	data_heap.at(index).at(data_heap.at(index).size()-1) = HEAP_FREE_FLAG;

	return 0;
}

int LuaVoxelManip::l_get_data_from_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	u32 index = luaL_checknumber(L, 2);
	u32 key = luaL_checknumber(L, 3);

	// Lua table index starts with 1 not with 0!
	key = key-1;

	if (key < 0 || index < 0 || (data_heap.capacity()-1) < index || data_heap.at(index).empty() || (data_heap.at(index).size()-1) < key)
	{
		//infostream << "l_get_data_from_heap index, key, volume: "<< index << " " << key << " " << volume << std::endl;
		lua_pushinteger(L, (lua_Integer)-1);
		return 1;
		//throw LuaError("LuaVoxelManip::l_get_data_from_heap failed!");
	}

	lua_pushinteger(L, (lua_Integer)data_heap.at(index).at(key));

	return 1;
}

int LuaVoxelManip::l_set_data_from_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 volume = vm->m_area.getVolume();

	u32 index = luaL_checknumber(L, 2);
	u32 key = luaL_checknumber(L, 3);
	u32 value = luaL_checknumber(L, 4);

	// Lua table index starts with 1 not with 0!
	key = key-1;

	if (key < 0 || index < 0 || (data_heap.capacity()-1) < index || data_heap.at(index).empty() || (data_heap.at(index).size()-1) < key)
	{
		infostream << "l_set_data_from_heap index, key, volume: "<< index << " " << key << " " << volume << std::endl;
		return 0;
		//throw LuaError("LuaVoxelManip::l_set_data_from_heap failed!");
	}

	data_heap.at(index).at(key) = (lua_Integer)value;

	return 0;
}

int LuaVoxelManip::l_load_param2_data_into_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 param2_data_heap_index;

	// if param2_data heap isn't reserved yet
	if (!is_heap_reserved)
		reserveHeap(vm);

	u32 volume = vm->m_area.getVolume();

	// search for not used vector with allocated memory
	for (u32 i = 0; i != (u32)param2_data_heap.size() ; i++)
	{
		if ((u32)param2_data_heap.at(i).size() == volume && param2_data_heap.at(i).at(0) == HEAP_FREE_FLAG && param2_data_heap.at(i).at(param2_data_heap.at(i).size()-1) == HEAP_FREE_FLAG)
		{
			// found not used vector
			param2_data_heap_index = i;

			// push data into heap
			for (u32 j = 0; j != volume; j++) {
				param2_data_heap.at(param2_data_heap_index).at(j) = (lua_Integer)vm->m_data[j].param2;
			}

			lua_pushinteger(L, (lua_Integer)param2_data_heap_index);

			return 1;
		}
	}

	// search for reserved empty vector
	for (u32 i = 0; i != (u32)param2_data_heap.size(); i++)
	{
		// found reserved empty vector
		if ((u32)param2_data_heap.at(i).size() == 0 && (u32)param2_data_heap.at(i).capacity() == volume)
		{
			param2_data_heap_index = i;

			// push data into heap
			for (u32 j = 0; j != volume; j++) {
				param2_data_heap.at(i).push_back((lua_Integer)vm->m_data[j].param2);
			}

			lua_pushinteger(L, (lua_Integer)param2_data_heap_index);

			return 1;
		}
	}

	// heap vector is full, add vector
	std::vector<lua_Integer> param2_data;

	param2_data_heap.push_back(param2_data);
	param2_data_heap_index = param2_data_heap.size()-1;

	param2_data_heap.at(param2_data_heap_index).reserve(volume);

	// push data into heap
	for (u32 i = 0; i != volume; i++) {
		param2_data_heap.at(param2_data_heap_index).push_back((lua_Integer)vm->m_data[i].param2);
	}

	lua_pushinteger(L, (lua_Integer)param2_data_heap_index);

	return 1;
}

int LuaVoxelManip::l_save_param2_data_from_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 index = luaL_checknumber(L, 2);

	if (index < 0  || (param2_data_heap.size()-1) < index || param2_data_heap.at(index).empty())
	{
		errorstream << "l_save_param2_data_from_heap index: " << index << std::endl;
		return -1;
	}

	for (u32 i = 0; i != param2_data_heap.at(index).size(); i++) {
		u8 param2 = param2_data_heap.at(index).at(i);
		vm->m_data[i].param2 = param2;
	}

	// mark heap vector as free
	param2_data_heap.at(index).at(0) = HEAP_FREE_FLAG;
	param2_data_heap.at(index).at(param2_data_heap.at(index).size()-1) = HEAP_FREE_FLAG;

	return 0;
}

int LuaVoxelManip::l_get_param2_data_from_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	//LuaVoxelManip *o = checkobject(L, 1);
	//MMVManip *vm = o->vm;

	//u32 volume = vm->m_area.getVolume();

	u32 index = luaL_checknumber(L, 2);
	u32 key = luaL_checknumber(L, 3);

	// Lua table index starts with 1 not with 0!
	key = key-1;

	if (key < 0 || index < 0 || (param2_data_heap.capacity()-1) < index || param2_data_heap.at(index).empty() || (param2_data_heap.at(index).size()-1) < key)
	{
		//infostream << "l_get_param2_data_from_heap index, key, volume: "<< index << " " << key << " " << volume << std::endl;
		lua_pushinteger(L, (lua_Integer)-1);
		return 1;
		//throw LuaError("LuaVoxelManip::l_get_param2_data_from_heap failed!");
	}

	lua_pushinteger(L, (lua_Integer)param2_data_heap.at(index).at(key));

	return 1;
}

int LuaVoxelManip::l_set_param2_data_from_heap(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 volume = vm->m_area.getVolume();

	u32 index = luaL_checknumber(L, 2);
	u32 key = luaL_checknumber(L, 3);
	u32 value = luaL_checknumber(L, 4);

	// Lua table index starts with 1 not with 0!
	key = key-1;

	if (key < 0 || index < 0 || (param2_data_heap.capacity()-1) < index || param2_data_heap.at(index).empty() || (param2_data_heap.at(index).size()-1) < key)
	{
		infostream << "l_set_param2_data_from_heap index, key, volume: "<< index << " " << key << " " << volume << std::endl;
		return 0;
		//throw LuaError("LuaVoxelManip::l_set_param2_data_from_heap failed!");
	}

	param2_data_heap.at(index).at(key) = (lua_Integer)value;

	return 0;
}

int LuaVoxelManip::l_set_data(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	if (!lua_istable(L, 2))
		return 0;

	u32 volume = vm->m_area.getVolume();
	for (u32 i = 0; i != volume; i++) {
		lua_rawgeti(L, 2, i + 1);
		content_t c = lua_tointeger(L, -1);

		vm->m_data[i].setContent(c);

		lua_pop(L, 1);
	}

	return 0;
}

int LuaVoxelManip::l_write_to_map(lua_State *L)
{
	MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	bool update_light = lua_isboolean(L, 2) ? lua_toboolean(L, 2) : true;
	GET_ENV_PTR;
	ServerMap *map = &(env->getServerMap());
	if (o->is_mapgen_vm || !update_light) {
		o->vm->blitBackAll(&(o->modified_blocks));
	} else {
		voxalgo::blit_back_with_light(map, o->vm,
			&(o->modified_blocks));
	}

	MapEditEvent event;
	event.type = MEET_OTHER;
	for (std::map<v3s16, MapBlock *>::iterator it = o->modified_blocks.begin();
			it != o->modified_blocks.end(); ++it)
		event.modified_blocks.insert(it->first);

	map->dispatchEvent(&event);

	o->modified_blocks.clear();
	return 0;
}

int LuaVoxelManip::l_get_node_at(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	INodeDefManager *ndef = getServer(L)->getNodeDefManager();

	LuaVoxelManip *o = checkobject(L, 1);
	v3s16 pos        = check_v3s16(L, 2);

	pushnode(L, o->vm->getNodeNoExNoEmerge(pos), ndef);
	return 1;
}

int LuaVoxelManip::l_set_node_at(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	INodeDefManager *ndef = getServer(L)->getNodeDefManager();

	LuaVoxelManip *o = checkobject(L, 1);
	v3s16 pos        = check_v3s16(L, 2);
	MapNode n        = readnode(L, 3, ndef);

	o->vm->setNodeNoEmerge(pos, n);

	return 0;
}

int LuaVoxelManip::l_update_liquids(lua_State *L)
{
	GET_ENV_PTR;

	LuaVoxelManip *o = checkobject(L, 1);

	Map *map = &(env->getMap());
	INodeDefManager *ndef = getServer(L)->getNodeDefManager();
	MMVManip *vm = o->vm;

	Mapgen mg;
	mg.vm   = vm;
	mg.ndef = ndef;

	mg.updateLiquid(&map->m_transforming_liquid,
			vm->m_area.MinEdge, vm->m_area.MaxEdge);

	return 0;
}

int LuaVoxelManip::l_calc_lighting(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	if (!o->is_mapgen_vm)
		return 0;

	INodeDefManager *ndef = getServer(L)->getNodeDefManager();
	EmergeManager *emerge = getServer(L)->getEmergeManager();
	MMVManip *vm = o->vm;

	v3s16 yblock = v3s16(0, 1, 0) * MAP_BLOCKSIZE;
	v3s16 fpmin  = vm->m_area.MinEdge;
	v3s16 fpmax  = vm->m_area.MaxEdge;
	v3s16 pmin   = lua_istable(L, 2) ? check_v3s16(L, 2) : fpmin + yblock;
	v3s16 pmax   = lua_istable(L, 3) ? check_v3s16(L, 3) : fpmax - yblock;
	bool propagate_shadow = lua_isboolean(L, 4) ? lua_toboolean(L, 4) : true;

	sortBoxVerticies(pmin, pmax);
	if (!vm->m_area.contains(VoxelArea(pmin, pmax)))
		throw LuaError("Specified voxel area out of VoxelManipulator bounds");

	Mapgen mg;
	mg.vm          = vm;
	mg.ndef        = ndef;
	mg.water_level = emerge->mgparams->water_level;

	mg.calcLighting(pmin, pmax, fpmin, fpmax, propagate_shadow);

	return 0;
}

int LuaVoxelManip::l_set_lighting(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	if (!o->is_mapgen_vm)
		return 0;

	if (!lua_istable(L, 2))
		return 0;

	u8 light;
	light  = (getintfield_default(L, 2, "day",   0) & 0x0F);
	light |= (getintfield_default(L, 2, "night", 0) & 0x0F) << 4;

	MMVManip *vm = o->vm;

	v3s16 yblock = v3s16(0, 1, 0) * MAP_BLOCKSIZE;
	v3s16 pmin = lua_istable(L, 3) ? check_v3s16(L, 3) : vm->m_area.MinEdge + yblock;
	v3s16 pmax = lua_istable(L, 4) ? check_v3s16(L, 4) : vm->m_area.MaxEdge - yblock;

	sortBoxVerticies(pmin, pmax);
	if (!vm->m_area.contains(VoxelArea(pmin, pmax)))
		throw LuaError("Specified voxel area out of VoxelManipulator bounds");

	Mapgen mg;
	mg.vm = vm;

	mg.setLighting(light, pmin, pmax);

	return 0;
}

int LuaVoxelManip::l_get_light_data(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	u32 volume = vm->m_area.getVolume();

	lua_newtable(L);
	for (u32 i = 0; i != volume; i++) {
		lua_Integer light = vm->m_data[i].param1;
		lua_pushinteger(L, light);
		lua_rawseti(L, -2, i + 1);
	}

	return 1;
}

int LuaVoxelManip::l_set_light_data(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	if (!lua_istable(L, 2))
		return 0;

	u32 volume = vm->m_area.getVolume();
	for (u32 i = 0; i != volume; i++) {
		lua_rawgeti(L, 2, i + 1);
		u8 light = lua_tointeger(L, -1);

		vm->m_data[i].param1 = light;

		lua_pop(L, 1);
	}

	return 0;
}

int LuaVoxelManip::l_get_param2_data(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	bool use_buffer  = lua_istable(L, 2);

	MMVManip *vm = o->vm;

	u32 volume = vm->m_area.getVolume();

	if (use_buffer)
		lua_pushvalue(L, 2);
	else
		lua_newtable(L);

	for (u32 i = 0; i != volume; i++) {
		lua_Integer param2 = vm->m_data[i].param2;
		lua_pushinteger(L, param2);
		lua_rawseti(L, -2, i + 1);
	}

	return 1;
}

int LuaVoxelManip::l_set_param2_data(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	if (!lua_istable(L, 2))
		return 0;

	u32 volume = vm->m_area.getVolume();
	for (u32 i = 0; i != volume; i++) {
		lua_rawgeti(L, 2, i + 1);
		u8 param2 = lua_tointeger(L, -1);

		vm->m_data[i].param2 = param2;

		lua_pop(L, 1);
	}

	return 0;
}

int LuaVoxelManip::l_update_map(lua_State *L)
{
	return 0;
}

int LuaVoxelManip::l_was_modified(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);
	MMVManip *vm = o->vm;

	lua_pushboolean(L, vm->m_is_dirty);

	return 1;
}

int LuaVoxelManip::l_get_emerged_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaVoxelManip *o = checkobject(L, 1);

	push_v3s16(L, o->vm->m_area.MinEdge);
	push_v3s16(L, o->vm->m_area.MaxEdge);

	return 2;
}

LuaVoxelManip::LuaVoxelManip(MMVManip *mmvm, bool is_mg_vm)
{
	this->vm           = mmvm;
	this->is_mapgen_vm = is_mg_vm;

	//reserveHeap();
}

LuaVoxelManip::LuaVoxelManip(Map *map)
{
	this->vm = new MMVManip(map);
	this->is_mapgen_vm = false;

	//reserveHeap();
}

LuaVoxelManip::LuaVoxelManip(Map *map, v3s16 p1, v3s16 p2)
{
	this->vm = new MMVManip(map);
	this->is_mapgen_vm = false;

	v3s16 bp1 = getNodeBlockPos(p1);
	v3s16 bp2 = getNodeBlockPos(p2);
	sortBoxVerticies(bp1, bp2);
	vm->initialEmerge(bp1, bp2);

	//reserveHeap();
}

LuaVoxelManip::~LuaVoxelManip()
{
	if (!is_mapgen_vm)
		delete vm;
}

// LuaVoxelManip()
// Creates an LuaVoxelManip and leaves it on top of stack
int LuaVoxelManip::create_object(lua_State *L)
{
	GET_ENV_PTR;

	Map *map = &(env->getMap());
	LuaVoxelManip *o = (lua_istable(L, 1) && lua_istable(L, 2)) ?
		new LuaVoxelManip(map, check_v3s16(L, 1), check_v3s16(L, 2)) :
		new LuaVoxelManip(map);

	*(void **)(lua_newuserdata(L, sizeof(void *))) = o;
	luaL_getmetatable(L, className);
	lua_setmetatable(L, -2);
	return 1;
}

LuaVoxelManip *LuaVoxelManip::checkobject(lua_State *L, int narg)
{
	NO_MAP_LOCK_REQUIRED;

	luaL_checktype(L, narg, LUA_TUSERDATA);

	void *ud = luaL_checkudata(L, narg, className);
	if (!ud)
		luaL_typerror(L, narg, className);

	return *(LuaVoxelManip **)ud;  // unbox pointer
}

void LuaVoxelManip::Register(lua_State *L)
{
	lua_newtable(L);
	int methodtable = lua_gettop(L);
	luaL_newmetatable(L, className);
	int metatable = lua_gettop(L);

	lua_pushliteral(L, "__metatable");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);  // hide metatable from Lua getmetatable()

	lua_pushliteral(L, "__index");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);

	lua_pushliteral(L, "__gc");
	lua_pushcfunction(L, gc_object);
	lua_settable(L, metatable);

	lua_pop(L, 1);  // drop metatable

	luaL_openlib(L, 0, methods, 0);  // fill methodtable
	lua_pop(L, 1);  // drop methodtable

	// Can be created from Lua (VoxelManip())
	lua_register(L, className, create_object);
}

bool LuaVoxelManip::is_heap_reserved = false;

std::vector<std::vector<lua_Integer> > LuaVoxelManip::data_heap;
std::vector<std::vector<lua_Integer> > LuaVoxelManip::param2_data_heap;

const char LuaVoxelManip::className[] = "VoxelManip";
const luaL_Reg LuaVoxelManip::methods[] = {
	luamethod(LuaVoxelManip, read_from_map),
	luamethod(LuaVoxelManip, get_data),
	luamethod(LuaVoxelManip, set_data),
	luamethod(LuaVoxelManip, load_data_into_heap),
	luamethod(LuaVoxelManip, save_data_from_heap),
	luamethod(LuaVoxelManip, get_data_from_heap),
	luamethod(LuaVoxelManip, set_data_from_heap),
	luamethod(LuaVoxelManip, load_param2_data_into_heap),
	luamethod(LuaVoxelManip, save_param2_data_from_heap),
	luamethod(LuaVoxelManip, get_param2_data_from_heap),
	luamethod(LuaVoxelManip, set_param2_data_from_heap),
	luamethod(LuaVoxelManip, get_node_at),
	luamethod(LuaVoxelManip, set_node_at),
	luamethod(LuaVoxelManip, write_to_map),
	luamethod(LuaVoxelManip, update_map),
	luamethod(LuaVoxelManip, update_liquids),
	luamethod(LuaVoxelManip, calc_lighting),
	luamethod(LuaVoxelManip, set_lighting),
	luamethod(LuaVoxelManip, get_light_data),
	luamethod(LuaVoxelManip, set_light_data),
	luamethod(LuaVoxelManip, get_param2_data),
	luamethod(LuaVoxelManip, set_param2_data),
	luamethod(LuaVoxelManip, was_modified),
	luamethod(LuaVoxelManip, get_emerged_area),
	{0,0}
};
