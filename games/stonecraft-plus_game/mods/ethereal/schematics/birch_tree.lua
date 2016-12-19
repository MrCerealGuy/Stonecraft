
-- birch tree

local ai = {name = "air", param1 = 000}
local tr = {name = "ethereal:birch_trunk", param1 = 255}
local lp = {name = "ethereal:birch_leaves", param1 = 255}
local lr = {name = "ethereal:birch_leaves", param1 = 150}

ethereal.birchtree = {

	size = {x = 5, y = 7, z = 5},

	data = {

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lr, lp, lp, lp, lr,
		lr, lp, lp, lp, lr,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lp, lp, lp, lp, lp,
		lp, lp, lp, lp, lp,
		ai, lr, lp, lr, ai,
		ai, ai, lp, ai, ai,

		ai, ai, tr, ai, ai,
		ai, ai, tr, ai, ai,
		ai, ai, tr, ai, ai,
		lp, lp, tr, lp, lp,
		lp, lp, tr, lp, lp,
		ai, lp, tr, lp, ai,
		ai, lp, lp, lp, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lp, lp, lp, lp, lp,
		lp, lp, lp, lp, lp,
		ai, lr, lp, lr, ai,
		ai, ai, lp, ai, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lr, lp, lp, lp, lr,
		lr, lp, lp, lp, lr,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 1, prob = 127}
	},
}
