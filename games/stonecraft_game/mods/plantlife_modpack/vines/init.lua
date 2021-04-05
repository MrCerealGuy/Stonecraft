vines = {
	name = 'vines',
	recipes = {}
}

local enable_roots = minetest.settings:get_bool("vines_enable_roots")

-- support for i18n
local S = minetest.get_translator("vines")

-- ITEMS

minetest.register_craftitem("vines:vines", {
	description = S("Vines"),
	inventory_image = "vines_item.png",
	groups = {vines = 1, flammable = 2}
})

-- FUNCTIONS

local function dig_down(pos, node, digger)

	if digger == nil then return end

	local np = {x = pos.x, y = pos.y - 1, z = pos.z}
	local nn = minetest.get_node(np)

	if minetest.get_item_group(nn.name, "vines") > 0 then
		minetest.node_dig(np, nn, digger)
	end
end


vines.register_vine = function( name, defs, biome )

	local groups = {vines = 1, snappy = 3, flammable = 2, attached_node = 1}
	local vine_name_end = 'vines:' .. name .. '_end'
	local vine_name_middle = 'vines:' .. name .. '_middle'
	local vine_image_end = "vines_" .. name .. "_end.png"
	local vine_image_middle = "vines_" .. name .. "_middle.png"
	local drop_node = vine_name_end

	biome.spawn_plants = {vine_name_end}

	local vine_group = 'group:' .. name .. '_vines'

	biome.spawn_surfaces[#biome.spawn_surfaces + 1] = vine_group

	local selection_box = {type = "wallmounted",}
	local drawtype = 'signlike'

	-- different properties for bottom and side vines.
	if not biome.spawn_on_side then

		selection_box = {
			type = "fixed", fixed = { -0.4, -1/2, -0.4, 0.4, 1/2, 0.4 }
		}

		drawtype = 'plantlike'
	end

	minetest.register_node(vine_name_end, {
		description = defs.description,
		walkable = false,
		climbable = true,
		wield_image = vine_image_end,
		drop = "vines:vines",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "wallmounted",
		buildable_to = false,
		tiles = {vine_image_end},
		drawtype = drawtype,
		inventory_image = vine_image_end,
		groups = groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = selection_box,

		on_construct = function(pos)

			local timer = minetest.get_node_timer(pos)

			timer:start(math.random(5, 10))
		end,

		on_timer = function(pos)

			local node = minetest.get_node(pos)
			local bottom = {x = pos.x, y = pos.y - 1, z = pos.z}
			local bottom_node = minetest.get_node( bottom )

			if bottom_node.name == "air" then

				if not math.random(defs.average_length) == 1 then

					minetest.set_node(pos, {
							name = vine_name_middle, param2 = node.param2})

					minetest.set_node(bottom, {
							name = node.name, param2 = node.param2})

					local timer = minetest.get_node_timer(bottom_node)

					timer:start(math.random(5, 10))
				end
			end
		end,

		after_dig_node = function(pos, node, metadata, digger)
			dig_down(pos, node, digger)
		end,
	})

	minetest.register_node( vine_name_middle, {
		description = S("Matured") .. " " .. defs.description,
		walkable = false,
		climbable = true,
		drop = "vines:vines",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "wallmounted",
		buildable_to = false,
		tiles = {vine_image_middle},
		wield_image = vine_image_middle,
		drawtype = drawtype,
		inventory_image = vine_image_middle,
		groups = groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = selection_box,

		after_dig_node = function(pos, node, metadata, digger)
			dig_down(pos, node, digger)
		end,
	})

	biome_lib:spawn_on_surfaces(biome)
end

-- ALIASES

-- used to remove the old vine nodes and give room for the new.
minetest.register_alias( 'vines:root', 'air' )
minetest.register_alias( 'vines:root_rotten', 'air' )
minetest.register_alias( 'vines:vine', 'air' )
minetest.register_alias( 'vines:vine_rotten', 'air' )
minetest.register_alias( 'vines:side', 'air' )
minetest.register_alias( 'vines:side_rotten', 'air' )
minetest.register_alias( 'vines:jungle', 'air' )
minetest.register_alias( 'vines:jungle_rotten', 'air' )
minetest.register_alias( 'vines:willow', 'air' )
minetest.register_alias( 'vines:willow_rotten', 'air' )

-- CRAFTS

minetest.register_craft({
	output = 'vines:rope_block',
	recipe = {
		{'group:vines', 'group:vines', 'group:vines'},
		{'group:vines', 'group:wood', 'group:vines'},
		{'group:vines', 'group:vines', 'group:vines'},
	}
})

if minetest.get_modpath("moreblocks") then

	minetest.register_craft({
		output = 'vines:rope_block',
		recipe = {
			{'moreblocks:rope', 'moreblocks:rope', 'moreblocks:rope'},
			{'moreblocks:rope', 'group:wood', 'moreblocks:rope'},
			{'moreblocks:rope', 'moreblocks:rope', 'moreblocks:rope'},
		}
	})
end

minetest.register_craft({
	output = 'vines:shears',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'group:stick', 'group:wood', 'default:steel_ingot'},
		{'', '', 'group:stick'}
	}
})

-- NODES

minetest.register_node("vines:rope_block", {
	description = S("Rope"),
	sunlight_propagates = true,
	paramtype = "light",
	tiles = {
		"default_wood.png^vines_rope.png",
		"default_wood.png^vines_rope.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png^vines_rope.png",
		"default_wood.png^vines_rope.png",
	},
	groups = {flammable = 2, choppy = 2, oddly_breakable_by_hand = 1},

	after_place_node = function(pos)

		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local n = minetest.get_node(p)

		if n.name == "air" then
			minetest.add_node(p, {name = "vines:rope_end"})
		end
	end,

	after_dig_node = function(pos, node, digger)

		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local n = minetest.get_node(p)

		while n.name == 'vines:rope' or n.name == 'vines:rope_end' do

			minetest.remove_node(p)

			p = {x = p.x, y = p.y - 1, z = p.z}
			n = minetest.get_node(p)
		end
	end
})

minetest.register_node("vines:rope", {
	description = S("Rope"),
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drop = {},
	tiles = {"vines_rope.png"},
	drawtype = "plantlike",
	groups = {flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
})

minetest.register_node("vines:rope_end", {
	description = S("Rope"),
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drop = {},
	tiles = {"vines_rope_end.png"},
	drawtype = "plantlike",
	groups = {flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos)

		local yesh = {x = pos.x, y = pos.y - 1, z = pos.z}

		minetest.add_node(yesh, {name = "vines:rope"})
	end,

	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},

	on_construct = function(pos)

		local timer = minetest.get_node_timer(pos)

		timer:start(1)
	end,

	on_timer = function( pos, elapsed )

		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local n = minetest.get_node(p)

		if	n.name == "air" then

			minetest.set_node(pos, {name = "vines:rope"})
			minetest.add_node(p, {name = "vines:rope_end"})
		else

			local timer = minetest.get_node_timer(pos)

			timer:start(1)
		end
	end
})

-- SHEARS

minetest.register_tool("vines:shears", {
	description = S("Shears"),
	inventory_image = "vines_shears.png",
	wield_image = "vines_shears.png",
	stack_max = 1,
	max_drop_level = 3,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[3] = 0.2}, uses = 60, maxlevel = 3},
		}
	},
})

-- VINES
local spawn_root_surfaces = {}

if enable_roots ~= false then
	spawn_root_surfaces = {
		"default:dirt_with_grass",
		"default:dirt"
	}
end

vines.register_vine('root',
	{description = S("Roots"), average_length = 9}, {
	choose_random_wall = true,
	avoid_nodes = {"vines:root_middle"},
	avoid_radius = 5,
	spawn_delay = 500,
	spawn_chance = 10,
	spawn_surfaces = spawn_root_surfaces,
	spawn_on_bottom = true,
	plantlife_limit = -0.6,
	humidity_min = 0.4,
})

vines.register_vine('vine',
	{description = S("Vines"), average_length = 5}, {
	choose_random_wall = true,
	avoid_nodes = {"group:vines"},
	avoid_radius = 5,
	spawn_delay = 500,
	spawn_chance = 100,
	spawn_surfaces = {
--		"default:leaves",
		"default:jungleleaves",
		"moretrees:jungletree_leaves_red",
		"moretrees:jungletree_leaves_yellow",
		"moretrees:jungletree_leaves_green"
	},
	spawn_on_bottom = true,
	plantlife_limit = -0.9,
	humidity_min = 0.7,
})

vines.register_vine('side',
	{description = S("Vines"), average_length = 6}, {
	choose_random_wall = true,
	avoid_nodes = {"group:vines", "default:apple"},
	avoid_radius = 3,
	spawn_delay = 500,
	spawn_chance = 100,
	spawn_surfaces = {
--		"default:leaves",
		"default:jungleleaves",
		"moretrees:jungletree_leaves_red",
		"moretrees:jungletree_leaves_yellow",
		"moretrees:jungletree_leaves_green"
	},
	spawn_on_side = true,
	plantlife_limit = -0.9,
	humidity_min = 0.4,
})

vines.register_vine("jungle",
	{description = S("Jungle Vines"), average_length = 7}, {
	choose_random_wall = true,
	neighbors = {
		"default:jungleleaves",
		"moretrees:jungletree_leaves_red",
		"moretrees:jungletree_leaves_yellow",
		"moretrees:jungletree_leaves_green"
	},
	avoid_nodes = {
		"vines:jungle_middle",
		"vines:jungle_end",
	},
	avoid_radius = 5,
	spawn_delay = 500,
	spawn_chance = 100,
	spawn_surfaces = {
		"default:jungletree",
		"moretrees:jungletree_trunk"
	},
	spawn_on_side = true,
	plantlife_limit = -0.9,
	humidity_min = 0.2,
})

vines.register_vine( 'willow',
	{description = S("Willow Vines"), average_length = 9}, {
	choose_random_wall = true,
	avoid_nodes = {"vines:willow_middle"},
	avoid_radius = 5,
	near_nodes = {'default:water_source'},
	near_nodes_size = 1,
	near_nodes_count = 1,
	near_nodes_vertical = 7,
	plantlife_limit = -0.8,
	spawn_chance = 10,
	spawn_delay = 500,
	spawn_on_side = true,
	spawn_surfaces = {"moretrees:willow_leaves"},
	humidity_min = 0.5
})


print("[Vines] Loaded!")
