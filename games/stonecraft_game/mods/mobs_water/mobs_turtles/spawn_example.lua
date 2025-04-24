
-- Turtle spawn examples

-- land turtle
mobs:spawn({
	name = "mobs_turtles:turtle",
	nodes = {"group:crumbly"},
	neighbors = {
		"group:crumbly", "default:papyrus", "default:cactus",
		"dryplants:juncus", "dryplants:reedmace"
	},
	min_light = 5,
	interval = 30,
	chance = 30000,
	min_height = 1,
	max_height = 10
})

-- sea turtle
mobs:spawn({
	name = "mobs_turtles:seaturtle",
	nodes = {"group:water"},
	neighbors = {
		"group:water", "group:seaplants", "seawrecks:woodship", "seawrecks:uboot"
	},
	min_light = 5,
	interval = 30,
	chance = 30000,
	max_height = 0
})
