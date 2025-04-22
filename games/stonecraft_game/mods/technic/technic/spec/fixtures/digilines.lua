-- Simple digilines mod fixture that logs sent messages, works with some simple digiline mods

mineunit:set_modpath("digilines", "spec/fixtures")

digilines = {
	_msg_log = {},
	receptor_send = function(pos, rules, channel, msg)
		table.insert(digilines._msg_log, {
			pos = pos,
			rules = rules,
			channel = channel,
			msg = msg,
		})
	end,
	rules = {
		default = {
			{x=0,  y=0,  z=-1},
			{x=1,  y=0,  z=0},
			{x=-1, y=0,  z=0},
			{x=0,  y=0,  z=1},
			{x=1,  y=1,  z=0},
			{x=1,  y=-1, z=0},
			{x=-1, y=1,  z=0},
			{x=-1, y=-1, z=0},
			{x=0,  y=1,  z=1},
			{x=0,  y=-1, z=1},
			{x=0,  y=1,  z=-1},
			{x=0,  y=-1, z=-1}
		}
	}
}

digilines = setmetatable(digilines, {
	__call = function(self,...) return self end,
	__index = function(...) return function(...)end end,
})
