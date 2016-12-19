
-- banana tree

local ai = {name = "air", param1 = 000}
local tr = {name = "ethereal:banana_trunk", param1 = 255}
local lp = {name = "ethereal:bananaleaves", param1 = 255}
local lr = {name = "ethereal:bananaleaves", param1 = 180}
local bp = {name = "ethereal:banana", param1 = 255}
local br = {name = "ethereal:banana", param1 = 070}

ethereal.bananatree = {

	size = {x = 7, y = 8, z = 7},

	data = {

		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, lr, ai, ai, ai,
		ai, ai, ai, lp, ai, ai, ai,

		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, br, ai, ai, ai,
		ai, ai, ai, bp, ai, ai, ai,
		ai, ai, ai, lp, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,

		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, br, tr, br, ai, ai,
		ai, ai, bp, lp, bp, ai, ai,
		ai, lp, lp, lp, lp, lp, ai,
		lp, lr, ai, lp, ai, lr, lp,

		ai, ai, ai, tr, ai, ai, ai,
		ai, ai, ai, tr, ai, ai, ai,
		ai, ai, ai, tr, ai, ai, ai,
		ai, ai, ai, tr, ai, ai, ai,
		ai, ai, ai, br, ai, ai, ai,
		ai, ai, ai, bp, ai, ai, ai,
		ai, ai, ai, lp, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,

		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, lp, ai, ai, ai,
		ai, ai, ai, lr, ai, ai, ai,

		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, lp, ai, ai, ai,

		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 1, prob = 127},
	},
}
