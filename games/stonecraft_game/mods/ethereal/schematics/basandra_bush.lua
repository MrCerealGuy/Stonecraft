
local _ = {name = "air", param1 = 0}
local S = {name = "ethereal:basandra_bush_stem", param1 = 255, force_place = true}
local B = {name = "ethereal:basandra_bush_leaves", param1 = 255}
local b = {name = "ethereal:basandra_bush_leaves", param1 = 100}

ethereal.basandrabush = {

	size = {x = 3, y = 2, z = 3},

	data = {

	b,B,b,
	b,b,b,

	B,S,B,
	b,B,b,

	b,B,b,
	b,b,b,

	}
}
