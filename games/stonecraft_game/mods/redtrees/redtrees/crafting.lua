--Obtain 4 planks
minetest.register_craft({
	output = "redtrees:rwood 4",
	recipe = {
		{"redtrees:rtree"},
	}
})

--Leaves » Dye
minetest.register_craft({
	output = "dye:red 2",
	recipe = {
		{"redtrees:rleaves"},
	}
})

--Leaves » Tree Chilli Powder
minetest.register_craft({
	output = "redtrees:treechillipowder 2",
	recipe = {
		{"redtrees:rleaves","redtrees:rleaves"},
		{"redtrees:rleaves","redtrees:rleaves"}
	}
})

--Tree Chilli Treat
minetest.register_craft({
	type = "shapeless",
	output = "redtrees:treechillitreat",
	recipe = {"redtrees:treechillipowder","farming:flour","redtrees:rleaves"}
})
--Making a luxurious Door with premium materials, the product recites its own recipe
--Some copycats grab normal wood and paint it so it looks premium
minetest.register_craft({
	output = "redtrees:rdoor_wood",
	recipe = {
		{"group:wood", "group:wood","dye:red"},
		{"group:wood", "group:wood","dye:red"},
		{"group:wood", "group:wood","dye:red"}
	}
})

minetest.register_craft({
	output = "redtrees:rdoor_wood",
	recipe = {
		{"dye:red","group:wood", "group:wood"},
		{"dye:red","group:wood", "group:wood"},
		{"dye:red","group:wood", "group:wood"}
	}
})

--Others just grab a finished normal door and paint it
minetest.register_craft({
	type = "shapeless",
	output = "redtrees:rdoor_wood",
	recipe = {"doors:door_wood","dye:red","dye:red","dye:red"},
})

--Bonsai no gendai bijutsu
minetest.register_craft({
	type = "shapeless",
	output = "redtrees:rbonsai",
	recipe = {"redtrees:rsapling","redtrees:rsapling","redtrees:rsapling"},
})

--"Huhuhuh" -The Pyro (TF2)
minetest.register_craft({
	type = "fuel",
	recipe = "redtrees:rtree",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "redtrees:rsapling",
	burntime = 45,
})

minetest.register_craft({
	type = "fuel",
	recipe = "redtrees:rleaves",
	burntime = 25,
})
