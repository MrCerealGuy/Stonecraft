
minetest.register_craft({
	output = "homedecor:table",
	recipe = {
		{ "group:wood","group:wood", "group:wood" },
		{ "group:stick", "", "group:stick" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:table_mahogany",
	recipe = {
		"homedecor:table",
		"dye:brown",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:table_mahogany",
	recipe = {
		"homedecor:table",
		"unifieddyes:dark_orange",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:table_white",
	recipe = {
		"homedecor:table",
		"dye:white",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table_mahogany",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table_white",
	burntime = 30,
})

minetest.register_craft({
	output = "homedecor:kitchen_chair_wood 2",
	recipe = {
		{ "group:stick",""},
		{ "group:wood","group:wood" },
		{ "group:stick","group:stick" },
	},
})

minetest.register_craft({
	output = "homedecor:armchair 2",
	recipe = {
	{ "wool:white",""},
	{ "group:wood","group:wood" },
	{ "wool:white","wool:white" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:kitchen_chair_padded",
	recipe = {
		"homedecor:kitchen_chair_wood",
		"wool:white",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:kitchen_chair_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:kitchen_chair_padded",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:armchair",
	burntime = 30,
})

minetest.register_craft({
	output = "homedecor:standing_lamp_off",
	recipe = {
		{"homedecor:table_lamp_off"},
		{"group:stick"},
		{"group:stick"},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table_lamp_off",
	burntime = 10,
})

minetest.register_craft({
	output = "homedecor:table_lamp_off",
	recipe = {
		{ "wool:white", "default:torch", "wool:white"},
		{ "", "group:stick", ""},
		{ "", "stairs:slab_wood", "" },
	},
})

minetest.register_craft({
	output = "homedecor:table_lamp_off",
	recipe = {
		{ "cottages:wool", "default:torch", "cottages:wool"},
		{ "", "group:stick", ""},
		{ "", "stairs:slab_wood", "" },
	},
})

minetest.register_craft({
	output = "homedecor:standing_lamp_off",
	recipe = {
		{ "homedecor:table_lamp_off"},
		{ "group:stick"},
		{ "group:stick"},
	},
})

minetest.register_craft({
	output = "homedecor:toilet",
	recipe = {
		{ "","","bucket:bucket_water"},
		{ "group:marble","group:marble", "group:marble" },
		{ "", "bucket:bucket_empty", "" },
	},
})

minetest.register_craft({
	output = "homedecor:sink",
	recipe = {
		{ "group:marble","bucket:bucket_empty", "group:marble" },
	},
})

minetest.register_craft({
	output = "homedecor:taps",
	recipe = {
		{ "default:steel_ingot","bucket:bucket_water", "default:steel_ingot" },
	},
})

minetest.register_craft({
	output = "homedecor:taps_brass",
	recipe = {
		{ "technic:brass_ingot","bucket:bucket_water", "technic:brass_ingot" },
	},
})

minetest.register_craft({
	output = "homedecor:shower_tray",
	recipe = {
		{ "group:marble","bucket:bucket_water", "group:marble" },
	},
})

minetest.register_craft({
	output = "homedecor:shower_head",
	recipe = {
		{"default:steel_ingot", "bucket:bucket_water"},
	},
})

minetest.register_craft({
	output = "homedecor:bathtub_clawfoot_brass_taps",
	recipe = {
		{ "homedecor:taps_brass", "", "" },
		{ "group:marble", "", "group:marble" },
		{"default:steel_ingot", "group:marble", "default:steel_ingot"},
	},
})

minetest.register_craft({
	output = "homedecor:bathtub_clawfoot_chrome_taps",
	recipe = {
		{ "homedecor:taps", "", "" },
		{ "group:marble", "", "group:marble" },
		{"default:steel_ingot", "group:marble", "default:steel_ingot"},
	},
})

minetest.register_craft({
	output = "homedecor:bars 6",
	recipe = {
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" },
		{ "homedecor:pole_wrought_iron","homedecor:pole_wrought_iron","homedecor:pole_wrought_iron" },
	},
})

minetest.register_craft({
	output = "homedecor:L_binding_bars 3",
	recipe = {
		{ "homedecor:bars","" },
		{ "homedecor:bars","homedecor:bars" },
	},
})

minetest.register_craft({
	output = "homedecor:torch_wall 10",
	recipe = {
		{ "default:coal_lump" },
		{ "default:steel_ingot" },
	},
})
