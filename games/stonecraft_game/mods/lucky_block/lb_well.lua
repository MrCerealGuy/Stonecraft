
local S = lucky_block.S

-- well block (player stands near and it triggers drops)

minetest.register_node("lucky_block:well_block", {
	description = S("Well Block"),
	tiles = {"default_glass.png"},
	light_source = 5,
	groups = {not_in_creative_inventory = 1, unbreakable = 1},
	on_blast = function() end,
	drop = {}
})

-- wishing well schematic layout

local stb = {name = "default:steelblock", param1 = 255}
local sbr = {name = "default:stonebrick", param1 = 255}
local fwd = {name = "default:fence_wood", param1 = 255}
local slb = {name = "stairs:slab_stonebrick", param1 = 255}
local wbl = {name = "lucky_block:well_block", param1 = 255}
local gla = {name = "default:glass", param1 = 255}
local wat = {name = "default:water_source", param1 = 255}
local air = {name = "air"}

local wishing_well = {
	size = {x = 3, y = 5, z = 3},
	data = {
		stb,sbr,stb,
		sbr,sbr,sbr,
		fwd,air,fwd,
		fwd,air,fwd,
		slb,slb,slb,

		sbr,wbl,sbr,
		sbr,wat,sbr,
		air,air,air,
		air,air,air,
		slb,gla,slb,

		stb,sbr,stb,
		sbr,sbr,sbr,
		fwd,air,fwd,
		fwd,air,fwd,
		slb,slb,slb
	}
}

-- add schematic to list

lucky_block:add_schematics({
	{"wishingwell", wishing_well, {x = 1, y = 1, z = 1}}
})

-- Global list containing well blocks that can be dropped

lucky_block.wellblocks = {}

-- helper function

local add_wblock = function(list)

	for s = 1, #list do
		table.insert(lucky_block.wellblocks, list[s])
	end
end

-- add default well blocks

if lucky_block.mod_def then

	add_wblock({
		{"default:ice", 5},
		{"default:bronzeblock", 2},
		{"default:lava_source", 7},
		{"default:coalblock", 4},
		{"default:sand", 7},
		{"default:goldblock", 2},
		{"default:cactus", 5},
		{"default:cobble", 5},
		{"default:brick", 5},
		{"fire:permanent_flame", 7},
		{"default:desert_sand", 7},
		{"default:grass_5", 7},
		{"default:obsidian", 4},
		{"default:diamondblock", 2},
		{"default:dirt", 7},
		{"default:clay", 5},
		{"default:copperblock", 2},
		{"default:mese", 2},
		{"default:silver_sand", 7},
		{"default:snowblock", 7},
		{"default:mossycobble", 5},
		{"default:lava_source", 5},
		{"default:blueberry_bush_leaves_with_berries", 4},
		{"default:coral_skeleton", 4},
		{"default:coral_orange", 4},
		{"default:coral_brown", 4},
		{"default:gravel", 5},
		{"default:permafrost_with_moss", 4},
		{"default:stone_with_diamond", 4},
		{"default:stone_with_gold", 4},
		{"default:stone_with_copper", 4},
		{"default:lava_source", 4},
		{"default:stone_with_mese", 4},
		{"default:stone_with_coal", 4},
		{"default:stone_with_tin", 4},
		{"default:stone_with_iron", 4},
		{"fire:permanent_flame", 7}
	})
end

-- tnt mod

if minetest.get_modpath("tnt") then

	add_wblock({
		{"tnt:tnt_burning", 8},
		{"tnt:tnt_burning", 4},
		{"tnt:tnt_burning", 8}
	})
end

-- ethereal

if minetest.get_modpath("ethereal") then

	add_wblock({
		{"ethereal:crystal_block", 2}
	})
end

-- bones

if minetest.get_modpath("bones") then

	add_wblock({
		{"bones:bones", 4}
	})
end

-- mineclone

if lucky_block.mod_mcl then

	add_wblock({
		{"mcl_core:diamondblock", 4},
		{"mcl_core:goldblock", 4},
		{"mcl_core:lava_source", 4},
		{"mcl_core:water_source", 4},
		{"mcl_core:sand", 7},
		{"mcl_core:gravel", 7},
		{"mcl_core:obsidian", 4},
		{"mcl_core:ironblock", 4},
		{"mcl_core:sandstone", 7},
		{"mcl_core:snow", 7}
	})
end

-- abm function to detect player and trigger drops

minetest.register_abm({
	label = "Lucky Block Wishing Well Block",
	nodenames = {"lucky_block:well_block"},
	interval = 2,
	chance = 1,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)

		for _,object in pairs(minetest.get_objects_inside_radius(pos, 1.2)) do

			if object and object:is_player() then

				minetest.swap_node(pos, {name = lucky_block.def_glass})

				minetest.sound_play("default_tool_breaks", {
						pos = pos, gain = 1.0, max_hear_distance = 5}, true)

				local b_no = math.random(#lucky_block.wellblocks)
				local item = lucky_block.wellblocks[b_no][1]

				for n = 1, lucky_block.wellblocks[b_no][2] do

					local nod = table.copy(minetest.registered_nodes[item])

					if nod then

						local obj = minetest.add_entity({
							x = pos.x + math.random(-7, 7),
							y = pos.y + 7,
							z = pos.z + math.random(-7, 7)
						}, "__builtin:falling_node")

						if obj then

							local ent = obj:get_luaentity()

							if ent then
								nod.param2 = 1 -- set default rotation
								ent:set_node(nod)
							end
						end
					end
				end

				break
			end
		end
	end
})
