if minetest.get_modpath("hunger_ng") ~= nil then
	hunger_ng.add_hunger_data('livingcaves:mushroom_edible', {
		satiates = 2.0,
	})
	hunger_ng.add_hunger_data('livingcaves:healingsoup', {
		heals = 20.0, 
		satiates = 3.0,
})
end