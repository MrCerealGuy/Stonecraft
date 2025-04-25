local S = minetest.get_translator("livingfloatlands")

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("livingfloatlands:giantforest_litter", {
	description = S("Giant Forest dirt with Grass"),
	tiles = {"livingfloatlands_giantforest_litter.png", "default_dirt.png",
		{name = "default_dirt.png^livingfloatlands_giantforest_litter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_biome({
    name = "livingfloatlands:giantforest",
    node_top = "livingfloatlands:giantforest_litter",
    depth_top = 1,
    node_filler = "default:dirt",
    depth_filler = 2,
		node_riverbed = "default:clay",
		depth_riverbed = 1,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
    y_max = 31000,
    y_min = 0,
    heat_point = 52,
    humidity_point = 71,
})

minetest.register_node("livingfloatlands:giantforest_litter_walkway", {
	description = S("Giant Forest Ground Walkway"),
	tiles = {"livingfloatlands_giantforest_litter_walkway.png"},
	groups = {crumbly = 3, soil = 1, falling_node = 0},
	drop = "livingfloatlands:giantforest_litter_walkway",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("livingfloatlands:giantforest_litter_with_moss", {
	description = S("Giant Forest Ground with Moss"),
	tiles = {"livingfloatlands_giantforest_litter_with_moss.png"},
	groups = {crumbly = 3, soil = 1, falling_node = 0},
	drop = "livingfloatlands:giantforest_litter_with_moss",
	sounds = default.node_sound_dirt_defaults(),
})


	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"livingfloatlands:giantforest_litter"},
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
		decoration = "livingfloatlands:giantforest_litter_walkway"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"livingfloatlands:giantforest_litter"},
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
		decoration = "livingfloatlands:giantforest_litter_with_moss"
	})

minetest.register_node("livingfloatlands:giantforest_fern", {
	description = S("Giant Forest Fern"),
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 4.0,
	tiles = {"livingfloatlands_giantforest_fern.png"},
	inventory_image = "livingfloatlands_giantforest_fern.png",
	wield_image = "livingfloatlands_giantforest_fern.png",
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
		name = "livingfloatlands:giantforest_fern",
		deco_type = "simple",
		place_on = {"livingfloatlands:giantforest_litter", "livingfloatlands:paleojungle_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.01,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"livingfloatlands:giantforest", "livingfloatlands:coldgiantforest", "livingfloatlands:paleojungle"},
		y_max = 31000,
		y_min = 2,
		decoration = "livingfloatlands:giantforest_fern",
		param2 = 4,
	})

	minetest.register_decoration({
		name = "livingfloatlands:giantforest_grass",
		deco_type = "simple",
		place_on = {"livingfloatlands:giantforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 2929,
			octaves = 5,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:giantforest_grass",
        spawn_by = "livingfloatlands:giantforest_litter"
	})

minetest.register_node("livingfloatlands:giantforest_grass", {
	    description = S"Wood Anemone",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_giantforest_grass.png"},
	    inventory_image = "livingfloatlands_giantforest_grass.png",
	    wield_image = "livingfloatlands_giantforest_grass.png",
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
		name = "livingfloatlands:giantforest_grass2",
		deco_type = "simple",
		place_on = {"livingfloatlands:giantforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 1123,
			octaves = 7,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:giantforest_grass2",
        spawn_by = "livingfloatlands:giantforest_litter"
	})

minetest.register_node("livingfloatlands:giantforest_grass2", {
	    description = S"Periwinkle",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_giantforest_grass2.png"},
	    inventory_image = "livingfloatlands_giantforest_grass2.png",
	    wield_image = "livingfloatlands_giantforest_grass2.png",
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
		name = "livingfloatlands:giantforest_grass3",
		deco_type = "simple",
		place_on = {"livingfloatlands:giantforest_litter", "livingfloatlands:paleojungle_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 6633,
			octaves = 4,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "livingfloatlands:giantforest_grass3",
        spawn_by = "livingfloatlands:giantforest_litter"
	})

minetest.register_node("livingfloatlands:giantforest_grass3", {
	    description = S"Giant Forest Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingfloatlands_giantforest_grass3.png"},
	    inventory_image = "livingfloatlands_giantforest_grass3.png",
	    wield_image = "livingfloatlands_giantforest_grass3.png",
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

-- fungus
minetest.register_node("livingfloatlands:giantforest_tinderfungus", {
	description = S("Tinder Fungus"),
	tiles = {
		"livingfloatlands_giantforest_tinderfungus_top.png",
		"livingfloatlands_giantforest_tinderfungus_bottom.png",
		"livingfloatlands_giantforest_tinderfungus_side.png"
	},
	groups = {coal = 1, choppy = 2, winleafdecay = 3, oddly_breakable_by_hand = 1, flammable = 1, winleafdecay_drop = 1 },
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_craft({
	type = "fuel",
	recipe = "livingfloatlands:giantforest_tinderfungus",
	burntime = 120,
})

-- cracked oaknut
minetest.register_craftitem("livingfloatlands:giantforest_oaknut_cracked", {
	description = S("Cracked Oaknut"),
	inventory_image = "livingfloatlands_giantforest_oaknut_cracked.png",
	on_use = minetest.item_eat(5),
	groups = {food = 1, flammable = 2},
})

minetest.register_craft({
	output = "livingfloatlands:giantforest_oaknut_cracked",
type = "shapeless",
	recipe = 
		{"livingfloatlands:giantforest_oaknut", "group:stone"}
})

-- oaknut

minetest.register_node("livingfloatlands:giantforest_oaknut", {
	description = S("Oaknut"),
	drawtype = "torchlike",
	tiles = {"livingfloatlands_giantforest_oaknut.png"},
	inventory_image = "livingfloatlands_giantforest_oaknut.png",
	wield_image = "livingfloatlands_giantforest_oaknut.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1
	},
	drop = "livingfloatlands:giantforest_oaknut",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingfloatlands:giantforest_oaknut", param2 = 1})
		end
	end
})

-- New giantforest paleo oak tree

local function grow_new_giantforest_paleooak_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 7, y = pos.y - 0, z = pos.z - 8}, modpath.."/schematics/giantforest_paleooak_tree.mts", "0", nil, false)

end

-- paleo oak trunk
minetest.register_node("livingfloatlands:giantforest_paleooak_trunk", {
	description = S("Paleo Oak Trunk"),
	tiles = {
		"livingfloatlands_giantforest_paleooak_trunk_top.png",
		"livingfloatlands_giantforest_paleooak_trunk_top.png",
		"livingfloatlands_giantforest_paleooak_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- paleo oak wood
minetest.register_node("livingfloatlands:giantforest_paleooak_wood", {
	description = S("Paleo Oak Wood"),
	tiles = {"livingfloatlands_giantforest_paleooak_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:giantforest_paleooak_wood 4",
	recipe = {{"livingfloatlands:giantforest_paleooak_trunk"}}
})

minetest.register_node("livingfloatlands:giantforest_paleooak_leaves", {
  description = S("Paleo Oak Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingfloatlands_giantforest_paleooak_leaves.png"},
  special_tiles = {"livingfloatlands_giantforest_paleooak_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:giantforest_paleooak_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:giantforest_paleooak_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:giantforest_paleooak_sapling", {
  description = S("Paleo Oak Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_giantforest_paleooak_sapling.png"},
  inventory_image = "livingfloatlands_giantforest_paleooak_sapling.png",
  wield_image = "livingfloatlands_giantforest_paleooak_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_giantforest_paleooak_tree,
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
      "livingfloatlands:giantforest_paleooak_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_giantforest_paleooak_wood",
      "livingfloatlands:giantforest_paleooak_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_giantforest_paleooak_wood.png"},
      S("Paleo Oak Stair"),
      S("Paleo Oak Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_giantforest_paleooak_trunk",
      "livingfloatlands:giantforest_paleooak_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_giantforest_paleooak_trunk_top.png", "livingfloatlands_giantforest_paleooak_trunk_top.png", "livingfloatlands_giantforest_paleooak_trunk.png"},
      S("Paleo Oak Trunk Stair"),
      S("Paleo Oak Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_paleooak_wood",
    {
      description = S("Paleo Oak Wood Fence Gate"),
      texture = "livingfloatlands_giantforest_paleooak_wood.png",
      material = "livingfloatlands:giantforest_paleooak_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_paleooak_wood",
  {
    description = S("Paleo Oak Fence"),
    texture = "livingfloatlands_giantforest_paleooak_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_giantforest_paleooak_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_giantforest_paleooak_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:giantforest_paleooak_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_paleooak_wood",
  {
    description = S("Paleo Oak Fence Rail"),
    texture = "livingfloatlands_giantforest_paleooak_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_giantforest_paleooak_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_giantforest_paleooak_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:giantforest_paleooak_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleooak_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00265,
    biomes = {"livingfloatlands:giantforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleooak_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleooak_tree2",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00265,
    biomes = {"livingfloatlands:giantforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleooak_tree2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleooak_tree3",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00265,
    biomes = {"livingfloatlands:giantforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleooak_tree3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

	minetest.register_decoration({
		name = "livingfloatlands:giantforest_rottenwood",
		deco_type = "schematic",
		place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00025,
		biomes = {"livingfloatlands:giantforest"},
		y_max = 31000,
		y_min = 2,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_giantforest_rottenwood.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})



	minetest.register_decoration({
		name = "livingfloatlands:giantforest_rottenwood4",
		deco_type = "schematic",
		place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00025,
		biomes = {"livingfloatlands:giantforest"},
		y_max = 31000,
		y_min = 2,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_giantforest_rottenwood4.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})