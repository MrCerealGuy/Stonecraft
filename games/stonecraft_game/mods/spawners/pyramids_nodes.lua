--[[

2017-05-15 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local img = {"eye", "men", "sun"}
local desc = {S("eye"), S("men"), S("sun")}

for i=1,3 do
	minetest.register_node("spawners:deco_stone"..i, {
		description = S("Sandstone with @1", desc[i]),
		tiles = {"default_sandstone.png^pyramids_"..img[i]..".png"},
		is_ground_content = true,
		groups = {crumbly=2,cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

trap_on_timer = function (pos, elapsed)
	local objs = minetest.get_objects_inside_radius(pos, 2)
	for i, obj in pairs(objs) do
		if obj:is_player() then
			local n = minetest.get_node(pos)
			if n and n.name then
				if minetest.registered_nodes[n.name].crack and minetest.registered_nodes[n.name].crack < 2 then
					minetest.set_node(pos, {name="spawners:trap_2"})
					nodeupdate(pos)
				end
			end
		end
	end
	return true
end

minetest.register_node("spawners:trap", {
	description = S("Cracked sandstone brick"),
	tiles = {"default_sandstone_brick.png^pyramids_crack.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(0.1)
	end,
	crack = 1,
	on_timer = trap_on_timer,
	drop = "",
})

minetest.register_node("spawners:trap_2", {
	description = S("trapstone"),
	tiles = {"default_sandstone_brick.png^pyramids_crack.png^[transformR90"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=3,falling_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	drop = "",
})
