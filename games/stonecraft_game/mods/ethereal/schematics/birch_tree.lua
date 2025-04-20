
local _ = {name = "air", param1 = 0}
local t = {name = "ethereal:birch_trunk", param1 = 255}
local T = {name = "ethereal:birch_trunk", param1 = 255, force_place = true}
local L = {name = "ethereal:birch_leaves", param1 = 255}
local l = {name = "ethereal:birch_leaves", param1 = 150}

ethereal.birchtree = {

	size = {x = 5, y = 7, z = 5},

	yslice_prob = {
		{ypos = 2, prob = 127},
		{ypos = 3, prob = 127}
	},

	data = {

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	l,L,L,L,l,
	l,L,L,L,l,
	_,_,_,_,_,
	_,_,_,_,_,

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	L,L,L,L,L,
	L,L,L,L,L,
	_,l,L,l,_,
	_,_,L,_,_,

	_,_,T,_,_,
	_,_,T,_,_,
	_,_,T,_,_,
	L,L,T,L,L,
	L,L,t,L,L,
	_,L,t,L,_,
	_,L,L,L,_,

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	L,L,L,L,L,
	L,L,L,L,L,
	_,l,L,l,_,
	_,_,L,_,_,

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	l,L,L,L,l,
	l,L,L,L,l,
	_,_,_,_,_,
	_,_,_,_,_,

	}
}
