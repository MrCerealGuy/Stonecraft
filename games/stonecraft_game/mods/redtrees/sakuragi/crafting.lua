--Obtain 4 planks
minetest.register_craft({
	output = "sakuragi:swood 4",
	recipe = {
		{"sakuragi:stree"},
	}
})

--Leaves » Dye
minetest.register_craft({
	output = "dye:pink 2",
	recipe = {
		{"sakuragi:sleaves"},
	}
})

minetest.register_craft({
	output = "sakuragi:tobira",
	recipe = {
		{"default:paper",  "default:stick"},
		{"default:stick",  "default:paper"},
		{"sakuragi:stree", "sakuragi:stree"}
	}
})

--"Huhuhuh" -The Pyro (TF2)
minetest.register_craft({
	type = "fuel",
	recipe = "sakuragi:stree",
	burntime = 250,
})

minetest.register_craft({
	type = "fuel",
	recipe = "sakuragi:ssapling",
	burntime = 35,
})

minetest.register_craft({
	type = "fuel",
	recipe = "sakuragi:sleaves",
	burntime = 15,
})
