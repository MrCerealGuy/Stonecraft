
if minetest.get_modpath("lucky_block") then

	lucky_block:add_blocks({
		{"spw", "mobs:sheep", 5},
		{"spw", "mobs:rat", 5},
		{"dro", {"mobs:rat_cooked"}, 5},
		{"spw", "mobs:bunny", 3},
		{"nod", "mobs:honey_block", 0},
		{"spw", "mobs:pumba", 5},
		{"nod", "mobs:cheeseblock", 0},
		{"spw", "mobs:chicken", 5},
		{"dro", {"mobs:egg"}, 5},
		{"spw", "mobs:cow", 5},
		{"dro", {"mobs:bucket_milk"}, 8},
		{"spw", "mobs:kitten", 2},
		{"tro", "default:nyancat", "mobs_kitten", true},
		{"exp"},
	})
	
end
