-- support for i18n
local S = minetest.get_translator("dryplants")

local function grow_juncus(pos)
	local juncus_type = math.random(2,3)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}

	local nodename = minetest.get_node(right_here).name
	if nodename == "air" or nodename == "default:junglegrass" then
		if juncus_type == 2 then
			minetest.swap_node(right_here, {name="dryplants:juncus_02"})
		else
			minetest.swap_node(right_here, {name="dryplants:juncus"})
		end
	end
end

minetest.register_node("dryplants:juncus", {
	description = S("Juncus"),
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	tiles = {"dryplants_juncus_03.png"},
	inventory_image = "dryplants_juncus_inv.png",
	walkable = false,
	buildable_to = true,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		flora=1
		--not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if not itemstack or not placer or not pointed_thing then
			return
		end

		local playername = placer:get_player_name()
		if minetest.is_protected(pointed_thing.above, playername) or
			minetest.is_protected(pointed_thing.under, playername) then
			minetest.chat_send_player(playername, "Someone else owns that spot.")
			return
		end
		local pos = pointed_thing.under
		local juncus_type = math.random(2,3)
		local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
		if juncus_type == 2 then
			minetest.swap_node(right_here, {name="dryplants:juncus_02"})
		else
			minetest.swap_node(right_here, {name="dryplants:juncus"})
		end
		if not minetest.is_creative_enabled(playername) then
			itemstack:take_item()
		end
		return itemstack
	end,
})

minetest.register_node("dryplants:juncus_02", {
	description = S("Juncus"),
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	tiles = {"dryplants_juncus_02.png"},
	walkable = false,
	buildable_to = true,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		flora=1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	drop = "dryplants:juncus",
})
-----------------------------------------------------------------------------------------------
-- GENERATE SMALL JUNCUS
-----------------------------------------------------------------------------------------------
-- near water or swamp
minetest.register_decoration({
	name = "dryplants:juncus_water",
	decoration = {"air"},
	fill_ratio = 0.16,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
	deco_type = "simple",
	flags = "all_floors",
	spawn_by = {
		"default:water_source",
		"sumpf:dirtywater_source",
		"sumpf:sumpf"
	},
	check_offset = -1,
	num_spawn_by = 1
})

-- at dunes/beach
minetest.register_decoration({
	name = "dryplants:juncus_beach",
	decoration = {"air"},
	fill_ratio = 0.08,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:sand",
	},
	deco_type = "simple",
	flags = "all_floors",
	spawn_by = {"default:dirt_with_grass"},
	check_offset = -1,
	num_spawn_by = 1
})

local did, did2
minetest.register_on_mods_loaded(function()
	did = minetest.get_decoration_id("dryplants:juncus_water")
	did2 = minetest.get_decoration_id("dryplants:juncus_beach")
	minetest.set_gen_notify("decoration", {did, did2})
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	local g = minetest.get_mapgen_object("gennotify")
	local locations = {}

	local deco_locations_1 = g["decoration#" .. did] or {}
	local deco_locations_2 = g["decoration#" .. did2] or {}

	for _, pos in pairs(deco_locations_1) do
		locations[#locations+1] = pos
	end
	for _, pos in pairs(deco_locations_2) do
		locations[#locations+1] = pos
	end

	if #locations == 0 then return end
	for _, pos in ipairs(locations) do
		grow_juncus(pos)
	end
end)