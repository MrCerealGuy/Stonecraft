local S = minetest.get_translator("livingdesert")

local modname = "livingdesert"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- Tree generation
--

-- New date palm tree


local function grow_new_date_palm_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 1, y = pos.y - 0, z = pos.z - 1}, modpath.."/schematics/livingdesert_date_palm.mts", "0", nil, false)

end

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:date_palm_sapling", grow_new_date_palm_tree, "soil"},
})
end


-- datepalm trunk
minetest.register_node("livingdesert:date_palm_trunk", {
	description = S("Date Palm Trunk"),
	tiles = {
		"livingdesert_date_palm_trunk_top.png",
		"livingdesert_date_palm_trunk_top.png",
		"livingdesert_date_palm_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:date_palm_leaves", {
  description = S("Date Palm Leaves"),
  drawtype = "plantlike",
  waving = 1,
  visual_scale = 4.0,
  tiles = {"livingdesert_date_palm_leaves.png"},
  special_tiles = {"livingdesert_date_palm_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/25 chance
        items = {'livingdesert:date_palm_sapling'},
        rarity = 3,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:date_palm_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:date_palm_sapling", {
  description = S("Date Palm Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_date_palm_sapling.png"},
  inventory_image = "livingdesert_date_palm_sapling.png",
  wield_image = "livingdesert_date_palm_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_date_palm_tree,
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
      "livingdesert:date_palm_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})

-- date_palm wood
minetest.register_node("livingdesert:date_palm_wood", {
	description = S("Date Palm Wood"),
	tiles = {"livingdesert_date_palm_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingdesert:date_palm_wood 4",
	recipe = {{"livingdesert:date_palm_trunk"}}
})

    stairs.register_stair_and_slab(
      "livingdesert_date_palm_wood",
      "livingdesert:date_palm_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingdesert_date_palm_wood.png"},
      S("Date Palm Stair"),
      S("Date Palm Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingdesert_date_palm_trunk",
      "livingdesert:date_palm_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingdesert_date_palm_trunk_top.png", "livingdesert_date_palm_trunk_top.png", "livingdesert_date_palm_trunk.png"},
      S("Date Palm Trunk Stair"),
      S("Date Palm Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingdesert:gate_date_palm_wood",
    {
      description = S("Date Palm Wood Fence Gate"),
      texture = "livingdesert_date_palm_wood.png",
      material = "livingdesert:date_palm_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingdesert:fence_date_palm_wood",
  {
    description = S("Date Palm Fence"),
    texture = "livingdesert_date_palm_fence_wood.png",
    inventory_image = "default_fence_overlay.png^livingdesert_date_palm_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingdesert_date_palm_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingdesert:date_palm_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingdesert:fence_rail_date_palm_wood",
  {
    description = S("Date Palm Fence Rail"),
    texture = "livingdesert_date_palm_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^livingdesert_date_palm_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingdesert_date_palm_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingdesert:date_palm_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)


minetest.register_decoration({
    name = "livingdesert:date_palm_tree",
    deco_type = "schematic",
    place_on = {"default:sand", "default:desert_sand"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00315,
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 3,
    y_min = 2,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_date_palm.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:date_palm_tree2",
    deco_type = "schematic",
    place_on = {"default:sand", "default:desert_sand"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00315,
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 3,
    y_min = 2,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_date_palm2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:date_palm_tree3",
    deco_type = "schematic",
    place_on = {"default:sand", "default:desert_sand"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00315,
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 3,
    y_min = 2,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_date_palm3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- date fruits
minetest.register_node("livingdesert:date_palm_fruits", {
	description = S("Date Palm Fruits"),
	drawtype = "plantlike",
	tiles = {"livingdesert_date_palm_fruits.png"},
	inventory_image = "livingdesert_date_palm_fruits.png",
	wield_image = "livingdesert_date_palm_fruits.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {food = 1, flammable = 2, fleshy = 3, dig_immediate = 3, leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1, winleafdecay = 3},
        drop = "livingdesert:date_palm_fruits",
	on_use = minetest.item_eat(6),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingdesert:date_palm_fruits", param2 = 1})
		end
	end
})

-- Tree generation
--

-- New euphorbia tree

local function grow_new_euphorbia_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 0, z = pos.z - 2}, modpath.."/schematics/livingdesert_euphorbia2.mts", "0", nil, false)

end

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:euphorbia_sapling", grow_new_euphorbia_tree, "soil"},
})
end

-- euphorbia trunk
minetest.register_node("livingdesert:euphorbia_trunk", {
	description = S("Euphorbia Trunk"),
	tiles = {
		"livingdesert_euphorbia_trunk.png",
		"livingdesert_euphorbia_trunk.png",
		"livingdesert_euphorbia_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:euphorbia_leaves", {
  description = S("Euphorbia Leaves"),
  drawtype = "plantlike",
  waving = 1,
  visual_scale = 2.0,
  tiles = {"livingdesert_euphorbia_leaves.png"},
  special_tiles = {"livingdesert_euphorbia_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingdesert:euphorbia_sapling'},
        rarity = 2,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:euphorbia_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:euphorbia_sapling", {
  description = S("Euphorbia Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_euphorbia_sapling.png"},
  inventory_image = "livingdesert_euphorbia_sapling.png",
  wield_image = "livingdesert_euphorbia_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_euphorbia_tree,
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
      "livingdesert:euphorbia_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


minetest.register_decoration({
    name = "livingdesert:euphorbia_tree",
    deco_type = "schematic",
    place_on = {"default:sand", "default:desert_sand"},
    place_offset_y = 0,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 50,
    y_min = 10,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_euphorbia.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:euphorbia_tree2",
    deco_type = "schematic",
    place_on = {"default:sand", "default:desert_sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 50,
    y_min = 10,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_euphorbia2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:euphorbia_tree3",
    deco_type = "schematic",
    place_on = {"default:sand", "default:desert_sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 50,
    y_min = 10,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_euphorbia3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- Tree generation
--

-- New figcactus tree

local function grow_new_figcactus_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 1, y = pos.y - 0, z = pos.z - 1}, modpath.."/schematics/livingdesert_figcactus7.mts", "0", nil, false)

end

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"livingdesert:figcactus_sapling", grow_new_figcactus_tree, "soil"},
})
end

-- figcactus trunk
minetest.register_node("livingdesert:figcactus_trunk", {
	description = S("Figcactus Trunk"),
	tiles = {
		"livingdesert_figcactus.png",
		"livingdesert_figcactus.png",
		"livingdesert_figcactus.png"
	},
	groups = {tree = 1, coppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:figcactus_flower", {
  description = S("Figcactus Leaves"),
  drawtype = "plantlike",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingdesert_figcactus_flower.png"},
  special_tiles = {"livingdesert_figcactus_flower.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/25 chance
        items = {'livingdesert:figcactus_sapling'},
        rarity = 2,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingdesert:figcactus_flower'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingdesert:figcactus_sapling", {
  description = S("Figcactus Sapling"),
  drawtype = "plantlike",
  tiles = {"livingdesert_figcactus_sapling.png"},
  inventory_image = "livingdesert_figcactus_sapling.png",
  wield_image = "livingdesert_figcactus_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_figcactus_tree,
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
      "livingdesert:figcactus_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})



minetest.register_decoration({
    name = "livingdesert:figcactus_tree",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:figcactus_tree2",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:figcactus_tree3",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:figcactus_tree4",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus4.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:figcactus_tree5",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus5.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:figcactus_tree6",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus6.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingdesert:figcactus_tree7",
    deco_type = "schematic",
    place_on = {"default:sand"},
    place_offset_y = 0,
    sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.015,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    y_max = 60,
    y_min = 7,
    schematic = minetest.get_modpath("livingdesert").."/schematics/livingdesert_figcactus7.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- figcactus fruits
minetest.register_node("livingdesert:figcactus_fruit", {
	description = S("Figcactus Fruit"),
	drawtype = "plantlike",
	tiles = {"livingdesert_figcactus_fruit.png"},
	inventory_image = "livingdesert_figcactus_fruit.png",
	wield_image = "livingdesert_figcactus_fruit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {food = 1, flammable = 2, fleshy = 3, dig_immediate = 3, leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1, winleafdecay = 3},
        drop = "livingdesert:figcactus_fruit",
	on_use = minetest.item_eat(6),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingdesert:figcactus_fruit", param2 = 1})
		end
	end
})

minetest.register_node("livingdesert:yucca", {
	description = S("Yucca palm"),
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 2.0,
	tiles = {"livingdesert_yucca.png"},
	inventory_image = "livingdesert_yucca.png",
	wield_image = "livingdesert_yucca.png",
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
		name = "livingdesert:yucca",
		deco_type = "simple",
                place_on = {"default:sand", "default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.01,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
                biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean", "cold_desert", "cold_desert_ocean"},
		y_max = 250,
		y_min = 4,
		decoration = "livingdesert:yucca",
		param2 = 4,
	})

	minetest.register_decoration({
		name = "livingdesert:succulent",
		deco_type = "simple",
                place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.05,
			spread = {x = 100, y = 100, z = 100},
			seed = 7238,
			octaves = 7,
			persist = 1,
		},
		y_max = 85,
		y_min = 35,
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		decoration = "livingdesert:succulent",
	})

minetest.register_node("livingdesert:succulent", {
	    description = "Lithops",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_succulent.png"},
	    inventory_image = "livingdesert_succulent.png",
	    wield_image = "livingdesert_succulent.png",
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
		name = "livingdesert:succulent2",
		deco_type = "simple",
                place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 1557,
			octaves = 7,
			persist = 1,
		},
		y_max = 85,
		y_min = 35,
                biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		decoration = "livingdesert:succulent2",
	})

minetest.register_node("livingdesert:succulent2", {
	    description = S"Succulent",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_succulent2.png"},
	    inventory_image = "livingdesert_succulent2.png",
	    wield_image = "livingdesert_succulent2.png",
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
		name = "livingdesert:succulent3",
		deco_type = "simple",
                place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 9009,
			octaves = 7,
			persist = 1,
		},
		y_max = 85,
		y_min = 35,
                biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		decoration = "livingdesert:succulent3",
	})

minetest.register_node("livingdesert:succulent3", {
	    description = S"Succulent",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_succulent3.png"},
	    inventory_image = "livingdesert_succulent3.png",
	    wield_image = "livingdesert_succulent3.png",
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
		name = "livingdesert:succulent4",
		deco_type = "simple",
                place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 7238,
			octaves = 7,
			persist = 1,
		},
		y_max = 85,
		y_min = 35,
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		decoration = "livingdesert:succulent4",
	})

minetest.register_node("livingdesert:succulent4", {
	    description = S"Lithops",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_succulent4.png"},
	    inventory_image = "livingdesert_succulent4.png",
	    wield_image = "livingdesert_succulent4.png",
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
		name = "livingdesert:succulent5",
		deco_type = "simple",
                place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 7238,
			octaves = 7,
			persist = 1,
		},
		y_max = 85,
		y_min = 35,
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		decoration = "livingdesert:succulent5",
	})

minetest.register_node("livingdesert:succulent5", {
	    description = S"Lithops",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_succulent5.png"},
	    inventory_image = "livingdesert_succulent5.png",
	    wield_image = "livingdesert_succulent5.png",
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
		name = "livingdesert:cactus",
		deco_type = "simple",
                place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 10, y = 10, z = 10},
			seed = 329,
			octaves = 3,
			persist = 0.2
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		y_max = 100,
		y_min = 10,
		decoration = "livingdesert:cactus",
		param2 = 4,
	})

minetest.register_node("livingdesert:cactus", {
	    description = S"Barrel Cactus",
	    drawtype = "plantlike",
	    waving = 0,
	    visual_scale = 2.0,
	    tiles = {"livingdesert_small_cactus.png"},
	    inventory_image = "livingdesert_small_cactus.png",
	    wield_image = "livingdesert_small_cactus.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = true,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingdesert:cactus2",
		deco_type = "simple",
                place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 10, y = 10, z = 10},
			seed = 329,
			octaves = 3,
			persist = 0.2
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		y_max = 100,
		y_min = 10,
		decoration = "livingdesert:cactus2",
		param2 = 4,
	})

minetest.register_node("livingdesert:cactus2", {
	    description = S"Peanut Cactus",
	    drawtype = "plantlike",
	    waving = 0,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_small_cactus2.png"},
	    inventory_image = "livingdesert_small_cactus2.png",
	    wield_image = "livingdesert_small_cactus2.png",
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
		name = "livingdesert:cactus3",
		deco_type = "simple",
                place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 10, y = 10, z = 10},
			seed = 329,
			octaves = 3,
			persist = 0.2
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
		y_max = 100,
		y_min = 10,
		decoration = "livingdesert:cactus3",
		param2 = 4,
	})

minetest.register_node("livingdesert:cactus3", {
	    description = S"Spider Cactus",
	    drawtype = "plantlike",
	    waving = 0,
	    visual_scale = 2.0,
	    tiles = {"livingdesert_small_cactus3.png"},
	    inventory_image = "livingdesert_small_cactus3.png",
	    wield_image = "livingdesert_small_cactus3.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = true,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "livingdesert:cactus4",
		deco_type = "simple",
                place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.009,
			spread = {x = 10, y = 10, z = 10},
			seed = 329,
			octaves = 3,
			persist = 0.2
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    spawn_by = "livingdesert:cactus",
		y_max = 100,
		y_min = 10,
		decoration = "livingdesert:cactus4",
		param2 = 4,
	})

minetest.register_node("livingdesert:cactus4", {
	    description = S"Small Barrel Cactus",
	    drawtype = "plantlike",
	    waving = 0,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_small_cactus4.png"},
	    inventory_image = "livingdesert_small_cactus4.png",
	    wield_image = "livingdesert_small_cactus4.png",
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
		name = "livingdesert:cactus5",
		deco_type = "simple",
                place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.008,
			spread = {x = 10, y = 10, z = 10},
			seed = 329,
			octaves = 3,
			persist = 0.2
		},
    biomes = {"sandstone_desert", "desert", "sandstone_desert_ocean", "desert_ocean"},
    spawn_by = "livingdesert:cactus3",
		y_max = 100,
		y_min = 10,
		decoration = "livingdesert:cactus5",
		param2 = 4,
	})

minetest.register_node("livingdesert:cactus5", {
	    description = S"Small Spider Cactus",
	    drawtype = "plantlike",
	    waving = 0,
	    visual_scale = 1.0,
	    tiles = {"livingdesert_small_cactus5.png"},
	    inventory_image = "livingdesert_small_cactus5.png",
	    wield_image = "livingdesert_small_cactus5.png",
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

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"default:desert_sand", {"livingdesert:cactus5", "livingdesert:cactus4", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus", "livingdesert:succulent5", "livingdesert:succulent4", "livingdesert:succulent3", "livingdesert:succulent2", "livingdesert:succulent", "livingdesert:yucca"}, {}}
	})
end

