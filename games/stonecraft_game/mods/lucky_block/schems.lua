
-- Generate schematics

local air = {name = "air"}
local san = {name = "default:sand"}
local sst = {name = "default:sandstone"}
local ssb = {name = "default:sandstonebrick"}
local luc = {name = "lucky_block:lucky_block"}
local lav = {name = "default:lava_source"}
local dir = {name = "default:dirt"}
local sow = {name = "farming:soil_wet"}
local wat = {name = "default:water_source"}
local whe = {name = "farming:wheat_8"}
local cot = {name = "farming:cotton_8"}
local obg = {name = "default:obsidian_glass"}
local fir = {name = "fire:basic_flame"}
local obs = {name = "default:obsidian"}

local platform = {
	size = {x = 5, y = 3, z = 5},
	data = {
		sst, sst, sst, sst, sst,
		ssb, ssb, ssb, ssb, ssb,
		ssb, ssb, ssb, ssb, ssb,

		sst, sst, sst, sst, sst,
		ssb, luc, air, luc, ssb,
		ssb, air, air, air, ssb,

		sst, sst, sst, sst, sst,
		ssb, air, air, air, ssb,
		ssb, air, air, air, ssb,

		sst, sst, sst, sst, sst,
		ssb, luc, air, luc, ssb,
		ssb, air, air, air, ssb,

		sst, sst, sst, sst, sst,
		ssb, ssb, ssb, ssb, ssb,
		ssb, ssb, ssb, ssb, ssb,
	},
}

local insta_farm = {
	size = {x = 5, y = 3, z = 3},
	data = {
		dir, dir, dir, dir, dir,
		sow, sow, sow, sow, sow,
		cot, cot, cot, cot, cot,

		sow, dir, dir, dir, sow,
		sow, wat, wat, wat, sow,
		cot, air, air, air, whe,

		dir, dir, dir, dir, san,
		sow, sow, sow, sow, sow,
		whe, whe, whe, whe, whe,
	},
}

local lava_trap = {
	size = {x = 3, y = 6, z = 3},
	data = {
		lav, lav, lav,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,

		lav, lav, lav,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,

		lav, lav, lav,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
	},
}

local sand_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		san, san, san,
		san, san, san,
		san, san, san,

		san, san, san,
		san, san, san,
		san, san, san,

		san, san, san,
		san, san, san,
		san, san, san,
	},
}

local water_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		obg, obg, obg,
		obg, obg, obg,
		obg, obg, obg,

		obg, obg, obg,
		obg, wat, obg,
		obg, obg, obg,

		obg, obg, obg,
		obg, obg, obg,
		obg, obg, obg,
	},
}

local fire_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		fir, fir, fir,
		fir, fir, fir,
		fir, fir, fir,

		fir, fir, fir,
		fir, fir, fir,
		fir, fir, fir,

		fir, fir, fir,
		fir, fir, fir,
		fir, fir, fir,
	},
}

local obsidian_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		obs, obs, obs,
		obs, obs, obs,
		obs, obs, obs,

		obs, air, obs,
		obs, air, obs,
		obs, lav, obs,

		obs, obs, obs,
		obs, obs, obs,
		obs, obs, obs,
	},
}

-- add schematics to list

lucky_block:add_schematics({
	{"watertrap", water_trap, {x = 1, y = 0, z = 1}},
	{"sandtrap", sand_trap, {x = 1, y = 0, z = 1}},
	{"lavatrap", lava_trap, {x = 1, y = 5, z = 1}},
	{"platform", platform, {x = 2, y = 1, z = 2}},
	{"instafarm", insta_farm, {x = 2, y = 2, z = 1}},
	{"firetrap", fire_trap, {x = 1, y = 0, z = 1}},
	{"obsidiantrap", obsidian_trap, {x = 1, y = 0, z = 1}},
})

-- wishing well

minetest.register_node("lucky_block:well_block", {
	description = "Well Block",
	tiles = {"default_glass.png"},
	light_source = 5,
	groups = {not_in_creative_inventory = 1},
})

local path = minetest.get_modpath("lucky_block") .. "/schematics/"

lucky_block:add_schematics({
	{"wishingwell", path .. "lb_wishing_well.mts", {x = 1, y = 1, z = 1}},
})

minetest.register_abm({

	label = "Lucky Block Wishing Well Block",
	nodenames = {"lucky_block:well_block"},
	interval = 2.0,
	chance = 1,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)

		for _,object in pairs(minetest.get_objects_inside_radius(pos, 1.2)) do

			if object and object:is_player() then

				minetest.swap_node(pos, {name = "default:glass"})

				minetest.sound_play("default_tool_breaks", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 10
				})

				local blocks = {
					{"default:ice", 7},
					{"default:bronzeblock", 5},
					{"default:coalblock", 5},
					{"default:sand", 7},
					{"default:goldblock", 5},
					{"default:cactus", 7},
					{"default:cobble", 7},
					{"default:brick", 8},
					{"default:desert_sand", 7},
					{"default:obsidian", 7},
					{"default:diamondblock", 4},
					{"default:dirt", 7},
					{"default:clay", 7},
					{"default:copperblock", 5},
					{"default:mese", 5},
					{"default:silver_sand", 7},
					{"default:snowblock", 7},
					{"default:mossycobble", 7},
				}
				local tot = #blocks

				if minetest.registered_nodes["tnt:tnt_burning"] then
					tot = tot + 1
					blocks[tot] = {"tnt:tnt_burning", 8}
					tot = tot + 1
					blocks[tot] = {"tnt:tnt_burning", 4}
					tot = tot + 1
					blocks[tot] = {"tnt:tnt_burning", 8}
				end

				if minetest.registered_nodes["ethereal:crystal_block"] then
					tot = tot + 1
					blocks[tot] = {"ethereal:crystal_block", 5}
				end

				if minetest.registered_nodes["bones:bones"] then
					tot = tot + 1
					blocks[tot] = {"bones:bones", 5}
				end

				local b_no = math.random(#blocks)

				for n = 1, blocks[b_no][2] do

					local xx = math.random(-7, 7)
					local zz = math.random(-7, 7)
					local p2 = {x = pos.x + xx, y = pos.y + 7, z = pos.z + zz}
					local nod = minetest.registered_nodes[blocks[b_no][1]]
					local obj = minetest.add_entity(p2, "__builtin:falling_node")

					obj:get_luaentity():set_node(nod)
				end

				break
			end
		end
	end,
})
