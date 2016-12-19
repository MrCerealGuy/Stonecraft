
local S = ethereal.intllib

-- register Ethereal wood type gates

doors.register_fencegate("ethereal:fencegate_scorched", {
	description = S("Scorched Wood Fence Gate"),
	texture = "scorched_tree.png",
	material = "ethereal:scorched_tree",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_frostwood", {
	description = S("Frost Wood Fence Gate"),
	texture = "frost_wood.png",
	material = "ethereal:frost_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_redwood", {
	description = S("Redwood Fence Gate"),
	texture = "redwood_wood.png",
	material = "ethereal:redwood_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_willow", {
	description = S("Willow Wood Fence Gate"),
	texture = "willow_wood.png",
	material = "ethereal:willow_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_yellowwood", {
	description = S("Healing Wood Fence Gate"),
	texture = "yellow_wood.png",
	material = "ethereal:yellow_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_palm", {
	description = S("Palm Wood Fence Gate"),
	texture = "moretrees_palm_wood.png",
	material = "ethereal:palm_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_banana", {
	description = S("Banana Wood Fence Gate"),
	texture = "banana_wood.png",
	material = "ethereal:banana_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_mushroom", {
	description = S("Mushroom Trunk Fence Gate"),
	texture = "mushroom_trunk.png",
	material = "ethereal:mushroom_trunk",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("ethereal:fencegate_birch", {
	description = S("Birch Wood Fence Gate"),
	texture = "moretrees_birch_wood.png",
	material = "ethereal:birch_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- add compatibility for ethereal's to default wooden gates
minetest.register_alias("ethereal:fencegate_wood_open", "doors:gate_wood_open")
minetest.register_alias("ethereal:fencegate_wood_closed", "doors:gate_wood_closed")

minetest.register_alias("ethereal:fencegate_acacia_open", "doors:gate_acacia_wood_open")
minetest.register_alias("ethereal:fencegate_acacia_closed", "doors:gate_acacia_wood_closed")

minetest.register_alias("ethereal:fencegate_junglewood_open", "doors:gate_junglewood_open")
minetest.register_alias("ethereal:fencegate_junglewood_closed", "doors:gate_junglewood_closed")

minetest.register_alias("ethereal:fencegate_pine_open", "doors:gate_pine_wood_open")
minetest.register_alias("ethereal:fencegate_pine_closed", "doors:gate_pine_wood_closed")
