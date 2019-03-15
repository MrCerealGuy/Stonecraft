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

#pragma once

#include "cpp_api/s_base.h"
#include "irr_v3d.h"
#include "util/string.h"

struct MoveAction;
struct InventoryLocation;
struct ItemStack;
struct ToolCapabilities;
struct PlayerHPChangeReason;

class ScriptApiPlayer : virtual public ScriptApiBase
{
public:
	virtual ~ScriptApiPlayer() = default;

	void on_newplayer(ServerActiveObject *player);
	void on_dieplayer(ServerActiveObject *player, const PlayerHPChangeReason &reason);
	bool on_respawnplayer(ServerActiveObject *player);
	bool on_prejoinplayer(const std::string &name, const std::string &ip,
			std::string *reason);
	bool can_bypass_userlimit(const std::string &name, const std::string &ip);
	void on_joinplayer(ServerActiveObject *player);
	void on_leaveplayer(ServerActiveObject *player, bool timeout);
	void on_cheat(ServerActiveObject *player, const std::string &cheat_type);
	bool on_punchplayer(ServerActiveObject *player, ServerActiveObject *hitter,
			float time_from_last_punch, const ToolCapabilities *toolcap,
			v3f dir, s16 damage);
	s32 on_player_hpchange(ServerActiveObject *player, s32 hp_change,
			const PlayerHPChangeReason &reason);
	void on_playerReceiveFields(ServerActiveObject *player,
			const std::string &formname, const StringMap &fields);
	void on_auth_failure(const std::string &name, const std::string &ip);

	// Player inventory callbacks
	// Return number of accepted items to be moved
	int player_inventory_AllowMove(
		const MoveAction &ma, int count,
		ServerActiveObject *player);
	// Return number of accepted items to be put
	int player_inventory_AllowPut(
		const MoveAction &ma, const ItemStack &stack,
		ServerActiveObject *player);
	// Return number of accepted items to be taken
	int player_inventory_AllowTake(
		const MoveAction &ma, const ItemStack &stack,
		ServerActiveObject *player);
	// Report moved items
	void player_inventory_OnMove(
		const MoveAction &ma, int count,
		ServerActiveObject *player);
	// Report put items
	void player_inventory_OnPut(
		const MoveAction &ma, const ItemStack &stack,
		ServerActiveObject *player);
	// Report taken items
	void player_inventory_OnTake(
		const MoveAction &ma, const ItemStack &stack,
		ServerActiveObject *player);
private:
	void pushPutTakeArguments(
		const char *method, const InventoryLocation &loc,
		const std::string &listname, int index, const ItemStack &stack,
		ServerActiveObject *player);
	void pushMoveArguments(const MoveAction &ma,
		int count, ServerActiveObject *player);
};
