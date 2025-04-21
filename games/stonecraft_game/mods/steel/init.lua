local modpath = minetest.get_modpath("steel")

dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/crafts.lua")

minetest.register_abm({
	label = "rest steel blocks near water",
	nodenames = {"steel:plate_soft"},
	neighbors = {"group:water"},
	interval = 50,
	chance = 20,
	action = function(pos)
		if minetest.find_node_near(pos, 2, "air") then
			minetest.set_node(pos, {name="steel:plate_rusted"})
		end
	end,
})
