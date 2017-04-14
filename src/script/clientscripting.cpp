/*
Minetest
Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com>
Copyright (C) 2017 nerzhul, Loic Blot <loic.blot@unix-experience.fr>

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

#include "clientscripting.h"
#include "client.h"
#include "cpp_api/s_internal.h"
#include "lua_api/l_client.h"
#include "lua_api/l_env.h"
#include "lua_api/l_minimap.h"
#include "lua_api/l_storage.h"
#include "lua_api/l_sound.h"
#include "lua_api/l_util.h"
#include "lua_api/l_item.h"
#include "lua_api/l_nodemeta.h"
#include "lua_api/l_localplayer.h"

ClientScripting::ClientScripting(Client *client):
	ScriptApiBase()
{
	setGameDef(client);

	SCRIPTAPI_PRECHECKHEADER

	// Security is mandatory client side
	initializeSecurityClient();

	lua_getglobal(L, "core");
	int top = lua_gettop(L);

	lua_newtable(L);
	lua_setfield(L, -2, "ui");

	InitializeModApi(L, top);
	lua_pop(L, 1);

	LuaMinimap::create(L, client->getMinimap());

	// Push builtin initialization type
	lua_pushstring(L, "client");
	lua_setglobal(L, "INIT");

	infostream << "SCRIPTAPI: Initialized client game modules" << std::endl;
}

void ClientScripting::InitializeModApi(lua_State *L, int top)
{
	ModApiUtil::InitializeClient(L, top);
	ModApiClient::Initialize(L, top);
	ModApiStorage::Initialize(L, top);
	ModApiEnvMod::InitializeClient(L, top);

	LuaItemStack::Register(L);
	StorageRef::Register(L);
	LuaMinimap::Register(L);
	NodeMetaRef::RegisterClient(L);
	LuaLocalPlayer::Register(L);
}

void ClientScripting::on_client_ready(LocalPlayer *localplayer)
{
	lua_State *L = getStack();
	LuaLocalPlayer::create(L, localplayer);
}
