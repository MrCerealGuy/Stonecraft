local S = minetest.get_translator("livingcaves")

local modname = "livingcaves"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- ground nodes

minetest.register_node("livingcaves:mossycaverock", {
	description = S("Mossy Cave Rock"),
	tiles = {"livingcaves_mossycaverock.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:mossycaverock",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:lichycaverock", {
	description = S("Lichen infested Cave Rock"),
	tiles = {"livingcaves_lichyrock.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:lichycaverock",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:mushcave_bottom", {
	description = S("Mushroom Infested Rock"),
	tiles = {"livingcaves_mushcave_bottom.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:mushcave_bottom",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:mushcave_bottom2", {
	description = S("Mushroom Infested Rock"),
	tiles = {"livingcaves_mushcave_bottom2.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:mushcave_bottom2",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:dripstonecave_bottom", {
	description = S("Dripstone Cave Stone"),
	tiles = {"livingcaves_dripstonecave_bottom.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:dripstonecave_bottom",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:dripstonecave_bottom2", {
	description = S("Dripstone Cave Stone"),
	tiles = {"livingcaves_dripstonecave_bottom2.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:dripstonecave_bottom2",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_bottom", {
	description = S("Bacteria Infested Rock"),
	tiles = {"livingcaves_bacteriacave_bottom.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:bacteriacave_bottom",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_bottom2", {
	description = S("Bacteria Infested Rock"),
	tiles = {"livingcaves_bacteriacave_bottom2.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:bacteriacave_bottom2",
        light_source = 4,
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:rootdirt", {
	description = S("Dirt With Roots"),
	tiles = {"livingcaves_rootdirt.png"},
	groups = {crumbly = 3, soil = 1,},
	drop = "livingcaves:rootdirt",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:rootdirt2", {
	description = S("Dirt With Roots"),
	tiles = {"livingcaves_rootdirt2.png"},
	groups = {crumbly = 3, soil = 1,},
	drop = "livingcaves:rootdirt2",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:icecave_ice", {
	description = S("Cave Ice"),
	tiles = {"livingcaves_icecave_ice.png"},
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	drop = "livingcaves:icecave_ice",
	legacy_mineral = true,
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("livingcaves:icecave_ice2", {
	description = S("Cave Ice"),
	tiles = {"livingcaves_icecave_ice2.png"},
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	drop = "livingcaves:icecave_ice2",
	legacy_mineral = true,
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_trapstone", {
	description = S("Flesh Eating Bacteria Trapstone"),
	tiles = {"livingcaves_bacteriacave_trapstone.png"},
	groups = {choppy = 3, wood = 1},
	drop = "livingcaves:bacteriacave_trapstone",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_trapnode", {
	description = S("Flesh Eating Bacteria Trap"),
	tiles = {"livingcaves_bacteriacave_bottom.png"},
	groups = {choppy = 3, wood = 1},
	walkable = false,
	drop = "livingcaves:bacteriacave_trapnode",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_poolstone", {
	description = S("Bacteria Poolstone"),
	tiles = {"livingcaves_bacteriacave_poolstone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingcaves:bacteriacave_poolstone",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_nestfoot", {
	description = S("Bacteria Nest Foot"),
	tiles = {"livingcaves_bacteriacave_nestfoot.png"},
	groups = {choppy = 3, stone = 1},
	drop = "livingcaves:bacteriacave_nestfoot",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("livingcaves:bacteriacave_nest", {
	description = S("Bacteria Nest Core"),
tiles = {
		{
			name = "livingcaves_bacteriacave_nest.png",
			animation = {type="vertical_frames", length = 4}
		}
	},
	groups = {choppy = 3, stone = 1},
        light_source = 7,
	drop = "livingcaves:bacteriacave_nest",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    flags = "force_placement,all_floors",
    y_max = -30,
    y_min = -90,
    decoration = "livingcaves:mushcave_bottom"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    flags = "force_placement,all_ceilings",
    y_max = -30,
    y_min = -90,
    decoration = "livingcaves:mushcave_bottom2"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    flags = "force_placement,all_floors",
    y_max = -90,
    y_min = -200,
    decoration = "livingcaves:dripstonecave_bottom"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    flags = "force_placement,all_ceilings",
    y_max = -90,
    y_min = -200,
    decoration = "livingcaves:dripstonecave_bottom2"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    flags = "force_placement,all_floors",
    y_max = -200,
    y_min = -400,
    decoration = "livingcaves:bacteriacave_bottom"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    flags = "force_placement,all_ceilings",
    y_max = -200,
    y_min = -400,
    decoration = "livingcaves:bacteriacave_bottom2"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    biomes = {"snowy_grassland", "icesheet_under", "icesheet", "snowy_grassland_under", "tundra_highland", "tundra_beach", "tundra_under", "taiga", "taiga_under", "livingfloatlands:coldsteppe"},
    flags = "force_placement,all_floors",
    y_max = -1,
    y_min = -30,
    decoration = "livingcaves:icecave_ice"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 8,
    biomes = {"snowy_grassland", "icesheet_under", "icesheet", "snowy_grassland_under", "tundra_highland", "tundra_beach", "tundra_under", "taiga", "taiga_under", "livingfloatlands:coldsteppe"},
    flags = "force_placement,all_ceilings",
    y_max = -1,
    y_min = -30,
    decoration = "livingcaves:icecave_ice2"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 2,
    biomes = {"coniferous_forest_under", "coniferous_forest", "deciduous_forest_under", "deciduous_forest", "savanna", "savanna_under", "rainforest", "rainforest_swamp", "rainforest_under", "naturalbiomes:alpine", "naturalbiomes:mediterranean", "naturalbiomes:wetsavanna", "livingjungle:jungle", "livingfloatlands:coldgiantforest", "livingfloatlands:giantforest", "livingfloatlands:paleojungle"},
    flags = "force_placement,all_ceilings",
    y_max = -1,
    y_min = -30,
    decoration = "livingcaves:rootdirt"

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:stone"},
    is_ground_content = true,
    sidelen = 16,
    place_offset_y = -1,
    fill_ratio = 2,
    biomes = {"coniferous_forest_under", "coniferous_forest", "deciduous_forest_under", "deciduous_forest", "savanna", "savanna_under", "rainforest", "rainforest_swamp", "rainforest_under", "naturalbiomes:alpine", "naturalbiomes:mediterranean", "naturalbiomes:wetsavanna", "livingjungle:jungle", "livingfloatlands:coldgiantforest", "livingfloatlands:giantforest", "livingfloatlands:paleojungle"},
    flags = "force_placement,all_ceilings",
    y_max = -1,
    y_min = -30,
    decoration = "livingcaves:rootdirt2"

})

minetest.register_node("livingcaves:spiderweb", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet.png"},
	drop = "livingcaves:spiderweb",
        drawtype = "plantlike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb",
	liquid_alternative_source = "livingcaves:spiderweb",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb2", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet2.png"},
	drop = "livingcaves:spiderweb2",
        drawtype = "plantlike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb2",
	liquid_alternative_source = "livingcaves:spiderweb2",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb3", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet3.png"},
	drop = "livingcaves:spiderweb3",
        drawtype = "plantlike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb3",
	liquid_alternative_source = "livingcaves:spiderweb3",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb4", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet4.png"},
	drop = "livingcaves:spiderweb4",
        drawtype = "plantlike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb4",
	liquid_alternative_source = "livingcaves:spiderweb4",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb5", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet5.png"},
	drop = "livingcaves:spiderweb5",
        drawtype = "plantlike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb5",
	liquid_alternative_source = "livingcaves:spiderweb5",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb6", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet6.png"},
	drop = "livingcaves:spiderweb6",
        drawtype = "plantlike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb6",
	liquid_alternative_source = "livingcaves:spiderweb6",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb7", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet7.png"},
	drop = "livingcaves:spiderweb7",
        drawtype = "raillike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb7",
	liquid_alternative_source = "livingcaves:spiderweb7",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb8", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet8.png"},
	drop = "livingcaves:spiderweb8",
        drawtype = "raillike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb8",
	liquid_alternative_source = "livingcaves:spiderweb8",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("livingcaves:spiderweb9", {
	description = S("Spider Web"),
	tiles = {"livingcaves_spidernet9.png"},
	drop = "livingcaves:spiderweb9",
        drawtype = "raillike",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "livingcaves:spiderweb9",
	liquid_alternative_source = "livingcaves:spiderweb9",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

