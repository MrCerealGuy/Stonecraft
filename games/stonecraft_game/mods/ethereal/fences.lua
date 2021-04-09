
local S = ethereal.intllib

default.register_fence("ethereal:fence_scorched", {
	description = S("Scorched Fence"),
	texture = "scorched_tree.png",
	material = "ethereal:scorched_tree",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_frostwood", {
	description = S("Frost Fence"),
	texture = "frost_wood.png",
	material = "ethereal:frost_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_redwood", {
	description = S("Redwood Fence"),
	texture = "redwood_wood.png",
	material = "ethereal:redwood_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_willow", {
	description = S("Willow Fence"),
	texture = "willow_wood.png",
	material = "ethereal:willow_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_yellowwood", {
	description = S("Healing Wood Fence"),
	texture = "yellow_wood.png",
	material = "ethereal:yellow_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_palm", {
	description = S("Palm Fence"),
	texture = "moretrees_palm_wood.png",
	material = "ethereal:palm_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_banana", {
	description = S("Banana Wood Fence"),
	texture = "banana_wood.png",
	material = "ethereal:banana_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_mushroom", {
	description = S("Mushroom Fence"),
	texture = "mushroom_trunk.png",
	material = "ethereal:mushroom_trunk",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_birch", {
	description = S("Birch Fence"),
	texture = "moretrees_birch_wood.png",
	material = "ethereal:birch_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

default.register_fence("ethereal:fence_sakura", {
	description = S("Sakura Fence"),
	texture = "ethereal_sakura_wood.png",
	material = "ethereal:sakura_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

-- fence rails

if default.register_fence_rail then

default.register_fence_rail("ethereal:fence_rail_scorched", {
	description = S("Scorched Fence Rail"),
	texture = "scorched_tree.png",
	material = "ethereal:scorched_tree",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_frostwood", {
	description = S("Frost Fence Rail"),
	texture = "frost_wood.png",
	material = "ethereal:frost_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_redwood", {
	description = S("Redwood Fence Rail"),
	texture = "redwood_wood.png",
	material = "ethereal:redwood_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_willow", {
	description = S("Willow Fence Rail"),
	texture = "willow_wood.png",
	material = "ethereal:willow_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_yellowwood", {
	description = S("Healing Wood Fence Rail"),
	texture = "yellow_wood.png",
	material = "ethereal:yellow_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_palm", {
	description = S("Palm Fence Rail"),
	texture = "moretrees_palm_wood.png",
	material = "ethereal:palm_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_banana", {
	description = S("Banana Wood Fence Rail"),
	texture = "banana_wood.png",
	material = "ethereal:banana_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_mushroom", {
	description = S("Mushroom Fence Rail"),
	texture = "mushroom_trunk.png",
	material = "ethereal:mushroom_trunk",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_birch", {
	description = S("Birch Fence Rail"),
	texture = "moretrees_birch_wood.png",
	material = "ethereal:birch_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("ethereal:fence_rail_sakura", {
	description = S("Sakura Fence Rail"),
	texture = "ethereal_sakura_wood.png",
	material = "ethereal:sakura_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

end
