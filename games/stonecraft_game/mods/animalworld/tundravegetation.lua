local S = minetest.get_translator("animalworld")

	minetest.register_decoration({
		name = "animalworld:animalworld_tundrashrub1",
		deco_type = "simple",
		place_on = {"default:permafrost", "default:permafrost_with_stones"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 444,
			octaves = 2,
			persist = 3,
		},
		y_max = 31000,
		y_min = 4,
		decoration = "animalworld:animalworld_tundrashrub1",
        spawn_by = "default:permafrost", "default:permafrost_with_stones"
	})

minetest.register_node("animalworld:animalworld_tundrashrub1", {
	    description = S"Tundra Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.5,
	    tiles = {"animalworld_tundrashrub1.png"},
	    inventory_image = "animalworld_tundrashrub1.png",
	    wield_image = "animalworld_tundrashrub1.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, swordy = 1, handy = 1, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = animalworld.sounds.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "animalworld:animalworld_tundrashrub2",
		deco_type = "simple",
		place_on = {"default:permafrost", "default:permafrost_with_stones"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 42,
			octaves = 2,
			persist = 3,
		},
		y_max = 31000,
		y_min = 4,
		decoration = "animalworld:animalworld_tundrashrub2",
        spawn_by = "default:permafrost", "default:permafrost_with_stones"
	})

minetest.register_node("animalworld:animalworld_tundrashrub2", {
	    description = S"Tundra Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.5,
	    tiles = {"animalworld_tundrashrub2.png"},
	    inventory_image = "animalworld_tundrashrub2.png",
	    wield_image = "animalworld_tundrashrub2.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, swordy = 1, handy = 1, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = animalworld.sounds.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "animalworld:animalworld_tundrashrub3",
		deco_type = "simple",
		place_on = {"default:permafrost", "default:permafrost_with_stones"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 999,
			octaves = 2,
			persist = 3,
		},
		y_max = 31000,
		y_min = 4,
		decoration = "animalworld:animalworld_tundrashrub3",
        spawn_by = "default:permafrost", "default:permafrost_with_stones"
	})

minetest.register_node("animalworld:animalworld_tundrashrub3", {
	    description = S"Tundra Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.5,
	    tiles = {"animalworld_tundrashrub3.png"},
	    inventory_image = "animalworld_tundrashrub3.png",
	    wield_image = "animalworld_tundrashrub3.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, swordy = 1, handy = 1, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = animalworld.sounds.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "animalworld:animalworld_tundrashrub4",
		deco_type = "simple",
		place_on = {"default:permafrost", "default:permafrost_with_stones"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 4385,
			octaves = 2,
			persist = 3,
		},
		y_max = 31000,
		y_min = 4,
		decoration = "animalworld:animalworld_tundrashrub4",
        spawn_by = "default:permafrost", "default:permafrost_with_stones"
	})

minetest.register_node("animalworld:animalworld_tundrashrub4", {
	    description = S"Tundra Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.5,
	    tiles = {"animalworld_tundrashrub4.png"},
	    inventory_image = "animalworld_tundrashrub4.png",
	    wield_image = "animalworld_tundrashrub4.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, swordy = 1, handy = 1, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = animalworld.sounds.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "animalworld:animalworld_tundrashrub5",
		deco_type = "simple",
		place_on = {"default:permafrost", "default:permafrost_with_stones"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 6072,
			octaves = 2,
			persist = 3,
		},
		y_max = 31000,
		y_min = 4,
		decoration = "animalworld:animalworld_tundrashrub5",
        spawn_by = "default:permafrost", "default:permafrost_with_stones"
	})

minetest.register_node("animalworld:animalworld_tundrashrub5", {
	    description = S"Tundra Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.5,
	    tiles = {"animalworld_tundrashrub5.png"},
	    inventory_image = "animalworld_tundrashrub5.png",
	    wield_image = "animalworld_tundrashrub5.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, swordy = 1, handy = 1, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = animalworld.sounds.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

