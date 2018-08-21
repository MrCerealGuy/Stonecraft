--[[
More Blocks: slope definitions

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

--[[

2017-05-15 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Node will be called <modname>:slope_<subname>

function register_slope(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_slope(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_slope_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["slope"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":slope_" .. subname_old .. alternate, modname_new .. ":slope_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slope_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["slope"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":slope_" .. subname_old .. alternate, modname_new .. ":slope_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slope(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["slope"])
	for alternate, def in pairs(defs) do
		stairsplus.register_single("slope", alternate, def, modname, subname, recipeitem, fields)
	end

	circular_saw.known_nodes[recipeitem] = {modname, subname}
end
