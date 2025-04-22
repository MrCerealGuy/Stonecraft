-- support for i18n
local S = minetest.get_translator("pl_sunflowers")

local sunflower_rarity = minetest.settings:get("pl_sunflowers.sunflower_rarity") or 0.005

local box = {
	type="fixed",
	fixed = { { -0.2, -0.5, -0.2, 0.2, 0.5, 0.2 } },
}

local sunflower_drop = "farming:seed_wheat"
if minetest.registered_items["farming:seed_spelt"] then
	sunflower_drop = "farming:seed_spelt"
end

minetest.register_node(":flowers:sunflower", {
	description = S("Sunflower"),
	drawtype = "mesh",
	paramtype = "light",
	paramtype2 = "degrotate",
	inventory_image = "flowers_sunflower_inv.png",
	mesh = "flowers_sunflower.obj",
	tiles = { "flowers_sunflower.png" },
	use_texture_alpha = "clip",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = { dig_immediate=3, flora=1, flammable=3, attached_node=1 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = box,
	collision_box = box,
	drop = {
		max_items = 1,
		items = {
			{items = {sunflower_drop}, rarity = 8},
			{items = {"flowers:sunflower"}},
		}
	}
})

minetest.register_decoration({
	decoration = {
		"flowers:sunflower"
	},
	fill_ratio = sunflower_rarity,
	y_min = 1,
	y_max = 40,
	param2 = 0,
	param2_max = 239,
	place_on = {
		"default:dirt_with_grass"
	},
	deco_type = "simple",
	flags = "all_floors",
})

minetest.register_alias("sunflower:sunflower", "flowers:sunflower")
