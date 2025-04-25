local S = minetest.get_translator("animalworld")

 -- Anteater

minetest.register_node("animalworld:anteaterpillow", {
    description = S"Anteater Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"textureanteaterpillow.png"},
    inventory_image = "aanteaterpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:anteaterpillow",
	burntime = 2,
})

minetest.register_node("animalworld:anteaterpillowleft", {
    description = S"Anteater Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"textureanteaterpillow.png"},
    inventory_image = "aanteaterpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:anteaterpillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:anteaterpillowright", {
    description = S"Anteater Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"textureanteaterpillow.png"},
    inventory_image = "aanteaterpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:anteaterpillowright",
	burntime = 2,
})

minetest.register_craftitem("animalworld:anteatercorpse", {
	description = S("Anteater Corpse"),
	inventory_image = "animalworld_anteatercorpse.png",
})

minetest.register_craft({
	output = "animalworld:anteaterpillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:anteatercorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:anteaterpillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:anteatercorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:anteaterpillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:anteatercorpse", "default:pick_stone", "group:wool"}

	
})

 -- bear

minetest.register_node("animalworld:beartrophy", {
    description = S"Bear Trophy",
    visual_scale = 1.0,
    mesh = "Beartrophy.b3d",
    tiles = {"texturebeartrophy.png"},
    inventory_image = "abeartrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:beartrophy",
	burntime = 2,
})

minetest.register_node("animalworld:bearpelt", {
    description = S"Bear Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"texturebearpelt.png"},
    inventory_image = "abearpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:bearpelt",
	burntime = 2,
})

minetest.register_node("animalworld:bearpelthanging", {
    description = S"Bear Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"texturebearpelt.png"},
    inventory_image = "abearpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:bearpelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:bearcorpse", {
	description = S("Bear Corpse"),
	inventory_image = "animalworld_bearcorpse.png",
})

minetest.register_craft({
	output = "animalworld:beartrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:bearcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craft({
	output = "animalworld:bearpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:bearcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:bearpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:bearcorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

minetest.register_node("animalworld:bearstool", {
    description = S"Bear Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturebearstool.png"},
    inventory_image = "abearstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:bearstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:bearstool",
	type = "shapeless",
	recipe = 
		{"animalworld:bearcorpse", "default:axe_stone", "group:wood", "default:stick"}

})

 -- blackbird

minetest.register_node("animalworld:blackbirdpillow", {
    description = S"Blackbird Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"textureblackbirdpillow.png"},
    inventory_image = "ablackbirdpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:blackbirdpillow",
	burntime = 2,
})

minetest.register_node("animalworld:blackbirdpillowleft", {
    description = S"Blackbird Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"textureblackbirdpillow.png"},
    inventory_image = "ablackbirdpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:blackbirdpillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:blackbirdpillowright", {
    description = S"Blackbird Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"textureblackbirdpillow.png"},
    inventory_image = "ablackbirdpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:blackbirdpillowright",
	burntime = 2,
})

minetest.register_craftitem("animalworld:blackbirdcorpse", {
	description = S("Blackbird Corpse"),
	inventory_image = "animalworld_blackbirdcorpse.png",
})

minetest.register_craft({
	output = "animalworld:blackbirdpillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:blackbirdcorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:blackbirdpillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:blackbirdcorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:blackbirdpillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:blackbirdcorpse", "default:pick_stone", "group:wool"}

	
})

minetest.register_node("animalworld:blackbirdcurtain", {
    description = S"Blackbird Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"textureblackbirdcurtain.png"},
    inventory_image = "ablackbirdcurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:blackbirdcurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:blackbirdcurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:blackbirdcorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})


 -- boar

minetest.register_node("animalworld:boartrophy", {
    description = S"Boar Trophy",
    visual_scale = 1.0,
    mesh = "Boartrophy.b3d",
    tiles = {"textureboartrophy.png"},
    inventory_image = "aboartrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.3, -0.3, 0.3, 0.3, 0.5},
            --[[{-0.3, -0.3, -0.3, 0.3, 0.3, 0.5},
            {-0.3, -0.3, -0.3, 0.3, 0.3, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.3, -0.3, 0.3, 0.3, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:boartrophy",
	burntime = 2,
})

minetest.register_node("animalworld:boarpelt", {
    description = S"Boar Pelt",
    visual_scale = 1,
    mesh = "Boarpelt.b3d",
    tiles = {"textureboarpelt.png"},
    inventory_image = "aboarpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.5, -0.9, 0.8, -0.5, 0.9},
            --[[{-0.8, -0.5, -0.0, 0.8, -0.5, 0.9},
            {-0.8, -0.5, -0.9, 0.8, -0.5, 0.9}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.5, -0.9, 0.8, -0.5, 0.9}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:boarpelt",
	burntime = 2,
})

minetest.register_node("animalworld:boarpelthanging", {
    description = S"Boar Pelt hanging",
    visual_scale = 1,
    mesh = "Boarpelthanging.b3d",
    tiles = {"textureboarpelt.png"},
    inventory_image = "aboarpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:boarpelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:boarcorpse", {
	description = S("Boar Corpse"),
	inventory_image = "animalworld_boarcorpse.png",
})

minetest.register_craft({
	output = "animalworld:boartrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:boarcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craft({
	output = "animalworld:boarpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:boarcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:boarpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:boarcorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

 -- camel

minetest.register_node("animalworld:camelpillow", {
    description = S"Camel Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturecamelpillow.png"},
    inventory_image = "acamelpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:camelpillow",
	burntime = 2,
})

minetest.register_node("animalworld:camelpillowleft", {
    description = S"Camel Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturecamelpillow.png"},
    inventory_image = "acamelpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:camelpillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:camelpillowright", {
    description = S"Camel Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturecamelpillow.png"},
    inventory_image = "acamelpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:camelpillowright",
	burntime = 2,
})

minetest.register_craftitem("animalworld:camelcorpse", {
	description = S("Camel Corpse"),
	inventory_image = "animalworld_camelcorpse.png",
})

minetest.register_craft({
	output = "animalworld:camelpillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:camelcorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:camelpillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:camelcorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:camelpillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:camelcorpse", "default:pick_stone", "group:wool"}

	
})


minetest.register_node("animalworld:camelpelt", {
    description = S"Camel Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"texturecamelpelt.png"},
    inventory_image = "acamelpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:camelpelt",
	burntime = 2,
})

minetest.register_node("animalworld:camelpelthanging", {
    description = S"Camel Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"texturecamelpelt.png"},
    inventory_image = "acamelpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:camelpelthanging",
	burntime = 2,
})


minetest.register_craft({
	output = "animalworld:camelpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:camelcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:camelpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:camelcorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

minetest.register_node("animalworld:camelcurtain", {
    description = S"Camel Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturecamelcurtain.png"},
    inventory_image = "acamelcurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:camelcurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:camelcurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:camelcorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Crocodile


minetest.register_node("animalworld:crocodiletrophy", {
    description = S"Crocodile Trophy",
    visual_scale = 1.0,
    mesh = "Crocodiletrophy.b3d",
    tiles = {"texturecrocodiletrophy.png"},
    inventory_image = "acrocodiletrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.35, -0.3, -0.6, 0.35, 0.3, 0.5},
            --[[{-0.35, -0.3, -0.6, 0.35, 0.3, 0.5},
            {-0.35, -0.3, -0.6, 0.35, 0.3, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.35, -0.3, -0.6, 0.35, 0.3, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:crocodiletrophy",
	burntime = 2,
})

minetest.register_craftitem("animalworld:crocodilecorpse", {
	description = S("Crocodile Corpse"),
	inventory_image = "animalworld_crocodilecorpse.png",
})

minetest.register_craft({
	output = "animalworld:crocodiletrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:crocodilecorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_node("animalworld:crocodilestool", {
    description = S"Crocodile Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturecrocodilestool.png"},
    inventory_image = "acrocodilestool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:crocodilestool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:crocodilestool",
	type = "shapeless",
	recipe = 
		{"animalworld:crocodilecorpse", "default:axe_stone", "group:wood", "default:stick"}

})minetest.register_node("animalworld:crocodilestool", {
    description = S"Crocodile Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturecrocodilestool.png"},
    inventory_image = "acrocodilestool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:crocodilestool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:crocodilestool",
	type = "shapeless",
	recipe = 
		{"animalworld:crocodilecorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_node("animalworld:crocodilecurtain", {
    description = S"Crocodile Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturecrocodilecurtain.png"},
    inventory_image = "acrocodilecurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:crocodilecurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:crocodilecurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:crocodilecorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

minetest.register_node("animalworld:crocodileskin", {
    description = S"Crocodile Skin",
    visual_scale = 1.0,
    mesh = "Reptileskin.b3d",
    tiles = {"texturecrocodileskin.png"},
    inventory_image = "acrocodileskin.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:crocodileskin",
	burntime = 2,
})

minetest.register_node("animalworld:crocodileskinhanging", {
    description = S"Crocodile Skin hanging",
    visual_scale = 1.0,
    mesh = "Reptileskinhanging.b3d",
    tiles = {"texturecrocodileskin.png"},
    inventory_image = "acrocodileskin.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:crocodileskinhanging",
	burntime = 2,
})


 -- elephant

minetest.register_node("animalworld:elephanttrophy", {
    description = S"Elephant Trophy",
    visual_scale = 1.0,
    mesh = "Elephanttrophy.b3d",
    tiles = {"textureelephanttrophy.png"},
    inventory_image = "aelephanttrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.5, -1.6, 0.8, 0.9, 0.5},
            --[[{-0.8, -0.5, -1.6, 0.8, 0.9, 0.5},
            {-0.8, -0.5, -1.6, 0.8, 0.9, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.5, -1.6, 0.8, 0.9, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:elephantrophy",
	burntime = 2,
})

minetest.register_craftitem("animalworld:elephantcorpse", {
	description = S("Elephant Corpse"),
	inventory_image = "animalworld_elephantcorpse.png",
})

minetest.register_craft({
	output = "animalworld:elephanttrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:elephantcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_node("animalworld:ivorytable", {
    description = S"Ivory Table",
    visual_scale = 1,
    mesh = "Ivorytable.b3d",
    tiles = {"textureivorytable.png"},
    inventory_image = "aivorytable.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.4, 0.4},
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:ivorytable",
	burntime = 3

})

minetest.register_node("animalworld:ivorychair", {
    description = S"Ivory Chair",
    visual_scale = 1,
    mesh = "Ivorychair.b3d",
    tiles = {"textureivorychair.png"},
    inventory_image = "aivorychair.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.35, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.35, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.35, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.35, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:ivorychair",
	burntime = 3

})


minetest.register_node("animalworld:ivoryvase", {
    description = S"Ivory Vase",
    visual_scale = 1,
    mesh = "Ivoryvase.b3d",
    tiles = {"textureivoryvase.png"},
    inventory_image = "aivoryvase.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
            --[[{-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
            {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:ivoryvase",
	burntime = 1

})

minetest.register_craft({
	output = "animalworld:ivorytable",
	type = "shapeless",
	recipe = 
		{"animalworld:elephantcorpse", "default:axe_stone"}

	
})

minetest.register_craft({
	output = "animalworld:ivorychair",
	type = "shapeless",
	recipe = 
		{"animalworld:elephantcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:ivoryvase",
	type = "shapeless",
	recipe = 
		{"animalworld:elephantcorpse", "default:shovel_stone"}

	
})

minetest.register_node("animalworld:elephantstool", {
    description = S"Elephant Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"textureelephantstool.png"},
    inventory_image = "aelephantstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:elephantstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:elephantstool",
	type = "shapeless",
	recipe = 
		{"animalworld:elephantcorpse", "default:axe_stone", "group:wood", "default:stick"}

})

 -- gnu


minetest.register_node("animalworld:gnupelt", {
    description = S"Gnu Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"texturegnupelt.png"},
    inventory_image = "agnupelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:gnupelt",
	burntime = 2,
})

minetest.register_node("animalworld:gnupelthanging", {
    description = S"Gnu Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"texturegnupelt.png"},
    inventory_image = "agnupelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:gnupelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:gnucorpse", {
	description = S("Gnu Corpse"),
	inventory_image = "animalworld_gnucorpse.png",
})


minetest.register_craft({
	output = "animalworld:gnupelt",
	type = "shapeless",
	recipe = 
		{"animalworld:gnucorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:gnupelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:gnucorpse", "default:sword_stone", "default:sign_wall_wood"}

})

minetest.register_node("animalworld:gnutrophy", {
    description = S"Gnu Trophy",
    visual_scale = 1.0,
    mesh = "Gnutrophy.b3d",
    tiles = {"texturegnutrophy.png"},
    inventory_image = "agnutrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.4, -0.4, 0.4, 0.4, 0.5},
            --[[{-0.4, -0.4, -0.4, 0.4, 0.4, 0.5},
            {-0.4, -0.4, -0.4, 0.4, 0.4, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.4, -0.4, 0.4, 0.4, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:gnutrophy",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:gnutrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:gnucorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_node("animalworld:gnustool", {
    description = S"Gnu Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturegnustool.png"},
    inventory_image = "agnustool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:gnustool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:gnustool",
	type = "shapeless",
	recipe = 
		{"animalworld:gnucorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_node("animalworld:gnucurtain", {
    description = S"Gnu Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturegnucurtain.png"},
    inventory_image = "agnucurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:gnucurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:gnucurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:gnucorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Hippo

minetest.register_node("animalworld:hippostool", {
    description = S"Hippo Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturehippostool.png"},
    inventory_image = "ahippostool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hippostool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:hippostool",
	type = "shapeless",
	recipe = 
		{"animalworld:hippocorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_craftitem("animalworld:hippocorpse", {
	description = S("Hippo Corpse"),
	inventory_image = "animalworld_hippocorpse.png",
})

minetest.register_node("animalworld:hippocurtain", {
    description = S"Hippo Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturehippocurtain.png"},
    inventory_image = "ahippocurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hippocurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:hippocurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:hippocorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Hyena

minetest.register_node("animalworld:hyenatrophy", {
    description = S"Hyena Trophy",
    visual_scale = 1.0,
    mesh = "Hyenatrophy.b3d",
    tiles = {"texturehyenatrophy.png"},
    inventory_image = "ahyenatrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.25, -0.35, 0.25, 0.25, 0.5},
            --[[{-0.25, -0.25, -0.35, 0.25, 0.25, 0.5},
            {-0.25, -0.25, -0.35, 0.25, 0.25, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.25, -0.35, 0.25, 0.25, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hyenatrophy",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:hyenatrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:hyenacorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craftitem("animalworld:hyenacorpse", {
	description = S("Hyena Corpse"),
	inventory_image = "animalworld_hyenacorpse.png",
})

minetest.register_node("animalworld:hyenapillow", {
    description = S"Hyena Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturehyenapillow.png"},
    inventory_image = "ahyenapillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hyenapillow",
	burntime = 2,
})

minetest.register_node("animalworld:hyenapillowleft", {
    description = S"Hyea Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturehyenapillow.png"},
    inventory_image = "ahyenapillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hyenapillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:hyenapillowright", {
    description = S"Hyena Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturehyenapillow.png"},
    inventory_image = "ahyenapillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hyenapillowright",
	burntime = 2,
})


minetest.register_craft({
	output = "animalworld:hyenapillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:hyenacorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:hyenapillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:hyenacorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:hyenapillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:hyenacorpse", "default:pick_stone", "group:wool"}

	
})

 -- Kangaroo


minetest.register_craftitem("animalworld:kangaroocorpse", {
	description = S("Kangaroo Corpse"),
	inventory_image = "animalworld_kangaroocorpse.png",
})

minetest.register_node("animalworld:kangaroopillow", {
    description = S"Kangaroo Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturekangaroopillow.png"},
    inventory_image = "akangaroopillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:kangaroopillow",
	burntime = 2,
})

minetest.register_node("animalworld:kangaroopillowleft", {
    description = S"Kangaroo Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturekangaroopillow.png"},
    inventory_image = "akangaroopillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:hyenapillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:kangaroopillowright", {
    description = S"Kangaroo Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturekangaroopillow.png"},
    inventory_image = "akangaroopillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:kangaroopillowright",
	burntime = 2,
})


minetest.register_craft({
	output = "animalworld:kangaroopillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:kangaroocorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:kangarooapillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:kangaroocorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:kangaroopillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:kangaroocorpse", "default:pick_stone", "group:wool"}

	
})

minetest.register_node("animalworld:kangaroocurtain", {
    description = S"Kangaroo Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturekangaroocurtain.png"},
    inventory_image = "akangaroocurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:kangaroocurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:kangaroocurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:kangaroocorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Monitor Lizard

minetest.register_node("animalworld:monitortrophy", {
    description = S"Monitor Lizard Trophy",
    visual_scale = 1.0,
    mesh = "Monitortrophy.b3d",
    tiles = {"texturemonitortrophy.png"},
    inventory_image = "amonitortrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.25, -0.5, 0.25, 0.25, 0.5},
            --[[{-0.25, -0.25, -0.5, 0.25, 0.25, 0.5},
            {-0.25, -0.25, -0.5, 0.25, 0.25, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.25, -0.5, 0.25, 0.25, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:monitortrophy",
	burntime = 2,
})

minetest.register_craftitem("animalworld:monitorcorpse", {
	description = S("Monitor Lizard Corpse"),
	inventory_image = "animalworld_monitorcorpse.png",
})

minetest.register_craft({
	output = "animalworld:monitortrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:monitorcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_node("animalworld:monitorstool", {
    description = S"Monitor Lizard Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturemonitorstool.png"},
    inventory_image = "amonitorstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:monitorstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:monitorstool",
	type = "shapeless",
	recipe = 
		{"animalworld:monitorcorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_node("animalworld:monitorcurtain", {
    description = S"Monitor Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturemonitorcurtain.png"},
    inventory_image = "amonitorcurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:monitorcurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:monitorcurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:monitorcorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Moose

minetest.register_node("animalworld:moosetrophy", {
    description = S"Moose Trophy",
    visual_scale = 1.0,
    mesh = "Moosetrophy.b3d",
    tiles = {"texturemoosetrophy.png"},
    inventory_image = "amoosetrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.7, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.7, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.7, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.7, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:moosetrophy",
	burntime = 2,
})

minetest.register_node("animalworld:moosepelt", {
    description = S"Moose Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"texturemoosepelt.png"},
    inventory_image = "amoosepelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:moosepelt",
	burntime = 2,
})

minetest.register_node("animalworld:moosepelthanging", {
    description = S"Moose Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"texturemoosepelt.png"},
    inventory_image = "amoosepelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:moosepelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:moosecorpse", {
	description = S("Moose Corpse"),
	inventory_image = "animalworld_moosecorpse.png",
})

minetest.register_craft({
	output = "animalworld:moosetrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:moosecorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craft({
	output = "animalworld:moosepelt",
	type = "shapeless",
	recipe = 
		{"animalworld:moosecorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:moosepelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:moosecorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

 -- Owl

minetest.register_node("animalworld:owltrophy", {
    description = S"Owl Trophy",
    visual_scale = 1.0,
    mesh = "Owltrophy.b3d",
    tiles = {"textureowltrophy.png"},
    inventory_image = "aowltrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.3, 0.5, 0.4, 0.5},
            --[[{-0.5, -0.5, -0.3, 0.5, 0.4, 0.5},
            {-0.5, -0.5, -0.3, 0.5, 0.4, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.3, 0.5, 0.4, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:owltrophy",
	burntime = 2,
})

minetest.register_craftitem("animalworld:owlcorpse", {
	description = S("Owl Corpse"),
	inventory_image = "animalworld_owlcorpse.png",
})

minetest.register_craft({
	output = "animalworld:owltrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:owlcorpse", "default:axe_stone", "group:wood"}

	
})

 -- Reindeer

minetest.register_node("animalworld:reindeertrophy", {
    description = S"Reindeer Trophy",
    visual_scale = 1.0,
    mesh = "Reindeertrophy.b3d",
    tiles = {"texturereindeertrophy.png"},
    inventory_image = "areindeertrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.3, -0.3, 0.3, 0.3, 0.5},
            --[[{-0.3, -0.3, -0.3, 0.3, 0.3, 0.5},
            {-0.3, -0.3, -0.3, 0.3, 0.3, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.3, -0.3, 0.3, 0.3, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:reindeertrophy",
	burntime = 2,
})

minetest.register_node("animalworld:reindeerpelt", {
    description = S"Reindeer Pelt",
    visual_scale = 1,
    mesh = "Boarpelt.b3d",
    tiles = {"texturereindeerpelt.png"},
    inventory_image = "areindeerpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.5, -0.9, 0.8, -0.5, 0.9},
            --[[{-0.8, -0.5, -0.0, 0.8, -0.5, 0.9},
            {-0.8, -0.5, -0.9, 0.8, -0.5, 0.9}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.5, -0.9, 0.8, -0.5, 0.9}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:reindeerpelt",
	burntime = 2,
})

minetest.register_node("animalworld:reindeerpelthanging", {
    description = S"Reindeer Pelt hanging",
    visual_scale = 1,
    mesh = "Boarpelthanging.b3d",
    tiles = {"texturereindeerpelt.png"},
    inventory_image = "areindeerpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:reindeerpelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:reindeercorpse", {
	description = S("Reindeer Corpse"),
	inventory_image = "animalworld_reindeercorpse.png",
})

minetest.register_craft({
	output = "animalworld:reindeertrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:reindeercorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craft({
	output = "animalworld:reindeerpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:reindeercorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:reindeerpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:reindeercorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

 -- Seal

minetest.register_node("animalworld:sealpillow", {
    description = S"Seal Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturesealpillow.png"},
    inventory_image = "asealpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:sealpillow",
	burntime = 2,
})

minetest.register_node("animalworld:sealpillowleft", {
    description = S"Seal Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturesealpillow.png"},
    inventory_image = "asealpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:sealpillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:sealpillowright", {
    description = S"Seal Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturesealpillow.png"},
    inventory_image = "asealpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:sealpillowright",
	burntime = 2,
})

minetest.register_craftitem("animalworld:sealcorpse", {
	description = S("Seal Corpse"),
	inventory_image = "animalworld_sealcorpse.png",
})

minetest.register_craft({
	output = "animalworld:sealpillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:sealcorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:sealpillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:sealcorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:sealpillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:sealcorpse", "default:pick_stone", "group:wool"}

	
})

minetest.register_node("animalworld:sealstool", {
    description = S"Seal Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturesealstool.png"},
    inventory_image = "asealstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:sealstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:sealstool",
	type = "shapeless",
	recipe = 
		{"animalworld:sealcorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_node("animalworld:sealcurtain", {
    description = S"Seal Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturesealcurtain.png"},
    inventory_image = "asealcurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:sealcurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:sealcurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:sealcorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Shark

minetest.register_node("animalworld:sharktrophy", {
    description = S"Shark Trophy",
    visual_scale = 1.0,
    mesh = "Sharktrophy.b3d",
    tiles = {"texturesharktrophy.png"},
    inventory_image = "asharktrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:sharktrophy",
	burntime = 2,
})

minetest.register_craftitem("animalworld:sharkcorpse", {
	description = S("Shark Corpse"),
	inventory_image = "animalworld_sharkcorpse.png",
})

minetest.register_craft({
	output = "animalworld:sharktrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:sharkcorpse", "default:axe_stone", "group:wood"}

	
})

 -- Vulture

minetest.register_node("animalworld:vulturepillow", {
    description = S"Vulture Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturevulturepillow.png"},
    inventory_image = "avulturepillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:vulturepillow",
	burntime = 2,
})

minetest.register_node("animalworld:vulturepillowleft", {
    description = S"Vulture Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturevulturepillow.png"},
    inventory_image = "avulturepillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:vulturepillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:vulturepillowright", {
    description = S"Vulture Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturevulturepillow.png"},
    inventory_image = "avulturepillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:vulturepillowright",
	burntime = 2,
})

minetest.register_craftitem("animalworld:vulturecorpse", {
	description = S("Vulture Corpse"),
	inventory_image = "animalworld_vulturecorpse.png",
})

minetest.register_craft({
	output = "animalworld:vulturepillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:vulturecorpse", "default:sword_stone", "group:wool"}

	
})

 -- Yak

minetest.register_node("animalworld:yaktrophy", {
    description = S"Yak Trophy",
    visual_scale = 1.0,
    mesh = "Yaktrophy.b3d",
    tiles = {"textureyaktrophy.png"},
    inventory_image = "ayaktrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:yaktrophy",
	burntime = 2,
})

minetest.register_node("animalworld:yakpelt", {
    description = S"Yak Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"textureyakpelt.png"},
    inventory_image = "ayakpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:yakpelt",
	burntime = 2,
})

minetest.register_node("animalworld:yakpelthanging", {
    description = S"Yak Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"textureyakpelt.png"},
    inventory_image = "ayakpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:yakpelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:yakcorpse", {
	description = S("Yak Corpse"),
	inventory_image = "animalworld_yakcorpse.png",
})

minetest.register_craft({
	output = "animalworld:yaktrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:yakcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craft({
	output = "animalworld:yakpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:yakcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:yakpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:yakcorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})


minetest.register_node("animalworld:yakstool", {
    description = S"Yak Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"textureyakstool.png"},
    inventory_image = "ayakstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:yakstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:yakstool",
	type = "shapeless",
	recipe = 
		{"animalworld:yakcorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_node("animalworld:yakcurtain", {
    description = S"Yak Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"textureyakcurtain.png"},
    inventory_image = "ayakcurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:yakcurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:yakcurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:yakcorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

 -- Snow Leopard

minetest.register_node("animalworld:snowleopardtrophy", {
    description = S"Snow Leopard Trophy",
    visual_scale = 1.0,
    mesh = "Snowleopardtrophy.b3d",
    tiles = {"texturesnowleopardtrophy.png"},
    inventory_image = "asnowleopardtrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.2, -0.15, -0.2, 0.2, 0.4, 0.5},
            --[[{-0.2, -0.15, -0.2, 0.2, 0.4, 0.5},
            {-0.2, -0.15, -0.2, 0.2, 0.4, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.2, -0.15, -0.2, 0.2, 0.4, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:snowleopardtrophy",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:snowleopardtrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:snowleopardcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_node("animalworld:snowleopardpillow", {
    description = S"Snow Leopard Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturesnowleopardpillow.png"},
    inventory_image = "asnowleopardpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:snowleopardpillow",
	burntime = 2,
})

minetest.register_node("animalworld:snowleopardpillowleft", {
    description = S"Snow Leopard Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturesnowleopardpillow.png"},
    inventory_image = "asnowleopardpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:snowleopardpillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:snowleopardpillowright", {
    description = S"Snow Leopard Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturesnowleopardpillow.png"},
    inventory_image = "asnowleopardpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:snowleopardpillowright",
	burntime = 2,
})


minetest.register_craft({
	output = "animalworld:snowleopardpillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:snowleopardcorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:snowleopardpillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:snowleopardcorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:snowleopardpillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:snowleopardcorpse", "default:pick_stone", "group:wool"}

	
})



minetest.register_craftitem("animalworld:snowleopardcorpse", {
	description = S("Snowleopard Corpse"),
	inventory_image = "animalworld_snowleopardcorpse.png",
})

 -- Tiger

minetest.register_node("animalworld:tigertrophy", {
    description = S"Tiger Trophy",
    visual_scale = 1.0,
    mesh = "Tigertrophy.b3d",
    tiles = {"texturetigertrophy.png"},
    inventory_image = "atigertrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.4, -0.2, 0.5, 0.45, 0.5},
            --[[{-0.5, -0.4, -0.2, 0.5, 0.45, 0.5},
            {-0.5, -0.4, -0.2, 0.5, 0.45, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.4, -0.2, 0.5, 0.45, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigertrophy",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:tigertrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_node("animalworld:tigerpillow", {
    description = S"Tiger Pillow",
    visual_scale = 1.0,
    mesh = "Pillow.b3d",
    tiles = {"texturetigerpillow.png"},
    inventory_image = "atigerpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigerpillow",
	burntime = 2,
})

minetest.register_node("animalworld:tigerpillowleft", {
    description = S"Tiger Pillow Left",
    visual_scale = 1.0,
    mesh = "Pillowleft.b3d",
    tiles = {"texturetigerpillow.png"},
    inventory_image = "atigerpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.4}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigerpillowleft",
	burntime = 2,
})

minetest.register_node("animalworld:tigerpillowright", {
    description = S"Tiger Pillow Right",
    visual_scale = 1.0,
    mesh = "Pillowright.b3d",
    tiles = {"texturetigerpillow.png"},
    inventory_image = "atigerpillow.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5},
            --[[{-0.5, -0.5, -0.0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.0, 0.5, 0.2, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigerpillowright",
	burntime = 2,
})


minetest.register_craft({
	output = "animalworld:tigerpillow", 
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:sword_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:tigerpillowleft", 
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:axe_stone", "group:wool"}

	
})

minetest.register_craft({
	output = "animalworld:tigerpillowright", 
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:pick_stone", "group:wool"}

	
})

minetest.register_craftitem("animalworld:tigercorpse", {
	description = S("Tiger Corpse"),
	inventory_image = "animalworld_tigercorpse.png",
})

minetest.register_node("animalworld:tigerstool", {
    description = S"Tiger Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturetigerstool.png"},
    inventory_image = "atigerstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigerstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:tigerstool",
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:axe_stone", "group:wood", "default:stick"}

})

minetest.register_node("animalworld:tigercurtain", {
    description = S"Tiger Curtain",
    visual_scale = 1.0,
    mesh = "Curtain.b3d",
    tiles = {"texturetigercurtain.png"},
    inventory_image = "atigercurtain.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            --[[{-0.7, -0.6, -0.1, 0.7, 0.6, 0.5},
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.7, -0.6, -0.1, 0.7, 0.6, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigercurtain",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:tigercurtain",
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:sword_stone", "group:wood", "group:wool", "farming:string", "default:stick"}

	
})

minetest.register_node("animalworld:tigerpelt", {
    description = S"Tiger Pelt",
    visual_scale = 1.0,
    mesh = "Tigerpelt.b3d",
    tiles = {"texturetigerpelt.png"},
    inventory_image = "atigerpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigerpelt",
	burntime = 2,
})

minetest.register_node("animalworld:tigerpelthanging", {
    description = S"Tiger Pelt hanging",
    visual_scale = 1.0,
    mesh = "Tigerpelthanging.b3d",
    tiles = {"texturetigerpelt.png"},
    inventory_image = "atigerpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:tigerpelthanging",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:tigerpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:tigerpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:tigercorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})



 -- Wolverine

minetest.register_node("animalworld:wolverinetrophy", {
    description = S"Wolverine Trophy",
    visual_scale = 1.0,
    mesh = "Wolverinetrophy.b3d",
    tiles = {"texturewolverinetrophy.png"},
    inventory_image = "awolverinetrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.25, -0.2, 0.25, 0.25, 0.5},
            --[[{-0.25, -0.25, -0.2, 0.25, 0.25, 0.5},
            {-0.25, -0.25, -0.2, 0.25, 0.25, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.25, -0.2, 0.25, 0.25, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:wolverinetrophy",
	burntime = 2,

})

minetest.register_craftitem("animalworld:wolverinecorpse", {
	description = S("Wolverine Corpse"),
	inventory_image = "animalworld_wolverinecorpse.png",
})

minetest.register_craft({
	output = "animalworld:wolverinetrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:wolverinecorpse", "default:axe_stone", "group:wood"}

	
})

 -- polar bear

minetest.register_node("animalworld:polarbeartrophy", {
    description = S"Polar Bear Trophy",
    visual_scale = 1.0,
    mesh = "Polarbeartrophy.b3d",
    tiles = {"texturepolarbeartrophy.png"},
    inventory_image = "apolarbeartrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.8, 0.4, 0.4, 0.5},
            --[[{-0.4, -0.5, -0.8, 0.4, 0.4, 0.5},
            {-0.4, -0.5, -0.8, 0.4, 0.4, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.8, 0.4, 0.4, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:polarbeartrophy",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:polarbeartrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:polarbearcorpse", "default:axe_stone", "group:wood"}
})


minetest.register_node("animalworld:polarbearpelt", {
    description = S"Polar Bear Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"texturepolarbearpelt.png"},
    inventory_image = "apolarbearpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:polarbearpelt",
	burntime = 2,
})

minetest.register_node("animalworld:polarbearpelthanging", {
    description = S"Polar Bear Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"texturepolarbearpelt.png"},
    inventory_image = "apolarbearpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:polarbearpelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:polarbearcorpse", {
	description = S("Polar Bear Corpse"),
	inventory_image = "animalworld_polarbearcorpse.png",
})


minetest.register_craft({
	output = "animalworld:polarbearpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:polarbearcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:polarbearpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:polarbearcorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

 -- Muskox

minetest.register_node("animalworld:muskoxtrophy", {
    description = S"Muskox Trophy",
    visual_scale = 1.0,
    mesh = "Muskoxtrophy.b3d",
    tiles = {"texturemuskoxtrophy.png"},
    inventory_image = "amuskoxtrophy.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.7, 0.5, 0.8, 0.5},
            --[[{-0.5, -0.5, -0.7, 0.5, 0.8, 0.5},
            {-0.5, -0.5, -0.7, 0.5, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.7, 0.5, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:muskoxtrophy",
	burntime = 2,
})

minetest.register_node("animalworld:muskoxpelt", {
    description = S"Muskox Pelt",
    visual_scale = 1.0,
    mesh = "Bearpelt.b3d",
    tiles = {"texturemuskoxpelt.png"},
    inventory_image = "amuskoxpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2},
            --[[{-1, -0.5, -1.2, 1, -0.5, 1.2},
            {-1, -0.5, -1.2, 1, -0.5, 1.2}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1.2, 1, -0.5, 1.2}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:muskoxpelt",
	burntime = 2,
})

minetest.register_node("animalworld:muskoxpelthanging", {
    description = S"Muskox Pelt hanging",
    visual_scale = 1.0,
    mesh = "Bearpelthanging.b3d",
    tiles = {"texturemuskoxpelt.png"},
    inventory_image = "amuskoxpelt.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            --[[{-0.8, -0.9, 0.4, 0.8, 0.8, 0.5},
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.8, -0.9, 0.4, 0.8, 0.8, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:muskoxpelthanging",
	burntime = 2,
})

minetest.register_craftitem("animalworld:muskoxcorpse", {
	description = S("Muskox Corpse"),
	inventory_image = "animalworld_muskoxcorpse.png",
})

minetest.register_craft({
	output = "animalworld:muskoxtrophy",
	type = "shapeless",
	recipe = 
		{"animalworld:muskoxcorpse", "default:axe_stone", "group:wood"}

	
})

minetest.register_craft({
	output = "animalworld:muskoxpelt",
	type = "shapeless",
	recipe = 
		{"animalworld:muskoxcorpse", "default:sword_stone"}

	
})

minetest.register_craft({
	output = "animalworld:muskoxpelthanging",
	type = "shapeless",
	recipe = 
		{"animalworld:muskoxcorpse", "default:sword_stone", "default:sign_wall_wood"}

	
})

minetest.register_node("animalworld:muskoxstool", {
    description = S"Muskox Stool",
    visual_scale = 1.0,
    mesh = "Stool.b3d",
    tiles = {"texturemuskoxstool.png"},
    inventory_image = "amuskoxstool.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
    sounds = animalworld.sounds.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:muskoxstool",
	burntime = 2,
})

minetest.register_craft({
	output = "animalworld:muskoxstool",
	type = "shapeless",
	recipe = 
		{"animalworld:muskoxcorpse", "default:axe_stone", "group:wood", "default:stick"}

})
