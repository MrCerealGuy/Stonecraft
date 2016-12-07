print (" ---- Dark Age is Loading! ---- ")
-- Commend this lines if you don't like some of this features
dofile(minetest.get_modpath("darkage").."/mapgen.lua")
dofile(minetest.get_modpath("darkage").."/building.lua")
dofile(minetest.get_modpath("darkage").."/furniture.lua")
dofile(minetest.get_modpath("darkage").."/stairs.lua")

----------
-- Items
----------

minetest.register_node("darkage:adobe", {
	description = "Adobe",
	tiles = {"darkage_adobe.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("darkage:basalt", {
  description = "Basalt",
	tiles = {"darkage_basalt.png"},
	is_ground_content = true,
  drop = 'darkage:basalt_cobble',
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:basalt_cobble", {
  description = "Basalt Cobble",
	tiles = {"darkage_basalt_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:chalk", {
  description = "Chalk",
	tiles = {"darkage_chalk.png"},
	is_ground_content = true,
  drop = 'darkage:chalk_powder 2',
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:cobble_with_plaster", {
	description = "Cobblestone With Plaster",
	tiles = {"darkage_cobble_with_plaster_D.png", "darkage_cobble_with_plaster_B.png", "darkage_cobble_with_plaster_C.png",
		"darkage_cobble_with_plaster_A.png", "default_cobble.png", "darkage_chalk.png"},
	is_ground_content = true,
  paramtype2 = "facedir",
  drop = 'default:cobble',
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("darkage:desert_stone_cobble", {
	description = "Desert Stone Cobble",
	tiles = {"darkage_desert_stone_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:desert_stone_with_iron", {
	description = "Desert Iron Ore",
	tiles = {"default_desert_stone.png^darkage_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("darkage:darkdirt", {
	description = "Dark Dirt",
	tiles = {"darkage_darkdirt.png"},
	is_ground_content = true,
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("darkage:dry_leaves", {
	description = "Dry Leaves",
	tiles = {"darkage_dry_leaves.png"},
	is_ground_content = true,
  paramtype = "light",
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("darkage:gneiss", {
  description = "Gneiss",
	tiles = {"darkage_gneiss.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get cobbles with 1/3 chance
				items = {'darkage:gneiss_cobble'},
				rarity = 3,
			},
			{
				items = {'darkage:gneiss'},
			}
		}
	},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:gneiss_cobble", {
  description = "Gneiss Cobble",
	tiles = {"darkage_gneiss_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:marble", {
  description = "Marble",
	tiles = {"darkage_marble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})


minetest.register_node("darkage:mud", {
  description = "Mud",
	tiles = {"darkage_mud_up.png","darkage_mud.png"},
	is_ground_content = true,
	groups = {crumbly=3},
  drop = 'darkage:mud_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("darkage:ors", {
  description = "Old Red Sandstone",
	tiles = {"darkage_ors.png"},
	is_ground_content = true,
  drop = 'darkage:ors_cobble',
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:ors_cobble", {
  description = "Old Red Sandstone Cobble",
	tiles = {"darkage_ors_cobble.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})


minetest.register_node("darkage:sandstone_cobble", {
  description = "Sandstone Cobble",
	tiles = {"darkage_sandstone_cobble.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:serpentine", {
  description = "Serpentine",
	tiles = {"darkage_serpentine.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:shale", {
  description = "Shale",
	tiles = {"darkage_shale.png","darkage_shale.png","darkage_shale_side.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:schist", {
  description = "Schist",
	tiles = {"darkage_schist.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:silt", {
  description = "Silt",
	tiles = {"darkage_silt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
  drop = 'darkage:silt_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("darkage:slate", {
  description = "Slate",
	tiles = {"darkage_slate.png","darkage_slate.png","darkage_slate_side.png"},
	is_ground_content = true,
  drop = 'darkage:slate_cobble',
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:slate_cobble", {
  description = "Slate Cobble",
	tiles = {"darkage_slate_cobble.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:slate_tale", {
  description = "Slate Tale",
	tiles = {"darkage_slate_tale.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:straw", {
  description = "Straw",
	tiles = {"darkage_straw.png"},
	is_ground_content = true,
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("darkage:stone_brick", {
  description = "Stone Brick",
	tiles = {"darkage_stone_brick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:straw_bale", {
  description = "Straw Bale",
	tiles = {"darkage_straw_bale.png"},
	is_ground_content = true,
  drop = 'darkage:straw 4',
	groups = {snappy=2, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("darkage:marble", {
  description = "Marble",
	tiles = {"darkage_marble.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:marble_tile", {
  description = "Marble Tile",
	tiles = {"darkage_marble_tile.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

---------------
-- Overrides
---------------
minetest.registered_nodes["default:desert_stone"].drop= {
		max_items = 1,
		items = {
			{
				-- player will get cobbles with 1/3 chance
				items = {'darkage:desert_stone_cobble'},
				rarity = 2,
			},
			{
				items = {'default:desert_stone'},
			}
		}
}


---------------
-- Crafts Items
---------------
minetest.register_craftitem("darkage:chalk_powder", {
	description = "Chalk Powder",
	inventory_image = "darkage_chalk_powder.png",
})

minetest.register_craftitem("darkage:mud_lump", {
	description = "Mud Lump",
	inventory_image = "darkage_mud_lump.png",
})

minetest.register_craftitem("darkage:silt_lump", {
	description = "Silt Lump",
	inventory_image = "darkage_silt_lump.png",
})

----------
-- Crafts
----------

--sand+clay+water+straw

minetest.register_craft({
	output = 'darkage:adobe 4',
	recipe = {
    {'default:sand','default:sand'},
		{'default:clay_lump','darkage:straw'},
	}
})


minetest.register_craft({
	output = 'darkage:basalt_cobble 4',
	recipe = {
    {'default:cobble','default:cobble'},
		{'default:coal_lump','default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'darkage:cobble_with_plaster 2',
	recipe = {
    {'default:cobble','darkage:chalk_powder'},
		{'default:cobble','darkage:chalk_powder'},
	}
})

minetest.register_craft({
	output = 'darkage:cobble_with_plaster 2',
	recipe = {
    {'darkage:chalk_powder','default:cobble'},
		{'darkage:chalk_powder','default:cobble'},
	}
})

minetest.register_craft({
	output = 'darkage:darkdirt 4',
	recipe = {
    {'default:dirt','default:dirt'},
		{'default:gravel','default:gravel'},
	}
})

minetest.register_craft({
	output = 'darkage:mud 3',
	recipe = {
    {'default:dirt','default:dirt'},
		{'default:clay_lump','darkage:silt_lump'},
	}
})

minetest.register_craft({
	output = 'darkage:mud',
	recipe = {
    {'darkage:mud_lump','darkage:mud_lump'},
    {'darkage:mud_lump','darkage:mud_lump'},
	}
})

minetest.register_craft({
	output = 'darkage:ors 4',
	recipe = {
    {'default:sandstone','default:sandstone'},
		{'default:iron_lump','default:sandstone'},
	}
})

minetest.register_craft({
	output = 'darkage:ors_cobble 4',
	recipe = {
    {'darkage:sandstone_cobble','darkage:sandstone_cobble'},
		{'default:iron_lump','darkage:sandstone_cobble'},
	}
})

minetest.register_craft({
	output = 'darkage:silt 3',
	recipe = {
    {'default:sand','default:sand'},
		{'default:clay_lump','default:clay_lump'},
	}
})

minetest.register_craft({
	output = 'darkage:silt',
	recipe = {
    {'darkage:silt_lump','darkage:silt_lump'},
		{'darkage:silt_lump','darkage:silt_lump'},
	}
})

minetest.register_craft({
	output = 'darkage:slate_tale 2',
	recipe = {
    {'darkage:slate_cobble','darkage:slate_cobble'},
		{'darkage:slate_cobble','darkage:slate_cobble'},
	}
})

minetest.register_craft({
	output = 'darkage:stone_brick 3',
	recipe = {
    {'default:cobble','default:cobble'},
		{'default:cobble','default:cobble'},
	}
})

minetest.register_craft({
	output = 'darkage:straw 2',
	recipe = {
    {'default:dry_shrub','default:dry_shrub'},
		{'default:dry_shrub','default:dry_shrub'},
	}
})

minetest.register_craft({
	output = 'darkage:straw 2',
	recipe = {
    {'darkage:dry_leaves','darkage:dry_leaves'},
		{'darkage:dry_leaves','darkage:dry_leaves'},
	}
})

minetest.register_craft({
	output = 'darkage:straw_bale',
	recipe = {
    {'darkage:straw','darkage:straw'},
    {'darkage:straw','darkage:straw'},
	}
})


-- Cookings
minetest.register_craft({
	type = "cooking",
	output = "darkage:basalt",
	recipe = "darkage:basalt_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "darkage:desert_stone_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:dry_leaves",
	recipe = "default:leaves",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:sandstone_cobble",
	recipe = "default:sandstone",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:schist",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:gneiss_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:ors",
	recipe = "darkage:ors_cobble",
})


minetest.register_craft({
	type = "cooking",
	output = "darkage:sandstone_cobble",
	recipe = "default:sandstone",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:schist",
	recipe = "darkage:slate",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:shale",
	recipe = "darkage:mud",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:shale",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:slate_cobble",
})

-- Desert
minetest.register_craft({
	type = "cooking",
	output = "darkage:ors_cobble",
	recipe = "default:desert_stone",
})

minetest.register_craft({
	output = 'default:desert_stone 2',
	recipe = {
    {'default:desert_sand','default:desert_sand'},
		{'default:desert_sand','default:desert_sand'},
	}
})

