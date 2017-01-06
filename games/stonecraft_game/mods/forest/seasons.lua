register_season("flowers:rose", {
	type = "disappear",
	start = 8.00,
	stop = 2.50,
	speed = 6,
})

register_season("flowers:rose", {
	type = "appear",
	start = 4.90,
	stop = 10.50,
	speed = 8,
})

register_season("flowers:viola", {
	type = "disappear",
	start = 4.00,
	stop = 3.00,
	speed = 20,
})

register_season("flowers:viola", {
	type = "appear",
	start = 3.00,
	stop = 4.30,
	speed = 25,
})

register_season("flowers:dandelion_white", {
	type = "disappear",
	start = 5.50,
	stop = 1.30,
	speed = 7,
})

register_season("flowers:dandelion_white", {
	type = "appear",
	start = 2.90,
	stop = 4.60,
	speed = 15,
})

register_season("flowers:dandelion_yellow", {
	type = "transforms",
	start = 4.00,
	stop = 8.00,
	speed = 5,
	new_node = {name = "flowers:dandelion_yellow"},
})

register_season("flowers:geranium", {
	type = "disappear",
	start = 9.80,
	stop = 6.50,
	speed = 6,
})

register_season("flowers:geranium", {
	type = "disappear",
	start = 5.00,
	stop = 9.80,
	speed = 1.5,
})

register_season("flowers:geranium", {
	type = "appear",
	start = 5.00,
	stop = 9.20,
	speed = 7.5,
})

register_season("flowers:tulip", {
	type = "disappear",
	start = 5.00,
	stop = 3.00,
	speed = 20,
})

register_season("flowers:tulip", {
	type = "appear",
	start = 4.10,
	stop = 5.00,
	speed = 18,
})

register_season("default:grass_1", {
	type = "transforms",
	start = 3.00,
	stop = 9.00,
	speed = 5,
	new_node = {name = "default:grass_2"},
})

register_season("default:grass_2", {
	type = "transforms",
	start = 3.75,
	stop = 9.00,
	speed = 5,
	new_node = {name = "default:grass_3"},
})

register_season("default:grass_3", {
	type = "transforms",
	start = 4.50,
	stop = 9.00,
	speed = 5,
	new_node = {name = "default:grass_4"},
})

register_season("default:grass_4", {
	type = "transforms",
	start = 5.25,
	stop = 9.00,
	speed = 5,
	new_node = {name = "default:grass_5"},
})

register_season("default:grass_5", {
	type = "transforms",
	start = 9.00,
	stop = 11.00,
	speed = 7,
	new_node = {name = "default:grass_4"},
})

register_season("default:grass_4", {
	type = "transforms",
	start = 9.00,
	stop = 11.00,
	speed = 7,
	new_node = {name = "default:grass_3"},
})

register_season("default:grass_3", {
	type = "transforms",
	start = 9.00,
	stop = 11.00,
	speed = 7,
	new_node = {name = "default:grass_2"},
})

register_season("default:grass_2", {
	type = "transforms",
	start = 9.00,
	stop = 11.00,
	speed = 7,
	new_node = {name = "default:grass_1"},
})
