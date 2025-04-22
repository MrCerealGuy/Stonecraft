
-- path to default and ethereal schematics

local path = minetest.get_modpath("ethereal") .. "/schematics/"
local dpath = minetest.get_modpath("default") .. "/schematics/"

-- load schematic tables

dofile(path .. "orange_tree.lua")
dofile(path .. "banana_tree.lua")
dofile(path .. "bamboo_tree.lua")
dofile(path .. "birch_tree.lua")
dofile(path .. "bush.lua")
dofile(path .. "waterlily.lua")
dofile(path .. "volcanom.lua")
dofile(path .. "volcanol.lua")
dofile(path .. "frosttrees.lua")
dofile(path .. "palmtree.lua")
dofile(path .. "pinetree.lua")
dofile(path .. "yellowtree.lua")
dofile(path .. "mushroomone.lua")
dofile(path .. "mushroomtwo.lua")
dofile(path .. "willow.lua")
dofile(path .. "bigtree.lua")
dofile(path .. "redwood_tree.lua")
dofile(path .. "redwood_small_tree.lua")
dofile(path .. "vinetree.lua")
dofile(path .. "sakura.lua")
dofile(path .. "igloo.lua")
dofile(path .. "lemon_tree.lua")
dofile(path .. "olive_tree.lua")
dofile(path .. "basandra_bush.lua")
dofile(path .. "desertstone_spike.lua")
dofile(path .. "desertstone_under_spike.lua")
dofile(path .. "pond.lua")

-- register decoration helper

local function register_decoration(enabled, def)

	if enabled ~= 1 then return end

	def.sidelen = def.sidelen or 80 -- some handy defaults
	def.deco_type = "schematic"
	def.y_min = def.y_min or 1
	def.y_max = def.y_max or 100
	def.flags = def.flags or "place_center_x, place_center_z"

	minetest.register_decoration(def)
end

-- old biome setting (when enabled old heat/humidity values are used)

local old = minetest.settings:get_bool("ethereal.old_biomes")

-- desertstone spike

register_decoration(minetest.get_modpath("stairs") and ethereal.caves, {
	place_on = "default:desert_stone",
	sidelen = 16, fill_ratio = 0.01, y_min = 5, y_max = 42,
	biomes = {"caves"},
	schematic = ethereal.desertstone_spike,
	spawn_by = "default:desert_stone", num_spawn_by = 8,
	flags = "place_center_x, place_center_z, force_placement", rotation = "random"})

-- desertstone under spike

register_decoration(ethereal.caves, {
	place_on = "default:stone",
	sidelen = 16, fill_ratio = 0.01, y_min = 5, y_max = 42,
	biomes = {"caves"},
	schematic = ethereal.desertstone_under_spike,
	flags = "place_center_x, place_center_z, all_floors", rotation = "random"})

-- igloo

register_decoration(ethereal.glacier, {
	place_on = "default:snowblock",
	fill_ratio = 0.0005, y_min = 3, y_max = 30,
	biomes = {"glacier"},
	schematic = ethereal.igloo, place_offset_y = -1,
	spawn_by = "default:snowblock", num_spawn_by = 8,
	flags = "place_center_x, place_center_z, force_placement", rotation = "random"})

-- sakura tree

register_decoration(ethereal.bamboo, {
	place_on = "ethereal:bamboo_dirt",
	fill_ratio = 0.002, y_min = 7, y_max = 35,
	biomes = {"bamboo"},
	schematic = ethereal.sakura_tree,
	spawn_by = "ethereal:bamboo_dirt", num_spawn_by = 6})

-- redwood tree

register_decoration(ethereal.mesa, {
	place_on = "default:dirt_with_dry_grass",
	fill_ratio = 0.0025,
	biomes = {"mesa_redwood"},
	schematic = ethereal.redwood_tree,
	flags = "place_center_x, place_center_z",
	spawn_by = "default:dirt_with_dry_grass", num_spawn_by = 8})

register_decoration(ethereal.mesa, {
	place_on = "default:dirt_with_dry_grass",
	fill_ratio = 0.0015,
	biomes = {"mesa_redwood"},
	schematic = ethereal.redwood_small_tree,
	flags = "place_center_x, place_center_z",
	spawn_by = "default:dirt_with_dry_grass", num_spawn_by = 8})

-- banana tree

register_decoration(ethereal.grove, {
	place_on = "ethereal:grove_dirt",
	fill_ratio = 0.015,
	biomes = {"grove"},
	schematic = ethereal.bananatree})

-- healing tree

register_decoration(1, {
	place_on = {"default:snow", "default:snowblock"},
	fill_ratio = 0.01, y_min = old and 120 or 150, y_max = old and 140 or 160,
	biomes = old and {"taiga"} or {"mountain", "glacier"},
	schematic = ethereal.yellowtree,
	spawn_by = old and "default:dirt_with_snow" or "default:snow", num_spawn_by = 8,
	flags = "place_center_x, place_center_z, force_placement"})

-- crystal frost tree

register_decoration(ethereal.frost, {
	place_on = "ethereal:crystal_dirt",
	fill_ratio = 0.01, y_min = 1, y_max = 1750,
	biomes = {"frost", "frost_floatland"},
	schematic = ethereal.frosttrees,
	spawn_by = "ethereal:crystal_dirt", num_spawn_by = 8})

-- giant red mushroom

register_decoration(ethereal.mushroom, {
	place_on = "ethereal:mushroom_dirt",
	fill_ratio = 0.018, sidelen = 8, y_min = 3, y_max = 25,
	biomes = {"mushroom"},
	schematic = ethereal.mushroomone,
	spawn_by = "ethereal:mushroom_dirt", num_spawn_by = 8})

-- giant brown mushroom

register_decoration(ethereal.mushroom, {
	place_on = "ethereal:mushroom_dirt",
	fill_ratio = 0.02, y_min = 26, y_max = 50,
	biomes = {"mushroom"},
	schematic = ethereal.mushroomtwo,
	spawn_by = "ethereal:mushroom_dirt", num_spawn_by = 6,
	rotation = "random"})

-- small lava crater

register_decoration(ethereal.fiery, {
	place_on = "ethereal:fiery_dirt",
	fill_ratio = 0.01,
	biomes = {"fiery"},
	schematic = ethereal.volcanom,
	spawn_by = "ethereal:fiery_dirt", num_spawn_by = 6})

-- large lava crater

register_decoration(ethereal.fiery, {
	place_on = "ethereal:fiery_dirt",
	fill_ratio = 0.003,
	biomes = {"fiery"},
	schematic = ethereal.volcanol,
	spawn_by = "ethereal:fiery_dirt", num_spawn_by = 4,
	rotation = "random"})

-- basandra bush

register_decoration(ethereal.fiery, {
	place_on = "ethereal:fiery_dirt",
	fill_ratio = 0.03,
	biomes = {"fiery"},
	schematic = ethereal.basandrabush})

-- default jungle tree

register_decoration(ethereal.junglee, {
	place_on = "default:dirt_with_rainforest_litter",
	fill_ratio = 0.08,
	biomes = {"rainforest"},
	schematic = dpath .. "jungle_tree.mts"})

-- willow tree

register_decoration(ethereal.grayness, {
	place_on = "ethereal:gray_dirt",
	fill_ratio = 0.02,
	biomes = {"grayness"},
	schematic = ethereal.willow,
	spawn_by = "ethereal:gray_dirt", num_spawn_by = 6})

-- default large pine tree for lower elevation

register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.025, y_min = 4, y_max = 50,
	biomes = {"coniferous_forest"},
	schematic = dpath .. "pine_tree.mts"})

-- default small pine tree for higher elevation

register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.025, y_min = 50, y_max = 140,
	biomes = {"coniferous_forest"},
	schematic = dpath .. "small_pine_tree.mts"})--ethereal.pinetree})

-- default large snowy pine tree for lower elevation

register_decoration(ethereal.alpine, {
	place_on = {"default:dirt_with_snow"},
	fill_ratio = 0.025, y_min = 4, y_max = 50,
	biomes = {"taiga"},
	schematic = dpath .. "snowy_pine_tree_from_sapling.mts"})

-- default small snowy pine for higher elevation

register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_snow"},
	fill_ratio = 0.025, y_min = 50, y_max = 140,
	biomes = {"taiga"},
	schematic = dpath .. "snowy_small_pine_tree_from_sapling.mts"})--ethereal.pinetree})

-- default apple tree

register_decoration(ethereal.grassy, {
	place_on = "default:dirt_with_grass",
	fill_ratio = 0.025,
	biomes = {"jumble", "deciduous_forest"},
	schematic = dpath .. "apple_tree.mts"})

-- big old tree

register_decoration(ethereal.jumble, {
	place_on = "default:dirt_with_grass",
	fill_ratio = 0.001,
	biomes = {"jumble"},
	schematic = ethereal.bigtree,
	spawn_by = "default:dirt_with_grass", num_spawn_by = 8})

-- default aspen tree

register_decoration(ethereal.grassytwo, {
	place_on = "default:dirt_with_grass",
	fill_ratio = 0.02, y_min = 1, y_max = 50,
	biomes = {"grassytwo"},
	schematic = dpath .. "aspen_tree.mts"})

-- birch tree

register_decoration(ethereal.grassytwo, {
	place_on = "default:dirt_with_grass",
	fill_ratio = 0.02, y_min = 50, y_max = 100,
	biomes = {"grassytwo"},
	schematic = ethereal.birchtree})

-- orange tree

register_decoration(ethereal.prairie, {
	place_on = "ethereal:prairie_dirt",
	fill_ratio = 0.01,
	biomes = {"prairie"},
	schematic = ethereal.orangetree})

-- default acacia tree

register_decoration(ethereal.savanna, {
	place_on = {"default:dry_dirt_with_dry_grass", "default:dirt_with_dry_grass"},
	fill_ratio = 0.004,
	biomes = {"savanna"},
	schematic = dpath .. "acacia_tree.mts"})

-- palm tree

register_decoration(1, {
	place_on = "default:sand",
	fill_ratio = 0.0025, y_min = 1, y_max = 1,
	biomes = {"desert_ocean", "plains_ocean", "sandstone_ocean",
			"mesa_ocean", "grove_ocean", "deciduous_forest_ocean"},
	schematic = ethereal.palmtree})

-- bamboo tree

register_decoration(ethereal.bamboo, {
	place_on = "ethereal:bamboo_dirt",
	fill_ratio = 0.025, y_min = 36, y_max = 70,
	biomes = {"bamboo"},
	schematic = ethereal.bambootree})

-- bush

register_decoration(ethereal.bamboo, {
	place_on = "ethereal:bamboo_dirt",
	fill_ratio = 0.08, y_min = 35, y_max = 70,
	biomes = {"bamboo"},
	schematic = ethereal.bush,
	spawn_by = "ethereal:bamboo_dirt", num_spawn_by = 6})

-- vine tree

register_decoration(ethereal.swamp, {
	place_on = "default:dirt_with_grass",
	fill_ratio = 0.02,
	biomes = {"swamp"},
	schematic = ethereal.vinetree})

-- lemon tree

register_decoration(ethereal.mediterranean, {
	place_on = "ethereal:grove_dirt",
	fill_ratio = 0.004, y_min = 5, y_max = 50,
	biomes = {"mediterranean"},
	schematic = ethereal.lemontree})

-- olive tree

register_decoration(ethereal.mediterranean, {
	place_on = "ethereal:grove_dirt",
	fill_ratio = 0.004, y_min = 5, y_max = 45,
	biomes = {"mediterranean"},
	schematic = ethereal.olivetree})

-- default large cactus

register_decoration(ethereal.desert, {
	place_on = {"default:desert_sand"},
	y_min = 5, y_max = 100,
	noise_params = {
		offset = -0.0005, scale = 0.0015, spread = {x = 200, y = 200, z = 200},
		seed = 230, octaves = 3, persist = 0.6},
	biomes = {"desert"},
	schematic = dpath .. "large_cactus.mts",
	flags = "place_center_x",
	rotation = "random"})

-- default bush

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
	sidelen = 16,
	noise_params = {
		offset = -0.004, scale = 0.01, spread = {x = 100, y = 100, z = 100},
		seed = 137, octaves = 3, persist = 0.7},
	biomes = {"deciduous_forest", "grassytwo", "jumble"},
	schematic = dpath .. "bush.mts"})

-- default acacia bush

register_decoration(1, {
	place_on = {"default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.004, scale = 0.01, spread = {x = 100, y = 100, z = 100},
		seed = 90155, octaves = 3, persist = 0.7},
	biomes = {"savanna", "mesa"},
	schematic = dpath .. "acacia_bush.mts"})

-- default pine bush

register_decoration((minetest.registered_nodes["default:pine_bush"] and 1), {
	name = "default:pine_bush",
	place_on = {"default:dirt_with_snow", "default:cold_dirt"},
	sidelen = 16, y_min = 4, y_max = 120,
	noise_params = {
		offset = -0.004, scale = 0.01, spread = {x = 100, y = 100, z = 100},
		seed = 137, octaves = 3, persist = 0.7},
	biomes = {"taiga", "snowy_grassland"},
	schematic = dpath .. "pine_bush.mts"})

-- default blueberry bush

register_decoration((minetest.registered_nodes["default:blueberry_bush_leaves"] and 1), {
	name = "default:blueberry_bush",
	place_on = {"default:dirt_with_coniferous_litter", "default:dirt_with_snow",
			"ethereal:cold_dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.004, scale = 0.01, spread = {x = 100, y = 100, z = 100},
		seed = 697, octaves = 3, persist = 0.7},
	biomes = {"coniferous_forest", "taiga", "snowy_grassland"},
	schematic = dpath .. "blueberry_bush.mts", place_offset_y = 1})

-- place waterlily in beach areas

register_decoration(1, {
	place_on = {"default:sand"},
	sidelen = 16, y_min = 0, y_max = 0,
	noise_params = {
		offset = -0.12, scale = 0.3, spread = {x = 200, y = 200, z = 200},
		seed = 33, octaves = 3, persist = 0.7},
	biomes = {"desert_ocean", "plains_ocean", "mesa_ocean", "grove_ocean",
			"deciduous_forest_ocean", "swamp_ocean"},
	schematic = ethereal.waterlily,
	rotation = "random"})

-- coral reef

if ethereal.reefs == 1 then

	-- override corals so crystal shovel can pick them up intact
	minetest.override_item("default:coral_skeleton", {groups = {crumbly = 3}})
	minetest.override_item("default:coral_orange", {groups = {crumbly = 3}})
	minetest.override_item("default:coral_brown", {groups = {crumbly = 3}})

	register_decoration(1, {
		place_on = {"default:sand"},
		noise_params = {
			offset = -0.15, scale = 0.1, spread = {x = 100, y = 100, z = 100},
			seed = 7013, octaves = 3, persist = 1},
		biomes = {"desert_ocean", "grove_ocean"},
		y_min = -8, y_max = -2,
		schematic = path .. "corals.mts",
		rotation = "random"})
end

-- tree logs

if ethereal.logs == 1 then

	register_decoration(ethereal.prairie, {
		name = "default:apple_log",
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		sidelen = 16, fill_ratio = 0.001,
		biomes = {"deciduous_forest", "jumble", "swamp", "prairie"},
		schematic = dpath .. "apple_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"default:dirt_with_grass", "ethereal:prairie_dirt"}, num_spawn_by = 8})

	register_decoration(ethereal.junglee, {
		name = "default:jungle_log",
		place_on = {"default:dirt_with_rainforest_litter"},
		fill_ratio = 0.005,
		biomes = {"rainforest"},
		schematic = dpath .. "jungle_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "default:dirt_with_rainforest_litter", num_spawn_by = 8})

	register_decoration(ethereal.snowy, {
		name = "default:pine_log",
		place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
		fill_ratio = 0.0018, y_min = 4, y_max = 100,
		biomes = {"taiga", "coniferous_forest"},
		schematic = dpath .. "pine_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
		num_spawn_by = 8})

	register_decoration(ethereal.savanna, {
		name = "default:acacia_log",
		deco_type = "schematic",
		place_on = {"default:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0, scale = 0.001, spread = {x = 250, y = 250, z = 250},
			seed = 2, octaves = 3, persist = 0.66},
		biomes = {"savanna"},
		schematic = dpath .. "acacia_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "default:dry_dirt_with_dry_grass", num_spawn_by = 8})

	register_decoration(ethereal.plains, {
		name = "ethereal:scorched_log",
		place_on = {"ethereal:dry_dirt"},
		fill_ratio = 0.0018, y_min = 4, y_max = 100,
		biomes = {"plains"},
		schematic = {
			size = {x = 3, y = 1, z = 1},
			data = {
				{name = "ethereal:scorched_tree", param1 = 201, param2 = 16},
				{name = "ethereal:scorched_tree", param1 = 255, param2 = 16},
				{name = "ethereal:scorched_tree", param1 = 255, param2 = 16}
			}
		}, place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "ethereal:dry_dirt", num_spawn_by = 8})

	register_decoration(ethereal.grove, {
		name = "ethereal:banana_log",
		place_on = {"ethereal:grove_dirt"},
		fill_ratio = 0.0018, y_min = 4, y_max = 100,
		biomes = {"grove"},
		schematic = {
			size = {x = 3, y = 1, z = 1},
			data = {
				{name = "ethereal:banana_trunk", param1 = 255, param2 = 16},
				{name = "ethereal:banana_trunk", param1 = 255, param2 = 16},
				{name = "ethereal:banana_trunk", param1 = 201, param2 = 16}
			}
		}, place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "ethereal:grove_dirt", num_spawn_by = 8})
end

-- deep see fumerole / vent

register_decoration(minetest.get_modpath("nether") and 1, {
	name = "nether:fumarole",
	place_on = {"default:sand"},
	sidelen = 16, y_min = -192, y_max = -45,
	fill_ratio = 0.0001,
	schematic = {
		size = {x = 1, y = 2, z = 2},
		data = {
			{name = "default:lava_source", param1 = 255, force_place = true},
			{name = "nether:fumarole", param1 = 255, force_place = true},
			{name = "default:sand", param1 = 192, force_place = true},
			{name = "ethereal:sandy", param1 = 192, force_place = true},
		}
	},
	place_offset_y = -1,
	spawn_by = {"default:water_source"}, num_spawn_by = 8})

if minetest.get_modpath("nether") then

	minetest.register_lbm({
		name = ":nether:extra_fumarole_timer",
		nodenames = {"nether:fumarole"},
		run_at_every_load = false,

		action = function(pos) minetest.get_node_timer(pos):start(10) end
	})
end
