
-- add lucky blocks

if minetest.get_modpath("lucky_block") then

	lucky_block:add_blocks({
		{"dro", {"farming:corn"}, 5},
		{"dro", {"farming:coffee_cup_hot"}, 1},
		{"dro", {"farming:bread"}, 5},
		{"nod", "farming:jackolantern", 0},
		{"tro", "farming:jackolantern_on"},
		{"nod", "default:river_water_source", 1},
		{"tel"},
		{"dro", {"farming:trellis", "farming:grapes"}, 5},
		{"dro", {"farming:bottle_ethanol"}, 1},
		{"nod", "farming:melon", 0},
		{"dro", {"farming:donut", "farming:donut_chocolate", "farming:donut_apple"}, 5},
		{"dro", {"farming:hemp_leaf", "farming:hemp_fibre", "farming:seed_hemp"}, 5},
		{"nod", "fire:permanent_flame", 1},
		{"dro", {"farming:chili_pepper", "farming:chili_bowl"}, 5},
		{"dro", {"farming:bowl"}, 3},
		{"dro", {"farming:saucepan"}, 1},
		{"dro", {"farming:pot"}, 1},
		{"dro", {"farming:baking_tray"}, 1},
		{"dro", {"farming:skillet"}, 1},
		{"exp", 4},
		{"dro", {"farming:mortar_pestle"}, 1},
		{"dro", {"farming:cutting_board"}, 1},
		{"dro", {"farming:juicer"}, 1},
		{"dro", {"farming:mixing_bowl"}, 1},
		{"dro", {"farming:hoe_bronze"}, 1},
		{"dro", {"farming:hoe_mese"}, 1},
		{"dro", {"farming:hoe_diamond"}, 1},
		{"dro", {"farming:hoe_bomb"}, 10},
		{"dro", {"farming:turkish_delight"}, 5},
		{"lig"},
	})
end
