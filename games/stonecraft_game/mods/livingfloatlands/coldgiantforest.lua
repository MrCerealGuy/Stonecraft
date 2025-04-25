local S = minetest.get_translator("livingfloatlands")

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")


minetest.register_biome({
    name = "livingfloatlands:coldgiantforest",
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
    heat_point = 47,
    humidity_point = 66,
})

-- New giantforest paleo redwood tree

local function grow_new_giantforest_paleoredwood_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/giantforest_paleoredwood_tree.mts", "0", nil, false)

end

-- paleo redwood trunk
minetest.register_node("livingfloatlands:giantforest_paleoredwood_trunk", {
	description = S("Paleo Redwood Trunk"),
	tiles = {
		"livingfloatlands_giantforest_paleoredwood_trunk_top.png",
		"livingfloatlands_giantforest_paleoredwood_trunk_top.png",
		"livingfloatlands_giantforest_paleoredwood_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- paleo redwood wood
minetest.register_node("livingfloatlands:giantforest_paleoredwood_wood", {
	description = S("Paleo Redwood Wood"),
	tiles = {"livingfloatlands_giantforest_paleoredwood_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingfloatlands:giantforest_paleoredwood_wood 4",
	recipe = {{"livingfloatlands:giantforest_paleoredwood_trunk"}}
})

minetest.register_node("livingfloatlands:giantforest_paleoredwood_leaves", {
  description = S("Paleo Redwood Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  visual_scale = 1.0,
  tiles = {"livingfloatlands_giantforest_paleoredwood_leaves.png"},
  special_tiles = {"livingfloatlands_giantforest_paleoredwood_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, winleafdecay = 3, flammable = 2, leaves = 1},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'livingfloatlands:giantforest_paleoredwood_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'livingfloatlands:giantforest_paleoredwood_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("livingfloatlands:giantforest_paleoredwood_sapling", {
  description = S("Paleo Redwood Sapling"),
  drawtype = "plantlike",
  tiles = {"livingfloatlands_giantforest_paleoredwood_sapling.png"},
  inventory_image = "livingfloatlands_giantforest_paleoredwood_sapling.png",
  wield_image = "livingfloatlands_giantforest_paleoredwood_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_giantforest_paleoredwood_tree,
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
      "livingfloatlands:giantforest_paleoredwood_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "livingfloatlands_giantforest_paleoredwood_wood",
      "livingfloatlands:giantforest_paleoredwood_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_giantforest_paleoredwood_wood.png"},
      S("Paleo Redwood Stair"),
      S("Paleo Redwood Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "livingfloatlands_giantforest_paleoredwood_trunk",
      "livingfloatlands:giantforest_paleoredwood_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"livingfloatlands_giantforest_paleoredwood_trunk_top.png", "livingfloatlands_giantforest_paleoredwood_trunk_top.png", "livingfloatlands_giantforest_paleoredwood_trunk.png"},
      S("Paleo Redwood Trunk Stair"),
      S("Paleo Redwood Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "livingfloatlands:gate_paleoredwood_wood",
    {
      description = S("Paleo Redwood Wood Fence Gate"),
      texture = "livingfloatlands_giantforest_paleoredwood_wood.png",
      material = "livingfloatlands:giantforest_paleoredwood_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "livingfloatlands:fence_paleoredwood_wood",
  {
    description = S("Paleo Redwood Fence"),
    texture = "livingfloatlands_giantforest_paleoredwood_fencewood.png",
    inventory_image = "default_fence_overlay.png^livingfloatlands_giantforest_paleoredwood_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^livingfloatlands_giantforest_paleoredwood_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:giantforest_paleoredwood_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "livingfloatlands:fence_rail_paleoredwood_wood",
  {
    description = S("Paleo Redwood Fence Rail"),
    texture = "livingfloatlands_giantforest_paleoredwood_fencewood.png",
    inventory_image = "default_fence_rail_overlay.png^livingfloatlands_giantforest_paleoredwood_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^livingfloatlands_giantforest_paleoredwood_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "livingfloatlands:giantforest_paleoredwood_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleoredwood_tree",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00235,
    biomes = {"livingfloatlands:coldgiantforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleoredwood_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleoredwood_treemush",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00147,
    biomes = {"livingfloatlands:coldgiantforest"},
    y_max = 31000,
    y_min = 2,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleoredwood_treemush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleoredwood_tree2",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00141,
    biomes = {"livingfloatlands:coldgiantforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleoredwood_tree2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleoredwood_tree2mush",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00090,
    biomes = {"livingfloatlands:coldgiantforest"},
    y_max = 31000,
    y_min = 2,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleoredwood_tree2mush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "livingfloatlands:giantforest_paleoredwood_treegiant",
    deco_type = "schematic",
    place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
    sidelen = 16,
    fill_ratio = 0.00085,
    biomes = {"livingfloatlands:coldgiantforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("livingfloatlands").."/schematics/giantforest_paleoredwood_treegiant.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
		name = "livingfloatlands:giantforest_rottenwood2",
		deco_type = "schematic",
		place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00028,
		biomes = {"livingfloatlands:coldgiantforest"},
		y_max = 31000,
		y_min = 2,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_giantforest_rottenwood2.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})

	minetest.register_decoration({
		name = "livingfloatlands:giantforest_rottenwood3",
		deco_type = "schematic",
		place_on = {"livingfloatlands:giantforest_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00028,
		biomes = {"livingfloatlands:coldgiantforest"},
		y_max = 31000,
		y_min = 2,
		schematic = minetest.get_modpath("livingfloatlands") .. "/schematics/livingfloatlands_giantforest_rottenwood3.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})