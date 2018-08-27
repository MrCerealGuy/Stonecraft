minetest.register_craft({
	output = 'currency:safe',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:mese_crystal', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'currency:shop',
	recipe = {
		{'default:sign_wall'},
		{'default:chest_locked'},
	}
})

minetest.register_craft({
	output = 'currency:barter',
	recipe = {
		{'default:sign_wall'},
		{'default:chest'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_5",
	recipe = {"currency:minegeld", "currency:minegeld", "currency:minegeld", "currency:minegeld", "currency:minegeld"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_10",
	recipe = {"currency:minegeld_5", "currency:minegeld_5"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_5 2",
	recipe = {"currency:minegeld_10"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld 5",
	recipe = {"currency:minegeld_5"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_10 5",
	recipe = {"currency:minegeld_50"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_50",
	recipe = {"currency:minegeld_10", "currency:minegeld_10", "currency:minegeld_10", "currency:minegeld_10", "currency:minegeld_10"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_bundle",
	recipe = {
		"group:minegeld",
		"group:minegeld",
		"group:minegeld",
		"group:minegeld",
		"group:minegeld",
		"group:minegeld",
		"group:minegeld",
		"group:minegeld",
		"group:minegeld"
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "currency:minegeld_bundle",
	burntime = 1,
})

