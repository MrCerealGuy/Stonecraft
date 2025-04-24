
-- Jellyfish spawn example

mobs:spawn({
	name = "mobs_jellyfish:jellyfish",
	nodes = {"default:water_source"},
	neighbors = {"group:water"},
	min_light = 5,
	interval = 30,
	chance = 10000,
	max_height = 0
})
