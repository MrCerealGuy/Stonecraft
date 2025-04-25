local S = minetest.get_translator("livingfloatlands")

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("livingfloatlands:paleodesert_litter", {
	description = S("Paleodesert sand litter"),
	tiles = {"livingfloatlands_paleodesert_litter.png", "default_desert_sandstone.png",
		{name = "default_desert_sandstone.png^livingfloatlands_paleodesert_litter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = "livingfloatlands:paleodesert_litter",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_biome({
    name = "livingfloatlands:paleodesert",
    node_top = "livingfloatlands:paleodesert_litter",
    depth_top = 1,
    node_filler = "default:desert_sandstone",
    depth_filler = 30,
		node_riverbed = "default:desert_sand",
		depth_riverbed = 3,
		node_dungeon = "default:desert_stonebrick",
		node_dungeon_alt = "default:desert_sandstone_brick",
		node_dungeon_stair = "stairs:desert_sandstone_stair",
    y_max = 31000,
    y_min = 0,
    heat_point = 96,
    humidity_point = 15,
})

minetest.register_node("livingfloatlands:paleodesert_fern", {
	description = S("Desert Fern"),
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 2.0,
	tiles = {"livingfloatlands_paleodesert_fern.png"},
	inventory_image = "livingfloatlands_paleodesert_fern.png",
	wield_image = "livingfloatlands_paleodesert_fern.png",
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
		name = "livingfloatlands:paleodesert_fern",
		deco_type = "simple",
		place_on = {"livingfloatlands:paleodesert_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.01,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 2,
		decoration = "livingfloatlands:paleodesert_fern",
		param2 = 4,
	})

minetest.register_node("livingfloatlands:puzzlegrass", {
	description = S("Puzzlegrass"),
	drawtype = "plantlike",
	tiles = {"livingfloatlands_puzzlegrass.png"},
	inventory_image = "livingfloatlands_puzzlegrass.png",
	wield_image = "livingfloatlands_puzzlegrass.png",
	paramtype = "light",
	visual_scale = 2.0,
	sunlight_propagates = true,
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

minetest.register_node("livingfloatlands:puzzlegrass_top", {
	description = S("Puzzlegrass Top"),
	drawtype = "plantlike",
	tiles = {"livingfloatlands_puzzlegrass_top.png"},
	inventory_image = "livingfloatlands_puzzlegrass_top.png",
	wield_image = "livingfloatlands_puzzlegrass_top.png",
	paramtype = "light",
	visual_scale = 2.0,
	sunlight_propagates = true,
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

	minetest.register_decoration({
		name = "livingfloatlands:puzzlegrass_patch",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 6,
			persist = 0.6
		},
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_puzzlegrass_patch.mts",
	})
	minetest.register_decoration({
		name = "livingfloatlands:puzzlegrass_patch2",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 6,
			persist = 0.6
		},
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_puzzlegrass_patch2.mts",
	})

minetest.register_decoration({
		name = "livingfloatlands:puzzlegrass_patch3",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 6,
			persist = 0.6
		},
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_puzzlegrass_patch3.mts",
	})

minetest.register_decoration({
		name = "livingfloatlands:puzzlegrass_patch4",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_puzzlegrass_patch4.mts",
	})

-- New paleodesert joshua tree

local function grow_new_paleodesert_joshua_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/paleodesert_joshua_tree3.mts", "0", nil, false)

end

-- joshua trunk
minetest.register_node("livingfloatlands:paleodesert_joshua_trunk", {
	description = S("Joshua Trunk"),
	tiles = {
		"livingfloatlands_paleodesert_joshua_trunk_top.png",
		"livingfloatlands_paleodesert_joshua_trunk_top.png",
		"livingfloatlands_paleodesert_joshua_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- joshua wood
minetest.register_node("livingfloatlands:paleodesert_joshua_wood", {
	description = S("Joshua Wood"),
	tiles = {"livingfloatlands_paleodesert_joshua_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:paleodesert_joshua_wood 4",
	recipe = {{"livingfloatlands:paleodesert_joshua_trunk"}}
})

minetest.register_node("livingfloatlands:paleodesert_joshua_leaves", {
  description = S("Joshua Leaves"),
  drawtype = "plantlike",
  waving = 1,
  visual_scale = 2.0,
  tiles = {"livingfloatlands_paleodesert_joshua_leaves.png"},
  special_tiles = {"livingfloatlands_paleodesert_joshua_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:paleodesert_joshua_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:paleodesert_joshua_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:paleodesert_joshua_sapling", {
  description = S("Joshua Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_paleodesert_joshua_sapling.png"},
  inventory_image = "livingfloatlands_paleodesert_joshua_sapling.png",
  wield_image = "livingfloatlands_paleodesert_joshua_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_paleodesert_joshua_tree,
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
      "livingfloatlands:paleodesert_joshua_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_paleodesert_joshua_wood",
      "livingfloatlands:paleodesert_joshua_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleodesert_joshua_wood.png"},
      S("Joshua Stair"),
      S("Joshua Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_paleodesert_joshua_trunk",
      "livingfloatlands:paleodesert_joshua_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleodesert_joshua_trunk_top.png", "livingfloatlands_paleodesert_joshua_trunk_top.png", "livingfloatlands_paleodesert_joshua_trunk.png"},
      S("Joshua Trunk Stair"),
      S("Joshua Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_joshua_wood",
    {
      description = S("Joshua Wood Fence Gate"),
      texture = "livingfloatlands_paleodesert_joshua_wood.png",
      material = "livingfloatlands:paleodesert_joshua_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_joshua_wood",
  {
    description = S("Joshua Fence"),
    texture = "livingfloatlands_paleodesert_joshua_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_paleodesert_joshua_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_paleodesert_joshua_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleodesert_joshua_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_joshua_wood",
  {
    description = S("Joshua Fence Rail"),
    texture = "livingfloatlands_paleodesert_joshua_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_paleodesert_joshua_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_paleodesert_joshua_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleodesert_joshua_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:paleodesert_joshua_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00013,
    biomes = {"livingfloatlands:paleodesert"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleodesert_joshua_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:paleodesert_joshua_tree2",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00013,
    biomes = {"livingfloatlands:paleodesert"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleodesert_joshua_tree2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:paleodesert_joshua_tree3",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00013,
    biomes = {"livingfloatlands:paleodesert"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleodesert_joshua_tree3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- New paleodesert paleopine tree

local function grow_new_paleodesert_paleopine_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 5, y = pos.y - 0, z = pos.z - 5}, modpath.."/schematics/paleodesert_paleopine.mts", "0", nil, false)

end

-- pine trunk
minetest.register_node("livingfloatlands:paleodesert_paleopine_trunk", {
	description = S("Paleopine Trunk"),
	tiles = {
		"livingfloatlands_paleodesert_paleopine_trunk_top.png",
		"livingfloatlands_paleodesert_paleopine_trunk_top.png",
		"livingfloatlands_paleodesert_paleopine_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- pine wood
minetest.register_node("livingfloatlands:paleodesert_paleopine_wood", {
	description = S("Paleopine Wood"),
	tiles = {"livingfloatlands_paleodesert_paleopine_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:paleodesert_paleopine_wood 4",
	recipe = {{"livingfloatlands:paleodesert_paleopine_trunk"}}
})

minetest.register_node("livingfloatlands:paleodesert_paleopine_leaves", {
  description = S("Paleopine Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingfloatlands_paleodesert_paleopine_leaves.png"},
  special_tiles = {"livingfloatlands_paleodesert_paleopine_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:paleodesert_paleopine_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:paleodesert_paleopine_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:paleodesert_paleopine_sapling", {
  description = S("Paleopine Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_paleodesert_paleopine_sapling.png"},
  inventory_image = "livingfloatlands_paleodesert_paleopine_sapling.png",
  wield_image = "livingfloatlands_paleodesert_paleopine_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_paleodesert_paleopine_tree,
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
      "livingfloatlands:paleodesert_paleopine_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_paleodesert_paleopine_wood",
      "livingfloatlands:paleodesert_paleopine_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleodesert_paleopine_wood.png"},
      S("Paleopine Stair"),
      S("Paleopine Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_paleodesert_paleopine_trunk",
      "livingfloatlands:paleodesert_paleopine_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_paleodesert_paleopine_trunk_top.png", "livingfloatlands_paleodesert_paleopine_trunk_top.png", "livingfloatlands_paleodesert_paleopine_trunk.png"},
      S("Paleopine Trunk Stair"),
      S("Paleopine Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_paleopine_wood",
    {
      description = S("Paleopine Wood Fence Gate"),
      texture = "livingfloatlands_paleodesert_paleopine_wood.png",
      material = "livingfloatlands:paleodesert_paleopine_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_paleopine_wood",
  {
    description = S("Paleopine Fence"),
    texture = "livingfloatlands_paleodesert_paleopine_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_paleodesert_paleopine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_paleodesert_paleopine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleodesert_paleopine_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_paleopine_wood",
  {
    description = S("Paleopine Fence Rail"),
    texture = "livingfloatlands_paleodesert_paleopine_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_paleodesert_paleopine_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_paleodesert_paleopine_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:paleodesert_paleopine_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:paleodesert_paleopine",
    deco_type = "schematic",
    place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00021,
    biomes = {"livingfloatlands:paleodesert"},
    y_max = 31000,
    y_min = 3,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/paleodesert_paleopine.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

	minetest.register_decoration({
		name = "livingfloatlands:paleodesert_rockformation",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_paleodesert_rockformation.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:paleodesert_rockformation2",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_paleodesert_rockformation2.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:paleodesert_rockformation3",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_paleodesert_rockformation3.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:paleodesert_rockformation4",
		deco_type = "schematic",
		place_on = {"livingfloatlands:paleodesert_litter"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00007,
		biomes = {"livingfloatlands:paleodesert"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_paleodesert_rockformation4.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

