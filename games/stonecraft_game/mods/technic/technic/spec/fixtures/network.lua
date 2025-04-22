
_G.technic = {}
_G.technic.S = string.format
_G.technic.getter = function(...) return "" end
_G.technic.get_or_load_node = minetest.get_node
_G.technic.digilines = {
	rules = {
		-- digilines.rules.default
		{x= 1,y= 0,z= 0},{x=-1,y= 0,z= 0}, -- along x beside
		{x= 0,y= 0,z= 1},{x= 0,y= 0,z=-1}, -- along z beside
		{x= 1,y= 1,z= 0},{x=-1,y= 1,z= 0}, -- 1 node above along x diagonal
		{x= 0,y= 1,z= 1},{x= 0,y= 1,z=-1}, -- 1 node above along z diagonal
		{x= 1,y=-1,z= 0},{x=-1,y=-1,z= 0}, -- 1 node below along x diagonal
		{x= 0,y=-1,z= 1},{x= 0,y=-1,z=-1}, -- 1 node below along z diagonal
		-- added rules for digi cable
		{x =  0, y = -1, z = 0}, -- along y below
	}
}

sourcefile("config")
sourcefile("register")
technic.register_tier("LV", "Busted LV")
technic.register_tier("MV", "Busted MV")
technic.register_tier("HV", "Busted HV")
