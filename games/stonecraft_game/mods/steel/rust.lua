local function moss(input, output)
	minetest.register_abm({
		nodenames = {input},
		neighbors = {"group:water"},
		interval = 50,
		chance = 20,
		action = function(pos)
			if not minetest.find_node_near(pos, 3, output) then
				minetest.add_node(pos, {name=output})
			end
		end,
	})
end

moss("steel:plate_soft",	"steel:plate_rusted")
