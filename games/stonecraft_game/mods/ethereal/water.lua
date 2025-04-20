
local S = minetest.get_translator("ethereal")

-- Thin Ice

local math_random = math.random

minetest.register_node("ethereal:thin_ice", {
	description = S("Thin Ice"),
	tiles = {"default_ice.png^[opacity:80"},
	inventory_image = "default_ice.png^[opacity:80",
	wield_image = "default_ice.png^[opacity:80",
	use_texture_alpha = "blend",
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	drop = {},
	node_box = {
		type = "fixed", fixed = {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
	},
	collision_box = {
		type = "fixed", fixed = {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
	},
	groups = {cracky = 3, crumbly = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_glass_defaults(),

	on_walk_over = function(pos, node, player)

		if math_random(13) == 1 then -- ice breaks if player unlucky

			minetest.sound_play("default_ice_dug",
					{pos = pos, gain = 0.5, pitch = 1.4, max_hear_distance = 5}, true)

			minetest.remove_node(pos)
		end
	end
})

-- Ice Brick

minetest.register_node("ethereal:icebrick", {
	description = S("Ice Brick"),
	tiles = {"ethereal_brick_ice.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {cracky = 3, puts_out_fire = 1, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft({
	output = "ethereal:icebrick 4",
	recipe = {
		{"default:ice", "default:ice"},
		{"default:ice", "default:ice"}
	}
})

-- Snow Brick

minetest.register_node("ethereal:snowbrick", {
	description = S("Snow Brick"),
	tiles = {"ethereal_brick_snow.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 3, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
		dug = {name = "default_snow_footstep", gain = 0.2},
		dig = {name = "default_snow_footstep", gain = 0.2}
	})
})

minetest.register_craft({
	output = "ethereal:snowbrick 4",
	recipe = {
		{"default:snowblock", "default:snowblock"},
		{"default:snowblock", "default:snowblock"}
	}
})

-- If Crystal Spike or Snowblock near Water, change Water to Ice

minetest.register_abm({
	label = "Ethereal freeze water",
	nodenames = {
		"ethereal:crystal_spike", "default:snowblock", "ethereal:snowbrick"
	},
	neighbors = {"default:water_source", "default:river_water_source"},
	interval = 15,
	chance = 4,
	catch_up = false,

	action = function(pos, node)

		local near = minetest.find_node_near(pos, 1,
				{"default:water_source", "default:river_water_source"})

		if near then
			minetest.swap_node(near, {name = "default:ice"})
		end
	end
})

-- If Heat Source near Ice or Snow then melt.

minetest.register_abm({
	label = "Ethereal melt snow/ice",
	nodenames = {
		"default:ice", "default:snowblock", "default:snow", "ethereal:thin_ice",
		"default:dirt_with_snow", "ethereal:snowbrick", "ethereal:icebrick"
	},
	neighbors = {
		"fire:basic_flame", "default:lava_source", "default:lava_flowing",
		"default:furnace_active", "default:torch", "default:torch_wall",
		"default:torch_ceiling", "fire:permanent_flame"
	},
	interval = 7,
	chance = 4,
	catch_up = false,

	action = function(pos, node)

		local water_node = "default:water"

		if pos.y > 2 then
			water_node = "default:river_water"
		end

		if node.name == "default:ice"
		or node.name == "default:snowblock"
		or node.name == "ethereal:icebrick"
		or node.name == "ethereal:snowbrick" then
			minetest.swap_node(pos, {name = water_node .. "_source"})

		elseif node.name == "default:snow"
		or node.name == "ethereal:thin_ice" then
			minetest.swap_node(pos, {name = water_node .. "_flowing"})

		elseif node.name == "default:dirt_with_snow" then
			minetest.swap_node(pos, {name = "default:dirt_with_grass"})
		end

		ethereal.check_falling(pos)
	end
})

-- If Water Source near Dry Dirt, change to normal Dirt

minetest.register_abm({
	label = "Ethereal wet dry dirt",
	nodenames = {
		"ethereal:dry_dirt", "default:dirt_with_dry_grass",
		"default:dry_dirt", "default:dry_dirt_with_dry_grass"
	},
	neighbors = {"group:water"},
	interval = 15,
	chance = 3,
	catch_up = false,

	action = function(pos, node)

		if node.name == "ethereal:dry_dirt" or node.name == "default:dry_dirt" then
			minetest.swap_node(pos, {name = "default:dirt"})
		elseif node.name == "default:dirt_with_dry_grass" then
			minetest.swap_node(pos, {name = "default:dirt_with_grass"})
		else
			minetest.swap_node(pos, {name = "default:dirt_with_dry_grass"})
		end
	end
})

-- when enabled, override torches so they drop when touching water

if ethereal.torchdrop == true and not minetest.get_modpath("real_torch") then

	local function on_flood(pos, oldnode, newnode)

		minetest.add_item(pos, ItemStack("default:torch 1"))

		local def = minetest.registered_items[newnode.name]

		if def and def.groups and def.groups.water and def.groups.water > 0 then

			minetest.sound_play("default_cool_lava",
					{pos = pos, max_hear_distance = 10, gain = 0.1}, true)
		end

		return false -- remove node
	end

	local function torch_override(name)
		minetest.override_item("default:" .. name, {on_flood = on_flood})
	end

	torch_override("torch")
	torch_override("torch_wall")
	torch_override("torch_ceiling")
end
