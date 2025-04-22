
local _ = {name = "air", param1 = 000}
local S = {name = "default:stone", param1 = 255}
local s = {name = "default:stone", param1 = 127}
local C = {name = "default:cobble", param1 = 255}
local c = {name = "default:cobble", param1 = 127}

ethereal.desertstone_under_spike = {

	size = {x = 3, y = 8, z = 3},

	yslice_prob = {
		{ypos = 3, prob = 127},
		{ypos = 5, prob = 127},
		{ypos = 6, prob = 127},
	},

	data = {

	C,S,C,
	C,S,C,
	_,S,_,
	_,S,_,
	_,C,_,
	_,_,_,
	_,_,_,
	_,_,_,

	S,S,S,
	S,S,S,
	S,S,S,
	_,S,_,
	_,S,_,
	_,S,_,
	_,S,_,
	_,C,_,

	C,S,C,
	C,S,C,
	_,S,_,
	_,S,_,
	_,C,_,
	_,_,_,
	_,_,_,
	_,_,_,

	}
}
