
if minetest.get_modpath("lucky_block") then

	lucky_block:add_blocks({
		{"spw", "mobs:dungeon_master", 1, nil, nil, 3, "Billy"},
		{"spw", "mobs:sand_monster", 3},
		{"spw", "mobs:stone_monster", 3, nil, nil, 3, "Bob"},
		{"spw", "mobs:dirt_monster", 3},
		{"spw", "mobs:tree_monster", 3},
		{"spw", "mobs:oerkki", 3},
		{"exp"},
		{"spw", "mobs:spider", 5},
		{"spw", "mobs:mese_monster", 2},
		{"spw", "mobs:lava_flan", 3},
		{"nod", "default:chest", 0, {
			{name = "mobs:lava_orb", max = 1}}},
	})

end
