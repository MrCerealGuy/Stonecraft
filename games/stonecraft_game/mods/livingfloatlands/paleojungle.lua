local S = minetest.get_translator("livingfloatlands")

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("livingfloatlands:paleojungle_litter", {
	description = S("Paleojungle dirt with Grass"),
	tiles = {"livingfloatlands_paleojungle_litter.png", "default_dirt.png",
		{name = "default_dirt.png^livingfloatlands_paleojungle_litter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_biome({
    name = "livingfloatlands:paleojungle",
    node_top = "livingfloatlands:paleojungle_litter",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 4,
		node_riverbed = "default:sand",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
    y_max = 31000,
    y_min = 3,
    heat_point = 95,
    humidity_point = 63,
})

minetest.register_node("livingfloatlands:paleojungle_ferngrass", {
	    description = S"Paleojungle Fern",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_paleojungle_ferngrass.png"},
	    inventory_image = "livingfloatlands_paleojungle_ferngrass.png",
	    wield_image = "livingfloatlands_paleojungle_ferngrass.png",
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
		name = "livingfloatlands:paleojungle_ferngrass",
		deco_type = "simple",
		place_on = {"livingfloatlands:paleojungle_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 1123,
			octaves = 9,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:paleojungle_ferngrass",
        spawn_by = "livingfloatlands:paleojungle_litter"
	})

minetest.register_node("livingfloatlands:paleojungle_smallpalm", {
	    description = S"Small Paleojungle Palm",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 4.0,
	    tiles = {"livingfloatlands_paleojungle_smallpalm.png"},
	    inventory_image = "livingfloatlands_paleojungle_smallpalm.png",
	    wield_image = "livingfloatlands_paleojungle_smallpalm.png",
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
		name = "livingfloatlands:paleojungle_smallpalm",
		deco_type = "simple",
		place_on = {"livingfloatlands:paleojungle_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.05,
			spread = {x = 40, y = 40, z = 40},
			seed = 0405,
			octaves = 6,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:paleojungle_smallpalm",
        spawn_by = "livingfloatlands:paleojungle_litter"
	})


minetest.register_node("livingfloatlands:paleojungle_clubmoss_fruit", {
  description = S("Clubmoss Fruit"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingfloatlands_paleojungle_clubmoss_fruit.png"},
  special_tiles = {"livingfloatlands_paleojungle_clubmoss_fruit.png"},
  paramtype = "light",
  on_use = minetest.item_eat(5),
  is_ground_content = false,
  groups = {food = 1, snappy = 3, leafdecay = 3, flammable = 2, winleafdecay_drop = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:paleojungle_clubmoss_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:paleojungle_clubmoss_fruit'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

-- New paleojungle clubmoss tree

local function grow_new_paleojungle_clubmoss_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 7, y = pos.y - 0, z = pos.z - 7}, modpath.."/schematics/paleojungle_clubmoss_tree.mts", "0", nil, false)

end

-- paleo oak trunk
minetest.register_node("livingfloatlands:paleojungle_clubmoss_trunk", {
	description = S("Clubmoss Trunk"),
	tiles = {
		"livingfloatlands_paleojungle_clubmoss_trunk_top.png",
		"livingfloatlands_paleojungle_clubmoss_trunk_top.png",
		"livingfloatlands_paleojungle_clubmoss_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- clubmoss wood
minetest.register_node("livingfloatlands:paleojungle_clubmoss_wood", {
	description = S("Clubmoss Wood"),
	tiles = {"livingfloatlands_paleojungle_clubmoss_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:paleojungle_clubmoss_wood 4",
	recipe = {{"livingfloatlands:paleojungle_clubmoss_trunk"}}
})

minetest.register_node("livingfloatlands:paleojungle_clubmoss_leaves", {
  description = S("Clubmoss Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingfloatlands_paleojungle_clubmoss_leaves.png"},
  special_tiles = {"livingfloatlands_paleojungle_clubmoss_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:paleojungle_clubmoss_sapling'},
        rarity = 4,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:paleojungle_clubmoss_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:paleojungle_clubmoss_sapling", {
  description = S("Clubmoss Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_paleojungle_clubmoss_sapling.png"},
  inventory_image = "livingfloatlands_paleojungle_clubmoss_sapling.png",
  wield_image = "livingfloatlands_paleojungle_clubmoss_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_paleojungle_clubmoss_tree,
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
      "livingfloatlands:paleojungle_clubmoss_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_paleojungle_clubmoss_wood",
      "livingfloatlands:paleojungle_clubmoss_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleojungle_clubmoss_wood.png"},
      S("Clubmoss Stair"),
      S("Clubmoss Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_paleojungle_clubmoss_trunk",
      "livingfloatlands:paleojungle_clubmoss_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleojungle_clubmoss_trunk_top.png", "livingfloatlands_paleojungle_clubmoss_trunk_top.png", "livingfloatlands_paleojungle_clubmoss_trunk.png"},
      S("Clubmoss Trunk Stair"),
      S("Clubmoss Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_clubmoss_wood",
    {
      description = S("Clubmoss Wood Fence Gate"),
      texture = "livingfloatlands_paleojungle_clubmoss_wood.png",
      material = "livingfloatlands_paleojungle_clubmoss_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_clubmoss_wood",
  {
    description = S("Clubmoss Fence"),
    texture = "livingfloatlands_paleojungle_clubmoss_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_paleojungle_clubmoss_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_paleojungle_clubmoss_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleojungle_clubmoss_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_clubmoss_wood",
  {
    description = S("Clubmoss Fence Rail"),
    texture = "livingfloatlands_paleojungle_clubmoss_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_paleojungle_clubmoss_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_paleojungle_clubmoss_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleojungle_clubmoss_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:giantforest_clubmoss_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00045,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_clubmoss_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_clubmoss_tree2",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00045,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_clubmoss_tree2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_clubmoss_tree3",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00045,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_clubmoss_tree3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- New conifere  tree

local function grow_new_paleojungle_conifere_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 7, y = pos.y - 0, z = pos.z - 8}, modpath.."/schematics/paleojungle_conifere_tree.mts", "0", nil, false)

end

-- conifere trunk
minetest.register_node("livingfloatlands:paleojungle_conifere_trunk", {
	description = S("Conifere Trunk"),
	tiles = {
		"livingfloatlands_paleojungle_conifere_trunk_top.png",
		"livingfloatlands_paleojungle_conifere_trunk_top.png",
		"livingfloatlands_paleojungle_conifere_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- conifere wood
minetest.register_node("livingfloatlands:paleojungle_conifere_wood", {
	description = S("Conifere Wood"),
	tiles = {"livingfloatlands_paleojungle_conifere_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:paleojungle_conifere_wood 4",
	recipe = {{"livingfloatlands:paleojungle_conifere_trunk"}}
})

minetest.register_node("livingfloatlands:paleojungle_conifere_leaves", {
  description = S("Conifere Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingfloatlands_paleojungle_conifere_leaves.png"},
  special_tiles = {"livingfloatlands_paleojungle_conifere_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:paleojungle_conifere_sapling'},
        rarity = 10,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:paleojungle_conifere_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:paleojungle_conifere_sapling", {
  description = S("Conifere Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_paleojungle_conifere_sapling.png"},
  inventory_image = "livingfloatlands_paleojungle_conifere_sapling.png",
  wield_image = "livingfloatlands_paleojungle_conifere_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_paleojungle_conifere_tree,
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
      "livingfloatlands:paleojungle_conifere_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_paleojungle_conifere_wood",
      "livingfloatlands:paleojungle_conifere_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleojungle_conifere_wood.png"},
      S("Conifere Stair"),
      S("Conifere Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_paleojungle_conifere_trunk",
      "livingfloatlands:paleojungle_conifere_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleojungle_conifere_trunk_top.png", "livingfloatlands_paleojungle_conifere_trunk_top.png", "livingfloatlands_paleojungle_conifere_trunk.png"},
      S("Conifere Trunk Stair"),
      S("Conifere Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_conifere_wood",
    {
      description = S("Conifere Wood Fence Gate"),
      texture = "livingfloatlands_paleojungle_conifere_wood.png",
      material = "livingfloatlands_paleojungle_conifere_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_conifere_wood",
  {
    description = S("Conifere Fence"),
    texture = "livingfloatlands_paleojungle_conifere_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_paleojungle_conifere_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_paleojungle_conifere_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleojungle_conifere_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_conifere_wood",
  {
    description = S("Conifere Fence Rail"),
    texture = "livingfloatlands_paleojungle_conifere_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_paleojungle_conifere_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_paleojungle_conifere_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleojungle_conifere_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:giantforest_conifere_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00045,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_conifere_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_conifere_tree2",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00045,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_conifere_tree2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})


-- New paleo Palm  tree

local function grow_new_paleojungle_paleopalm_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 4, y = pos.y - 0, z = pos.z - 4}, modpath.."/schematics/paleojungle_paleopalm_tree.mts", "0", nil, false)

end

-- paleo palm trunk
minetest.register_node("livingfloatlands:paleojungle_paleopalm_trunk", {
	description = S("Paleopalm Trunk"),
	tiles = {
		"livingfloatlands_paleojungle_paleopalm_trunk_top.png",
		"livingfloatlands_paleojungle_paleopalm_trunk_top.png",
		"livingfloatlands_paleojungle_paleopalm_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- paleo Palm wood
minetest.register_node("livingfloatlands:paleojungle_paleopalm_wood", {
	description = S("Paleo Palm Wood"),
	tiles = {"livingfloatlands_paleojungle_paleopalm_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:paleojungle_paleopalm_wood 4",
	recipe = {{"livingfloatlands:paleojungle_paleopalm_trunk"}}
})

minetest.register_node("livingfloatlands:paleojungle_paleopalm_leaves", {
  description = S("Paleo Palm Leaves"),
 drawtype = "plantlike",
  waving = 1,
  visual_scale = 4.0,
  tiles = {"livingfloatlands_paleojungle_paleopalm_leaves.png"},
  special_tiles = {"livingfloatlands_paleojungle_paleopalm_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:paleojungle_paleopalm_sapling'},
        rarity =8,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:paleojungle_paleopalm_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:paleojungle_paleopalm_sapling", {
  description = S("Paleo Palm Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_paleojungle_paleopalm_sapling.png"},
  inventory_image = "livingfloatlands_paleojungle_paleopalm_sapling.png",
  wield_image = "livingfloatlands_paleojungle_paleopalm_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_paleojungle_paleopalm_tree,
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
      "livingfloatlands:paleojungle_paleopalm_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_paleojungle_paleopalm_wood",
      "livingfloatlands:paleojungle_paleopalm_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleojungle_paleopalm_wood.png"},
      S("Paleo Palm Stair"),
      S("Paleo Palm Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_paleojungle_paleopalm_trunk",
      "livingfloatlands:paleojungle_paleopalm_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleojungle_paleopalm_trunk_top.png", "livingfloatlands_paleojungle_paleopalm_trunk_top.png", "livingfloatlands_paleojungle_paleopalm_trunk.png"},
      S("Paleo Palm Trunk Stair"),
      S("Paleo Palm Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_paleopalm_wood",
    {
      description = S("Paleo Palm Wood Fence Gate"),
      texture = "livingfloatlands_paleojungle_paleopalm_wood.png",
      material = "livingfloatlands_paleojungle_paleopalm_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_paleopalm_wood",
  {
    description = S("Paleo Palm Fence"),
    texture = "livingfloatlands_paleojungle_conifere_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_paleojungle_paleopalm_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_paleojungle_paleopalm_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleojungle_paleopalm_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_paleopalm_wood",
  {
    description = S("Paleo Palm Fence Rail"),
    texture = "livingfloatlands_paleojungle_paleopalm_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_paleojungle_paleopalm_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_paleojungle_paleopalm_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleojungle_paleopalm_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleopalm_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00245,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_paleopalm_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleopalm_tree2",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00245,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_paleopalm_tree2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleopalm_tree3",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleojungle_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00245,
    biomes = {"livingfloatlands:paleojungle"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleojungle_paleopalm_tree3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_node("livingfloatlands:paleojungle_littler_dirt", {
	description = S("Paleo Jungle Ground with dirt"),
	tiles = {"livingfloatlands_paleojungle_litter_dirt.png"},
	groups = {crumbly = 3, soil = 1, falling_node = 0},
	drop = "livingfloatlands:paleojungle_littler_dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("livingfloatlands:paleojungle_littler_leaves", {
	description = S("Paleo Jungle Ground with leaves"),
	tiles = {"livingfloatlands_paleojungle_litter_leaves.png"},
	groups = {crumbly = 3, soil = 1, falling_node = 0},
	drop = "livingfloatlands:paleojungle_littler_leaves",
	sounds = default.node_sound_dirt_defaults(),
})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"livingfloatlands:paleojungle_litter"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
		noise_params = {
			offset = -0,
			scale = 0.2,
			spread = {x = 50, y = 50, z = 50},
			seed = 9233,
			octaves = 7,
			persist = 1,
		},
		y_max = 3100,
		y_min = 0,
		decoration = "livingfloatlands:paleojungle_littler_dirt"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"livingfloatlands:paleojungle_litter"},
		sidelen = 16,
		place_offset_y = -1,
                flags = "force_placement",
		noise_params = {
			offset = -0,
			scale = 0.2,
			spread = {x = 50, y = 50, z = 50},
			seed = 1874,
			octaves = 8,
			persist = 1,
		},
		y_max = 3100,
		y_min = 0,
		decoration = "livingfloatlands:paleojungle_littler_leaves"
	})