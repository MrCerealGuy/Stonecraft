
-- translator and protection check setting

local S = minetest.get_translator("ethereal")
local sapling_protection_check = minetest.settings:get_bool(
		"ethereal.sapling_protection_check", false)

-- sapling placement helper

local function prepare_on_place(itemstack, placer, pointed_thing, name, w, h)

	if sapling_protection_check then

		-- check if grown tree area intersects any players protected area
		return default.sapling_on_place(itemstack, placer, pointed_thing,
				name, {x = -w, y = 1, z = -w}, {x = w, y = h, z = w}, 4)
	end

	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	-- Check if node clicked on has it's own on_rightclick function
	if pdef and pdef.on_rightclick
	and not (placer and placer:is_player() and placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	-- place normally
	return minetest.item_place_node(itemstack, placer, pointed_thing)
end

-- Basandra Bush Sapling

minetest.register_node("ethereal:basandra_bush_sapling", {
	description = S("Basandra Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"ethereal_basandra_bush_sapling.png"},
	inventory_image = "ethereal_basandra_bush_sapling.png",
	wield_image = "ethereal_basandra_bush_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, attached_node = 1, ethereal_sapling = 1,
			sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
	grown_height = 2,

	on_place = function(itemstack, placer, pointed_thing)
		return prepare_on_place(itemstack, placer, pointed_thing,
				"ethereal:basandra_bush_sapling", 1, 2)
	end
})

-- Bamboo Sprout

minetest.register_node("ethereal:bamboo_sprout", {
	description = S("Bamboo Sprout"),
	drawtype = "plantlike",
	tiles = {"ethereal_bamboo_sprout.png"},
	inventory_image = "ethereal_bamboo_sprout.png",
	wield_image = "ethereal_bamboo_sprout.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {
		food_bamboo_sprout = 1, snappy = 3, attached_node = 1, flammable = 2,
		dig_immediate = 3, ethereal_sapling = 1, sapling = 1,
	},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -0.1, 3 / 16}
	},
	on_use = minetest.item_eat(2),
	grown_height = 11,

	on_place = function(itemstack, placer, pointed_thing)
		return prepare_on_place(itemstack, placer, pointed_thing,
				"ethereal:bamboo_sprout", 1, 18)
	end
})

-- register Sapling helper

local function register_sapling(name, desc, texture, width, height)

	minetest.register_node(name .. "_sapling", {
		description = S(desc .. " Tree Sapling"),
		drawtype = "plantlike",
		tiles = {texture .. ".png"},
		inventory_image = texture .. ".png",
		wield_image = texture .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		selection_box = {
			type = "fixed", fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
		},
		groups = {
			snappy = 2, dig_immediate = 3, flammable = 2,
			ethereal_sapling = 1, attached_node = 1, sapling = 1
		},
		sounds = default.node_sound_leaves_defaults(),
		grown_height = height,

		on_place = function(itemstack, placer, pointed_thing)
			return prepare_on_place(itemstack, placer, pointed_thing,
					name .. "_sapling", width, height)
		end
	})
end

-- add saplings

register_sapling("ethereal:willow", "Willow", "ethereal_willow_sapling", 5, 14)
register_sapling("ethereal:yellow_tree", "Healing", "ethereal_yellow_tree_sapling", 4, 19)
register_sapling("ethereal:big_tree", "Big", "ethereal_big_tree_sapling", 4, 7)
register_sapling("ethereal:banana_tree", "Banana", "ethereal_banana_tree_sapling", 3, 8)
register_sapling("ethereal:frost_tree", "Frost", "ethereal_frost_tree_sapling", 4, 19)
register_sapling("ethereal:mushroom", "Mushroom", "ethereal_mushroom_sapling", 4, 11)
register_sapling("ethereal:mushroom_brown", "Brown Mushroom",
		"ethereal_mushroom_brown_sapling", 1, 11)
register_sapling("ethereal:palm", "Palm", "moretrees_palm_sapling", 4, 9)
register_sapling("ethereal:giant_redwood", "Giant Redwood",
		"ethereal_giant_redwood_sapling", 7, 33)
register_sapling("ethereal:redwood", "Redwood", "ethereal_redwood_sapling", 4, 21)
register_sapling("ethereal:orange_tree", "Orange", "ethereal_orange_tree_sapling", 2, 6)
register_sapling("ethereal:birch", "Birch", "moretrees_birch_sapling", 2, 7)
register_sapling("ethereal:sakura", "Sakura", "ethereal_sakura_sapling", 4, 10)
register_sapling("ethereal:lemon_tree", "Lemon", "ethereal_lemon_tree_sapling", 2, 7)
register_sapling("ethereal:olive_tree", "Olive", "ethereal_olive_tree_sapling", 3, 10)

-- add tree schematic

local function add_tree(pos, schem, replace)

	minetest.swap_node(pos, {name = "air"})

	minetest.place_schematic(pos, schem, "random", replace, false,
			"place_center_x, place_center_z")
end

-- get mod path and schematic folder

local path = minetest.get_modpath("ethereal") .. "/schematics/"

-- global tree grow functions

function ethereal.grow_basandra_bush(pos)
	add_tree(pos, ethereal.basandrabush)
end

function ethereal.grow_yellow_tree(pos)
	add_tree(pos, ethereal.yellowtree)
end

function ethereal.grow_big_tree(pos)
	add_tree(pos, ethereal.bigtree)
end

function ethereal.grow_banana_tree(pos)

	if math.random(2) == 1 and minetest.find_node_near(pos, 1, {"farming:soil_wet"}) then

		add_tree(pos, ethereal.bananatree,
				{{"ethereal:banana", "ethereal:banana_bunch"}})
	else
		add_tree(pos, ethereal.bananatree)
	end
end

function ethereal.grow_frost_tree(pos)
	add_tree(pos, ethereal.frosttrees)
end

function ethereal.grow_mushroom_tree(pos)
	add_tree(pos, ethereal.mushroomone)
end

function ethereal.grow_mushroom_brown_tree(pos)
	add_tree(pos, ethereal.mushroomtwo)
end

function ethereal.grow_palm_tree(pos)
	add_tree(pos, ethereal.palmtree)
end

function ethereal.grow_willow_tree(pos)
	add_tree(pos, ethereal.willow)
end

function ethereal.grow_redwood_tree(pos)
	add_tree(pos, ethereal.redwood_small_tree)
end

function ethereal.grow_giant_redwood_tree(pos)
	add_tree(pos, ethereal.redwood_tree)
end

function ethereal.grow_orange_tree(pos)
	add_tree(pos, ethereal.orangetree)
end

function ethereal.grow_bamboo_tree(pos)
	add_tree(pos, ethereal.bambootree)
end

function ethereal.grow_birch_tree(pos)
	add_tree(pos, ethereal.birchtree)
end

function ethereal.grow_sakura_tree(pos)

	if math.random(10) == 1 then

		add_tree(pos, ethereal.sakura_tree,
				{{"ethereal:sakura_leaves", "ethereal:sakura_leaves2"}})
	else
		add_tree(pos, ethereal.sakura_tree)
	end
end

function ethereal.grow_lemon_tree(pos)
	add_tree(pos, ethereal.lemontree)
end

function ethereal.grow_olive_tree(pos)
	add_tree(pos, ethereal.olivetree)
end

-- return True if sapling has enough height room to grow

local function enough_height(pos, height)

	return minetest.line_of_sight(
		{x = pos.x, y = pos.y + 1, z = pos.z},
		{x = pos.x, y = pos.y + height, z = pos.z})
end

-- global function run by Abm

function ethereal.grow_sapling(pos, node)

	if (minetest.get_node_light(pos) or 0) < 13 then return end

	-- get node below sapling
	local under =  minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name
	local def = minetest.registered_nodes[node.name] ; if not def then return end
	local height = def.grown_height or 33

	-- do we have enough height to grow sapling into tree?
	if not height or not enough_height(pos, height) then return end

	-- check if Ethereal Sapling is growing on correct substrate
	if node.name == "ethereal:basandra_bush_sapling"
	and under == "ethereal:fiery_dirt" then ethereal.grow_basandra_bush(pos)

	elseif node.name == "ethereal:yellow_tree_sapling"
	and minetest.get_item_group(under, "soil") > 0 then ethereal.grow_yellow_tree(pos)

	elseif node.name == "ethereal:big_tree_sapling"
	and under == "default:dirt_with_grass" then ethereal.grow_big_tree(pos)

	elseif node.name == "ethereal:banana_tree_sapling"
	and under == "ethereal:grove_dirt" then ethereal.grow_banana_tree(pos)

	elseif node.name == "ethereal:frost_tree_sapling"
	and under == "ethereal:crystal_dirt" then ethereal.grow_frost_tree(pos)

	elseif node.name == "ethereal:mushroom_sapling"
	and under == "ethereal:mushroom_dirt" then ethereal.grow_mushroom_tree(pos)

	elseif node.name == "ethereal:mushroom_brown_sapling"
	and under == "ethereal:mushroom_dirt" then ethereal.grow_mushroom_brown_tree(pos)

	elseif node.name == "ethereal:palm_sapling"
	and under == "default:sand" then ethereal.grow_palm_tree(pos)

	elseif node.name == "ethereal:willow_sapling"
	and under == "ethereal:gray_dirt" then ethereal.grow_willow_tree(pos)

	elseif node.name == "ethereal:redwood_sapling"
	and under == "default:dirt_with_dry_grass" then ethereal.grow_redwood_tree(pos)

	elseif node.name == "ethereal:giant_redwood_sapling"
	and under == "default:dirt_with_dry_grass" then ethereal.grow_giant_redwood_tree(pos)

	elseif node.name == "ethereal:orange_tree_sapling"
	and under == "ethereal:prairie_dirt" then ethereal.grow_orange_tree(pos)

	elseif node.name == "ethereal:bamboo_sprout"
	and under == "ethereal:bamboo_dirt" then ethereal.grow_bamboo_tree(pos)

	elseif node.name == "ethereal:birch_sapling"
	and under == "default:dirt_with_grass" then ethereal.grow_birch_tree(pos)

	elseif node.name == "ethereal:sakura_sapling"
	and under == "ethereal:bamboo_dirt" then ethereal.grow_sakura_tree(pos)

	elseif node.name == "ethereal:olive_tree_sapling"
	and under == "ethereal:grove_dirt" then ethereal.grow_olive_tree(pos)

	elseif node.name == "ethereal:lemon_tree_sapling"
	and under == "ethereal:grove_dirt" then ethereal.grow_lemon_tree(pos) end
end

-- grow saplings Abm

minetest.register_abm({
	label = "Ethereal grow sapling",
	nodenames = {"group:ethereal_sapling"},
	interval = 10,
	chance = 50,
	catch_up = false,
	action = ethereal.grow_sapling
})

-- 2x redwood saplings make 1x giant redwood sapling

minetest.register_craft({
	output = "ethereal:giant_redwood_sapling",
	recipe = {{"ethereal:redwood_sapling", "ethereal:redwood_sapling"}}
})
