/*
Minetest
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
*/

#include "l_camera.h"
#include <cmath>
#include "script/common/c_converter.h"
#include "l_internal.h"
#include "client/content_cao.h"
#include "client/camera.h"
#include "client/client.h"

LuaCamera::LuaCamera(Camera *m) : m_camera(m)
{
}

void LuaCamera::create(lua_State *L, Camera *m)
{
	lua_getglobal(L, "core");
	luaL_checktype(L, -1, LUA_TTABLE);
	int objectstable = lua_gettop(L);
	lua_getfield(L, -1, "camera");

	// Duplication check
	if (lua_type(L, -1) == LUA_TUSERDATA) {
		lua_pop(L, 1);
		return;
	}

	LuaCamera *o = new LuaCamera(m);
	*(void **)(lua_newuserdata(L, sizeof(void *))) = o;
	luaL_getmetatable(L, className);
	lua_setmetatable(L, -2);

	lua_pushvalue(L, lua_gettop(L));
	lua_setfield(L, objectstable, "camera");
}

// set_camera_mode(self, mode)
int LuaCamera::l_set_camera_mode(lua_State *L)
{
	Camera *camera = getobject(L, 1);
	GenericCAO *playercao = getClient(L)->getEnv().getLocalPlayer()->getCAO();
	if (!camera)
		return 0;
	sanity_check(playercao);
	if (!lua_isnumber(L, 2))
		return 0;

	camera->setCameraMode((CameraMode)((int)lua_tonumber(L, 2)));
	// Make the player visible depending on camera mode.
	playercao->updateMeshCulling();
	playercao->setChildrenVisible(camera->getCameraMode() > CAMERA_MODE_FIRST);
	return 0;
}

// get_camera_mode(self)
int LuaCamera::l_get_camera_mode(lua_State *L)
{
	Camera *camera = getobject(L, 1);
	if (!camera)
		return 0;

	lua_pushinteger(L, (int)camera->getCameraMode());

	return 1;
}

// get_fov(self)
int LuaCamera::l_get_fov(lua_State *L)
{
	Camera *camera = getobject(L, 1);
	if (!camera)
		return 0;

	lua_newtable(L);
	lua_pushnumber(L, camera->getFovX() * core::RADTODEG);
	lua_setfield(L, -2, "x");
	lua_pushnumber(L, camera->getFovY() * core::RADTODEG);
	lua_setfield(L, -2, "y");
	lua_pushnumber(L, camera->getCameraNode()->getFOV() * core::RADTODEG);
	lua_setfield(L, -2, "actual");
	lua_pushnumber(L, camera->getFovMax() * core::RADTODEG);
	lua_setfield(L, -2, "max");
	return 1;
}

// get_pos(self)
int LuaCamera::l_get_pos(lua_State *L)
{
	Camera *camera = getobject(L, 1);
	if (!camera)
		return 0;

	push_v3f(L, camera->getPosition() / BS);
	return 1;
}

// get_offset(self)
int LuaCamera::l_get_offset(lua_State *L)
{
	LocalPlayer *player = getClient(L)->getEnv().getLocalPlayer();
	sanity_check(player);

	push_v3f(L, player->getEyeOffset() / BS);
	return 1;
}

// get_look_dir(self)
int LuaCamera::l_get_look_dir(lua_State *L)
{
	Camera *camera = getobject(L, 1);
	if (!camera)
		return 0;

	push_v3f(L, camera->getDirection());
	return 1;
}

// get_look_horizontal(self)
// FIXME: wouldn't localplayer be a better place for this?
int LuaCamera::l_get_look_horizontal(lua_State *L)
{
	LocalPlayer *player = getClient(L)->getEnv().getLocalPlayer();
	sanity_check(player);

	lua_pushnumber(L, (player->getYaw() + 90.f) * core::DEGTORAD);
	return 1;
}

// get_look_vertical(self)
// FIXME: wouldn't localplayer be a better place for this?
int LuaCamera::l_get_look_vertical(lua_State *L)
{
	LocalPlayer *player = getClient(L)->getEnv().getLocalPlayer();
	sanity_check(player);

	lua_pushnumber(L, -1.0f * player->getPitch() * core::DEGTORAD);
	return 1;
}

// get_aspect_ratio(self)
int LuaCamera::l_get_aspect_ratio(lua_State *L)
{
	Camera *camera = getobject(L, 1);
	if (!camera)
		return 0;

	lua_pushnumber(L, camera->getCameraNode()->getAspectRatio());
	return 1;
}

LuaCamera *LuaCamera::checkobject(lua_State *L, int narg)
{
	luaL_checktype(L, narg, LUA_TUSERDATA);

	void *ud = luaL_checkudata(L, narg, className);
	if (!ud)
		luaL_typerror(L, narg, className);

	return *(LuaCamera **)ud;
}

Camera *LuaCamera::getobject(LuaCamera *ref)
{
	return ref->m_camera;
}

Camera *LuaCamera::getobject(lua_State *L, int narg)
{
	LuaCamera *ref = checkobject(L, narg);
	assert(ref);
	Camera *camera = getobject(ref);
	if (!camera)
		return NULL;
	return camera;
}

int LuaCamera::gc_object(lua_State *L)
{
	LuaCamera *o = *(LuaCamera **)(lua_touserdata(L, 1));
	delete o;
	return 0;
}

void LuaCamera::Register(lua_State *L)
{
	lua_newtable(L);
	int methodtable = lua_gettop(L);
	luaL_newmetatable(L, className);
	int metatable = lua_gettop(L);

	lua_pushliteral(L, "__metatable");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);

	lua_pushliteral(L, "__index");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);

	lua_pushliteral(L, "__gc");
	lua_pushcfunction(L, gc_object);
	lua_settable(L, metatable);

	lua_pop(L, 1);

	luaL_openlib(L, 0, methods, 0);
	lua_pop(L, 1);
}

// clang-format off
const char LuaCamera::className[] = "Camera";
const luaL_Reg LuaCamera::methods[] = {
	luamethod(LuaCamera, set_camera_mode),
	luamethod(LuaCamera, get_camera_mode),
	luamethod(LuaCamera, get_fov),
	luamethod(LuaCamera, get_pos),
	luamethod(LuaCamera, get_offset),
	luamethod(LuaCamera, get_look_dir),
	luamethod(LuaCamera, get_look_vertical),
	luamethod(LuaCamera, get_look_horizontal),
	luamethod(LuaCamera, get_aspect_ratio),

	{0, 0}
};
// clang-format on
