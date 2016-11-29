
-- clear default mapgen biomes, decorations and ores
minetest.clear_registered_biomes()
minetest.clear_registered_decorations()
--minetest.clear_registered_ores()

local path = minetest.get_modpath("ethereal")

dofile(path .. "/ores.lua")

path = path .. "/schematics/"

local dpath = minetest.get_modpath("default") .. "/schematics/"

-- tree schematics
dofile(path .. "orange_tree.lua")
dofile(path .. "banana_tree.lua")
dofile(path .. "bamboo_tree.lua")
dofile(path .. "birch_tree.lua")
dofile(path .. "bush.lua")
dofile(path .. "waterlily.lua")

--= Biomes (Minetest 0.4.13 and above)

local add_biome = function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p)

	if p ~= 1 then return end

	minetest.register_biome({
		name = a,
		node_dust = b,
		node_top = c,
		depth_top = d,
		node_filler = e,
		depth_filler = f,
		node_stone = g,
		node_water_top = h,
		depth_water_top = i,
		node_water = j,
		node_river_water = k,
		y_min = l,
		y_max = m,
		heat_point = n,
		humidity_point = o,
	})
end

add_biome("underground", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
	-31000, -192, 50, 50, 1)

add_biome("mountain", nil, "default:snow", 1, "default:snowblock", 2,
	nil, nil, nil, nil, nil, 140, 31000, 50, 50, 1)

add_biome("desert", nil, "default:desert_sand", 1, "default:desert_sand", 3,
	"default:desert_stone", nil, nil, nil, nil, 3, 23, 35, 20, ethereal.desert)

add_biome("desert_ocean", nil, "default:sand", 1, "default:sand", 2,
	"default:desert_stone", nil, nil, nil, nil, -192, 3, 35, 20, ethereal.desert)

add_biome("glacier", "default:snowblock", "default:snowblock", 1,
	"default:snowblock", 3, "default:ice", "default:ice", 10, -8, 31000, 0, 50, ethereal.glacier)

add_biome("glacier_ocean", "default:snowblock", "default:sand", 1, "default:sand", 3,
	nil, nil, nil, nil, nil, -112, -9, 0, 50, ethereal.glacier)

add_biome("clearing", nil, "ethereal:green_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 71, 45, 65, 1) -- ADDED

add_biome("bamboo", nil, "ethereal:bamboo_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 71, 45, 75, ethereal.bamboo)

add_biome("bamboo_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 45, 75, ethereal.bamboo)

add_biome("mesa", nil, "bakedclay:orange", 1, "bakedclay:orange", 15,
	nil, nil, nil, nil, nil, 1, 71, 25, 28, ethereal.mesa)

add_biome("mesa_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 25, 28, ethereal.mesa)

add_biome("alpine", nil, "default:dirt_with_snow", 1, "default:dirt", 2,
	nil, nil, nil, nil, nil, 40, 140, 10, 40, ethereal.alpine)

add_biome("snowy", nil, "ethereal:cold_dirt", 1, "default:dirt", 2,
	nil, nil, nil, nil, nil, 4, 40, 10, 40, ethereal.snowy)

add_biome("frost", nil, "ethereal:crystal_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 1, 71, 10, 40, ethereal.frost)

add_biome("frost_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 10, 40, ethereal.frost)

add_biome("grassy", nil, "ethereal:green_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 91, 13, 40, ethereal.grassy)

add_biome("grassy_ocean", nil, "defaut:sand", 2, "default:gravel", 1,
	nil, nil, nil, nil, nil, -31000, 3, 13, 40, ethereal.grassy)

add_biome("caves", nil, "default:desert_stone", 3, "air", 8,
	nil, nil, nil, nil, nil, 4, 41, 15, 25, ethereal.caves)

add_biome("grayness", nil, "ethereal:gray_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 2, 41, 15, 30, ethereal.grayness)

add_biome("grayness_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 15, 30, ethereal.grayness)

add_biome("grassytwo", nil, "ethereal:green_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 1, 91, 15, 40, ethereal.grassytwo)

add_biome("grassytwo_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 15, 40, ethereal.grassytwo)

add_biome("prairie", nil, "ethereal:prairie_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 26, 20, 40, ethereal.prairie)

add_biome("prairie_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 20, 40, ethereal.prairie)

add_biome("jumble", nil, "ethereal:green_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 1, 71, 25, 50, ethereal.jumble)

add_biome("jumble_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 25, 50, ethereal.jumble)

add_biome("junglee", nil, "ethereal:jungle_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 1, 71, 30, 60, ethereal.junglee)

add_biome("junglee_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 30, 60, ethereal.junglee)

add_biome("grove", nil, "ethereal:grove_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 23, 45, 35, ethereal.grove)

add_biome("grove_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 45, 35, ethereal.grove)

add_biome("mushroom", nil, "ethereal:mushroom_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 50, 45, 55, ethereal.mushroom)

add_biome("mushroom_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 45, 55, ethereal.mushroom)

add_biome("sandstone", nil, "default:sandstone", 1, "default:sandstone", 1,
	"default:sandstone", nil, nil, nil, nil, 3, 23, 50, 20, ethereal.sandstone)

add_biome("sandstone_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 50, 20, ethereal.sandstone)

add_biome("quicksand", nil, "ethereal:quicksand2", 3, "default:gravel", 1,
	nil, nil, nil, nil, nil, 1, 1, 50, 38, ethereal.quicksand)

add_biome("plains", nil, "ethereal:dry_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 25, 65, 25, ethereal.plains)

add_biome("plains_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 55, 25, ethereal.plains)

add_biome("savannah", nil, "default:dirt_with_dry_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 50, 55, 25, ethereal.savannah)

add_biome("savannah_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 55, 25, ethereal.savannah)

add_biome("fiery", nil, "ethereal:fiery_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 5, 20, 75, 10, ethereal.fiery)

add_biome("fiery_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 4, 75, 10, ethereal.fiery)

add_biome("sandclay", nil, "default:sand", 3, "default:clay", 2,
	nil, nil, nil, nil, nil, 1, 11, 65, 2, ethereal.sandclay)

--= schematic decorations

local add_schem = function(a, b, c, d, e, f, g)

	if g ~= 1 then return end

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = a,
		sidelen = 80,
		fill_ratio = b,
		biomes = c,
		y_min = d,
		y_max = e,
		schematic = f,
		flags = "place_center_x, place_center_z",
	})
end

-- redwood tree
add_schem({"bakedclay:orange"}, 0.0025, {"mesa"}, 1, 100, path .. "redwood.mts", ethereal.mesa)

-- banana tree
add_schem({"ethereal:grove_dirt"}, 0.015, {"grove"}, 1, 100, ethereal.bananatree, ethereal.grove)

-- healing tree
add_schem({"default:dirt_with_snow"}, 0.01, {"alpine"}, 120, 140, path .. "yellowtree.mts", ethereal.alpine)

-- crystal frost tree
add_schem({"ethereal:crystal_dirt"}, 0.01, {"frost"}, 1, 100, path .. "frosttrees.mts", ethereal.frost)

-- giant mushroom
add_schem({"ethereal:mushroom_dirt"}, 0.02, {"mushroom"}, 1, 100, path .. "mushroomone.mts", ethereal.mushroom)

-- small lava crater
add_schem({"ethereal:fiery_dirt"}, 0.01, {"fiery"}, 1, 100, path .. "volcanom.mts", ethereal.fiery)

-- large lava crater
add_schem({"ethereal:fiery_dirt"}, 0.01, {"fiery"}, 1, 100, path .. "volcanol.mts", ethereal.fiery)

-- default jungle tree
add_schem({"ethereal:jungle_dirt"}, 0.08, {"junglee"}, 1, 100, dpath .. "jungle_tree.mts", ethereal.junglee)

-- willow tree
add_schem({"ethereal:gray_dirt"}, 0.02, {"grayness"}, 1, 100, path .. "willow.mts", ethereal.grayness)

-- pine tree (default for lower elevation and ethereal for higher)
add_schem({"ethereal:cold_dirt"}, 0.025, {"snowy"}, 10, 40, dpath .. "pine_tree.mts", ethereal.snowy)
add_schem({"default:dirt_with_snow"}, 0.025, {"alpine"}, 40, 140, path .. "pinetree.mts", ethereal.alpine)

-- default apple tree
add_schem({"ethereal:green_dirt"}, 0.02, {"jumble"}, 1, 100, dpath .. "apple_tree.mts", ethereal.grassy)
add_schem({"ethereal:green_dirt"}, 0.03, {"grassy"}, 1, 100, dpath .. "apple_tree.mts", ethereal.grassy)

-- big old tree
add_schem({"ethereal:green_dirt"}, 0.001, {"jumble"}, 1, 100, path .. "bigtree.mts", ethereal.jumble)

-- aspen tree
add_schem({"ethereal:green_dirt"}, 0.02, {"grassytwo"}, 1, 50, dpath .. "aspen_tree.mts", ethereal.jumble)

-- birch tree
add_schem({"ethereal:green_dirt"}, 0.02, {"grassytwo"}, 50, 100, ethereal.birchtree, ethereal.grassytwo)

-- orange tree
add_schem({"ethereal:prairie_dirt"}, 0.01, {"prairie"}, 1, 100, ethereal.orangetree, ethereal.prairie)

-- default acacia tree
add_schem({"default:dirt_with_dry_grass"}, 0.004, {"savannah"}, 1, 100, dpath .. "acacia_tree.mts", ethereal.savannah)

-- large cactus (by Paramat)
if ethereal.desert == 1 then
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:desert_sand"},
	sidelen = 80,
	noise_params = {
		offset = -0.0005,
		scale = 0.0015,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"desert"},
	y_min = 5,
	y_max = 31000,
	schematic = dpath.."large_cactus.mts",
	flags = "place_center_x", --, place_center_z",
	rotation = "random",
})
end

-- palm tree
add_schem({"default:sand"}, 0.0025, {"desert_ocean"}, 1, 1, path .. "palmtree.mts", ethereal.desert)
add_schem({"default:sand"}, 0.0025, {"plains_ocean"}, 1, 1, path .. "palmtree.mts", ethereal.plains)
add_schem({"default:sand"}, 0.0025, {"sandclay"}, 1, 1, path .. "palmtree.mts", ethereal.sandclay)
add_schem({"default:sand"}, 0.0025, {"sandstone_ocean"}, 1, 1, path .. "palmtree.mts", ethereal.sandstone)
add_schem({"default:sand"}, 0.0025, {"mesa_ocean"}, 1, 1, path .. "palmtree.mts", ethereal.mesa)
add_schem({"default:sand"}, 0.0025, {"grove_ocean"}, 1, 1, path .. "palmtree.mts", ethereal.grove)
add_schem({"default:sand"}, 0.0025, {"grassy_ocean"}, 1, 1, path .. "palmtree.mts", ethereal.grassy)

-- bamboo tree
add_schem({"ethereal:bamboo_dirt"}, 0.025, {"bamboo"}, 1, 100, ethereal.bambootree, ethereal.bamboo)

-- bush
add_schem({"ethereal:bamboo_dirt"}, 0.08, {"bamboo"}, 1, 100, ethereal.bush, ethereal.bamboo)

--= simple decorations

local add_node = function(a, b, c, d, e, f, g, h, i, j)

	if j ~= 1 then return end

	minetest.register_decoration({
		deco_type = "simple",
		place_on = a,
		sidelen = 80,
		fill_ratio = b,
		biomes = c,
		y_min = d,
		y_max = e,
		decoration = f,
		height_max = g,
		spawn_by = h,
		num_spawn_by = i,
	})
end

-- scorched tree
add_node({"ethereal:dry_dirt"}, 0.006, {"plains"}, 1, 100, {"ethereal:scorched_tree"}, 6, nil, nil, ethereal.plains)

-- dry shrub
add_node({"ethereal:dry_dirt"}, 0.015, {"plains"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.plains)
add_node({"default:sand"}, 0.015, {"grassy_ocean"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.grassy)
add_node({"default:desert_sand"}, 0.015, {"desert"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.desert)
add_node({"default:sandstone"}, 0.015, {"sandstone"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.sandstone)
add_node({"bakedclay:red", "bakedclay:orange"}, 0.015, {"mesa"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.mesa)

-- dry grass
add_node({"default:dirt_with_dry_grass"}, 0.25, {"savannah"}, 1, 100, {"default:dry_grass_2",
	"default:dry_grass_3", "default:dry_grass_4", "default:dry_grass_5"}, nil, nil, nil, ethereal.savannah)

-- flowers & strawberry
add_node({"ethereal:green_dirt"}, 0.025, {"grassy"}, 1, 100, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:green_dirt"}, 0.025, {"grassytwo"}, 1, 100, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7"}, nil, nil, nil, ethereal.grassytwo)

-- prairie flowers & strawberry
add_node({"ethereal:prairie_dirt"}, 0.035, {"prairie"}, 1, 100, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7"}, nil, nil, nil, ethereal.prairie)

-- crystal spike & crystal grass
add_node({"ethereal:crystal_dirt"}, 0.02, {"frost"}, 1, 100, {"ethereal:crystal_spike",
	"ethereal:crystalgrass"}, nil, nil, nil, ethereal.frost)

-- red shrub
add_node({"ethereal:fiery_dirt"}, 0.10, {"fiery"}, 1, 100, {"ethereal:dry_shrub"}, nil, nil, nil, ethereal.fiery)

-- fire flower
--add_node({"ethereal:fiery_dirt"}, 0.02, {"fiery"}, 1, 100, {"ethereal:fire_flower"}, nil, nil, nil, ethereal.fiery)

-- snowy grass
add_node({"ethereal:gray_dirt"}, 0.05, {"grayness"}, 1, 100, {"ethereal:snowygrass"}, nil, nil, nil, ethereal.grayness)
add_node({"ethereal:cold_dirt"}, 0.05, {"snowy"}, 1, 100, {"ethereal:snowygrass"}, nil, nil, nil, ethereal.snowy)

-- cactus
add_node({"default:sandstone"}, 0.0025, {"sandstone"}, 1, 100, {"default:cactus"}, 3, nil, nil, ethereal.sandstone)
add_node({"default:desert_sand"}, 0.005, {"desert"}, 1, 100, {"default:cactus"}, 4, nil, nil, ethereal.desert)

-- wild red mushroom
add_node({"ethereal:mushroom_dirt"}, 0.01, {"mushroom"}, 1, 100, {"flowers:mushroom_fertile_red"}, nil, nil, nil, ethereal.mushroom)

local list = {
	{"junglee", "ethereal:jungle_dirt", ethereal.junglee},
	{"grassy", "ethereal:green_dirt", ethereal.grassy},
	{"grassytwo", "ethereal:green_dirt", ethereal.grassytwo},
	{"prairie", "ethereal:prairie_dirt", ethereal.prairie},
	{"mushroom", "ethereal:mushroom_dirt", ethereal.mushroom}
}

-- wild red and brown mushrooms
for _, row in pairs(list) do

if row[3] == 1 then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {row[2]},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 200, y = 200, z = 200},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {row[1]},
	y_min = 1,
	y_max = 120,
	decoration = {"flowers:mushroom_brown", "flowers:mushroom_red"},
})
end

end

-- jungle grass
add_node({"ethereal:jungle_dirt"}, 0.10, {"junglee"}, 1, 100, {"default:junglegrass"}, nil, nil, nil, ethereal.junglee)
add_node({"ethereal:green_dirt"}, 0.15, {"jumble"}, 1, 100, {"default:junglegrass"}, nil, nil, nil, ethereal.jumble)

-- grass
add_node({"ethereal:green_dirt"}, 0.35, {"grassy"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:green_dirt"}, 0.35, {"grassytwo"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grassytwo)
add_node({"ethereal:green_dirt"}, 0.35, {"jumble"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.jumble)
add_node({"ethereal:jungle_dirt"}, 0.35, {"junglee"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.junglee)
add_node({"ethereal:prairie_dirt"}, 0.35, {"prairie"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.prairie)
add_node({"ethereal:grove_dirt"}, 0.35, {"grove"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grove)
add_node({"ethereal:bamboo_dirt"}, 0.35, {"bamboo"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.bamboo)
add_node({"ethereal:green_dirt"}, 0.25, {"clearing"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4"}, nil, nil, nil, 1)

-- grass on sand
add_node({"default:sand"}, 0.25, {"sandclay"}, 3, 3, {"default:grass_2", "default:grass_3"}, nil, nil, nil, ethereal.sandclay)

-- ferns
add_node({"ethereal:grove_dirt"}, 0.2, {"grove"}, 1, 100, {"ethereal:fern"}, nil, nil, nil, ethereal.grove)


-- snow
add_node({"ethereal:cold_dirt"}, 0.8, {"snowy"}, 4, 40, {"default:snow"}, nil, nil, nil, ethereal.snowy)
add_node({"default:dirt_with_snow"}, 0.8, {"alpine"}, 40, 140, {"default:snow"}, nil, nil, nil, ethereal.alpine)

-- wild onion
add_node({"ethereal:green_dirt"}, 0.25, {"grassy"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:green_dirt"}, 0.25, {"grassytwo"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.grassytwo)
add_node({"ethereal:green_dirt"}, 0.25, {"jumble"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.jumble)
add_node({"ethereal:prairie_dirt"}, 0.25, {"prairie"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.prairie)

-- papyrus
add_node({"ethereal:green_dirt"}, 0.1, {"grassy"}, 1, 1, {"default:papyrus"}, 4, "default:water_source", 1, ethereal.grassy)
add_node({"ethereal:jungle_dirt"}, 0.1, {"junglee"}, 1, 1, {"default:papyrus"}, 4, "default:water_source", 1, ethereal.junglee)

--= Farming Redo plants

if farming and farming.mod and farming.mod == "redo" then

print ("[MOD] Ethereal - Farming Redo detected and in use")

-- potato
add_node({"ethereal:jungle_dirt"}, 0.035, {"junglee"}, 1, 100, {"farming:potato_3"}, nil, nil, nil, ethereal.junglee)

-- carrot, cucumber, potato, tomato, corn, coffee, raspberry, rhubarb
add_node({"ethereal:green_dirt"}, 0.05, {"grassytwo"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4"}, nil, nil, nil, ethereal.grassytwo)
add_node({"ethereal:green_dirt"}, 0.05, {"grassy"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:green_dirt"}, 0.05, {"jumble"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4"}, nil, nil, nil, ethereal.jumble)
add_node({"ethereal:prairie_dirt"}, 0.05, {"prairie"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4"}, nil, nil, nil, ethereal.prairie)

-- melon and pumpkin
add_node({"ethereal:jungle_dirt"}, 0.015, {"junglee"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.junglee)
add_node({"ethereal:green_dirt"}, 0.015, {"grassy"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.grassy)
add_node({"ethereal:green_dirt"}, 0.015, {"grassytwo"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.grassytwo)
add_node({"ethereal:green_dirt"}, 0.015, {"jumble"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.jumble)

-- green beans
add_node({"ethereal:green_dirt"}, 0.035, {"grassytwo"}, 1, 100, {"farming:beanbush"}, nil, nil, nil, ethereal.grassytwo)

-- grape bushel
add_node({"ethereal:green_dirt"}, 0.025, {"grassytwo"}, 1, 100, {"farming:grapebush"}, nil, nil, nil, ethereal.grassytwo)
add_node({"ethereal:green_dirt"}, 0.025, {"grassy"}, 1, 100, {"farming:grapebush"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:prairie_dirt"}, 0.025, {"prairie"}, 1, 100, {"farming:grapebush"}, nil, nil, nil, ethereal.prairie)

end

-- place waterlily in beach areas
local list = {
	{"desert_ocean", ethereal.desert},
	{"plains_ocean", ethereal.plains},
	{"sandclay", ethereal.sandclay},
	{"sandstone_ocean", ethereal.sandstone},
	{"mesa_ocean", ethereal.mesa},
	{"grove_ocean", ethereal.grove},
	{"grassy_ocean", ethereal.grassy},
}

for _, row in pairs(list) do

	if row[2] == 1 then

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 200, y = 200, z = 200},
			seed = 33,
			octaves = 3,
			persist = 0.7
		},
		biomes = {row[1]},
		y_min = 0,
		y_max = 0,
		schematic = ethereal.waterlily,
		rotation = "random",
	})

	end

end

-- Generate Illumishroom in caves next to coal
minetest.register_on_generated(function(minp, maxp)

	if minp.y > -30 or maxp.y < -3000 then
		return
	end

	local bpos
	local coal = minetest.find_nodes_in_area_under_air(minp, maxp, "default:stone_with_coal")

	for n = 1, #coal do

		bpos = {x = coal[n].x, y = coal[n].y + 1, z = coal[n].z }

		if math.random(1, 2) == 1 then

			if bpos.y > -3000 and bpos.y < -2000 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom3"})

			elseif bpos.y > -2000 and bpos.y < -1000 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom2"})

			elseif bpos.y > -1000 and bpos.y < -30 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom"})
			end
		end
	end
end)
