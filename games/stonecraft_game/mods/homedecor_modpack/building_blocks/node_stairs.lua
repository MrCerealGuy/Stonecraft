local S = homedecor_i18n.gettext

local stairs_groups_names = {"cracky","choppy","flammable","crumbly","snappy"}

local function building_blocks_stairs(nodename, def)
	minetest.register_node(nodename, def)
	if minetest.get_modpath("moreblocks") or minetest.get_modpath("stairs") then
		local mod, name = nodename:match("(.*):(.*)")
		minetest.register_alias(mod .. ":slab_" .. name, "stairs:slab_" .. name)
		minetest.register_alias(mod .. ":stair_" .. name, "stairs:stair_" .. name)
		local stairs_groups = {}
		for _, groupname in ipairs(stairs_groups_names) do
			stairs_groups[groupname] = def.groups[groupname]
		end

		if minetest.get_modpath("moreblocks") then
			stairsplus:register_all(
				mod,
				name,
				nodename,
				{
					description = def.description,
					tiles = def.tiles,
					groups = stairs_groups,
					sounds = def.sounds,
				}
			)
		else
			stairs.register_stair_and_slab(name,nodename,
				stairs_groups,
				def.tiles,
				("%s Stair"):format(def.description),
				("%s Slab"):format(def.description),
				def.sounds
			)
		end	
	end
end

building_blocks_stairs("building_blocks:grate", {
	drawtype = "glasslike",
	description = S("Grate"),
	tiles = {"building_blocks_grate.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})
building_blocks_stairs("building_blocks:smoothglass", {
	drawtype = "glasslike",
	description = S("Streak Free Glass"),
	tiles = {"building_blocks_sglass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=3,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
building_blocks_stairs("building_blocks:woodglass", {
	drawtype = "glasslike",
	description = S("Wood Framed Glass"),
	tiles = {"building_blocks_wglass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=3,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

building_blocks_stairs("building_blocks:Adobe", {
	tiles = {"building_blocks_Adobe.png"},
	description = S("Adobe"),
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_stone_defaults(),
})
building_blocks_stairs("building_blocks:fakegrass", {
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	description = S("Fake Grass"),
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
building_blocks_stairs("building_blocks:hardwood", {
	tiles = {"building_blocks_hardwood.png"},
	is_ground_content = true,
	description = S("Hardwood"),
	groups = {choppy=1,flammable=1},
	sounds = default.node_sound_wood_defaults(),
})
building_blocks_stairs("building_blocks:Roofing", {
	tiles = {"building_blocks_Roofing.png"},
	is_ground_content = true,
	description = S("Roof block"),
	groups = {snappy=3},
	sounds = default.node_sound_stone_defaults(),
})
building_blocks_stairs("building_blocks:Tar", {
	description = S("Tar"),
	tiles = {"building_blocks_tar.png"},
	is_ground_content = true,
	groups = {crumbly=1, tar_block = 1},
	sounds = default.node_sound_stone_defaults(),
})
building_blocks_stairs("building_blocks:Marble", {
	description = S("Marble"),
	tiles = {"building_blocks_marble.png"},
	is_ground_content = true,
	groups = {cracky=3, marble = 1},
	sounds = default.node_sound_stone_defaults(),
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

if not minetest.get_modpath("moreblocks") or not minetest.get_modpath("gloopblocks") then
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
end

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

minetest.register_node("building_blocks:BWtile", {
	drawtype = "nodebox",
	description = S("Chess board tiling"),
	tiles = {
		"building_blocks_BWtile.png",
		"building_blocks_BWtile.png^[transformR90",
		"building_blocks_BWtile.png^[transformR90",
		"building_blocks_BWtile.png^[transformR90",
		"building_blocks_BWtile.png",
		"building_blocks_BWtile.png"
	},
	inventory_image = "building_blocks_bwtile_inv.png",
	paramtype = "light",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
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
	sounds = default.node_sound_stone_defaults(),
})
