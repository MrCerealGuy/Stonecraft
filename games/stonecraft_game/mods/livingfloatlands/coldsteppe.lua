local S = minetest.get_translator("livingfloatlands")

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("livingfloatlands:coldsteppe_litter", {
	description = S("Coldsteppe dirt with Grass"),
	tiles = {"livingfloatlands_coldsteppe_litter.png", "default_permafrost.png",
		{name = "default_permafrost.png^livingfloatlands_coldsteppe_litter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:permafrost",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_biome({
    name = "livingfloatlands:coldsteppe",
    node_top = "livingfloatlands:coldsteppe_litter",
    depth_top = 1,
    node_filler = "default:permafrost",
    depth_filler = 6,
		node_riverbed = "default:sand",
		depth_riverbed = 3,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
    y_max = 31000,
    y_min = 0,
    heat_point = 38,
    humidity_point = 27,
})

minetest.register_node("livingfloatlands:coldsteppe_bulbouschervil_block", {
	description = S("Bulbous Chervil Node"),
	tiles = {"livingfloatlands_coldsteppe_bulbouschervil_block.png"},
	groups = {crumbly = 3, soil = 1, falling_node = 0},
	drop = "livingfloatlands:coldsteppe_bulbous_chervil_root",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("livingfloatlands:coldsteppe_bulbous_chervil_root", {
	description = S("Bulbous Chervil Root"),
	drawtype = "torchlike",
	tiles = {"livingfloatlands_coldsteppe_bulbouschervil_root.png"},
	inventory_image = "livingfloatlands_coldsteppe_bulbouschervil_root.png",
	wield_image = "livingfloatlands_coldsteppe_bulbouschervil_root.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1
	},
	drop = "livingfloatlands:coldsteppe_bulbous_chervil_root",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingfloatlands:coldsteppe_bulbous_chervil_root", param2 = 1})
		end
	end
})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_litter"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
		noise_params = {
			offset = -0,
			scale = 0.1,
			spread = {x = 50, y = 50, z = 50},
			seed = 3456,
			octaves = 6,
			persist = 1,
		},
		y_max = 3100,
		y_min = 0,
		decoration = "livingfloatlands:coldsteppe_bulbouschervil_block"
	})

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_bulbouschervil_plant",
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_bulbouschervil_block"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 10, y = 10, z = 10},
			seed = 5,
			octaves = 1,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:coldsteppe_bulbouschervil_plant",
        spawn_by = "livingfloatlands:coldsteppe_bulbouschervil_block"
	})

minetest.register_node("livingfloatlands:coldsteppe_bulbouschervil_plant", {
	    description = S"Bulbous Chervil Plant",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_coldsteppe_bulbouschervil_plant.png"},
	    inventory_image = "livingfloatlands_coldsteppe_bulbouschervil_plant.png",
	    wield_image = "livingfloatlands_coldsteppe_bulbouschervil_plant.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_grass1",
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 6,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:coldsteppe_grass1",
        spawn_by = "livingfloatlands:coldsteppe_litter"
	})

minetest.register_node("livingfloatlands:coldsteppe_grass1", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_coldsteppe_grass1.png"},
	    inventory_image = "livingfloatlands_coldsteppe_grass1.png",
	    wield_image = "livingfloatlands_coldsteppe_grass1.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_grass2",
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 8,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:coldsteppe_grass2",
        spawn_by = "livingfloatlands:coldsteppe_litter"
	})

minetest.register_node("livingfloatlands:coldsteppe_grass2", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_coldsteppe_grass2.png"},
	    inventory_image = "livingfloatlands_coldsteppe_grass2.png",
	    wield_image = "livingfloatlands_coldsteppe_grass2.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_grass3",
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:coldsteppe_grass3",
        spawn_by = "livingfloatlands:coldsteppe_litter"
	})

minetest.register_node("livingfloatlands:coldsteppe_grass3", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_coldsteppe_grass3.png"},
	    inventory_image = "livingfloatlands_coldsteppe_grass3.png",
	    wield_image = "livingfloatlands_coldsteppe_grass3.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_grass4",
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:coldsteppe_grass4",
        spawn_by = "livingfloatlands:coldsteppe_litter"
	})

minetest.register_node("livingfloatlands:coldsteppe_grass4", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_coldsteppe_grass4.png"},
	    inventory_image = "livingfloatlands_coldsteppe_grass4.png",
	    wield_image = "livingfloatlands_coldsteppe_grass4.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_shrub",
		deco_type = "simple",
		place_on = {"livingfloatlands:coldsteppe_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 31000,
		y_min = 2,
		decoration = "livingfloatlands:coldsteppe_shrub",
        spawn_by = "livingfloatlands:coldsteppe_litter"
	})

minetest.register_node("livingfloatlands:coldsteppe_shrub", {
	    description = S"Coldsteppe Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"livingfloatlands_coldsteppe_shrub.png"},
	    inventory_image = "livingfloatlands_coldsteppe_shrub.png",
	    wield_image = "livingfloatlands_coldsteppe_shrub.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

-- New coldsteppe pine tree red pine

local function grow_new_coldsteppe_pine_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 6, y = pos.y - 0, z = pos.z - 6}, modpath.."/schematics/livingfloatlands_coldsteppe_pine.mts", "0", nil, false)

end

-- pine trunk
minetest.register_node("livingfloatlands:coldsteppe_pine_trunk", {
	description = S("Red Pine Trunk"),
	tiles = {
		"livingfloatlands_coldsteppe_pine_trunk_top.png",
		"livingfloatlands_coldsteppe_pine_trunk_top.png",
		"livingfloatlands_coldsteppe_pine_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- pine wood
minetest.register_node("livingfloatlands:coldsteppe_pine_wood", {
	description = S("Red Pine Wood"),
	tiles = {"livingfloatlands_coldsteppe_pine_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_pine_wood 4",
	recipe = {{"livingfloatlands:coldsteppe_pine_trunk"}}
})

minetest.register_node("livingfloatlands:coldsteppe_pine_leaves", {
  description = S("Red Pine Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"livingfloatlands_coldsteppe_pine_leaves.png"},
  special_tiles = {"livingfloatlands_coldsteppe_pine_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:coldsteppe_pine_sapling'},
        rarity = 35,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:coldsteppe_pine_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:coldsteppe_pine_sapling", {
  description = S("Red Pine Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_coldsteppe_pine_sapling.png"},
  inventory_image = "livingfloatlands_coldsteppe_pine_sapling.png",
  wield_image = "livingfloatlands_coldsteppe_pine_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_coldsteppe_pine_tree,
  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },
  groups = {snappy = 2, dig_immediate = 3, flammable = 2,
    attached_node = 1, sapling = 1},
  sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

  on_place = function(itemstack, placer, pointed_thing)
    itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
      "livingfloatlands:coldsteppe_pine_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_pine_wood",
      "livingfloatlands:coldsteppe_pine_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_coldsteppe_pine_wood.png"},
      S("Red Pine Stair"),
      S("Red Pine Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_pine_trunk",
      "livingfloatlands:coldsteppe_pine_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_coldsteppe_pine_trunk_top.png", "livingfloatlands_coldsteppe_pine_trunk_top.png", "livingfloatlands_coldsteppe_pine_trunk.png"},
      S("Red Pine Trunk Stair"),
      S("Red Pine Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_pine_wood",
    {
      description = S("Red Pine Wood Fence Gate"),
      texture = "livingfloatlands_coldsteppe_pine_wood.png",
      material = "livingfloatlands:coldsteppe_pine_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_pine_wood",
  {
    description = S("Red Pine Fence"),
    texture = "livingfloatlands_coldsteppe_pine_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_coldsteppe_pine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_coldsteppe_pine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:coldsteppe_pine_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_pine_wood",
  {
    description = S("Red Pine Fence Rail"),
    texture = "livingfloatlands_coldsteppe_pine_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_coldsteppe_pine_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_coldsteppe_pine_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:coldsteppe_pine_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:coldsteppe_pine_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00013,
    biomes = {"livingfloatlands:coldsteppe"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/livingfloatlands_coldsteppe_pine.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:coldsteppe_pine_tree11",
    deco_type = "schematic",
    place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00013,
    biomes = {"livingfloatlands:coldsteppe"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/livingfloatlands_coldsteppe_pine11.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- cooked pinecone
minetest.register_craftitem("livingfloatlands:roasted_pine_nuts", {
	description = S("Roasted Pine Nuts"),
	inventory_image = "livingfloatlands_coldsteppe_pine_nuts_roasted.png",
	on_use = minetest.item_eat(5),
	groups = {food = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "livingfloatlands:roasted_pine_nuts",
	recipe = "livingfloatlands:coldsteppe_pine_pinecone",
	cooktime = 10,
})

-- raw pinecone

minetest.register_node("livingfloatlands:coldsteppe_pine_pinecone", {
	description = S("Unroasted Red Pinecone"),
	drawtype = "torchlike",
	tiles = {"livingfloatlands_coldsteppe_pine_pinecone.png"},
	inventory_image = "livingfloatlands_coldsteppe_pine_pinecone.png",
	wield_image = "livingfloatlands_coldsteppe_pine_pinecone.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1, winleafdecay = 3
	},
	drop = "livingfloatlands:coldsteppe_pine_pinecone",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingfloatlands:coldsteppe_pine_pinecone", param2 = 1})
		end
	end
})

-- New coldsteppe pine2 tree norway spruce

local function grow_new_coldsteppe_pine2_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 7, y = pos.y - 0, z = pos.z - 7}, modpath.."/schematics/livingfloatlands_coldsteppe_pine2.mts", "0", nil, false)

end

-- pine2 trunk
minetest.register_node("livingfloatlands:coldsteppe_pine2_trunk", {
	description = S("Norway Spruce Trunk"),
	tiles = {
		"livingfloatlands_coldsteppe_pine2_trunk_top.png",
		"livingfloatlands_coldsteppe_pine2_trunk_top.png",
		"livingfloatlands_coldsteppe_pine2_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- pine2 wood
minetest.register_node("livingfloatlands:coldsteppe_pine2_wood", {
	description = S("Norway Spruce Wood"),
	tiles = {"livingfloatlands_coldsteppe_pine2_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_pine2_wood 4",
	recipe = {{"livingfloatlands:coldsteppe_pine2_trunk"}}
})

minetest.register_node("livingfloatlands:coldsteppe_pine2_leaves", {
  description = S("Norway Spruce Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"livingfloatlands_coldsteppe_pine2_leaves.png"},
  special_tiles = {"livingfloatlands_coldsteppe_pine2_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:coldsteppe_pine2_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:coldsteppe_pine2_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:coldsteppe_pine2_sapling", {
  description = S("Norway Spruce Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_coldsteppe_pine2_sapling.png"},
  inventory_image = "livingfloatlands_coldsteppe_pine2_sapling.png",
  wield_image = "livingfloatlands_coldsteppe_pine2_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_coldsteppe_pine2_tree,
  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },
  groups = {snappy = 2, dig_immediate = 3, flammable = 2,
    attached_node = 1, sapling = 1},
  sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

  on_place = function(itemstack, placer, pointed_thing)
    itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
      "livingfloatlands:coldsteppe_pine2_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_pine2_wood",
      "livingfloatlands:coldsteppe_pine2_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_coldsteppe_pine2_wood.png"},
      S("Norway Spruce Stair"),
      S("Norway Spruce Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_pine2_trunk",
      "livingfloatlands:coldsteppe_pine2_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_coldsteppe_pine_trunk_top.png", "livingfloatlands_coldsteppe_pine2_trunk_top.png", "livingfloatlands_coldsteppe_pine2_trunk.png"},
      S("Norway Spruce Trunk Stair"),
      S("Norway Spruce Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_pine2_wood",
    {
      description = S("Norway Spruce Wood Fence Gate"),
      texture = "livingfloatlands_coldsteppe_pine2_wood.png",
      material = "livingfloatlands:coldsteppe_pine2_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_pine2_wood",
  {
    description = S("Norway Spruce Fence"),
    texture = "livingfloatlands_coldsteppe_pine2_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_coldsteppe_pine2_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_coldsteppe_pine2_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:coldsteppe_pine2_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_pine2_wood",
  {
    description = S("Norway Spruce Fence Rail"),
    texture = "livingfloatlands_coldsteppe_pine2_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_coldsteppe_pine2_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_coldsteppe_pine2_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:coldsteppe_pine2_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:coldsteppe_pine2_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00017,
    biomes = {"livingfloatlands:coldsteppe"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/livingfloatlands_coldsteppe_pine2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:coldsteppe_pine22_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00015,
    biomes = {"livingfloatlands:coldsteppe"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/livingfloatlands_coldsteppe_pine22.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_craft({
	type = "cooking",
	output = "livingfloatlands:roasted_pine_nuts",
	recipe = "livingfloatlands:coldsteppe_pine2_pinecone",
	cooktime = 10,
})

-- raw pinecone

minetest.register_node("livingfloatlands:coldsteppe_pine2_pinecone", {
	description = S("Unroasted Norway Spruce Pinecone"),
	drawtype = "torchlike",
	tiles = {"livingfloatlands_coldsteppe_pine2_pinecone.png"},
	inventory_image = "livingfloatlands_coldsteppe_pine2_pinecone.png",
	wield_image = "livingfloatlands_coldsteppe_pine2_pinecone.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1, winleafdecay = 3
	},
	drop = "livingfloatlands:coldsteppe_pine2_pinecone",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingfloatlands:coldsteppe_pine2_pinecone", param2 = 1})
		end
	end
})

-- New coldsteppe pine3 tree siberian larix

local function grow_new_coldsteppe_pine3_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 4, y = pos.y - 0, z = pos.z - 4}, modpath.."/schematics/livingfloatlands_coldsteppe_pine3.mts", "0", nil, false)

end

-- pine3 trunk
minetest.register_node("livingfloatlands:coldsteppe_pine3_trunk", {
	description = S("Siberian Larix Trunk"),
	tiles = {
		"livingfloatlands_coldsteppe_pine3_trunk_top.png",
		"livingfloatlands_coldsteppe_pine3_trunk_top.png",
		"livingfloatlands_coldsteppe_pine3_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- pine3 wood
minetest.register_node("livingfloatlands:coldsteppe_pine3_wood", {
	description = S("Siberian Larix Wood"),
	tiles = {"livingfloatlands_coldsteppe_pine3_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_pine3_wood 4",
	recipe = {{"livingfloatlands:coldsteppe_pine3_trunk"}}
})

minetest.register_node("livingfloatlands:coldsteppe_pine3_leaves", {
  description = S("Siberian Larix Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"livingfloatlands_coldsteppe_pine3_leaves.png"},
  special_tiles = {"livingfloatlands_coldsteppe_pine3_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:coldsteppe_pine3_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:coldsteppe_pine3_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:coldsteppe_pine3_sapling", {
  description = S("Siberian Larix Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_coldsteppe_pine3_sapling.png"},
  inventory_image = "livingfloatlands_coldsteppe_pine3_sapling.png",
  wield_image = "livingfloatlands_coldsteppe_pine3_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_coldsteppe_pine3_tree,
  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },
  groups = {snappy = 2, dig_immediate = 3, flammable = 2,
    attached_node = 1, sapling = 1},
  sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

  on_place = function(itemstack, placer, pointed_thing)
    itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
      "livingfloatlands:coldsteppe_pine3_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_pine3_wood",
      "livingfloatlands:coldsteppe_pine3_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_coldsteppe_pine3_wood.png"},
      S("Siberian Larix Stair"),
      S("Siberian Larix Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_pine3_trunk",
      "livingfloatlands:coldsteppe_pine3_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_coldsteppe_pine_trunk_top.png", "livingfloatlands_coldsteppe_pine3_trunk_top.png", "livingfloatlands_coldsteppe_pine3_trunk.png"},
      S("Siberian Larix Trunk Stair"),
      S("Siberian Larix Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_pine3_wood",
    {
      description = S("Siberian Larix Wood Fence Gate"),
      texture = "livingfloatlands_coldsteppe_pine3_wood.png",
      material = "livingfloatlands:coldsteppe_pine3_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_pine3_wood",
  {
    description = S("Siberian Larix Fence"),
    texture = "livingfloatlands_coldsteppe_pine3_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_coldsteppe_pine3_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_coldsteppe_pine3_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:coldsteppe_pine3_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_pine3_wood",
  {
    description = S("Siberian Larix Fence Rail"),
    texture = "livingfloatlands_coldsteppe_pine3_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_coldsteppe_pine3_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_coldsteppe_pine3_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:coldsteppe_pine3_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:coldsteppe_pine3_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00057,
    biomes = {"livingfloatlands:coldsteppe"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/livingfloatlands_coldsteppe_pine3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:coldsteppe_pine33_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00137,
    biomes = {"livingfloatlands:coldsteppe"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/livingfloatlands_coldsteppe_pine33.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})


minetest.register_craft({
	type = "cooking",
	output = "livingfloatlands:roasted_pine_nuts",
	recipe = "livingfloatlands:coldsteppe_pine3_pinecone",
	cooktime = 10,
})

-- raw pinecone

minetest.register_node("livingfloatlands:coldsteppe_pine3_pinecone", {
	description = S("Unroasted Siberian Larix Pinecone"),
	drawtype = "torchlike",
	tiles = {"livingfloatlands_coldsteppe_pine3_pinecone.png"},
	inventory_image = "livingfloatlands_coldsteppe_pine3_pinecone.png",
	wield_image = "livingfloatlands_coldsteppe_pine3_pinecone.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1, winleafdecay = 3
	},
	drop = "livingfloatlands:coldsteppe_pine3_pinecone",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingfloatlands:coldsteppe_pine3_pinecone", param2 = 1})
		end
	end
})

minetest.register_node("livingfloatlands:coldsteppe_rock", {
	description = S("Coldsteppe Granite Rock"),
	tiles = {"livingfloatlands_coldsteppe_rock.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingfloatlands:coldsteppe_rock",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_rockformation",
		deco_type = "schematic",
		place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -4,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:coldsteppe"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_rockformation.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})


	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_rockformation11",
		deco_type = "schematic",
		place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -2,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:coldsteppe"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_rockformation11.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

minetest.register_node("livingfloatlands:coldsteppe_rock2", {
	description = S("Coldsteppe Limestone Rock"),
	tiles = {"livingfloatlands_coldsteppe_rock2.png"},
	groups = {cracky = 3, stone = 1},
	drop = "livingfloatlands:coldsteppe_rock2",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_rockformation2",
		deco_type = "schematic",
		place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:coldsteppe"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_rockformation2.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})


	minetest.register_decoration({
		name = "livingfloatlands:coldsteppe_rockformation22",
		deco_type = "schematic",
		place_on = {"livingfloatlands:coldsteppe_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:coldsteppe"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_rockformation.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

-- Bricks slabs and walls

walls.register(":livingfloatlands:coldsteppe_brick_wall", S"Coldsteppe Granite Brick Wall", "livingfloatlands_coldsteppe_rock_brick.png",
		"livingfloatlands:coldsteppe_brick_wall", default.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_rock_brick",
      "livingfloatlands:coldsteppe_rock_brick",
      {cracky = 1, oddly_breakable_by_hand = 0, flammable = 0},
      {"livingfloatlands_coldsteppe_rock_brick.png"},
      S("Coldsteppe Granite Brick Stair"),
      S("Coldsteppe Granite Brick Slab"),
      default.node_sound_wood_defaults()
    )

minetest.register_node("livingfloatlands:coldsteppe_rock_brick", {
	description = S("Coldsteppe Granite Brick"),
	tiles = {"livingfloatlands_coldsteppe_rock_brick.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_rock_brick",
	type = "shapeless",
	recipe = 
		{"livingfloatlands:coldsteppe_rock", "livingfloatlands:coldsteppe_rock"}

	
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_brick_wall",
	type = "shapeless",
	recipe = 
		{"livingfloatlands:coldsteppe_rock_brick"}

	
})

walls.register(":livingfloatlands:coldsteppe_brick2_wall", S"Coldsteppe Limestone Brick Wall", "livingfloatlands_coldsteppe_rock2_brick.png",
		"livingfloatlands:coldsteppe_brick2_wall", default.node_sound_stone_defaults())

    stairs.register_stair_and_slab(
      "livingfloatlands_coldsteppe_rock2_brick",
      "livingfloatlands:coldsteppe_rock2_brick",
      {cracky = 1, oddly_breakable_by_hand = 0, flammable = 0},
      {"livingfloatlands_coldsteppe_rock2_brick.png"},
      S("Coldsteppe Limestone Brick Stair"),
      S("Coldsteppe Limestone Brick Slab"),
      default.node_sound_wood_defaults()
    )

minetest.register_node("livingfloatlands:coldsteppe_rock2_brick", {
	description = S("Coldsteppe limestone Brick"),
	tiles = {"livingfloatlands_coldsteppe_rock2_brick.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_rock2_brick",
	type = "shapeless",
	recipe = 
		{"livingfloatlands:coldsteppe_rock2", "livingfloatlands:coldsteppe_rock2"}

	
})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_brick2_wall",
	type = "shapeless",
	recipe = 
		{"livingfloatlands:coldsteppe_rock2_brick"}

	
})