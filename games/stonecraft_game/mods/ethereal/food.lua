
-- translator and mod check

local S = minetest.get_translator("ethereal")
local mod_fredo = minetest.get_modpath("farming")
		and farming and farming.mod and farming.mod == "redo"

-- replacement bowl

local bowl = mod_fredo and "farming:bowl" or "ethereal:bowl"

-- Banana

minetest.register_node("ethereal:banana", {
	description = S("Banana"),
	drawtype = "torchlike",
	tiles = {"ethereal_banana_single.png"},
	inventory_image = "ethereal_banana_single.png",
	wield_image = "ethereal_banana_single.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		food_banana = 1, fleshy = 3, dig_immediate = 3, leafdecay = 1, leafdecay_drop = 1
	},
	drop = "ethereal:banana",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	place_param2 = 1
})

ethereal.add_eatable("ethereal:banana", 2)

-- Banana Bunch

minetest.register_node("ethereal:banana_bunch", {
	description = S("Banana Bunch"),
	drawtype = "torchlike",
	tiles = {"ethereal_banana_bunch.png"},
	inventory_image = "ethereal_banana_bunch.png",
	wield_image = "ethereal_banana_bunch.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, leafdecay = 1, leafdecay_drop = 1
	},
	drop = "ethereal:banana_bunch",
	on_use = minetest.item_eat(6),
	sounds = default.node_sound_leaves_defaults(),
	place_param2 = 1
})

ethereal.add_eatable("ethereal:banana_bunch", 6)

minetest.register_craft({
	output = "ethereal:banana 3",
	recipe = {{"ethereal:banana_bunch"}}
})

minetest.register_craft({
	output = "ethereal:banana_bunch",
	recipe = {{"ethereal:banana", "ethereal:banana", "ethereal:banana"}}
})

-- Banana Dough

minetest.register_craftitem("ethereal:banana_dough", {
	description = S("Banana Dough"),
	inventory_image = "ethereal_banana_dough.png"
})

minetest.register_craft({
	output = "ethereal:banana_dough",
	recipe = {{"group:food_flour", "group:food_banana"}}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 14,
	output = "ethereal:banana_bread",
	recipe = "ethereal:banana_dough"
})

-- Orange

minetest.register_node("ethereal:orange", {
	description = S("Orange"),
	drawtype = "plantlike",
	tiles = {"farming_orange.png"},
	inventory_image = "farming_orange.png",
	wield_image = "farming_orange.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
	},
	groups = {
		food_orange = 1, fleshy = 3, dig_immediate = 3,
		leafdecay = 3, leafdecay_drop = 1
	},
	drop = "ethereal:orange",
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_leaves_defaults(),
	place_param2 = 1
})

ethereal.add_eatable("ethereal:orange", 4)

-- Pine Nuts

minetest.register_craftitem("ethereal:pine_nuts", {
	description = S("Pine Nuts"),
	inventory_image = "ethereal_pine_nuts.png",
	wield_image = "ethereal_pine_nuts.png",
	groups = {food_pine_nuts = 1},
	on_use = minetest.item_eat(1)
})

ethereal.add_eatable("ethereal:pine_nuts", 1)

-- Banana Loaf

minetest.register_craftitem("ethereal:banana_bread", {
	description = S("Banana Loaf"),
	inventory_image = "ethereal_banana_bread.png",
	wield_image = "ethereal_banana_bread.png",
	groups = {food_bread = 1},
	on_use = minetest.item_eat(6)
})

ethereal.add_eatable("ethereal:banana_bread", 6)

-- coconut settings if farming redo found

local fredo = minetest.get_modpath("farming") and farming and farming.mod
		and farming.mod == "redo"

local cdrp = fredo and "ethereal:coconut" or "ethereal:coconut_slice 4"
local cgrp = fredo and {3, 2} or {1, 1}

-- Coconut (drops 4x coconut slice by default, whole coconut if farming redo found)

minetest.register_node("ethereal:coconut", {
	description = S("Coconut"),
	drawtype = "plantlike",
	walkable = false,
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"moretrees_coconut.png"},
	inventory_image = "moretrees_coconut.png",
	wield_image = "moretrees_coconut.png",
	selection_box = {
		type = "fixed", fixed = {-0.31, -0.43, -0.31, 0.31, 0.44, 0.31}
	},
	groups = {
		food_coconut = 1, snappy = cgrp[1], oddly_breakable_by_hand = cgrp[2],
		cracky = cgrp[1], choppy = cgrp[1], flammable = 1,
		leafdecay = 3, leafdecay_drop = 1
	},
	drop = cdrp,
	sounds = default.node_sound_wood_defaults(),
	place_param2 = 1
})

-- Coconut Slice

minetest.register_craftitem("ethereal:coconut_slice", {
	description = S("Coconut Slice"),
	inventory_image = "moretrees_coconut_slice.png",
	wield_image = "moretrees_coconut_slice.png",
	groups = {food_coconut_slice = 1},
	on_use = minetest.item_eat(1)
})

ethereal.add_eatable("ethereal:coconut_slice", 1)

-- coconut slice recipe (farming redo)

if fredo then

	minetest.register_craft({
		output = "ethereal:coconut_slice 4",
		recipe = {{"farming:cutting_board", "ethereal:coconut"}},
		replacements = {{"farming:cutting_board", "farming:cutting_board"}}
	})
end

-- coconut slice into whole coconut

minetest.register_craft({
	output = "ethereal:coconut",
	recipe = {
		{"ethereal:coconut_slice", "ethereal:coconut_slice"},
		{"ethereal:coconut_slice", "ethereal:coconut_slice"}
	}
})

-- Golden Apple

minetest.register_node("ethereal:golden_apple", {
	description = S("Golden Apple"),
	drawtype = "plantlike",
	tiles = {"default_apple_gold.png"},
	inventory_image = "default_apple_gold.png",
	wield_image = "default_apple_gold.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.2, -0.37, -0.2, 0.2, 0.31, 0.2}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, leafdecay = 3,leafdecay_drop = 1, eatable = 2
	},
	drop = "ethereal:golden_apple",
	sounds = default.node_sound_leaves_defaults(),
	place_param2 = 1,

	on_use = function(itemstack, user, pointed_thing)

		if user and pointed_thing and pointed_thing.type ~= "object" then

			user:set_hp(20)

			return minetest.do_item_eat(2, nil, itemstack, user, pointed_thing)
		end
	end
})

-- Hearty Stew

minetest.register_craftitem("ethereal:hearty_stew", {
	description = S("Hearty Stew"),
	inventory_image = "ethereal_hearty_stew.png",
	wield_image = "ethereal_hearty_stew.png",
	on_use = minetest.item_eat(10, bowl)
})

ethereal.add_eatable("ethereal:hearty_stew", 10)

minetest.register_craft({
	output = "ethereal:hearty_stew",
	recipe = {
		{"group:food_onion","flowers:mushroom_brown", "group:food_tuber"},
		{"","flowers:mushroom_brown", ""},
		{"","group:food_bowl", ""}
	}
})

-- Extra recipe for hearty stew

if fredo then

	minetest.register_craft({
		output = "ethereal:hearty_stew",
		recipe = {
			{"group:food_onion","flowers:mushroom_brown", "group:food_beans"},
			{"","flowers:mushroom_brown", ""},
			{"","group:food_bowl", ""}
		}
	})
end

-- Bucket of Cactus Pulp

minetest.register_craftitem("ethereal:bucket_cactus", {
	description = S("Bucket of Cactus Pulp"),
	inventory_image = "bucket_cactus.png",
	wield_image = "bucket_cactus.png",
	stack_max = 1,
	groups = {vessel = 1, drink = 1},
	on_use = minetest.item_eat(2, "bucket:bucket_empty"),
})

ethereal.add_eatable("ethereal:bucket_cactus", 2)

minetest.register_craft({
	output = "ethereal:bucket_cactus",
	recipe = {{"bucket:bucket_empty","default:cactus"}}
})

-- firethorn jelly

minetest.register_craftitem("ethereal:firethorn_jelly", {
	description = S("Firethorn Jelly"),
	inventory_image = "ethereal_firethorn_jelly.png",
	wield_image = "ethereal_firethorn_jelly.png",
	on_use = minetest.item_eat(2, "vessels:glass_bottle"),
	groups = {vessel = 1}
})

ethereal.add_eatable("ethereal:firethorn_jelly", 2)

if fredo then

	minetest.register_craft({
		output = "ethereal:firethorn_jelly",
		recipe = {
			{"farming:mortar_pestle","vessels:glass_bottle", ""},
			{"ethereal:firethorn", "ethereal:firethorn", "ethereal:firethorn"},
			{"bucket:bucket_water", "bucket:bucket_water", "bucket:bucket_water"}
		},
		replacements = {
			{"bucket:bucket_water", "bucket:bucket_empty 3"},
			{"farming:mortar_pestle", "farming:mortar_pestle"}
		}
	})
end

-- Lemon

minetest.register_node("ethereal:lemon", {
	description = S("Lemon"),
	drawtype = "plantlike",
	tiles = {"ethereal_lemon.png"},
	inventory_image = "ethereal_lemon_fruit.png",
	wield_image = "ethereal_lemon_fruit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
	},
	groups = {
		food_lemon = 1, fleshy = 3, dig_immediate = 3, leafdecay = 3, leafdecay_drop = 1
	},
	drop = "ethereal:lemon",
	on_use = minetest.item_eat(3),
	sounds = default.node_sound_leaves_defaults(),
	place_param2 = 1
})

ethereal.add_eatable("ethereal:lemon", 3)

-- Candied Lemon

minetest.register_craftitem("ethereal:candied_lemon", {
	description = S("Candied Lemon"),
	inventory_image = "ethereal_candied_lemon.png",
	wield_image = "ethereal_candied_lemon.png",
	groups = {food_candied_lemon = 1},
	on_use = minetest.item_eat(5)
})

ethereal.add_eatable("ethereal:candied_lemon", 5)

minetest.register_craft({
	output = "ethereal:candied_lemon",
	recipe = {
		{"farming:baking_tray", "ethereal:lemon", "group:food_sugar"}
	},
	replacements = {
		{"farming:baking_tray", "farming:baking_tray"}
	}
})

-- Lemonade

minetest.register_node("ethereal:lemonade", {
	description = S("Lemonade"),
	drawtype = "plantlike",
	visual_scale = 0.5,
	tiles = {"ethereal_lemonade.png"},
	inventory_image = "ethereal_lemonade.png",
	wield_image = "ethereal_lemonade.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.15, -0.5, -0.15, 0.15, 0, 0.15}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, drink = 1},
	on_use = minetest.item_eat(5, "vessels:drinking_glass"),
	sounds = default.node_sound_glass_defaults()
})

ethereal.add_eatable("ethereal:lemonade", 5)

minetest.register_craft({
	output = "ethereal:lemonade",
	recipe = {
		{"ethereal:lemon", "group:food_sugar", "group:food_sugar"},
		{"vessels:drinking_glass", "group:water_bucket", ""}
	},
	replacements = {
		{"group:water_bucket", "bucket:bucket_empty"},
	}
})

-- Olive

minetest.register_node("ethereal:olive", {
	description = S("Olive"),
	drawtype = "plantlike",
	tiles = {"ethereal_olive.png"},
	inventory_image = "ethereal_olive_fruit.png",
	wield_image = "ethereal_olive_fruit.png",
	visual_scale = 0.2,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3, leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
	place_param2 = 1
})

ethereal.add_eatable("ethereal:olive", 1)

-- Olive Oil

minetest.register_craftitem("ethereal:olive_oil", {
	description = S("Olive Oil"),
	inventory_image = "ethereal_olive_oil.png",
	wield_image = "ethereal_olive_oil.png",
	groups = {food_oil = 1, food_olive_oil = 1, vessel = 1}
})

minetest.register_craft({
	output = "ethereal:olive_oil",
	recipe = {
		{"ethereal:olive", "ethereal:olive", "ethereal:olive"},
		{"ethereal:olive", "ethereal:olive", "ethereal:olive"},
		{"farming:juicer", "vessels:glass_bottle", ""}
	},
	replacements = {{"farming:juicer", "farming:juicer"}}
})

-- Kappa Maki (sushi with cucumber)

minetest.register_craftitem("ethereal:sushi_kappamaki", {
	description = S("Kappa Maki Sushi"),
	inventory_image = "ethereal_sushi_kappa_maki.png",
	on_use = minetest.item_eat(3)
})

ethereal.add_eatable("ethereal:sushi_kappamaki", 3)

minetest.register_craft({
	output = "ethereal:sushi_kappamaki 2",
	recipe = {
		{"group:food_seaweed", "group:food_cucumber", "group:food_rice"}
	}
})

-- Nigiri (sushi with raw fish)

minetest.register_craftitem("ethereal:sushi_nigiri", {
	description = S("Nigiri Sushi"),
	inventory_image = "ethereal_sushi_nigiri.png",
	on_use = minetest.item_eat(2)
})

ethereal.add_eatable("ethereal:sushi_nigiri", 2)

minetest.register_craft({
	output = "ethereal:sushi_nigiri 2",
	recipe = {
		{"group:food_rice", "group:food_fish_raw", ""}
	}
})

-- Tamago (sushi with sweet egg)

minetest.register_craftitem("ethereal:sushi_tamago", {
	description = S("Tamago Sushi"),
	inventory_image = "ethereal_sushi_tamago.png",
	on_use = minetest.item_eat(2)
})

ethereal.add_eatable("ethereal:sushi_tamago", 2)

minetest.register_craft({
	output = "ethereal:sushi_tamago 2",
	recipe = {
		{"group:food_seaweed", "group:food_egg", "group:food_rice"}
	}
})

-- Fugu (prepared pufferfish)

minetest.register_craftitem("ethereal:fugu", {
	description = S("Fugusashi"),
	inventory_image = "ethereal_fugu.png",

	on_use = function(itemstack, user, pointed_thing)

		if user then

			if math.random(12) == 1 then
				return minetest.do_item_eat(-16, nil, itemstack, user, pointed_thing)
			else
				return minetest.do_item_eat(4, nil, itemstack, user, pointed_thing)
			end
		end
	end
})

ethereal.add_eatable("ethereal:fugu", 4)

minetest.register_craft({
	output = "ethereal:fugu",
	recipe = {
		{"group:food_cutting_board", "ethereal:fish_pufferfish", "group:food_soy_sauce"}
	},
	replacements = {
		{"group:food_cutting_board", "farming:cutting_board"},
		{"group:food_soy_sauce", "vessels:glass_bottle"}
	}
})

-- Teriyaki Chicken

minetest.register_craftitem("ethereal:teriyaki_chicken", {
	description = S("Teriyaki Chicken"),
	inventory_image = "ethereal_teriyaki_chicken.png",
	on_use = minetest.item_eat(4)
})

ethereal.add_eatable("ethereal:teriyaki_chicken", 4)

minetest.register_craft({
	output = "ethereal:teriyaki_chicken 2",
	recipe = {
		{"group:food_chicken_raw", "group:food_sugar", "group:food_soy_sauce"},
		{"group:food_garlic_clove", "group:food_saucepan", "group:food_gelatin"}
	},
	replacements = {
		{"group:food_soy_sauce", "vessels:glass_bottle"},
		{"group:food_saucepan", "farming:saucepan"}
	}
})

-- Teriyaki Beef

minetest.register_craftitem("ethereal:teriyaki_beef", {
	description = S("Teriyaki Beef"),
	inventory_image = "ethereal_teriyaki_beef.png",
	on_use = minetest.item_eat(12, bowl)
})

ethereal.add_eatable("ethereal:teriyaki_beef", 12)

minetest.register_craft({
	output = "ethereal:teriyaki_beef",
	recipe = {
		{"group:food_meat_raw", "group:food_sugar", "group:food_soy_sauce"},
		{"group:food_garlic_clove", "group:food_saucepan", "group:food_gelatin"},
		{"group:food_cabbage", "group:food_rice", "group:food_bowl"}
	},
	replacements = {
		{"group:food_soy_sauce", "vessels:glass_bottle"},
		{"group:food_saucepan", "farming:saucepan"}
	}
})

-- mushroom soup

minetest.register_craftitem("ethereal:mushroom_soup", {
	description = S("Mushroom Soup"),
	inventory_image = "ethereal_mushroom_soup.png",
	groups = {drink = 1},
	on_use = minetest.item_eat(5, bowl)
})

ethereal.add_eatable("ethereal:mushroom_soup", 5)

minetest.register_craft({
	output = "ethereal:mushroom_soup",
	recipe = {
		{"group:food_mushroom"},
		{"group:food_mushroom"},
		{"group:food_bowl"}
	}
})

-- boiled shrimp

minetest.register_craftitem("ethereal:fish_shrimp_cooked", {
	description = S("Boiled Shrimp"),
	inventory_image = "ethereal_fish_shrimp_cooked.png",
	on_use = minetest.item_eat(2)
})

ethereal.add_eatable("ethereal:fish_shrimp_cooked", 2)

minetest.register_craft({
	output = "ethereal:fish_shrimp_cooked 5",
	recipe = {
		{"ethereal:fish_shrimp", "ethereal:fish_shrimp", "ethereal:fish_shrimp"},
		{"ethereal:fish_shrimp", "group:water_bucket", "ethereal:fish_shrimp"},
		{"", "ethereal:fire_dust", ""}
	},
	replacements = {{"group:water_bucket", "bucket:bucket_empty"}}
})

-- garlic butter shrimp

minetest.register_craftitem("ethereal:garlic_shrimp", {
	description = S("Garlic Butter Shrimp"),
	inventory_image = "ethereal_garlic_butter_shrimp.png",
	on_use = minetest.item_eat(6)
})

ethereal.add_eatable("ethereal:garlic_shrimp", 6)

minetest.register_craft({
	output = "ethereal:garlic_shrimp",
	recipe = {
		{"farming:skillet", "ethereal:fish_shrimp", "ethereal:fish_shrimp"},
		{"group:food_butter", "group:food_garlic_clove", "ethereal:lemon"}
	},
	replacements = {{"farming:skillet", "farming:skillet"}}
})

-- jellyfish salad

minetest.register_craftitem("ethereal:jellyfish_salad", {
	description = S("Jellyfish Salad"),
	inventory_image = "ethereal_jellyfish_salad.png",
	on_use = minetest.item_eat(6)
})

ethereal.add_eatable("ethereal:jellyfish_salad", 6)

minetest.register_craft({
	output = "ethereal:jellyfish_salad",
	recipe = {
		{"farming:cutting_board", "ethereal:fish_jellyfish", "group:food_onion"},
	},
	replacements = {{"farming:cutting_board", "farming:cutting_board"}}
})

-- raw calamari

minetest.register_craftitem("ethereal:calamari_raw", {
	description = S("Raw Calamari"),
	inventory_image = "ethereal_calamari_raw.png",
	on_use = minetest.item_eat(-2)
})

ethereal.add_eatable("ethereal:calamari_raw", -2)

minetest.register_craft({
	output = "ethereal:calamari_raw 2",
	recipe = {
		{"farming:cutting_board", "ethereal:fish_squid"},
	},
	replacements = {{"farming:cutting_board", "farming:cutting_board"}}
})

-- cooked calamari

minetest.register_craftitem("ethereal:calamari_cooked", {
	description = S("Calamari"),
	inventory_image = "ethereal_calamari_cooked.png",
	on_use = minetest.item_eat(5)
})

ethereal.add_eatable("ethereal:calamari_cooked", 5)

minetest.register_craft({
	output = "ethereal:calamari_cooked",
	recipe = {
		{"farming:skillet", "ethereal:calamari_raw", "farming:flour"},
	},
	replacements = {{"farming:skillet", "farming:skillet"}}
})

-- fish & chips

minetest.register_craftitem("ethereal:fish_n_chips", {
	description = S("Fish & Chips"),
	inventory_image = "ethereal_fish_chips.png",
	on_use = minetest.item_eat(6)
})

ethereal.add_eatable("ethereal:fish_n_chips", 6)

minetest.register_craft({
	output = "ethereal:fish_n_chips",
	recipe = {
		{"farming:baking_tray", "group:ethereal_fish", "group:food_potato"}
	},
	replacements = {{"farming:baking_tray", "farming:baking_tray"}}
})

-- cooked fish

minetest.register_craftitem(":ethereal:fish_cooked", {
	description = S("Cooked Fish"),
	inventory_image = "ethereal_fish_cooked.png",
	wield_image = "ethereal_fish_cooked.png",
	groups = {food_fish = 1},
	on_use = minetest.item_eat(5)
})

ethereal.add_eatable("ethereal:fish_cooked", 5)

minetest.register_craft({
	type = "cooking",
	output = "ethereal:fish_cooked",
	recipe = "group:ethereal_fish",
	cooktime = 8
})

-- Sashimi

minetest.register_craftitem("ethereal:sashimi", {
	description = S("Sashimi"),
	inventory_image = "ethereal_sashimi.png",
	wield_image = "ethereal_sashimi.png",
	on_use = minetest.item_eat(4)
})

ethereal.add_eatable("ethereal:sashimi", 4)

minetest.register_craft({
	output = "ethereal:sashimi 2",
	recipe = {
		{"group:food_seaweed", "group:food_fish_raw", "group:food_seaweed"},
	}
})

-- agar powder

minetest.register_craftitem("ethereal:agar_powder", {
	description = S("Agar Powder"),
	inventory_image = "ethereal_agar_powder.png",
	groups = {food_gelatin = 1, flammable = 2}
})

minetest.register_craft({
	output = "ethereal:agar_powder 3",
	recipe = {
		{"group:food_seaweed", "group:food_seaweed", "group:food_seaweed"},
		{"bucket:bucket_water", "bucket:bucket_water", "default:torch"},
		{"bucket:bucket_water", "bucket:bucket_water", "default:torch"}
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty 4"}}
})
