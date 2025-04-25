local S = minetest.get_translator("livingdesert")

local modname = "livingdesert"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:silver_sand"},
		sidelen = 16,
		place_offset_y = -2,
                flags = "force_placement",
    fill_ratio = 1.0,
    biomes = {"default:cold_desert", "default:cold_desert_ocean"},
		y_max = 300,
		y_min = 0,
		decoration = "default:sand"
	})

-- ground nodes

minetest.register_node("livingdesert:coldsteppe_ground", {
	description = S("Cold Desert Ground"),
	tiles = {"livingdesert_coldsteppe_ground.png", "default_sand.png",
		{name = "default_sand.png^livingdesert_coldsteppe_ground_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:sand",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("livingdesert:coldsteppe_ground2", {
	description = S("Cold Desert Ground"),
	tiles = {"livingdesert_coldsteppe_ground2.png", "default_sand.png",
		{name = "default_sand.png^livingdesert_coldsteppe_ground2_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:sand",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("livingdesert:coldsteppe_ground3", {
	description = S("Cold Desert Ground"),
	tiles = {"livingdesert_coldsteppe_ground3.png", "default_sand.png",
		{name = "default_sand.png^livingdesert_coldsteppe_ground3_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:sand",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("livingdesert:coldsteppe_ground4", {
	description = S("Cold Desert Ground"),
	tiles = {"livingdesert_coldsteppe_ground4.png", "default_sand.png",
		{name = "default_sand.png^livingdesert_coldsteppe_ground4_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:sand",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:silver_sand"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
    fill_ratio = 5,
    biomes = {"default:cold_desert", "default:cold_desert_ocean"},
		y_max = 15,
		y_min = 2,
		decoration = "livingdesert:coldsteppe_ground"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:silver_sand"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
    fill_ratio = 5,
    biomes = {"default:cold_desert", "default:cold_desert_ocean"},
		y_max = 70,
		y_min = 10,
		decoration = "livingdesert:coldsteppe_ground2"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:silver_sand"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
    fill_ratio = 5,
    biomes = {"default:cold_desert", "default:cold_desert_ocean"},
		y_max = 100,
		y_min = 35,
		decoration = "livingdesert:coldsteppe_ground3"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:silver_sand"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
    fill_ratio = 5,
    biomes = {"default:cold_desert", "default:cold_desert_ocean"},
		y_max = 300,
		y_min = 48,
		decoration = "livingdesert:coldsteppe_ground4"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2", "default_silver_sand"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
    fill_ratio = 0.5,
    biomes = {"default:cold_desert", "default:cold_desert_ocean"},
		y_max = 7,
		y_min = 0,
		decoration = "default:sand"
	})



--- grass

	minetest.register_decoration({
		name = "livingdesert:coldsteppe_grass1",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2"},
		sidelen = 16,
                fill_ratio = 0.145,
		y_max = 25,
		y_min = 7,
		decoration = "livingdesert:coldsteppe_grass1",
	})

minetest.register_node("livingdesert:coldsteppe_grass1", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_coldsteppe_grass1.png"},
	    inventory_image = "livingdesert_coldsteppe_grass1.png",
	    wield_image = "livingdesert_coldsteppe_grass1.png",
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
		name = "livingdesert:coldsteppe_grass2",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground"},
		sidelen = 16,
                fill_ratio = 0.145,
		y_max = 80,
		y_min = 20,
		decoration = "livingdesert:coldsteppe_grass2",
	})

minetest.register_node("livingdesert:coldsteppe_grass2", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_coldsteppe_grass2.png"},
	    inventory_image = "livingdesert_coldsteppe_grass2.png",
	    wield_image = "livingdesert_coldsteppe_grass2.png",
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
		name = "livingdesert:coldsteppe_grass3",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"},
		sidelen = 16,
                fill_ratio = 0.145,
		y_max = 80,
		y_min = 30,
		decoration = "livingdesert:coldsteppe_grass3",
	})

minetest.register_node("livingdesert:coldsteppe_grass3", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_coldsteppe_grass3.png"},
	    inventory_image = "livingdesert_coldsteppe_grass3.png",
	    wield_image = "livingdesert_coldsteppe_grass3.png",
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
		name = "livingdesert:coldsteppe_grass4",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground4", "livingdesert:coldsteppe_ground3"},
		sidelen = 16,
                fill_ratio = 0.145,
		y_max = 250,
		y_min = 65,
		decoration = "livingdesert:coldsteppe_grass4",
	})

minetest.register_node("livingdesert:coldsteppe_grass4", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_coldsteppe_grass4.png"},
	    inventory_image = "livingdesert_coldsteppe_grass4.png",
	    wield_image = "livingdesert_coldsteppe_grass4.png",
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
		name = "livingdesert:coldsteppe_grass6",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2"},
		sidelen = 16,
                fill_ratio = 0.145,
		y_max = 7,
		y_min = 1,
		decoration = "livingdesert:coldsteppe_grass6",
	})

minetest.register_node("livingdesert:coldsteppe_grass6", {
	    description = S"Coldsteppe Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_coldsteppe_grass6.png"},
	    inventory_image = "livingdesert_coldsteppe_grass6.png",
	    wield_image = "livingdesert_coldsteppe_grass6.png",
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
		name = "livingdesert:saxaul_shrub",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.04,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 300,
		y_min = 15,
		decoration = "livingdesert:saxaul_shrub",
		param2 = 4,
	})

minetest.register_node("livingdesert:saxaul_shrub", {
	    description = S"Coldsteppe Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"livingdesert_saxaul_shrub.png"},
	    inventory_image = "livingdesert_saxaul_shrub.png",
	    wield_image = "livingdesert_saxaul_shrub.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})

	minetest.register_decoration({
		name = "livingdesert:saxaul_shrub2",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground4", "livingdesert:coldsteppe_ground3"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.04,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 300,
		y_min = 45,
		decoration = "livingdesert:saxaul_shrub2",
		param2 = 4,
	})

minetest.register_node("livingdesert:saxaul_shrub2", {
	    description = S"Coldsteppe Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"livingdesert_saxaul_shrub2.png"},
	    inventory_image = "livingdesert_saxaul_shrub2.png",
	    wield_image = "livingdesert_saxaul_shrub2.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})


--- trees

-- New Cold Desert Larch tree

local function grow_new_pine_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/livingdesert_pine.mts", "0", nil, false)

end

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:pine_sapling", grow_new_pine_tree, "soil"},
})
end


local function grow_new_pine2_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/livingdesert_pine2.mts", "0", nil, false)

end


if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:pine_sapling2", grow_new_pine2_tree, "soil"},
})
end


local function grow_new_pine3_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/livingdesert_pine3.mts", "0", nil, false)

end


if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:pine_sapling3", grow_new_pine3_tree, "soil"},
})
end

-- datepalm trunk
minetest.register_node("livingdesert:pine_trunk", {
	description = S("Cold Desert Larch Trunk"),
	tiles = {
		"livingdesert_pine_trunk_top.png",
		"livingdesert_pine_trunk_top.png",
		"livingdesert_pine_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:pine_leaves", {
  description = S("Cold Desert Larch Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingdesert_pine_leaves.png"},
  special_tiles = {"livingdesert_pine_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingdesert:pine_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:pine_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:pine_leaves2", {
  description = S("Cold Desert Larch Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingdesert_pine_leaves2.png"},
  special_tiles = {"livingdesert_pine_leaves2.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingdesert:pine_sapling2'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:pine_leaves2'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:pine_leaves3", {
  description = S("Cold Desert Larch Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingdesert_pine_leaves3.png"},
  special_tiles = {"livingdesert_pine_leaves3.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingdesert:pine_sapling3'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:pine_leaves3'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:pine_sapling", {
  description = S("Cold Desert Larch Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_pine_sapling.png"},
  inventory_image = "livingdesert_pine_sapling.png",
  wield_image = "livingdesert_pine_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_pine_tree,
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
      "livingdesert:pine_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})

minetest.register_node("livingdesert:pine_sapling2", {
  description = S("Cold Desert Larch Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_pine_sapling2.png"},
  inventory_image = "livingdesert_pine_sapling2.png",
  wield_image = "livingdesert_pine_sapling2.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_pine2_tree,
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
      "livingdesert:pine_sapling2",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})

minetest.register_node("livingdesert:pine_sapling3", {
  description = S("Cold Desert Larch Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_pine_sapling3.png"},
  inventory_image = "livingdesert_pine_sapling3.png",
  wield_image = "livingdesert_pine_sapling3.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_pine3_tree,
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
      "livingdesert:pine_sapling3",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})

-- pine wood
minetest.register_node("livingdesert:pine_wood", {
	description = S("Cold Desert Larch Wood"),
	tiles = {"livingdesert_pine_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingdesert:pine_wood 4",
	recipe = {{"livingdesert:pine_trunk"}}
})

    stairs.register_stair_and_slab(
      "livingdesert_pine_wood",
      "livingdesert:pine_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingdesert_pine_wood.png"},
      S("Cold Desert Larch Stair"),
      S("Cold Desert Larch Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingdesert_pine_trunk",
      "livingdesert:pine_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingdesert_pine_trunk_top.png", "livingdesert_pine_trunk_top.png", "livingdesert_pine_trunk.png"},
      S("Cold Desert Larch Trunk Stair"),
      S("Cold Desert Larch Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingdesert:gate_pine_wood",
    {
      description = S("Cold Desert Larch Wood Fence Gate"),
      texture = "livingdesert_pine_wood.png",
      material = "livingdesert:pine_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingdesert:fence_pine_wood",
  {
    description = S("Cold Desert Larch Fence"),
    texture = "livingdesert_pine_fence_wood.png",
    inventory_image = "default_fence_overlay.png^livingdesert_pine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingdesert_pine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingdesert:pine_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingdesert:fence_rail_pine_wood",
  {
    description = S("Cold Desert Larch Fence Rail"),
    texture = "livingdesert_pine_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^livingdesert_pine_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingdesert_pine_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingdesert:pine_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)


minetest.register_decoration({
    name = "livingdesert:pine_tree",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.012,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    y_max = 75,
    y_min = 25,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree11",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.012,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    y_max = 75,
    y_min = 25,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine11.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree111",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.012,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    y_max = 75,
    y_min = 25,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine111.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree2",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.012,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    y_max = 100,
    y_min = 50,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree22",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.012,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    y_max = 100,
    y_min = 50,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine22.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree222",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.012,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    y_max = 100,
    y_min = 50,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine222.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree3",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground4", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.032,
			spread = {x = 100, y = 100, z = 100},
			seed = 099,
			octaves = 3,
			persist = 0.6
		},
    y_max = 200,
    y_min = 45,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree33",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground4", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.032,
			spread = {x = 100, y = 100, z = 100},
			seed = 099,
			octaves = 3,
			persist = 0.6
		},
    y_max = 200,
    y_min = 45,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine33.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:pine_tree333",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground4", "livingdesert:coldsteppe_ground3"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00715,
    y_max = 200,
    y_min = 45,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_pine333.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- New saxaul tree

local function grow_new_saxaul_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 0, z = pos.z - 2}, modpath.."/schematics/livingdesert_saxaul.mts", "0", nil, false)

end

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:saxaul_sapling", grow_new_saxaul_tree, "soil"},
})
end

-- saxaul trunk
minetest.register_node("livingdesert:saxaul_trunk", {
	description = S("Saxaul Tree Trunk"),
	tiles = {
		"livingdesert_saxaul_trunk.png",
		"livingdesert_saxaul_trunk.png",
		"livingdesert_saxaul_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:saxaul_leaves", {
  description = S("Saxaul Tree Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingdesert_saxaul_leaves.png"},
  special_tiles = {"livingdesert_saxaul_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingdesert:saxaul_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:saxaul_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:saxaul_sapling", {
  description = S("Saxaul Tree Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_saxaul_sapling.png"},
  inventory_image = "livingdesert_saxaul_sapling.png",
  wield_image = "livingdesert_saxaul_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_saxaul_tree,
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
      "livingdesert:saxaul_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})

-- saxaul wood
minetest.register_node("livingdesert:saxaul_wood", {
	description = S("Saxaul Tree Wood"),
	tiles = {"livingdesert_saxaul_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingdesert:saxaul_wood 4",
	recipe = {{"livingdesert:saxaul_trunk"}}
})

    stairs.register_stair_and_slab(
      "livingdesert_saxaul_wood",
      "livingdesert:saxaul_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingdesert_saxaul_wood.png"},
      S("Saxaul Tree Stair"),
     S("Saxaul Tree Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingdesert_saxaul_trunk",
      "livingdesert:saxaul_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingdesert_saxaul_trunk.png", "livingdesert_saxaul_trunk.png", "livingdesert_saxaul_trunk.png"},
      S("Saxaul Tree Trunk Stair"),
      S("Saxaul Tree Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingdesert:gate_saxaul_wood",
    {
      description = S("Saxaul Tree Wood Fence Gate"),
      texture = "livingdesert_saxaul_wood.png",
      material = "livingdesert:saxaul_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingdesert:fence_saxaul_wood",
  {
    description = S("Saxaul Tree Fence"),
    texture = "livingdesert_saxaul_fence_wood.png",
    inventory_image = "default_fence_overlay.png^livingdesert_saxaul_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingdesert_saxaul_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingdesert:saxaul_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingdesert:fence_rail_saxaul_wood",
  {
    description = S("Saxaul Tree Fence Rail"),
    texture = "livingdesert_saxaul_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^livingdesert_saxaul_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingdesert_saxaul_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingdesert:saxaul_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)


minetest.register_decoration({
    name = "livingdesert:saxaul_tree",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground3"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00315,
    y_max = 45,
    y_min = 3,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_saxaul.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:saxaul_tree2",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground3"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00315,
    y_max = 45,
    y_min = 3,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_saxaul2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:saxaul_tree3",
    deco_type = "schematic",
    place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground3"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00315,
    y_max = 45,
    y_min = 3,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_saxaul3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

--- rocks

	minetest.register_decoration({
		name = "livingfloatlands:livingdesert_rockformation",
		deco_type = "schematic",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingdesert") .. "/schematics/livingdesert_rockformation.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:livingdesert_rockformation2",
		deco_type = "schematic",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingdesert") .. "/schematics/livingdesert_rockformation2.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})


	minetest.register_decoration({
		name = "livingfloatlands:livingdesert_rockformation3",
		deco_type = "schematic",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingdesert") .. "/schematics/livingdesert_rockformation3.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:livingdesert_rockformation4",
		deco_type = "schematic",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground2"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00001,
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingdesert") .. "/schematics/livingdesert_rockformation4.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:livingdesert_rockformation5",
		deco_type = "schematic",
		place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00007,
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingdesert") .. "/schematics/livingdesert_rockformation5.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

--- additional replacers

	minetest.register_decoration({
		name = "livingdesert:deadshrub",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground", "livingdesert:coldsteppe_ground4"},
		sidelen = 16,
                flags = "force_placement",
		noise_params = {
			offset = -0.1,
			scale = 0.08,
			spread = {x = 100, y = 100, z = 100},
			seed = 0934,
			octaves = 6,
			persist = 1,
		},
                biomes = {"cold_desert_ocean", "cold_desert"},
		y_max = 300,
		y_min = 0,
		decoration = "livingdesert:deadshrub",
		param2 = 4,
	})

minetest.register_node("livingdesert:deadshrub", {
	    description = S"Dead Shrub",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"livingdesert_deadshrub.png"},
	    inventory_image = "livingdesert_deadshrub.png",
	    wield_image = "livingdesert_deadshrub.png",
	  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),

})

minetest.register_node("livingdesert:flower", {
	    description = S"Crocus Flower",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_flower.png"},
	    inventory_image = "livingdesert_flower.png",
	    wield_image = "livingdesert_flower.png",
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
		name = "livingdesert:flower",
		deco_type = "simple",
		place_on = {"livingdesert:coldsteppe_ground2", "livingdesert:coldsteppe_ground3"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4579,
			octaves = 9,
			persist = 1,
		},
                biomes = {"cold_desert_ocean", "cold_desert"},
		y_max = 300,
		y_min = 0,
		decoration = "livingdesert:flower",
	})

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"livingdesert:coldsteppe_ground", {"livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3", "livingdesert:coldsteppe_grass4", "livingdesert:coldsteppe_grass6", "livingdesert:saxaul_shrub", "livingdesert:saxaul_shrub2", "livingdesert:flower", "livingdesert:deadshrub"}, {}}
	})
end

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"livingdesert:coldsteppe_ground2", {"livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3", "livingdesert:coldsteppe_grass4", "livingdesert:coldsteppe_grass6", "livingdesert:flower"}, {}}
	})
end

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"livingdesert:coldsteppe_ground2", {"livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3", "livingdesert:coldsteppe_grass4", "livingdesert:coldsteppe_grass6", "livingdesert:flower"}, {}}
	})
end

