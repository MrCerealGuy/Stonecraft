
-- bush

local ai = {name = "air", param1 = 000}
local bp = {name = "ethereal:bush", param1 = 255}
local br = {name = "ethereal:bush", param1 = 100}

ethereal.bush = {

	size = {x = 5, y = 3, z = 5},

	data = {

		br, bp, bp, bp, br,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

		bp, bp, bp, bp, bp,
		ai, br, bp, br, ai,
		ai, ai, ai, ai, ai,

		bp, bp, bp, bp, bp,
		ai, bp, bp, bp, ai,
		ai, ai, br, ai, ai,

		bp, bp, bp, bp, bp,
		ai, br, bp, br, ai,
		ai, ai, ai, ai, ai,

		br, bp, bp, bp, br,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 1, prob = 127},
	},
}
