
local S = homedecor_i18n.gettext

minetest.register_node("building_blocks:Adobe", {
	tiles = {"building_blocks_Adobe.png"},
	description = S("Adobe"),
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("building_blocks:Roofing", {
	tiles = {"building_blocks_Roofing.png"},
	is_ground_content = true,
	description = S("Roof block"),
	groups = {snappy=3},
})
minetest.register_craft({
	output = 'building_blocks:terrycloth_towel 2',
	recipe = {
		{"farming:string", "farming:string", "farming:string"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Tarmac_spread 4',
	recipe = {
		{"group:tar_block", "group:tar_block"},
	}
})
minetest.register_craft({
	output = 'building_blocks:gravel_spread 4',
	recipe = {
		{"default:gravel", "default:gravel", "default:gravel"},
	}
})
minetest.register_craft({
	output = 'building_blocks:brobble_spread 4',
	recipe = {
		{"default:brick", "default:cobble", "default:brick"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Fireplace 1',
	recipe = {
		{"default:steel_ingot", "building_blocks:sticks", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Adobe 3',
	recipe = {
		{"default:sand"},
		{"default:clay"},
		{"group:stick"},
	}
})

minetest.register_craft({
	output = 'building_blocks:Roofing 10',
	recipe = {
		{"building_blocks:Adobe", "building_blocks:Adobe"},
		{"building_blocks:Adobe", "building_blocks:Adobe"},
	}
})
minetest.register_craft({
	output = 'building_blocks:BWtile 10',
	recipe = {
		{"group:marble", "group:tar_block"},
		{"group:tar_block", "group:marble"},
	}
})
minetest.register_craft({
	output = 'building_blocks:grate 1',
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:glass", "default:glass"},
	}
})
minetest.register_craft({
	output = 'building_blocks:woodglass 1',
	recipe = {
		{"default:wood"},
		{"default:glass"},
	}
})
minetest.register_craft({
	output = 'building_blocks:hardwood 2',
	recipe = {
		{"default:wood", "default:junglewood"},
		{"default:junglewood", "default:wood"},
	}
})

minetest.register_craft({
	output = 'building_blocks:hardwood 2',
	recipe = {
		{"default:junglewood", "default:wood"},
		{"default:wood", "default:junglewood"},
	}
})
if minetest.get_modpath("moreblocks") then
	minetest.register_craft({
		output = 'building_blocks:sticks 2',
		recipe = {
			{'group:stick', ''           , 'group:stick'},
			{'group:stick', 'group:stick', 'group:stick'},
			{'group:stick', 'group:stick', 'group:stick'},
		}
	})
else
	minetest.register_craft({
		output = 'building_blocks:sticks',
		recipe = {
			{'group:stick', 'group:stick'},
			{'group:stick', 'group:stick'},
		}
	})
end

minetest.register_craft({
	output = 'default:stick 4',
	recipe = {
		{'building_blocks:sticks'},
	}
})

minetest.register_craft({
	output = 'building_blocks:fakegrass 2',
	recipe = {
		{'default:leaves'},
		{"default:dirt"},
	}
})

minetest.register_craft({
	output = 'building_blocks:tar_base 4',
	recipe = {
		{"default:coal_lump", "default:gravel"},
		{"default:gravel", "default:coal_lump"}
	}
})

minetest.register_craft({
	output = 'building_blocks:tar_base 4',
	recipe = {
		{"default:gravel", "default:coal_lump"},
		{"default:coal_lump", "default:gravel"}
	}
})

minetest.register_craft({
	type = "cooking",
	output = "building_blocks:smoothglass",
	recipe = "default:glass"
})
minetest.register_node("building_blocks:smoothglass", {
	drawtype = "glasslike",
	description = S("Streak Free Glass"),
	tiles = {"building_blocks_sglass.png"},
	inventory_image = minetest.inventorycube("building_blocks_sglass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=3,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("building_blocks:grate", {
	drawtype = "glasslike",
	description = S("Grate"),
	tiles = {"building_blocks_grate.png"},
	inventory_image = minetest.inventorycube("building_blocks_grate.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("building_blocks:Fireplace", {
	description = S("Fireplace"),
	tiles = {
		"building_blocks_cast_iron.png",
		"building_blocks_cast_iron.png",
		"building_blocks_cast_iron.png",
		"building_blocks_cast_iron_fireplace.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = default.LIGHT_MAX,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=2},
})

minetest.register_node("building_blocks:woodglass", {
	drawtype = "glasslike",
	description = S("Wood Framed Glass"),
	tiles = {"building_blocks_wglass.png"},
	inventory_image = minetest.inventorycube("building_blocks_wglass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=3,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("building_blocks:terrycloth_towel", {
	drawtype = "raillike",
	description = S("Terrycloth towel"),
	tiles = {"building_blocks_towel.png"},
	inventory_image = "building_blocks_towel_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})
minetest.register_node("building_blocks:Tarmac_spread", {
	drawtype = "raillike",
	description = S("Tarmac Spread"),
	tiles = {"building_blocks_tar.png"},
	inventory_image = "building_blocks_tar_spread_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_node("building_blocks:BWtile", {
	drawtype = "raillike",
	description = S("Chess board tiling"),
	tiles = {"building_blocks_BWtile.png"},
	inventory_image = "building_blocks_bwtile_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})
minetest.register_node("building_blocks:brobble_spread", {
	drawtype = "raillike",
	-- Translators: "Brobble" is a portmanteau of "Brick" and "Cobble".
	-- Translate however you see fit.
	description = S("Brobble Spread"),
	tiles = {"building_blocks_brobble.png"},
	inventory_image = "building_blocks_brobble_spread_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})
minetest.register_node("building_blocks:gravel_spread", {
	drawtype = "raillike",
	description = S("Gravel Spread"),
	tiles = {"default_gravel.png"},
	inventory_image = "building_blocks_gravel_spread_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})
minetest.register_node("building_blocks:hardwood", {
	tiles = {"building_blocks_hardwood.png"},
	is_ground_content = true,
	description = S("Hardwood"),
	groups = {choppy=1,flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

if minetest.get_modpath("moreblocks") then

	stairsplus:register_all(
		"building_blocks",
		"marble",
		"building_blocks:Marble",
		{
			description = "Marble",
			tiles = {"building_blocks_marble.png"},
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
		}
	)
	stairsplus:register_all(
		"building_blocks",
		"hardwood",
		"building_blocks:hardwood",
		{
			description = "Hardwood",
			tiles = {"building_blocks_hardwood.png"},
			groups = {choppy=1,flammable=1},
			sounds = default.node_sound_wood_defaults(),
		}
	)
	stairsplus:register_all(
		"building_blocks",
		"fakegrass",
		"building_blocks:fakegrass",
		{
			description = "Grass",
			tiles = {"default_grass.png"},
			groups = {crumbly=3},
			sounds = default.node_sound_dirt_defaults({
				footstep = {name="default_grass_footstep", gain=0.4},
			}),
		}
	)

	for _, i in ipairs(stairsplus.shapes_list) do
		local class = i[1]
		local cut = i[2]
		minetest.unregister_item("moreblocks:"..class.."tar"..cut)
		minetest.register_alias("moreblocks:"..class.."tar"..cut, "building_blocks:"..class.."tar"..cut)

	end
	minetest.unregister_item("moreblocks:tar")
	minetest.register_alias("moreblocks:tar", "building_blocks:Tar")

	stairsplus:register_all(
		"building_blocks",
		"tar",
		"building_blocks:Tar",
		{
			description = "Tar",
			tiles = {"building_blocks_tar.png"},
			groups = {crumbly=1},
			sounds = default.node_sound_stone_defaults(),
		}
	)

	stairsplus:register_all(
		"building_blocks",
		"grate",
		"building_blocks:grate",
		{
			description = "Grate",
			tiles = {"building_blocks_grate.png"},
			groups = {cracky=1},
			sounds = default.node_sound_stone_defaults(),
		}
	)
	stairsplus:register_all(
		"building_blocks",
		"Adobe",
		"building_blocks:Adobe",
		{
			description = "Adobe",
			tiles = {"building_blocks_Adobe.png"},
			groups = {crumbly=3},
			sounds = default.node_sound_stone_defaults(),
		}
	)
	stairsplus:register_all(
		"building_blocks",
		"Roofing",
		"building_blocks:Roofing",
		{
			description = "Roofing",
			tiles = {"building_blocks_Roofing.png"},
			groups = {snappy=3},
			sounds = default.node_sound_stone_defaults(),
		}
	)
else
	bb_stairs = {}

	-- Node will be called stairs:stair_<subname>
	function bb_stairs.register_stair(subname, recipeitem, groups, images, description)
		minetest.register_node("building_blocks:stair_" .. subname, {
			description = description,
			drawtype = "nodebox",
			tiles = images,
			paramtype = "light",
			paramtype2 = "facedir",
			is_ground_content = true,
			groups = groups,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		})

		minetest.register_craft({
			output = 'building_blocks:stair_' .. subname .. ' 4',
			recipe = {
				{recipeitem, "", ""},
				{recipeitem, recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Flipped recipe for the silly minecrafters
		minetest.register_craft({
			output = 'building_blocks:stair_' .. subname .. ' 4',
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})
	end

	-- Node will be called stairs:slab_<subname>
	function bb_stairs.register_slab(subname, recipeitem, groups, images, description)
		minetest.register_node("building_blocks:slab_" .. subname, {
			description = description,
			drawtype = "nodebox",
			tiles = images,
			paramtype = "light",
			is_ground_content = true,
			groups = groups,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		})

		minetest.register_craft({
			output = 'building_blocks:slab_' .. subname .. ' 3',
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
		})
	end

	-- Nodes will be called stairs:{stair,slab}_<subname>
	function bb_stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
		bb_stairs.register_stair(subname, recipeitem, groups, images, desc_stair)
		bb_stairs.register_slab(subname, recipeitem, groups, images, desc_slab)
	end
	bb_stairs.register_stair_and_slab("marble","building_blocks:Marble",
		{cracky=3},
		{"building_blocks_marble.png"},
		S("Marble stair"),
		S("Marble slab")
	)
	bb_stairs.register_stair_and_slab("hardwood","building_blocks:hardwood",
		{choppy=1,flammable=1},
		{"building_blocks_hardwood.png"},
		S("Hardwood stair"),
		S("Hardwood slab")
	)
	bb_stairs.register_stair_and_slab("fakegrass","building_blocks:fakegrass",
		{crumbly=3},
		{"default_grass.png"},
		S("Grass stair"),
		S("Grass slab")
	)
	bb_stairs.register_stair_and_slab("tar","building_blocks:Tar",
		{crumbly=1},
		{"building_blocks_tar.png"},
		S("Tar stair"),
		S("Tar slab")
	)
	bb_stairs.register_stair_and_slab("grate","building_blocks:grate",
		{cracky=1},
		{"building_blocks_grate.png"},
		S("Grate Stair"),
		S("Grate Slab")
	)
	bb_stairs.register_stair_and_slab("Adobe", "building_blocks:Adobe",
		{crumbly=3},
		{"building_blocks_Adobe.png"},
		S("Adobe stair"),
		S("Adobe slab")
	)
	bb_stairs.register_stair_and_slab("Roofing", "building_blocks:Roofing",
		{snappy=3},
		{"building_blocks_Roofing.png"},
		S("Roofing stair"),
		S("Roofing slab")
	)
end


minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:hardwood",
	burntime = 28,
})

minetest.register_node("building_blocks:fakegrass", {
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	description = S("Fake Grass"),
	is_ground_content = true,
	groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_craftitem("building_blocks:sticks", {
	description = S("Small bundle of sticks"),
	image = "building_blocks_sticks.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem("building_blocks:tar_base", {
	description = S("Tar base"),
	image = "building_blocks_tar_base.png",
})

--Tar
minetest.register_craft({
	output = 'building_blocks:knife 1',
	recipe = {
		{"group:tar_block"},
		{"group:stick"},
	}
})

minetest.register_alias("tar", "building_blocks:Tar")
minetest.register_alias("fakegrass", "building_blocks:fakegrass")
minetest.register_alias("tar_knife", "building_blocks:knife")
minetest.register_alias("adobe", "building_blocks:Adobe")
minetest.register_alias("building_blocks_roofing", "building_blocks:Roofing")
minetest.register_alias("hardwood", "building_blocks:hardwood")
minetest.register_alias("sticks", "building_blocks:sticks")
minetest.register_alias("building_blocks:faggot", "building_blocks:sticks")
minetest.register_alias("marble", "building_blocks:Marble")

minetest.register_node("building_blocks:Tar", {
	description = S("Tar"),
	tiles = {"building_blocks_tar.png"},
	is_ground_content = true,
	groups = {crumbly=1, tar_block = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("building_blocks:Marble", {
	description = S("Marble"),
	tiles = {"building_blocks_marble.png"},
	is_ground_content = true,
	groups = {cracky=3, marble = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:sticks",
	burntime = 5,
})
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:Tar",
	burntime = 40,
})

minetest.register_craft({
	type = "cooking",
	output = "building_blocks:Tar",
	recipe = "building_blocks:tar_base",
})

minetest.register_tool("building_blocks:knife", {
	description = S("Tar Knife"),
	inventory_image = "building_blocks_knife.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[2]=7.50, [3]=2.80}, uses=100, maxlevel=1},
			fleshy={times={[2]=5.50, [3]=2.80}, uses=100, maxlevel=1}
		}
	},
})

minetest.register_craft({
	output = "building_blocks:Marble 9",
	recipe = {
		{"default:clay", "group:tar_block", "default:clay"},
		{"group:tar_block","default:clay", "group:tar_block"},
		{"default:clay", "group:tar_block","default:clay"},
	}
})

if not minetest.get_modpath("technic") then
	minetest.register_node( ":technic:granite", {
		    description = S("Granite"),
		    tiles = { "technic_granite.png" },
		    is_ground_content = true,
		    groups = {cracky=1},
		    sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		output = "technic:granite 9",
		recipe = {
			{ "group:tar_block", "group:marble", "group:tar_block" },
			{ "group:marble", "group:tar_block", "group:marble" },
			{ "group:tar_block", "group:marble", "group:tar_block" }
		},
	})

	if minetest.get_modpath("moreblocks") then
		stairsplus:register_all("technic", "granite", "technic:granite", {
				description=S("Granite"),
				groups={cracky=1, not_in_creative_inventory=1},
				tiles={"technic_granite.png"},
		})
	end
end
