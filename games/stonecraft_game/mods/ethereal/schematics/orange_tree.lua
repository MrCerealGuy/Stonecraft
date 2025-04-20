
local _ = {name = "air", param1 = 0}
local L = {name = "ethereal:orange_leaves", param1 = 255}
local l = {name = "ethereal:orange_leaves", param1 = 200}
local t = {name = "default:tree", param1 = 255}
local T = {name = "default:tree", param1 = 255, force_place = true}
local o = {name = "ethereal:orange", param1 = 200}

ethereal.orangetree = {

	size = {x = 5, y = 6, z = 5},

	data = {

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	_,_,L,_,_,
	_,_,L,_,_,
	_,_,_,_,_,

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	_,o,L,o,_,
	_,L,L,L,_,
	_,_,L,_,_,

	_,_,T,_,_,
	_,_,T,_,_,
	_,_,T,_,_,
	L,L,t,L,L,
	L,T,L,T,L,
	_,L,L,L,_,

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	_,o,L,o,_,
	_,L,L,L,_,
	_,_,L,_,_,

	_,_,_,_,_,
	_,_,_,_,_,
	_,_,_,_,_,
	_,_,L,_,_,
	_,_,L,_,_,
	_,_,_,_,_,

	}
}
