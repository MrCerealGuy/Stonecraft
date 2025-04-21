-- Idea by Sokomine
-- Code & textures by Mossmanikin

-- support for i18n
local S = minetest.get_translator("molehills")

local molehill_rarity = minetest.settings:get("molehills.molehill_rarity") or 0.002

-- Node
local mh_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, -0.125, 0.5}
}

minetest.register_node("molehills:molehill",{
	drawtype = "mesh",
	mesh = "molehill_molehill.obj",
	description = S("Mole Hill"),
	inventory_image = "molehills_side.png",
	tiles = { "molehills_dirt.png" },
	use_texture_alpha = "clip",
	paramtype = "light",
	selection_box = mh_cbox,
	collision_box = mh_cbox,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
})

-- Crafting
minetest.register_craft({ -- molehills --> dirt
	output = "default:dirt",
	recipe = {
		{"molehills:molehill","molehills:molehill"},
		{"molehills:molehill","molehills:molehill"},
	}
})

-- Generating
minetest.register_decoration({
	decoration = {
		"molehills:molehill"
	},
	fill_ratio = molehill_rarity,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass"
	},
	spawn_by = "air",
	num_spawn_by = 3,
	deco_type = "simple",
	flags = "all_floors",
})
