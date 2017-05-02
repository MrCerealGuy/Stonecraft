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

#ifndef L_OBJECT_H_
#define L_OBJECT_H_

#include "lua_api/l_base.h"
#include "irrlichttypes.h"

class ServerActiveObject;
class LuaEntitySAO;
class PlayerSAO;
class RemotePlayer;

/*
	ObjectRef
*/

class ObjectRef : public ModApiBase {
private:
	ServerActiveObject *m_object;

	static const char className[];
	static const luaL_Reg methods[];
public:
	static ObjectRef *checkobject(lua_State *L, int narg);

	static ServerActiveObject* getobject(ObjectRef *ref);
private:
	static LuaEntitySAO* getluaobject(ObjectRef *ref);

	static PlayerSAO* getplayersao(ObjectRef *ref);

	static RemotePlayer *getplayer(ObjectRef *ref);

	// Exported functions

	// garbage collector
	static int gc_object(lua_State *L);

	// remove(self)
	static int l_remove(lua_State *L);

	// get_pos(self)
	// returns: {x=num, y=num, z=num}
	static int l_get_pos(lua_State *L);

	// set_pos(self, pos)
	static int l_set_pos(lua_State *L);

	// move_to(self, pos, continuous=false)
	static int l_move_to(lua_State *L);

	// punch(self, puncher, time_from_last_punch, tool_capabilities, dir)
	static int l_punch(lua_State *L);

	// right_click(self, clicker); clicker = an another ObjectRef
	static int l_right_click(lua_State *L);

	// set_hp(self, hp)
	// hp = number of hitpoints (2 * number of hearts)
	// returns: nil
	static int l_set_hp(lua_State *L);

	// get_hp(self)
	// returns: number of hitpoints (2 * number of hearts)
	// 0 if not applicable to this type of object
	static int l_get_hp(lua_State *L);

	// get_inventory(self)
	static int l_get_inventory(lua_State *L);

	// get_wield_list(self)
	static int l_get_wield_list(lua_State *L);

	// get_wield_index(self)
	static int l_get_wield_index(lua_State *L);

	// get_wielded_item(self)
	static int l_get_wielded_item(lua_State *L);

	// set_wielded_item(self, itemstack or itemstring or table or nil)
	static int l_set_wielded_item(lua_State *L);

	// set_armor_groups(self, groups)
	static int l_set_armor_groups(lua_State *L);

	// get_armor_groups(self)
	static int l_get_armor_groups(lua_State *L);

	// set_physics_override(self, physics_override_speed, physics_override_jump,
	//                      physics_override_gravity, sneak, sneak_glitch, new_move)
	static int l_set_physics_override(lua_State *L);

	// get_physics_override(self)
	static int l_get_physics_override(lua_State *L);

	// set_animation(self, frame_range, frame_speed, frame_blend, frame_loop)
	static int l_set_animation(lua_State *L);

	// get_animation(self)
	static int l_get_animation(lua_State *L);

	// set_bone_position(self, std::string bone, v3f position, v3f rotation)
	static int l_set_bone_position(lua_State *L);

	// get_bone_position(self, bone)
	static int l_get_bone_position(lua_State *L);

	// set_attach(self, parent, bone, position, rotation)
	static int l_set_attach(lua_State *L);

	// get_attach(self)
	static int l_get_attach(lua_State *L);

	// set_detach(self)
	static int l_set_detach(lua_State *L);

	// set_properties(self, properties)
	static int l_set_properties(lua_State *L);

	// get_properties(self)
	static int l_get_properties(lua_State *L);

	// is_player(self)
	static int l_is_player(lua_State *L);

	/* LuaEntitySAO-only */

	// set_velocity(self, {x=num, y=num, z=num})
	static int l_set_velocity(lua_State *L);

	// get_velocity(self)
	static int l_get_velocity(lua_State *L);

	// set_acceleration(self, {x=num, y=num, z=num})
	static int l_set_acceleration(lua_State *L);

	// get_acceleration(self)
	static int l_get_acceleration(lua_State *L);

	// set_yaw(self, radians)
	static int l_set_yaw(lua_State *L);

	// get_yaw(self)
	static int l_get_yaw(lua_State *L);

	// set_texture_mod(self, mod)
	static int l_set_texture_mod(lua_State *L);

	// l_get_texture_mod(self)
	static int l_get_texture_mod(lua_State *L);

	// set_sprite(self, p={x=0,y=0}, num_frames=1, framelength=0.2,
	//           select_horiz_by_yawpitch=false)
	static int l_set_sprite(lua_State *L);

	// DEPRECATED
	// get_entity_name(self)
	static int l_get_entity_name(lua_State *L);

	// get_luaentity(self)
	static int l_get_luaentity(lua_State *L);

	/* Player-only */

	// is_player_connected(self)
	static int l_is_player_connected(lua_State *L);

	// get_player_name(self)
	static int l_get_player_name(lua_State *L);

	// get_player_velocity(self)
	static int l_get_player_velocity(lua_State *L);

	// get_look_dir(self)
	static int l_get_look_dir(lua_State *L);

	// DEPRECATED
	// get_look_pitch(self)
	static int l_get_look_pitch(lua_State *L);

	// DEPRECATED
	// get_look_yaw(self)
	static int l_get_look_yaw(lua_State *L);

	// get_look_pitch2(self)
	static int l_get_look_vertical(lua_State *L);

	// get_look_yaw2(self)
	static int l_get_look_horizontal(lua_State *L);

	// set_look_vertical(self, radians)
	static int l_set_look_vertical(lua_State *L);

	// set_look_horizontal(self, radians)
	static int l_set_look_horizontal(lua_State *L);

	// DEPRECATED
	// set_look_pitch(self, radians)
	static int l_set_look_pitch(lua_State *L);

	// DEPRECATED
	// set_look_yaw(self, radians)
	static int l_set_look_yaw(lua_State *L);

	// set_breath(self, breath)
	static int l_set_breath(lua_State *L);

	// get_breath(self, breath)
	static int l_get_breath(lua_State *L);

	// set_attribute(self, attribute, value)
	static int l_set_attribute(lua_State *L);

	// get_attribute(self, attribute)
	static int l_get_attribute(lua_State *L);

	// set_inventory_formspec(self, formspec)
	static int l_set_inventory_formspec(lua_State *L);

	// get_inventory_formspec(self) -> formspec
	static int l_get_inventory_formspec(lua_State *L);

	// get_player_control(self)
	static int l_get_player_control(lua_State *L);

	// get_player_control_bits(self)
	static int l_get_player_control_bits(lua_State *L);

	// hud_add(self, id, form)
	static int l_hud_add(lua_State *L);

	// hud_rm(self, id)
	static int l_hud_remove(lua_State *L);

	// hud_change(self, id, stat, data)
	static int l_hud_change(lua_State *L);

	// hud_get_next_id(self)
	static u32 hud_get_next_id(lua_State *L);

	// hud_get(self, id)
	static int l_hud_get(lua_State *L);

	// hud_set_flags(self, flags)
	static int l_hud_set_flags(lua_State *L);

	// hud_get_flags()
	static int l_hud_get_flags(lua_State *L);

	// hud_set_hotbar_itemcount(self, hotbar_itemcount)
	static int l_hud_set_hotbar_itemcount(lua_State *L);

	// hud_get_hotbar_itemcount(self)
	static int l_hud_get_hotbar_itemcount(lua_State *L);

	// hud_set_hotbar_image(self, name)
	static int l_hud_set_hotbar_image(lua_State *L);

	// hud_get_hotbar_image(self)
	static int l_hud_get_hotbar_image(lua_State *L);

	// hud_set_hotbar_selected_image(self, name)
	static int l_hud_set_hotbar_selected_image(lua_State *L);

	// hud_get_hotbar_selected_image(self)
	static int l_hud_get_hotbar_selected_image(lua_State *L);

	// set_sky(self, type, list)
	static int l_set_sky(lua_State *L);

	// get_sky(self, type, list)
	static int l_get_sky(lua_State *L);

	// set_clouds(self, {density=, color=, ambient=, height=, thickness=, speed=})
	static int l_set_clouds(lua_State *L);

	// get_clouds(self)
	static int l_get_clouds(lua_State *L);

	// override_day_night_ratio(self, type)
	static int l_override_day_night_ratio(lua_State *L);

	// get_day_night_ratio(self)
	static int l_get_day_night_ratio(lua_State *L);

	// set_local_animation(self, {stand/idle}, {walk}, {dig}, {walk+dig}, frame_speed)
	static int l_set_local_animation(lua_State *L);

	// get_local_animation(self)
	static int l_get_local_animation(lua_State *L);

	// set_eye_offset(self, v3f first pv, v3f third pv)
	static int l_set_eye_offset(lua_State *L);

	// get_eye_offset(self)
	static int l_get_eye_offset(lua_State *L);

	// set_nametag_attributes(self, attributes)
	static int l_set_nametag_attributes(lua_State *L);

	// get_nametag_attributes(self)
	static int l_get_nametag_attributes(lua_State *L);

public:
	ObjectRef(ServerActiveObject *object);

	~ObjectRef();

	// Creates an ObjectRef and leaves it on top of stack
	// Not callable from Lua; all references are created on the C side.
	static void create(lua_State *L, ServerActiveObject *object);

	static void set_null(lua_State *L);

	static void Register(lua_State *L);
};

#endif /* L_OBJECT_H_ */
