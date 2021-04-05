--[[
	Teleporter mod for minetest

	Teleporter teleports players or objects to the programmed receiver.

]]

teleporter = {}
teleporter.version = 2.6
teleporter.active_light = 3;
teleporter.groups = {oddly_breakable_by_hand=2};
teleporter.groups2 = {oddly_breakable_by_hand=2,not_in_creative_inventory=1,}
local strategies = {
	fs={name="teleporters", form="json", place="world"},
}
teleporter.storage = playerDB(strategies)

teleporter.formbg = (default.gui_bg or "")..
	(default.gui_bg_img or "")..
	(default.gui_slots or "")

dofile(minetest.get_modpath("teleporter").."/functions.lua")
dofile(minetest.get_modpath("teleporter").."/nodes.lua")




	

minetest.register_abm({
	nodenames = {"teleporter:teleporter_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		teleporter.teleport(pos, 1); -- Teleport everything within a radius of 1
	end
})

