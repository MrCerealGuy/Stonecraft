local S = minetest.get_translator("marinara")

  stairs.register_stair_and_slab(
      "marinara_reed_node",
      "marinara:reed_bundle",
      {snappy = 3, oddly_breakable_by_hand = 0, flammable = 0},
      {"marinara_reed_node_top.png", "marinara_reed_node.png", "marinara_reed_node_top.png"},
      S("Reed Node Stair"),
      S("Reed Node Slab"),
      default.node_sound_leaves_defaults()
    )

minetest.register_node("marinara:reed_bundle", {
	description = S("Reed Node"),
	tiles = {
		"marinara_reed_node.png",
		"marinara_reed_node.png",
		"marinara_reed_node_top.png"
	},
	is_ground_content = false,
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "marinara:reed_bundle",
	type = "shapeless",
	recipe = 
		{"marinara:reed", "marinara:reed"}

})

minetest.register_craft({
	output = "marinara:reed_bundle",
	type = "shapeless",
	recipe = 
		{"marinara:reed_root", "marinara:reed_root"}

})

minetest.register_node("marinara:bountychest", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:steel_ingot 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest2", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "tnt:gunpowder 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest3", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:axe_bronze 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest4", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "farming:seed_wheat 10",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest5", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:sword_steel 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest6", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:gold_ingot 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest7", {
	description = ("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "farming:string 6",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest8", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:book 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest9", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:mese_crystal_fragment 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest10", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:pick_bronze 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest11", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "default:obsidian_shard 1",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:bountychest12", {
	description = S("Bounty Chest"),
tiles = {
		"marinara_bootynode_top.png",
		"marinara_bootynode_bottom.png",
		"marinara_bootynode_right.png",
		"marinara_bootynode_left.png",
		"marinara_bootynode_back.png",
		"marinara_bootynode_front.png"
	},
groups = {wood = 1, choppy = 2, flammable = 2},
	drop = "farming:seed_cotton 10",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marinara:sand_with_seashells", {
	description = S("Sand with Seashells"),
	tiles = {"default_sand.png^marinara_seashells.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile",
	type = "shapeless",
	recipe = 
		{"marinara:seashells", "farming:string"}

})

minetest.register_craftitem("marinara:seashells", {
	description = S("Seashells"),
	inventory_image = "marinara_seashells.png",
})

minetest.register_node("marinara:seashellmobile", {
	description = S("Seashell Mobile"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile.png"},
	inventory_image = "marinara_seashellmobile.png",
	wield_image = "marinara_seashellmobile.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

walls.register(":marinara:coastbrick_wall", S"Coast Brick Wall", "marinara_coastbrick.png",
		"marinara:coastbrick_wall", default.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "marinara_coastbrick",
      "marinara:coastbricks",
      {cracky = 1, oddly_breakable_by_hand = 0, flammable = 0},
      {"marinara_coastbrick.png"},
      S("Coast Rock Brick Stair"),
      S("Coast Rock Brick Slab"),
      default.node_sound_stone_defaults()
    )

minetest.register_node("marinara:coastbricks", {
	description = S("Coast Bricks"),
	tiles = {"marinara_coastbrick.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "marinara:coastbricks",
	type = "shapeless",
	recipe = 
		{"marinara:coastrock", "marinara:coastrock"}

	
})

minetest.register_craft({
	output = "marinara:coastbrick_wall",
	type = "shapeless",
	recipe = 
		{"marinara:coastbricks"}

	
})

walls.register(":marinara:coastbrick_wall_alage", S"Coast Brick Wall with Alage", "marinara_coastbrick_alage.png",
		"marinara:coastbrick_wall_alage", default.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "marinara_coastbrick_alage",
      "marinara:coastbricks_alage",
      {cracky = 1, oddly_breakable_by_hand = 0, flammable = 0},
      {"marinara_coastbrick_alage.png"},
     S("Coast Rock Brick Stair with Alage"),
      S("Coast Rock Brick Slab with Alage"),
      default.node_sound_stone_defaults()
    )

minetest.register_node("marinara:coastbricks_alage", {
	description = S("Coast Bricks with Alage"),
	tiles = {"marinara_coastbrick_alage.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "marinara:coastbricks_alage",
	type = "shapeless",
	recipe = 
		{"marinara:coastrock_alage", "marinara:coastrock_alage"}

	
})

minetest.register_craft({
	output = "marinara:coastbrick_wall_alage",
	type = "shapeless",
	recipe = 
		{"marinara:coastbricks_alage"}

	
})

minetest.register_node("marinara:sand_with_seashells_orange", {
	description = S("Sand with Seashells Orange"),
	tiles = {"default_sand.png^marinara_seashells_orange.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells_orange",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile_orange",
	type = "shapeless",
	recipe = 
		{"marinara:seashells_orange", "farming:string"}

})

minetest.register_craftitem("marinara:seashells_orange", {
	description = S("Seashells Orange"),
	inventory_image = "marinara_seashells_orange.png",
})

minetest.register_node("marinara:seashellmobile_orange", {
	description = S("Seashell Mobile Orange"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile_orange.png"},
	inventory_image = "marinara_seashellmobile_orange.png",
	wield_image = "marinara_seashellmobile_orange.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("marinara:sand_with_seashells_broken", {
	description = S("Sand with Seashells Broken"),
	tiles = {"default_sand.png^marinara_seashells_broken.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells_broken",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile_broken",
	type = "shapeless",
	recipe = 
		{"marinara:seashells_broken", "farming:string"}

})

minetest.register_craftitem("marinara:seashells_broken", {
	description = S("Seashells Broken"),
	inventory_image = "marinara_seashells_broken.png",
})

minetest.register_node("marinara:seashellmobile_broken", {
	description = S("Seashell Mobile Broken"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile_broken.png"},
	inventory_image = "marinara_seashellmobile_broken.png",
	wield_image = "marinara_seashellmobile_broken.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("marinara:sand_with_seashells_pink", {
	description = S("Sand with Seashells Pink"),
	tiles = {"default_sand.png^marinara_seashells_pink.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells_pink",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile_pink",
	type = "shapeless",
	recipe = 
		{"marinara:seashells_pink", "farming:string"}

})

minetest.register_craftitem("marinara:seashells_pink", {
	description = S("Seashells Pink"),
	inventory_image = "marinara_seashells_pink.png",
})

minetest.register_node("marinara:seashellmobile_pink", {
	description = S("Seashell Mobile Pink"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile_pink.png"},
	inventory_image = "marinara_seashellmobile_pink.png",
	wield_image = "marinara_seashellmobile_pink.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("marinara:sand_with_seashells_brown", {
	description = S("Sand with Seashells Brown"),
	tiles = {"default_sand.png^marinara_seashells_brown.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells_brown",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile_brown",
	type = "shapeless",
	recipe = 
		{"marinara:seashells_brown", "farming:string"}

})

minetest.register_craftitem("marinara:seashells_brown", {
	description = S("Seashells Brown"),
	inventory_image = "marinara_seashells_brown.png",
})

minetest.register_node("marinara:seashellmobile_brown", {
	description = S("Seashell Mobile Brown"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile_brown.png"},
	inventory_image = "marinara_seashellmobile_brown.png",
	wield_image = "marinara_seashellmobile_brown.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("marinara:sand_with_seashells_yellow", {
	description = S("Sand with Seashells Yellow"),
	tiles = {"default_sand.png^marinara_seashells_yellow.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells_yellow",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile_yellow",
	type = "shapeless",
	recipe = 
		{"marinara:seashells_yellow", "farming:string"}

})

minetest.register_craftitem("marinara:seashells_yellow", {
	description = S("Seashells Yellow"),
	inventory_image = "marinara_seashells_yellow.png",
})

minetest.register_node("marinara:seashellmobile_yellow", {
	description = S("Seashell Mobile Yellow"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile_yellow.png"},
	inventory_image = "marinara_seashellmobile_yellow.png",
	wield_image = "marinara_seashellmobile_yellow.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("marinara:sand_with_seashells_white", {
	description = S("Sand with Seashells White"),
	tiles = {"default_sand.png^marinara_seashells_white.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "marinara:seashells_white",
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	output = "marinara:seashellmobile_white",
	type = "shapeless",
	recipe = 
		{"marinara:seashells_white", "farming:string"}

})

minetest.register_craftitem("marinara:seashells_white", {
	description = S("Seashells White"),
	inventory_image = "marinara_seashells_white.png",
})

minetest.register_node("marinara:seashellmobile_white", {
	description = S("Seashell Mobile White"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinara_seashellmobile_white.png"},
	inventory_image = "marinara_seashellmobile_white.png",
	wield_image = "marinara_seashellmobile_white.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})