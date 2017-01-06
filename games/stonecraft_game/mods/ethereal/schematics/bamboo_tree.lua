
-- bamboo stalk with leaves

local ai = {name = "air", param1 = 000}
local bt = {name = "ethereal:bamboo", param1 = 255}
local lp = {name = "ethereal:bamboo_leaves", param1 = 255}
local lr = {name = "ethereal:bamboo_leaves", param1 = 100}

ethereal.bambootree = {

	size = {x = 3, y = 18, z = 3},

	data = {

		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		lr, lp, lr,
		ai, lp, ai,
		ai, ai, ai,

		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		lr, lp, lr,
		ai, lp, ai,
		ai, lr, ai,

		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		lr, lp, lr,
		ai, lp, ai,
		ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 3, prob = 127},
	},
}

minetest.override_item("default:papyrus", {
	walkable = true,
	sunlight_propagates = true
})
