
local _ = {name = "air", param1 = 000}
local t = {name = "ethereal:mushroom_trunk", param1 = 255}
local T = {name = "ethereal:mushroom_trunk", param1 = 255, force_place = true}
local M = {name = "ethereal:mushroom_brown", param1 = 255}
local P = {name = "ethereal:mushroom_pore", param1 = 255}
local l = {name = "ethereal:lightstring", param1 = 255, param2 = 10}

ethereal.mushroomtwo = {

	size = {x = 3, y = 11, z = 3},

	yslice_prob = {
		{ypos = 3, prob = 127},
		{ypos = 4, prob = 127},
		{ypos = 5, prob = 127},
		{ypos = 6, prob = 127},
		{ypos = 8, prob = 127},
	},

	data = {

	_,_,_,
	_,_,_,
	_,l,_,
	_,l,_,
	_,l,_,
	_,l,_,
	M,M,M,
	M,M,M,
	M,M,M,
	M,M,M,
	_,M,_,

	_,T,_,
	_,T,_,
	_,T,_,
	_,t,_,
	_,t,_,
	_,t,_,
	M,t,M,
	M,t,M,
	M,P,M,
	M,P,M,
	M,M,M,

	_,_,_,
	_,_,_,
	_,_,_,
	_,_,_,
	_,_,_,
	_,_,_,
	M,M,M,
	M,M,M,
	M,M,M,
	M,M,M,
	_,M,_,

	}
}
