
-- register decoration helper

local function register_decoration(enabled, def)

	if enabled ~= 1 then return end

	def.sidelen = def.sidelen or 80 -- some handy defaults
	def.deco_type = "simple"
	def.y_min = def.y_min or 1
	def.y_max = def.y_max or 100

	minetest.register_decoration(def)
end

-- ponds

register_decoration(ethereal.mesa, {
	place_on = {"group:bakedclay"},
	sidelen = 32, fill_ratio = 0.003, y_min = 18, y_max = 72,
	biomes = {"mesa"},
	decoration = {"ethereal:pond"},
	spawn_by = "group:bakedclay", num_spawn_by = 8})

-- thin ice

register_decoration(ethereal.frost, {
	place_on = {"default:silver_sand"},
	fill_ratio = 1.0, y_min = 0, y_max = 0,
	decoration = "ethereal:thin_ice", place_offset_y = 1,
	biomes = {"frost_ocean"} })

-- water pools in swamp areas

register_decoration(1, {
	place_on = {"default:dirt_with_grass"},
	sidelen = 4, fill_ratio = 0.01, y_min = 1, y_max = 2,
	biomes = {"swamp"},
	flags = "force_placement",
	decoration = "default:water_source", place_offset_y = -1,
	spawn_by = "default:dirt_with_grass", num_spawn_by = 8})

register_decoration(1, {
	place_on = {"default:dirt_with_grass"},
	sidelen = 4, fill_ratio = 0.1, y_min = 1, y_max = 2,
	biomes = {"swamp"},
	flags = "force_placement",
	decoration = "default:water_source", place_offset_y = -1,
	spawn_by = {"default:dirt_with_grass", "default:water_source"}, num_spawn_by = 8})

-- dry dirt patches

register_decoration(1, {
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 4,
	noise_params = {offset = -1.5, scale = -1.5, spread = {x = 200, y = 200, z = 200},
			seed = 329, octaves = 4, persist = 1.0},
	biomes = {"savanna"},
	decoration = "default:dry_dirt", place_offset_y = -1,
	flags = "force_placement"
})

-- farming redo check, salt crystal if found, strawberry if not

if minetest.get_modpath("farming") and farming.mod and farming.mod == "redo" then

	register_decoration(ethereal.cold_desert, {
		place_on = "default:silver_sand",
		fill_ratio = 0.001, y_min = 4, y_max = 100,
		decoration = "farming:salt_crystal"})
else
	register_decoration(1, {
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		sidelen = 16, y_min = 15, y_max = 55,
		noise_params = {offset = 0, scale = 0.002, spread = {x = 100, y = 100, z = 100},
				seed = 143, octaves = 3, persist = 0.6},
		decoration = "ethereal:strawberry_7"})
end

-- firethorn shrub

register_decoration(ethereal.glacier, {
	place_on = "default:snowblock",
	fill_ratio = 0.001, y_min = 1, y_max = 30,
	biomes = {"glacier"},
	decoration = "ethereal:firethorn"})

-- caverealm icicle

register_decoration((minetest.get_modpath("caverealms") and 1), {
	place_on = "default:snowblock",
	fill_ratio = 0.008, y_min = 3, y_max = 30,
	biomes = {"glacier"},
	decoration = "caverealms:icicle_up"})

-- scorched tree

register_decoration(ethereal.plains, {
	place_on = "ethereal:dry_dirt",
	fill_ratio = 0.006,
	biomes = {"plains"},
	decoration = "ethereal:scorched_tree", height_max = 6})

-- dry shrub

register_decoration(ethereal.plains, {
	place_on = {"ethereal:dry_dirt", "default:sand", "default:desert_sand",
			"default:sandstone", "default:dirt_with_dry_grass",
			"default:permafrost_with_stones"},
	fill_ratio = 0.015,
	biomes = {"plains", "deciduous_forest_ocean", "desert", "sandstone_desert", "mesa",
			"tundra"},
	decoration = "default:dry_shrub"})

register_decoration(ethereal.plains, {
	place_on = {"default:desert_sand", "default:dirt_with_dry_grass", "bakedclay:red",
			"bakedclay:grey", "bakedclay:brown", "bakedclay:orange"},
	fill_ratio = 0.015,
	biomes = {"mesa_beach", "mesa_redwood", "mesa"},
	decoration = "default:dry_shrub"})

-- dry grass

register_decoration(ethereal.savanna, {
	place_on = {"default:dry_dirt_with_dry_grass", "default:dirt_with_dry_grass"},
	fill_ratio = 0.25,
	biomes = {"savanna"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4",
			"default:dry_grass_5"}})

register_decoration(ethereal.mesa, {
	place_on = {"default:dirt_with_dry_grass"},
	fill_ratio = 0.10,
	biomes = {"mesa_redwood"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4",
			"default:dry_grass_5"}})

register_decoration(ethereal.caves, {
	place_on = {"default:desert_stone"},
	fill_ratio = 0.005, y_min = 5, y_max = 42,
	biomes = {"caves"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_shrub"}})

-- flowers

register_decoration(ethereal.grassy, {
	place_on = {"default:dirt_with_grass", "ethereal:grove_dirt"},
	fill_ratio = 0.025,
	biomes = {"deciduous_forest", "grassytwo", "mediterranean"},
	decoration = {"flowers:dandelion_white", "flowers:dandelion_yellow",
			"flowers:geranium", "flowers:rose", "flowers:tulip", "flowers:viola"}})

-- prairie flowers

register_decoration(ethereal.prairie, {
	place_on = {"ethereal:prairie_dirt"},
	fill_ratio = 0.035,
	biomes = {"prairie"},
	decoration = {"flowers:dandelion_white", "flowers:dandelion_yellow",
			"flowers:geranium", "flowers:rose", "flowers:tulip",
			"flowers:viola", "flowers:chrysanthemum_green",
			"flowers:tulip_black"}})

-- crystal spike & grass

register_decoration(ethereal.frost, {
	place_on = {"ethereal:crystal_dirt"},
	fill_ratio = 0.02, y_min = 1, y_max = 1750,
	biomes = {"frost", "frost_floatland"},
	decoration = {"ethereal:crystal_spike", "ethereal:crystalgrass"}})

-- red shrub

register_decoration(ethereal.fiery, {
	place_on = {"ethereal:fiery_dirt"},
	fill_ratio = 0.10,
	biomes = {"fiery"},
	decoration = "ethereal:dry_shrub"})

-- snowy grass

register_decoration(ethereal.snowy, {
	place_on = {"ethereal:gray_dirt"},
	fill_ratio = 0.05,
	biomes = {"grayness"},
	decoration = "ethereal:snowygrass"})

register_decoration(ethereal.snowy, {
	place_on = {"default:silver_sand"},
	fill_ratio = 0.025,
	biomes = {"cold_desert"},
	decoration = {"default:dry_shrub", "ethereal:snowygrass"} })

-- cactus

register_decoration(ethereal.sandstone, {
	place_on = {"default:sandstone"},
	fill_ratio = 0.002,
	biomes = {"sandstone_desert"},
	decoration = "default:cactus", height_max = 2})

register_decoration(ethereal.desert, {
	place_on = {"default:desert_sand"},
	fill_ratio = 0.005,
	biomes = {"desert"},
	decoration = "default:cactus", height_max = 4})

-- spore grass

register_decoration(ethereal.mushroom, {
	place_on = {"ethereal:mushroom_dirt"},
	fill_ratio = 0.1,
	biomes = {"mushroom"},
	decoration = "ethereal:spore_grass"})

-- slime mold

register_decoration(ethereal.mushroom, {
	place_on = {"default:sand"},
	fill_ratio = 0.1, y_min = 2, y_max = 6,
	biomes = {"mushroom_ocean"},
	decoration = "ethereal:slime_mold"})

-- red & brown mushroom

register_decoration(1, {
	place_on = {"default:dirt_with_rainforest_litter", "default:dirt_with_grass",
			"ethereal:prairie_dirt", "ethereal:mushroom_dirt"},
	sidelen = 16, fill_ratio = 0.01,
	biomes = {"rainforest", "deciduous_forest", "grassytwo", "prairie", "swamp", "mushroom"},
	decoration = {"flowers:mushroom_brown", "flowers:mushroom_red"}})

-- jungle grass

register_decoration(ethereal.junglee, {
	place_on = {"default:dirt_with_rainforest_litter"},
	fill_ratio = 0.1,
	biomes = {"rainforest"},
	decoration = "default:junglegrass"})

register_decoration(ethereal.jumble, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.15,
	biomes = {"jumble"},
	decoration = "default:junglegrass"})

register_decoration(ethereal.swamp, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.25,
	biomes = {"swamp"},
	decoration = "default:junglegrass"})

-- grass

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter",
		"ethereal:prairie_dirt", "ethereal:grove_dirt", "ethereal:bamboo_dirt"},
	fill_ratio = 0.35,
	biomes = {"deciduous_forest", "grassytwo", "jumble", "rainforest", "grove", "prairie",
			"mediterranean", "bamboo", "grassland", "swamp"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4",
			"default:grass_5"}})

-- lilac

register_decoration(ethereal.bamboo, {
	place_on = {"ethereal:bamboo_dirt"},
	fill_ratio = 0.025, y_min = 3, y_max = 35,
	biomes = {"bamboo"},
	decoration = "ethereal:lilac"})

-- marram grass

register_decoration(1, {
	place_on = {"default:sand"},
	sidelen = 4, y_min = 3, y_max = 6,
	noise_params = {offset = -0.7, scale = 3.0, spread = {x = 16, y = 16, z = 16},
			seed = 513337, octaves = 1, persist = 0.0, flags = "absvalue, eased"},
	biomes = {"coniferous_forest_dunes", "grassland_ocean"},
	decoration = {"default:marram_grass_1", "default:marram_grass_2",
			"default:marram_grass_3"}})

-- ferns

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "ethereal:grove_dirt"},
	fill_ratio = 0.1,
	biomes = {"swamp", "grove"},
	decoration = "ethereal:fern"})

register_decoration(ethereal.frost, { -- chance of something edible so high up
	place_on = {"ethereal:crystal_dirt"},
	fill_ratio = 0.001, y_min = 1025, y_max = 1750,
	biomes = {"frost_floatland"},
	decoration = "ethereal:fern"})

-- snow

register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.8, y_min = 20, y_max = 140,
	biomes = {"coniferous_forest"},
	decoration = "default:snow"})

register_decoration(ethereal.alpine, {
	place_on = {"default:dirt_with_snow"},
	fill_ratio = 0.8, y_min = 40, y_max = 140,
	biomes = {"taiga"},
	decoration = "default:snow"})

register_decoration(1, {
	place_on = {"ethereal:cold_dirt"},
	fill_ratio = 0.8, y_min = 2, y_max = 40,
	biomes = {"snowy_grassland"},
	decoration = "default:snow"})

-- wild onion and setting

local abundant = minetest.settings:get_bool("ethereal.abundant_onions") ~= false

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
	fill_ratio = (abundant and 0.025 or 0.005),
	biomes = {"deciduous_forest", "grassytwo", "jumble", "prairie"},
	decoration = "ethereal:onion_4"})

-- papyrus

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	fill_ratio = 0.1, y_min = 1, y_max = 1,
	biomes = {"deciduous_forest", "rainforest", "swamp"},
	decoration = "default:papyrus", height_max = 4,
	spawn_by = "default:water_source", num_spawn_by = 1})

-- baked clay flowers

if minetest.get_modpath("bakedclay") then

register_decoration(1, {
	place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass", "ethereal:grove_dirt"},
	sidelen = 16, y_min = 10, y_max = 90,
	noise_params = {offset = 0, scale = 0.004, spread = {x = 100, y = 100, z = 100},
			seed = 7133, octaves = 3, persist = 0.6},
	decoration = "bakedclay:delphinium"})

register_decoration(1, {
	place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
			"ethereal:grove_dirt", "ethereal:bamboo_dirt"},
	sidelen = 16, y_min = 15, y_max = 90,
	noise_params = {offset = 0, scale = 0.004, spread = {x = 100, y = 100, z = 100},
			seed = 7134, octaves = 3, persist = 0.6},
	decoration = "bakedclay:thistle"})

register_decoration(1, {
	place_on = {"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"},
	sidelen = 16, y_min = 1, y_max = 90,
	noise_params = {offset = 0, scale = 0.01, spread = {x = 100, y = 100, z = 100},
			seed = 7135, octaves = 3, persist = 0.6},
	decoration = "bakedclay:lazarus",
	spawn_by = "default:jungletree", num_spawn_by = 1})

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "default:sand"},
	sidelen = 16, y_min = 1, y_max = 15,
	noise_params = {offset = 0, scale = 0.009, spread = {x = 100, y = 100, z = 100},
			seed = 7136, octaves = 3, persist = 0.6},
	decoration = "bakedclay:mannagrass",
	spawn_by = "group:water", num_spawn_by = 1})
end

-- blue agave from wine mod

if minetest.get_modpath("wine") then

	register_decoration(ethereal.desert, {
		place_on = {"default:desert_sand"},
		sidelen = 16, fill_ratio = 0.001,
		biomes = {"desert"},
		decoration = {"wine:blue_agave"}})
end

-- default ferns

register_decoration(1, {
	place_on = {"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
	sidelen = 16, fill_ratio = 0.2, y_min = 3, y_max = 100,
	decoration = {"default:fern_1", "default:fern_2", "default:fern_3"} })

-- stone with yellow algae

register_decoration(minetest.get_modpath("caverealms") and ethereal.tundra, {
	place_on = {"default:permafrost_with_stones"},
	sidelen = 4, y_min = 3, y_max = 50,
	noise_params = {offset = -0.2, scale = 1.0, spread = {x = 100, y = 100, z = 100},
			seed = 1920, octaves = 3, persist = 0.5},
	biomes = {"tundra"},
	decoration = "caverealms:stone_with_algae", place_offset_y = -1,
	flags = "force_placement"})

-- Tundra moss

register_decoration(ethereal.tundra, {
	place_on = {"default:permafrost_with_stones"},
	sidelen = 4, y_min = 2, y_max = 50,
	noise_params = {offset = -0.8, scale = 2.0, spread = {x = 100, y = 100, z = 100},
			seed = 53995, octaves = 3, persist = 1.0},
	biomes = {"tundra"},
	decoration = "default:permafrost_with_moss", place_offset_y = -1,
	flags = "force_placement"})

-- Tundra patchy snow

register_decoration(ethereal.tundra, {
	place_on = {"default:permafrost_with_moss", "default:permafrost_with_stones",
			"default:stone", "default:gravel"},
	sidelen = 4, y_min = 1, y_max = 50,
	noise_params = {offset = 0, scale = 1.0, spread = {x = 100, y = 100, z = 100},
			seed = 172555, octaves = 3, persist = 1.0},
	biomes = {"tundra", "tundra_beach"},
	decoration = "default:snow"})

-- butterflies mod

if minetest.get_modpath("butterflies") then

	register_decoration(1, {
		name = "butterflies:butterfly",
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		fill_ratio = 0.005, y_min = 1, y_max = 200,
		biomes = {"deciduous_forest", "grassytwo", "prairie", "jumble"},
		decoration = {"butterflies:butterfly_white", "butterflies:butterfly_red",
				"butterflies:butterfly_violet"}, place_offset_y = 2,
		spawn_by = "group:flower", num_spawn_by = 1})

	-- restart butterfly timers
	minetest.register_lbm({
		name = ":butterflies:butterfly_timer",
		nodenames = {
			"butterflies:butterfly_white", "butterflies:butterfly_red",
			"butterflies:butterfly_violet"
		},
		run_at_every_load = false,

		action = function(pos) minetest.get_node_timer(pos):start(5) end
	})
end

-- fireflies mod

if minetest.get_modpath("fireflies") then

	register_decoration(1, {
		name = "fireflies:firefly_low",
		place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter",
				"default:dirt_with_rainforest_litter", "default:dirt",
				"ethereal:prairie_dirt"},
		fill_ratio = 0.0005, y_min = -1, y_max = 200,
		biomes = {"deciduous_forest", "grassytwo", "coniferous_forest", "rainforest",
				"swamp"},
		decoration = "fireflies:hidden_firefly", place_offset_y = 2})

	-- restart firefly timers
	minetest.register_lbm({
		name = ":fireflies:firefly_timer",
		nodenames = {"fireflies:firefly", "fireflies:hidden_firefly"},
		run_at_every_load = false,

		action = function(pos) minetest.get_node_timer(pos):start(5) end
	})
end

-- Coral Reef

register_decoration(1, {
	name = "default:corals",
	place_on = {"default:sand"},
	sidelen = 4, y_min = -8, y_max = -2,
	noise_params = {offset = -4, scale = 4, spread = {x = 50, y = 50, z = 50},
			seed = 7013, octaves = 3, persist = 0.7},
	biomes = {"desert_ocean", "savanna_ocean", "rainforest_ocean"},
	flags = "force_placement",
	decoration = {"default:coral_green", "default:coral_pink", "default:coral_cyan",
			"default:coral_brown", "default:coral_orange", "default:coral_skeleton"},
	place_offset_y = -1})

-- Kelp

register_decoration(1, {
	name = "default:kelp",
	place_on = {"default:sand"},
	sidelen = 16, y_min = -10, y_max = -5,
	noise_params = {offset = -0.04, scale = 0.1, spread = {x = 200, y = 200, z = 200},
			seed = 87112, octaves = 3, persist = 0.7},
	biomes = {"frost_ocean", "deciduous_forest_ocean", "sandstone_ocean", "swamp_ocean",
			"snowy_grassland_ocean"},
	flags = "force_placement",
	decoration = "default:sand_with_kelp", place_offset_y = -1,
	param2 = 48, param2_max = 96})

-- illumishrooms using underground decoration placement

local function add_illumishroom(low, high, nodename)

	register_decoration(1, {
		place_on = {"default:stone_with_coal"},
		sidelen = 16, fill_ratio = 0.5, y_min = low, y_max = high,
		flags = "force_placement, all_floors",
		decoration = nodename})
end

add_illumishroom(-1000, -50, "ethereal:illumishroom")
add_illumishroom(-2000, -1000, "ethereal:illumishroom2")
add_illumishroom(-3000, -2000, "ethereal:illumishroom3")

--= Register Biome Decoration Using Plants Mega Pack Lite if Xanadu found

if minetest.get_modpath("xanadu") then

	--= Desert Biome

	-- Cactus
	register_decoration(1, {
		place_on = {"default:desert_sand", "default:sandstone"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"desert", "sandstone"},
		decoration = {"xanadu:cactus_echinocereus", "xanadu:cactus_matucana",
				"xanadu:cactus_baseball", "xanadu:cactus_golden"}})

	-- Desert Plants
	register_decoration(1, {
		place_on = {"default:desert_sand", "default:sandstone", "default:sand"},
		sidelen = 16, fill_ratio = 0.004,
		biomes = {"desert", "sandstone"},
		decoration = {"xanadu:desert_kangaroo", "xanadu:desert_brittle",
				"xanadu:desert_ocotillo", "xanadu:desert_whitesage"}})

	--=  Prairie Biome

	-- Grass
	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo"},
		decoration = {"xanadu:grass_prairie", "xanadu:grass_cord",
				"xanadu:grass_wheatgrass", "xanadu:desert_whitesage"}})

	-- Flowers
	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
				"ethereal:grove_dirt", "ethereal:bamboo_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo", "bamboo"},
		decoration = {"xanadu:flower_jacobsladder", "xanadu:flower_thistle",
				"xanadu:flower_wildcarrot"}})

	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
				"ethereal:grove_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo", "grove"},
		decoration = {"xanadu:flower_delphinium", "xanadu:flower_celosia",
				"xanadu:flower_daisy", "xanadu:flower_bluerose"}})

	-- Shrubs
	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
				"ethereal:grove_dirt", "ethereal:jungle_grass", "ethereal:gray_dirt",
				"default:dirt_with_rainforest_litter"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo", "grove", "rainforest",
				"grayness", "jumble"},
		decoration = {"xanadu:shrub_kerria", "xanadu:shrub_spicebush"}})

	--= Jungle Biome

	register_decoration(1, {
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16, fill_ratio = 0.007,
		biomes = {"rainforest", "jumble"},
		decoration = {"xanadu:rainforest_guzmania", "xanadu:rainforest_devil",
				"xanadu:rainforest_lazarus", "xanadu:rainforest_lollipop",
				"xanadu:mushroom_woolly"}})

	--= Cold Biomes

	register_decoration(1, {
		place_on = {"default:dirt_with_snow", "ethereal:gray_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"coniferous_forest", "taiga", "grayness"},
		decoration = {"xanadu:mountain_edelweiss", "xanadu:mountain_armeria",
				"xanadu:mountain_bellflower", "xanadu:mountain_willowherb",
				"xanadu:mountain_bistort"}})

	--= Mushroom Biome

	register_decoration(1, {
		place_on = {"ethereal:mushroom_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"mushroom"},
		decoration = {"xanadu:mushroom_powderpuff", "xanadu:mushroom_chanterelle",
				"xanadu:mushroom_parasol"}})

	--= Lakeside

	register_decoration(1, {
		place_on = {"default:sand", "default:dirt_with_grass"},
		sidelen = 16, fill_ratio = 0.015,
		biomes = {"deciduous_forest_ocean", "grassland", "grassytwo", "jumble",
				"swamp"},
		decoration = {"xanadu:wetlands_cattails", "xanadu:wetlands_pickerel",
				"xanadu:wetlands_mannagrass", "xanadu:wetlands_turtle"},
		spawn_by = "default:water_source", num_spawn_by = 1})

	--= Harsh Biomes

	register_decoration(1, {
		place_on = {"ethereal:mushroom_dirt", "default:dirt_with_grass",
				"ethereal:gray_dirt", "ethereal:dirt_with_snow", "ethereal:prairie_dirt",
				"ethereal:grove_dirt", "ethereal:dry_dirt", "ethereal:fiery_dirt",
				"default:sand", "default:desert_sand", "ethereal:bamboo_dirt",
				"default:dirt_with_rainforest_litter", "default:permafrost_with_stones"},
		sidelen = 16, fill_ratio = 0.004,
		biomes = {"mushroom", "prairie", "grayness", "plains", "desert", "rainforest",
				"deciduous_forest", "grassytwo", "jumble", "coniferous_forest", "taiga",
				"fiery", "mesa", "bamboo", "tundra"},
		decoration = {"xanadu:spooky_thornbush", "xanadu:spooky_baneberry"}})
end

--= Poppy's growing in Clearing Biome in memory of RealBadAngel

register_decoration(1, {
	place_on = {"default:dirt_with_grass"},
	sidelen = 16, fill_ratio = 0.004,
	biomes = {"grassland"},
	decoration = {"xanadu:poppy"}})
