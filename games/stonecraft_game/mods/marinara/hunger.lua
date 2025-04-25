if minetest.get_modpath("hunger_ng") ~= nil then
	hunger_ng.add_hunger_data('marinara:raw_oisters', {
		satiates = 2.0,
	})
	hunger_ng.add_hunger_data('marinara:mussels_cooked', {
		satiates = 5.0,
})
end