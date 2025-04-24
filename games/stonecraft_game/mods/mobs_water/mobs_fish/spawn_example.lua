
-- Fish spawn examples

mobs:spawn({
	name = "mobs_fish:clownfish",
	nodes = {"group:water"},
	neighbors =  {"group:crumbly", "group:seaplants", "group:seacoral"},
	min_light = 5,
	interval = 30,
	chance = 10000,
	max_height = -1,
	active_object_count = 5
})

mobs:spawn({
	name = "mobs_fish:tropical",
	nodes = {"group:water"},
	neighbors =  {"group:crumbly", "group:seaplants", "group:seacoral"},
	min_light = 5,
	interval = 30,
	chance = 10000,
	max_height = -1,
	active_object_count = 5
})
