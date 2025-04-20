
local S = minetest.get_translator("ethereal")

-- Cactus flower

minetest.register_node("ethereal:cactus_flower", {
	description = S("Cactus Flower"),
	drawtype = "plantlike",
	tiles = {"ethereal_cactus_flower.png"},
	inventory_image = "ethereal_cactus_flower.png",
	wield_image = "ethereal_cactus_flower.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 3 / 16, 4 / 16}
	},
	on_use = minetest.item_eat(1)
})

ethereal.add_eatable("ethereal:cactus_flower", 1)

minetest.register_craft({
	output = "dye:violet 2",
	recipe = {{"ethereal:cactus_flower"}}
})

-- Spore Grass

minetest.register_node("ethereal:spore_grass", {
	description = S("Spore Grass"),
	drawtype = "plantlike",
	tiles = {"ethereal_spore_grass.png"},
	inventory_image = "ethereal_spore_grass.png",
	wield_image = "ethereal_spore_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16}
	}
})

-- Firethorn (poisonous when eaten raw, must be crushed and washed with water 1st)

minetest.register_node("ethereal:firethorn", {
	description = S("Firethorn Shrub"),
	drawtype = "plantlike",
	tiles = {"ethereal_firethorn.png"},
	inventory_image = "ethereal_firethorn.png",
	wield_image = "ethereal_firethorn.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16}
	}
})

-- Fire Flower

minetest.register_node("ethereal:fire_flower", {
	description = S("Fire Flower"),
	drawtype = "plantlike",
	tiles = { "ethereal_fire_flower.png" },
	inventory_image = "ethereal_fire_flower.png",
	wield_image = "ethereal_fire_flower.png",
	paramtype = "light",
	light_source = 5,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	damage_per_second = 2,
	groups = {snappy = 1, oddly_breakable_by_hand = 3, igniter = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 1 / 2, 5 / 16}
	},

	on_punch = function(pos, node, puncher) -- hurts when punched

		puncher:punch(puncher, 1.0, {
				full_punch_interval = 1.0, damage_groups = {fleshy = 2}}, nil)
	end
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:fire_flower",
	burntime = 20
})

-- Fire Dust

minetest.register_craftitem("ethereal:fire_dust", {
	description = S("Fire Dust"),
	inventory_image = "ethereal_fire_dust.png"
})

minetest.register_craft({
	output = "ethereal:fire_dust 2",
	recipe = {{"ethereal:fire_flower"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:fire_dust",
	burntime = 10
})

-- vines

minetest.register_node("ethereal:vine", {
	description = S("Vine"),
	drawtype = "signlike",
	tiles = {"ethereal_vine.png"},
	inventory_image = "ethereal_vine.png",
	wield_image = "ethereal_vine.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {type = "wallmounted"},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_craft({
	output = "ethereal:vine 2",
	recipe = {
		{"group:leaves", "", "group:leaves"},
		{"", "group:leaves", ""},
		{"group:leaves", "", "group:leaves"}
	}
})

-- light strings (glowing vine)

minetest.register_node("ethereal:lightstring", {
	description = S("Light String Vine"),
	drawtype = "signlike",
	tiles = {"ethereal_lightstring.png"},
	inventory_image = "ethereal_lightstring.png",
	wield_image = "ethereal_lightstring.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 10,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {type = "wallmounted"},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_craft({
	output = "ethereal:lightstring 8",
	recipe = {
		{"ethereal:vine", "ethereal:vine", "ethereal:vine"},
		{"ethereal:vine", "ethereal:fire_dust", "ethereal:vine"},
		{"ethereal:vine", "ethereal:vine", "ethereal:vine"}
	}
})

-- Boston Fern

minetest.register_node("ethereal:fern", {
	description = S("Fern"),
	drawtype = "plantlike",
	visual_scale = 1.4,
	tiles = {"ethereal_fern.png"},
	inventory_image = "ethereal_fern.png",
	wield_image = "ethereal_fern.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:fern_tubers"}, rarity = 6},
			{items = {"ethereal:fern"}}
		}
	},
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.67, 5 / 16}
	}
})

-- Boston Ferns sometimes drop edible Tubers

minetest.register_craftitem("ethereal:fern_tubers", {
	description = S("Fern Tubers"),
	inventory_image = "ethereal_fern_tubers.png",
	groups = {food_tuber = 1},
	on_use = minetest.item_eat(1)
})

ethereal.add_eatable("ethereal:fern_tubers", 1)

-- Red Shrub (not flammable)

minetest.register_node("ethereal:dry_shrub", {
	description = S("Fiery Dry Shrub"),
	drawtype = "plantlike",
	tiles = {"ethereal_dry_shrub.png"},
	inventory_image = "ethereal_dry_shrub.png",
	wield_image = "ethereal_dry_shrub.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16}
	}
})

-- Grey Shrub (not Flammable - too cold to burn)

minetest.register_node("ethereal:snowygrass", {
	description = S("Snowy Grass"),
	drawtype = "plantlike",
	visual_scale = 0.9,
	tiles = {"ethereal_snowygrass.png"},
	inventory_image = "ethereal_snowygrass.png",
	wield_image = "ethereal_snowygrass.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 5 / 16, 5 / 16}
	}
})

-- Crystal Shrub (not Flammable - too cold to burn)

minetest.register_node("ethereal:crystalgrass", {
	description = S("Crystal Grass"),
	drawtype = "plantlike",
	visual_scale = 0.9,
	tiles = {"ethereal_crystalgrass.png"},
	inventory_image = "ethereal_crystalgrass.png",
	wield_image = "ethereal_crystalgrass.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 5 / 16, 5 / 16}
	}
})

-- tall lilac

minetest.register_node("ethereal:lilac", {
	description = S("Lilac"),
	drawtype = "plantlike",
	visual_scale = 1.9,
	tiles = {"ethereal_lilac.png"},
	inventory_image = "ethereal_lilac.png",
	wield_image = "ethereal_lilac.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.67, 5 / 16}
	}
})

minetest.register_craft({
	output = "dye:magenta 2",
	recipe = {{"ethereal:lilac"}}
})

-- moss helper function

local function add_moss(typ, descr, texture, receipe_item)

	minetest.register_node("ethereal:" .. typ .. "_moss", {
		description = S(descr .. " Moss"),
		tiles = {texture},
		groups = {crumbly = 3},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = 0.4}})
	})

	minetest.register_craft({
		output = "ethereal:" .. typ .. "_moss",
		recipe = {{"default:dirt", receipe_item}}
	})
end

-- add moss types (has grass texture on all sides)

add_moss("crystal", "Crystal", "ethereal_grass_crystal_top.png", "ethereal:frost_leaves")
add_moss("mushroom", "Mushroom", "ethereal_grass_mushroom_top.png", "ethereal:spore_grass")
add_moss("fiery", "Fiery", "ethereal_grass_fiery_top.png", "ethereal:dry_shrub")
add_moss("gray", "Gray", "ethereal_grass_gray_top.png", "ethereal:snowygrass")
add_moss("green", "Green", "default_grass.png", "default:jungleleaves")
add_moss("bamboo", "Bamboo", "ethereal_grass_bamboo_top.png", "ethereal:bamboo_leaves")

-- shroom helper function

local function add_shroom(name, desc, ad)

	minetest.register_node("ethereal:illumishroom" .. ad, {
		description = S(desc .. " Illumishroom"),
		drawtype = "plantlike",
		tiles = {"ethereal_illumishroom_" .. name .. ".png"},
		inventory_image = "ethereal_illumishroom_" .. name .. ".png",
		wield_image = "ethereal_illumishroom_" .. name .. ".png",
		paramtype = "light",
		light_source = 5,
		sunlight_propagates = true,
		walkable = false,
		groups = {dig_immediate = 3, attached_node = 1, flammable = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed", fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.47, 6 / 16}
		}
	})
end

-- add illuminated cave shrooms

add_shroom("red", "Red", "")
add_shroom("green", "Green", "2")
add_shroom("cyan", "Cyan", "3")

-- poppy

if not minetest.get_modpath("xanadu") then

	minetest.register_node(":xanadu:poppy", {
		description = S("Poppy"),
		tiles = {"ethereal_poppy.png"},
		inventory_image = "ethereal_poppy.png",
		wield_image = "ethereal_poppy.png",
		sunlight_propagates = true,
		buildable_to = true,
		waving = 1,
		drawtype = "plantlike",
		paramtype = "light",
		walkable = false,
		groups = {flower = 1, flora = 1, snappy = 3, attached_node = 1, flammable = 3},
		selection_box = {
			type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
		},
		sounds = default.node_sound_leaves_defaults(),
	})

	-- craft dye from plant
	minetest.register_craft({
		output = "dye:red 4",
		recipe = {{"xanadu:poppy"}}
	})
end
