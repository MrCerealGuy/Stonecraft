local S = minetest.get_translator("animalworld")

walls.register(":animalworld:termiteconcrete_wall", S"Termite Concrete Wall", "termiteconcrete.png",
		"animalworld:termiteconcrete_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcrete",
      "animalworld:termiteconcrete",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcrete.png"},
      S("Termite Concrete Stair"),
      S("Termite Concrete Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcrete_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "animalworld:termiteconcrete", "animalworld:termiteconcrete", "animalworld:termiteconcrete", "animalworld:termiteconcrete", "animalworld:termiteconcrete"}

	
})

walls.register(":animalworld:termiteconcretewhite_wall", S"Termite Concrete White Wall", "termiteconcretewhite.png",
		"animalworld:termiteconcretewhite_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretewhite",
      "animalworld:termiteconcretewhite",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretewhite.png"},
      S("Termite Concrete White Stair"),
      S("Termite Concrete White Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretewhite_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretewhite", "animalworld:termiteconcretewhite", "animalworld:termiteconcretewhite", "animalworld:termiteconcretewhite", "animalworld:termiteconcretewhite", "animalworld:termiteconcretewhite"}

	
})

walls.register(":animalworld:termiteconcretegrey_wall", S"Termite Concrete Grey Wall", "termiteconcretegrey.png",
		"animalworld:termiteconcretegrey_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretegrey",
      "animalworld:termiteconcretegrey",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretegrey.png"},
      S("Termite Concrete Grey Stair"),
      S("Termite Concrete Grey Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretegrey_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretegrey", "animalworld:termiteconcretegrey", "animalworld:termiteconcretegrey", "animalworld:termiteconcretegrey", "animalworld:termiteconcretegrey", "animalworld:termiteconcretegrey"}

	
})

walls.register(":animalworld:termiteconcreteblack_wall", S"Termite Concrete Black Wall", "termiteconcreteblack.png",
		"animalworld:termiteconcreteblack_wall", default.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcreteblack",
      "animalworld:termiteconcreteblack",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcreteblack.png"},
      S("Termite Concrete Black Stair"),
     S("Termite Concrete Black Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcreteblack_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcreteblack", "animalworld:termiteconcreteblack", "animalworld:termiteconcreteblack", "animalworld:termiteconcreteblack", "animalworld:termiteconcreteblack", "animalworld:termiteconcreteblack"}

	
})

walls.register(":animalworld:termiteconcreteblue_wall", S"Termite Concrete Blue Wall", "termiteconcreteblue.png",
		"animalworld:termiteconcreteblue_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcreteblue",
      "animalworld:termiteconcreteblue",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcreteblue.png"},
      S("Termite Concrete Blue Stair"),
      S("Termite Concrete Blue Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcreteblue_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcreteblue", "animalworld:termiteconcreteblue", "animalworld:termiteconcreteblue", "animalworld:termiteconcreteblue", "animalworld:termiteconcreteblue", "animalworld:termiteconcreteblue"}

	
})

walls.register(":animalworld:termiteconcretecyan_wall", S"Termite Concrete Cyan Wall", "termiteconcretecyan.png",
		"animalworld:termiteconcretecyan_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretecyan",
      "animalworld:termiteconcretecyan",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretecyan.png"},
      S("Termite Concrete Cyan Stair"),
      S("Termite Concrete Cyan Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretecyan_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretecyan", "animalworld:termiteconcretecyan", "animalworld:termiteconcretecyan", "animalworld:termiteconcretecyan", "animalworld:termiteconcretecyan", "animalworld:termiteconcretecyan"}

	
})

walls.register(":animalworld:termiteconcretegreen_wall", S"Termite Concrete Green Wall", "termiteconcretegreen.png",
		"animalworld:termiteconcretegreen_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretegreen",
      "animalworld:termiteconcretegreen",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretegreen.png"},
      S("Termite Concrete Green Stair"),
      S("Termite Concrete Green Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretegreen_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretegreen", "animalworld:termiteconcretegreen", "animalworld:termiteconcretegreen", "animalworld:termiteconcretegreen", "animalworld:termiteconcretegreen", "animalworld:termiteconcretegreen"}

	
})

walls.register(":animalworld:termiteconcretedarkgreen_wall", S"Termite Concrete Dark Green Wall", "termiteconcretedarkgreen.png",
		"animalworld:termiteconcretedarkgreen_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretedarkgreen",
      "animalworld:termiteconcretedarkgreen",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretedarkgreen.png"},
      S("Termite Concrete Dark Green Stair"),
      S("Termite Concrete Dark Green Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretedarkgreen_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretedarkgreen", "animalworld:termiteconcretedarkgreen", "animalworld:termiteconcretedarkgreen", "animalworld:termiteconcretedarkgreen", "animalworld:termiteconcretedarkgreen", "animalworld:termiteconcretedarkgreen"}

	
})

walls.register(":animalworld:termiteconcreteyellow_wall", S"Termite Concrete Yellow Wall", "termiteconcreteyellow.png",
		"animalworld:termiteconcreteyellow_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcreteyellow",
      "animalworld:termiteconcreteyellow",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcreteyellow.png"},
      S("Termite Concrete Yellow Stair"),
      S("Termite Concrete Yellow Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcreteyellow_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcreteyellow", "animalworld:termiteconcreteyellow", "animalworld:termiteconcreteyellow", "animalworld:termiteconcreteyellow", "animalworld:termiteconcreteyellow", "animalworld:termiteconcreteyellow"}

	
})

walls.register(":animalworld:termiteconcreteorange_wall", S"Termite Concrete Orange Wall", "termiteconcreteorange.png",
		"animalworld:termiteconcreteorange_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcreteorange",
      "animalworld:termiteconcreteorange",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcreteorange.png"},
     S("Termite Concrete Orange Stair"),
      S("Termite Concrete Orange Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcreteorange_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcreteorange", "animalworld:termiteconcreteorange", "animalworld:termiteconcreteorange", "animalworld:termiteconcreteorange", "animalworld:termiteconcreteorange", "animalworld:termiteconcreteorange"}

	
})

walls.register(":animalworld:termiteconcretebrown_wall", S"Termite Concrete Brown Wall", "termiteconcretebrown.png",
		"animalworld:termiteconcretebrown_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretebrown",
      "animalworld:termiteconcretebrown",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretebrown.png"},
      S("Termite Concrete Brown Stair"),
      S("Termite Concrete Brown Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretebrown_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretebrown", "animalworld:termiteconcretebrown", "animalworld:termiteconcretebrown", "animalworld:termiteconcretebrown", "animalworld:termiteconcretebrown", "animalworld:termiteconcretebrown"}

	
})

walls.register(":animalworld:termiteconcretered_wall", S"Termite Concrete Red Wall", "termiteconcretered.png",
		"animalworld:termiteconcretered_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretered",
      "animalworld:termiteconcretered",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretered.png"},
      S("Termite Concrete Red Stair"),
      S("Termite Concrete Red Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretered_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretered", "animalworld:termiteconcretered", "animalworld:termiteconcretered", "animalworld:termiteconcretered", "animalworld:termiteconcretered", "animalworld:termiteconcretered"}

	
})

walls.register(":animalworld:termiteconcretepink_wall", S"Termite Concrete Pink Wall", "termiteconcretepink.png",
		"animalworld:termiteconcretepink_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretepink",
      "animalworld:termiteconcretepink",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretepink.png"},
      S("Termite Concrete Pink Stair"),
      S("Termite Concrete Pink Slab"),
       animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretepink_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretepink", "animalworld:termiteconcretepink", "animalworld:termiteconcretepink", "animalworld:termiteconcretepink", "animalworld:termiteconcretepink", "animalworld:termiteconcretepink"}

	
})

walls.register(":animalworld:termiteconcretemagenta_wall", S"Termite Concrete Magenta Wall", "termiteconcretemagenta.png",
		"animalworld:termiteconcretemagenta_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcretemagenta",
      "animalworld:termiteconcretemagenta",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcretemagenta.png"},
      S("Termite Concrete Magenta Stair"),
      S("Termite Concrete Magenta Slab"),
       animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcretemagenta_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcretemagenta", "animalworld:termiteconcretemagenta", "animalworld:termiteconcretemagenta", "animalworld:termiteconcretemagenta", "animalworld:termiteconcretemagenta", "animalworld:termiteconcretemagenta"}

	
})

walls.register(":animalworld:termiteconcreteviolet_wall", S"Termite Concrete Violet Wall", "termiteconcreteviolet.png",
		"animalworld:termiteconcreteviolet_wall", animalworld.sounds.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "termiteconcreteviolet",
      "animalworld:termiteconcreteviolet",
      {cracky = 2, oddly_breakable_by_hand = 0, flammable = 0},
      {"termiteconcreteviolet.png"},
      S("Termite Concrete Violet Stair"),
      S("Termite Concrete Violet Slab"),
      animalworld.sounds.node_sound_stone_defaults()
    )

minetest.register_craft({
	output = "animalworld:termiteconcreteviolet_wall",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcreteviolet", "animalworld:termiteconcreteviolet", "animalworld:termiteconcreteviolet", "animalworld:termiteconcreteviolet", "animalworld:termiteconcreteviolet", "animalworld:termiteconcreteviolet"}

	
})

