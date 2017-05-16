--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-16 MrCerealGuy: added intllib support

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_seaplants = world_conf:get("enable_seaplants")

if enable_seaplants ~= nil and enable_seaplants == "false" then
	minetest.log("info", "[sea:noairblocks] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- NODES

minetest.register_node("noairblocks:water_flowingx", {
	description = S("Flowing Waterx"),
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image="default_water_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="default_water_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = 0,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "noairblocks:water_flowingx",
	liquid_alternative_source = "noairblocks:water_sourcex",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:snow",
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, freezes=1, melt_around=1},
})

minetest.register_node("noairblocks:water_sourcex", {
	description = S("Water Sourcex"),
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_water_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	alpha = 0,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "noairblocks:water_flowingx",
	liquid_alternative_source = "noairblocks:water_sourcex",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:ice",
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, freezes=1},
})


-- ABM'S


-- 6 x default to noairblocks


minetest.register_abm({
nodenames = {"group:sea"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local xn = {x = pos.x - 1, y = pos.y, z = pos.z}
	local yp= {x = pos.x, y = pos.y + 1, z = pos.z}
	local xnyp= {x = pos.x - 1, y = pos.y + 1, z = pos.z}
	if minetest.get_node(xn).name == "default:water_source" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(xnyp).name ~= "air" then 
				minetest.add_node(xn, {name = "noairblocks:water_sourcex"}) else
	if minetest.get_node(xn).name == "default:water_flowing" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(xnyp).name ~= "air" then 
				minetest.add_node(xn, {name = "noairblocks:water_flowingx"}) else
			return
		end
	end
end,
})

minetest.register_abm({
nodenames = {"group:sea"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local xp = {x = pos.x + 1, y = pos.y, z = pos.z}
	local yp= {x = pos.x, y = pos.y + 1, z = pos.z}
	local xpyp= {x = pos.x + 1, y = pos.y + 1, z = pos.z}
	if minetest.get_node(xp).name == "default:water_source" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(xpyp).name ~= "air" then 
				minetest.add_node(xp, {name = "noairblocks:water_sourcex"}) else
	if minetest.get_node(xp).name == "default:water_flowing" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(xpyp).name ~= "air" then  
				minetest.add_node(xp, {name = "noairblocks:water_flowingx"}) else
			return
		end
	end
end,
})

minetest.register_abm({
nodenames = {"group:sea"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local zn = {x = pos.x, y = pos.y, z = pos.z - 1}
	local yp= {x = pos.x, y = pos.y + 1, z = pos.z}
	local znyp= {x = pos.x, y = pos.y + 1, z = pos.z - 1}
	if minetest.get_node(zn).name == "default:water_source" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(znyp).name ~= "air" then 
				minetest.add_node(zn, {name = "noairblocks:water_sourcex"}) else
	if minetest.get_node(zn).name == "default:water_flowing" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(znyp).name ~= "air" then 
				minetest.add_node(zn, {name = "noairblocks:water_flowingx"}) else
			return
		end
	end
end,
})

minetest.register_abm({
nodenames = {"group:sea"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local zp = {x = pos.x, y = pos.y, z = pos.z + 1}
	local yp= {x = pos.x, y = pos.y + 1, z = pos.z}
	local zpyp= {x = pos.x, y = pos.y + 1, z = pos.z + 1}
	if minetest.get_node(zp).name == "default:water_source" and
			minetest.get_node(yp).name ~= "air" and
 			minetest.get_node(zpyp).name ~= "air" then 
				minetest.add_node(zp, {name = "noairblocks:water_sourcex"}) else
	if minetest.get_node(zp).name == "default:water_flowing" and
			minetest.get_node(yp).name ~= "air" and
			minetest.get_node(zpyp).name ~= "air" then  
				minetest.add_node(zp, {name = "noairblocks:water_flowingx"}) else
			return
		end
	end
end,
})

minetest.register_abm({
nodenames = {"group:sea"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp= {x = pos.x, y = pos.y + 1, z = pos.z}
	if minetest.get_node(yp).name == "default:water_source" then 
			minetest.add_node(yp, {name = "noairblocks:water_sourcex"}) else
	if minetest.get_node(yp).name == "default:water_flowing" then
			minetest.add_node(yp, {name = "noairblocks:water_flowingx"}) else
			return
		end
	end
end,
})

minetest.register_abm({
nodenames = {"group:sea"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yn = {x = pos.x, y = pos.y - 1, z = pos.z}
	local yp= {x = pos.x, y = pos.y + 1, z = pos.z}
	if minetest.get_node(yn).name == "default:water_source" and
			minetest.get_node(yp).name ~= "air" then 
			minetest.add_node(yn, {name = "noairblocks:water_sourcex"}) else
	if minetest.get_node(yn).name == "default:water_flowing" and
			minetest.get_node(yp).name ~= "air" then 
			minetest.add_node(yn, {name = "noairblocks:water_flowingx"}) else
			return
		end
	end
end,
})


-- Undoing x


minetest.register_abm({
nodenames = {"noairblocks:water_sourcex"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
local pos0 = {x=pos.x-1,y=pos.y-1,z=pos.z-1}
local pos1 = {x=pos.x+1,y=pos.y+1,z=pos.z+1}
	if #minetest.find_nodes_in_area(pos0, pos1, "group:sea") < 1 then
	minetest.add_node(pos, {name = "default:water_source"}) else
	return
	end
end,
})

minetest.register_abm({
nodenames = {"noairblocks:water_flowingx"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
local pos0 = {x=pos.x-1,y=pos.y-1,z=pos.z-1}
local pos1 = {x=pos.x+1,y=pos.y+1,z=pos.z+1}
	if #minetest.find_nodes_in_area(pos0, pos1, "group:sea") < 1 then
	minetest.add_node(pos, {name = "default:water_flowing"}) else
	return
	end
end,
})