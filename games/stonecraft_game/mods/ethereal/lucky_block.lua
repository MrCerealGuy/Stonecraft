
-- add lucky blocks

if minetest.get_modpath("lucky_block") then

local epath = minetest.get_modpath("ethereal") .. "/schematics/"

lucky_block:add_schematics({
	{"pinetree", epath .. "pinetree.mts", {x = 3, y = 0, z = 3}},
	{"palmtree", epath .. "palmtree.mts", {x = 4, y = 0, z = 4}},
	{"bananatree", ethereal.bananatree, {x = 3, y = 0, z = 3}},
	{"orangetree", ethereal.orangetree, {x = 1, y = 0, z = 1}},
	{"birchtree", ethereal.birchtree, {x = 2, y = 0, z = 2}},
})

lucky_block:add_blocks({
	{"nod", "ethereal:crystal_spike", 1},
	{"sch", "pinetree", 0, false},
	{"dro", {"ethereal:orange"}, 10},
	{"sch", "appletree", 0, false},
	{"dro", {"ethereal:strawberry"}, 10},
	{"sch", "bananatree", 0, false},
	{"sch", "orangetree", 0, false},
	{"dro", {"ethereal:banana"}, 10},
	{"sch", "acaciatree", 0, false},
	{"dro", {"ethereal:golden_apple"}, 3},
	{"sch", "palmtree", 0, false},
	{"dro", {"ethereal:tree_sapling", "ethereal:orange_tree_sapling", "ethereal:banana_tree_sapling"}, 10},
	{"dro", {"ethereal:green_dirt", "ethereal:prairie_dirt", "ethereal:grove_dirt", "ethereal:cold_dirt"}, 10},
	{"dro", {"ethereal:axe_crystal"}, 1},
	{"nod", "ethereal:fire_flower", 1},
	{"dro", {"ethereal:sword_crystal"}, 1},
	{"dro", {"ethereal:pick_crystal"}, 1},
	{"sch", "birchtree", 0, false},
	{"dro", {"ethereal:fish_raw"}, 1},
	{"dro", {"ethereal:shovel_crystal"}, 1},
	{"dro", {"ethereal:fishing_rod_baited"}, 1},
	{"exp"},
	{"dro", {"ethereal:fire_dust"}, 2},
})

if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:helmet_crystal"}, 1},
	{"dro", {"3d_armor:chestplate_crystal"}, 1},
	{"dro", {"3d_armor:leggings_crystal"}, 1},
	{"dro", {"3d_armor:boots_crystal"}, 1},
	{"lig"},
})
end

if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_crystal"}, 1},
	{"exp"},
})
end

end -- END IF
