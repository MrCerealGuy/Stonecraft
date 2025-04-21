-- NOTES (from wikipedia, some of this might get implemented)
-- rhizomes are edible
-- outer portion of young plants can be peeled and the heart can be eaten raw or boiled and eaten like asparagus
-- leaf bases can be eaten raw or cooked
-- sheath can be removed from the developing green flower spike, which can then be boiled and eaten like corn on the cob
-- pollen can be collected and used as a flour supplement or thickener
-- Typha stems and leaves can be used to make paper
-- The seed hairs were used by some Native American groups as tinder for starting fires

-- support for i18n
local S = minetest.get_translator("dryplants")

-----------------------------------------------------------------------------------------------
-- REEDMACE SHAPES
-----------------------------------------------------------------------------------------------

local function grow_reedmace(pos)
	local size = math.random(1,3)
	local spikes = math.random(1,3)
	local pos_01 = {x = pos.x, y = pos.y + 1, z = pos.z}
	local pos_02 = {x = pos.x, y = pos.y + 2, z = pos.z}
	local pos_03 = {x = pos.x, y = pos.y + 3, z = pos.z}

	local nodename = minetest.get_node(pos_01).name
	if nodename == "air"  -- bug fix
	or nodename == "dryplants:reedmace_sapling" then
		if minetest.get_node(pos_02).name ~= "air" then
			minetest.swap_node(pos_01, {name="dryplants:reedmace_top"})
		elseif minetest.get_node(pos_03).name ~= "air" then
			minetest.swap_node(pos_01, {name="dryplants:reedmace_height_2"})
		elseif size == 1 then
			minetest.swap_node(pos_01, {name="dryplants:reedmace_top"})
		elseif size == 2 then
			minetest.swap_node(pos_01, {name="dryplants:reedmace_height_2"})
		elseif size == 3 then
			if spikes == 1 then
				minetest.swap_node(pos_01, {name="dryplants:reedmace_height_3_spikes"})
			else
				minetest.swap_node(pos_01, {name="dryplants:reedmace_height_3"})
			end
		end
	end
end

local function grow_reedmace_water(pos)
	local size = math.random(1,3)
	local spikes = math.random(1,3)
	local pos_01 = {x = pos.x, y = pos.y + 1, z = pos.z}
	local pos_02 = {x = pos.x, y = pos.y + 2, z = pos.z}
	local pos_03 = {x = pos.x, y = pos.y + 3, z = pos.z}
	local pos_04 = {x = pos.x, y = pos.y + 4, z = pos.z}

	minetest.add_entity(pos_01, "dryplants:reedmace_water_entity")

	if minetest.get_node(pos_02).name == "air" then -- bug fix
		if minetest.get_node(pos_03).name ~= "air" then
			minetest.swap_node(pos_02, {name="dryplants:reedmace_top"})
		elseif minetest.get_node(pos_04).name ~= "air" then
			minetest.swap_node(pos_02, {name="dryplants:reedmace_height_2"})
		elseif size == 1 then
			minetest.swap_node(pos_02, {name="dryplants:reedmace_top"})
		elseif size == 2 then
			minetest.swap_node(pos_02, {name="dryplants:reedmace_height_2"})
		elseif size == 3 then
			if spikes == 1 then
				minetest.swap_node(pos_02, {name="dryplants:reedmace_height_3_spikes"})
			else
				minetest.swap_node(pos_02, {name="dryplants:reedmace_height_3"})
			end
		end
	end
end

abstract_dryplants.grow_reedmace = grow_reedmace -- compatibility

-----------------------------------------------------------------------------------------------
-- REEDMACE SPIKES
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_spikes", {
	description = S("Reedmace"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_spikes.png"},
	inventory_image = "dryplants_reedmace_spikes.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 1
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_top", {
	description = S("Reedmace, height: 1"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_top.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 2
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_height_2", {
	description = S("Reedmace, height: 2"),
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	tiles = {"dryplants_reedmace_height_2.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2--,
		--not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 3
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_height_3", {
	description = S("Reedmace, height: 3"),
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	tiles = {"dryplants_reedmace_height_3.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2--,
		--not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 3 & Spikes
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_height_3_spikes", {
	description = S("Reedmace, height: 3 & Spikes"),
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	tiles = {"dryplants_reedmace_height_3_spikes.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2--,
		--not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE STEMS
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace", {
	description = S("Reedmace"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace.png"},
	inventory_image = "dryplants_reedmace.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "dryplants:reedmace_top"
		or node.name == "dryplants:reedmace_spikes" then
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z})
            minetest.add_item(pos,"dryplants:reedmace_sapling")
        end
    end,
})
-----------------------------------------------------------------------------------------------
-- REEDMACE BOTTOM
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_bottom", {
	description = S("Reedmace"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_bottom.png"},
	inventory_image = "dryplants_reedmace_bottom.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	is_ground_content = false,
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "dryplants:reedmace"
		or node.name == "dryplants:reedmace_top"
		or node.name == "dryplants:reedmace_spikes" then
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z})
            minetest.add_item(pos,"dryplants:reedmace_sapling")
        end
    end,
})
-----------------------------------------------------------------------------------------------
-- REEDMACE "SAPLING" (the drop from the above)
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_sapling", {
	description = S("Reedmace"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_sapling.png"},
	inventory_image = "dryplants_reedmace_sapling.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		sapling=1,
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-- abm
minetest.register_abm({
	nodenames = "dryplants:reedmace_sapling",
	interval = 600,
	chance = 100/5,
	action = function(pos, node, _, _)
		if string.find(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z	 }).name, "default:water")
		or string.find(minetest.get_node({x = pos.x,	 y = pos.y, z = pos.z + 1}).name, "default:water")
		or string.find(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z	 }).name, "default:water")
		or string.find(minetest.get_node({x = pos.x,	 y = pos.y, z = pos.z - 1}).name, "default:water") then
			if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
				grow_reedmace_water({x = pos.x, y = pos.y - 1, z = pos.z})
			end
			minetest.swap_node({x=pos.x, y=pos.y, z=pos.z}, {name="default:water_source"})
		else
			grow_reedmace({x = pos.x, y = pos.y - 1, z = pos.z})
		end
    end
})
-----------------------------------------------------------------------------------------------
-- REEDMACE WATER (for entity)
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_water", {
	description = S("Reedmace"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_water.png"},
	inventory_image = "dryplants_reedmace_water.png",
	groups = {not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE WATER ENTITY
-----------------------------------------------------------------------------------------------
minetest.register_entity("dryplants:reedmace_water_entity",{
	visual = "mesh",
	mesh = "plantlike.obj",
	visual_size = {x=10, y=10},
	textures = {"dryplants_reedmace_water.png"},
	collisionbox = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	on_punch = function(self, puncher)
		if puncher:is_player() and puncher:get_inventory() then
			if not minetest.is_creative_enabled(puncher:get_player_name()) then
				puncher:get_inventory():add_item("main", "dryplants:reedmace_sapling")
			end
			self.object:remove()
		end
	end,
})
-----------------------------------------------------------------------------------------------
-- GENERATE REEDMACE
-----------------------------------------------------------------------------------------------
-- near water or swamp
minetest.register_decoration({
	name = "dryplants:reedmace_swamp",
	decoration = {"air"},
	fill_ratio = "0.05",
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass",
		"default:desert_sand",
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

-- in water
minetest.register_decoration({
	name = "dryplants:reedmace_water",
	decoration = {"air"},
	fill_ratio = "0.01",
	y_min = 0,
	y_max = 0,
	place_on = {
		"default:dirt",
		"default:dirt_with_grass",
		"stoneage:sand_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
	deco_type = "simple",
	flags = "all_floors",
	spawn_by = {
		"default:water_source",
		"sumpf:dirtywater_source"
	},
	check_offset = -1,
	num_spawn_by = 1
})

-- for oases & tropical beaches & tropical swamps
minetest.register_decoration({
	name = "dryplants:reedmace_beach",
	decoration = {"air"},
	fill_ratio = "0.05",
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:sand",
		"sumpf:sumpf"
	},
	deco_type = "simple",
	flags = "all_floors",
	spawn_by = {
		"default:water_source",
		"sumpf:dirtywater_source",
		"sumpf:sumpf",
		"default:desert_sand"
	},
	check_offset = -1,
	num_spawn_by = 1
})

local did, did2, did3
minetest.register_on_mods_loaded(function()
	did = minetest.get_decoration_id("dryplants:reedmace_swamp")
	did2 = minetest.get_decoration_id("dryplants:reedmace_water")
	did3 = minetest.get_decoration_id("dryplants:reedmace_beach")
	minetest.set_gen_notify("decoration", {did, did2, did3})
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	local g = minetest.get_mapgen_object("gennotify")
	local locations = {}

	local deco_locations_1 = g["decoration#" .. did] or {}
	local deco_locations_3 = g["decoration#" .. did3] or {}

	for _, pos in pairs(deco_locations_1) do
		locations[#locations+1] = pos
	end
	for _, pos in pairs(deco_locations_3) do
		locations[#locations+1] = pos
	end

	if #locations == 0 then return end
	for _, pos in ipairs(locations) do
		grow_reedmace(pos)
	end
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	local g = minetest.get_mapgen_object("gennotify")
	local locations = {}

	local deco_locations_2 = g["decoration#" .. did2] or {}

	for _, pos in pairs(deco_locations_2) do
		locations[#locations+1] = pos
	end

	if #locations == 0 then return end
	for _, pos in ipairs(locations) do
		grow_reedmace_water(pos)
	end
end)
