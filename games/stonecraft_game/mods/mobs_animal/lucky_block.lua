
-- add lucky blocks

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
	{"dro", {"mobs:bucket_milk", "bucket:bucket_water"}, 8},
	{"spw", "mobs:kitten", 2},
	{"exp"},
	{"dro", {"mobs:hairball"}, 3},
	{"dro", {"mobs:chicken_raw", "mobs:chicken_cooked"}, 10},
	{"dro", {"mobs:pork_raw", "mobs:pork_cooked"}, 10},
	{"dro", {"mobs:mutton_raw", "mobs:mutton_cooked"}, 10},
	{"dro", {"mobs:meat_raw", "mobs:meat"}, 10},
	{"dro", {"mobs:glass_milk"}, 5}
})

-- if nyancat found add special block

if minetest.registered_nodes["default:nyancat"] then

	lucky_block:add_blocks({
		{"tro", "default:nyancat", "mobs_kitten", true}
	})
end
