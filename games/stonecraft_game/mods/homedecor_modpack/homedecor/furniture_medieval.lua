
local S = homedecor_i18n.gettext

homedecor.register("bars", {
	description = S("Bars"),
	tiles = { { name = "homedecor_generic_metal.png^[transformR270", color = homedecor.color_black } },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.50, -0.10, -0.4,  0.50,  0.10 },
			{ -0.1, -0.50, -0.10,  0.1,  0.50,  0.10 },
			{  0.4, -0.50, -0.10,  0.5,  0.50,  0.10 },
			{ -0.5, -0.50, -0.05,  0.5, -0.45,  0.05 },
			{ -0.5,  0.45, -0.05,  0.5,  0.50,  0.05 },
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.1, 0.5, 0.5, 0.1 },
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

--L Binding Bars
homedecor.register("L_binding_bars", {
	description = S("Binding Bars"),
	tiles = { { name = "homedecor_generic_metal.png^[transformR270", color = homedecor.color_black } },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.10, -0.50, -0.50,  0.10,  0.50, -0.40 },
			{ -0.15, -0.50, -0.15,  0.15,  0.50,  0.15 },
			{  0.40, -0.50, -0.10,  0.50,  0.50,  0.10 },
			{  0.00, -0.50, -0.05,  0.50, -0.45,  0.05 },
			{ -0.05, -0.50, -0.50,  0.05, -0.45,  0.00 },
			{  0.00,  0.45, -0.05,  0.50,  0.50,  0.05 },
			{ -0.05,  0.45, -0.50,  0.05,  0.50,  0.00 },
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

local chain_cbox = {
	type = "fixed",
	fixed = {-1/2, -1/2, 1/4, 1/2, 1/2, 1/2},
}

homedecor.register("chains", {
	description = S("Chains"),
	mesh = "forniture_chains.obj",
	tiles = { { name = "homedecor_generic_metal.png", color = homedecor.color_black } },
	inventory_image="forniture_chains_inv.png",
	selection_box = chain_cbox,
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

homedecor.register("torch_wall", {
	description = S("Wall Torch"),
	mesh = "forniture_torch.obj",
	tiles = {
		{
			name="forniture_torch_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=40,
				aspect_h=40,
				length=1.0,
			},
		},
		{ name = "homedecor_generic_metal.png", color = homedecor.color_black },
		{ name = "homedecor_generic_metal.png", color = homedecor.color_med_grey },
		"forniture_coal.png",
	},
	inventory_image="forniture_torch_inv.png",
	walkable = false,
	light_source = 14,
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.45, 0.15, 0.15,0.35, 0.5 },
	},
	groups = {cracky=3},
})

local wl_cbox = {
	type = "fixed",
	fixed = { -0.2, -0.5, 0, 0.2, 0.5, 0.5 },
}

homedecor.register("wall_lamp", {
	description = S("Wall Lamp"),
	mesh = "homedecor_wall_lamp.obj",
	tiles = {
		{ name = "homedecor_generic_metal.png", color = homedecor.color_med_grey },
		homedecor.lux_wood,
		"homedecor_light.png",
		"homedecor_generic_metal_wrought_iron.png"
	},
	use_texture_alpha = true,
	inventory_image = "homedecor_wall_lamp_inv.png",
	groups = {snappy=3},
	light_source = 11,
	selection_box = wl_cbox,
	walkable = false
})

minetest.register_alias("3dforniture:bars", "homedecor:bars")
minetest.register_alias("3dforniture:L_binding_bars", "homedecor:L_binding_bars")
minetest.register_alias("3dforniture:chains", "homedecor:chains")
minetest.register_alias("3dforniture:torch_wall", "homedecor:torch_wall")

minetest.register_alias('bars', 'homedecor:bars')
minetest.register_alias('binding_bars', 'homedecor:L_binding_bars')
minetest.register_alias('chains', 'homedecor:chains')
minetest.register_alias('torch_wall', 'homedecor:torch_wall')
