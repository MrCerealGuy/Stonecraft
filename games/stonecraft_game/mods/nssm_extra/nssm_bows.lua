if minetest.get_modpath("bows") then

	bows.register_bow("bow_berinhog",{
		description = "Berinhog Bow",
		texture = "bow_berinhog.png",
		texture_loaded = "bow_berinhog_loaded.png",
		uses = 400,
		level = 16,
		shots = 1,
		craft = {
			{"", "nssm:berinhog_horn", "nssm:web_string"},
			{"group:stick", "", "nssm:web_string"},
			{"", "nssm:berinhog_horn", "nssm:web_string"}
		}
	})

	bows.register_arrow("arrow_ice",{
		description = "Ice Arrow",
		texture = "arrow_ice.png",
		damage = 12,
		craft_count = 4,
		drop_chance = 10,
		craft = {
			{"", "", ""},
			{"nssm:little_ice_tooth", "group:stick", "nssm:duck_feather"},
			{"", "", ""}
		}
	})
end

