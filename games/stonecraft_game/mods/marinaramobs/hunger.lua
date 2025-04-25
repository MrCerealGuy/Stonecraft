if minetest.get_modpath("hunger_ng") ~= nil then
	hunger_ng.add_hunger_data('marinaramobs:octopus_cooked', {
		satiates = 1.0,
	})
	hunger_ng.add_hunger_data('marinaramobs:octopus_raw', {
		satiates = 3.0,
})
	hunger_ng.add_hunger_data('marinaramobs:raw_exotic_fish', {
		satiates = 1.0,
	})
	hunger_ng.add_hunger_data('marinaramobs:cooked_exotic_fish', {
		satiates = 4.0,
})
	hunger_ng.add_hunger_data('marinaramobs:seaurchin_cooked', {
		satiates = 1.0,
	})
end