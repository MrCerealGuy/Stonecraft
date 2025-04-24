
-- example ghost spawn

mobs:spawn({name = "mobs_ghost_redo:ghost",
	nodes = {"group:cracky", "group:crumbly"},
	neighbors = {"air"},
	max_light = 4,
	interval = 60,
	chance = 7500,
	active_object_count = 2,
	min_height = -30912,
	day_toggle = false
})
