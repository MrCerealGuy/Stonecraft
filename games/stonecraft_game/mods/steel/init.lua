dofile(minetest.get_modpath("steel").."/rust.lua")

if minetest.setting_getbool("creative_mode") and not minetest.get_modpath("unified_inventory") then
	steel_expect_infinite_stacks = true
else
	steel_expect_infinite_stacks = false
end

function steel_node_is_owned(pos, placer)
	local ownername = false
	if type(IsPlayerNodeOwner) == "function" then					-- node_ownership mod
		if HasOwner(pos, placer) then						-- returns true if the node is owned
			if not IsPlayerNodeOwner(pos, placer:get_player_name()) then
				if type(getLastOwner) == "function" then		-- ...is an old version
					ownername = getLastOwner(pos)
				elseif type(GetNodeOwnerName) == "function" then	-- ...is a recent version
					ownername = GetNodeOwnerName(pos)
				else
					ownername = "someone"
				end
			end
		end

	elseif type(isprotect)=="function" then						-- glomie's protection mod
		if not isprotect(5, pos, placer) then
			ownername = "someone"
		end
	elseif type(protector)=="table" and type(protector.can_dig)=="function" then					-- Zeg9's protection mod
		if not protector.can_dig(5, pos, placer) then
			ownername = "someone"
		end
	end

	if ownername ~= false then
		minetest.chat_send_player( placer:get_player_name(), ("Sorry, %s owns that spot."):format(ownername) )
		return true
	else
		return false
	end
end

function steel_rotate_and_place(itemstack, placer, pointed_thing)

	local node = minetest.get_node(pointed_thing.under)
	if not minetest.registered_nodes[node.name] or not minetest.registered_nodes[node.name].on_rightclick then
		if steel_node_is_owned(pointed_thing.above, placer) then
			return itemstack
		end
		local above = pointed_thing.above
		local under = pointed_thing.under
		local pitch = placer:get_look_pitch()
		local node = minetest.get_node(above)
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local wield_name = itemstack:get_name()

		if node.name ~= "air" then return end

		local iswall = (above.x ~= under.x) or (above.z ~= under.z)
		local isceiling = (above.x == under.x) and (above.z == under.z) and (pitch > 0)

		if iswall then
			local dirs = { 2, 3, 0, 1 }
			minetest.add_node(above, {name = wield_name.."_wall", param2 = dirs[fdir+1] }) -- place wall variant
		elseif isceiling then
			minetest.add_node(above, {name = wield_name.."_wall", param2 = 19 }) -- place wall variant on ceiling
		else
			minetest.add_node(above, {name = wield_name }) -- place regular variant
		end

		if not steel_expect_infinite_stacks then
			itemstack:take_item()
			return itemstack
		end
	else
		minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack)
	end
end

minetest.register_node("steel:plate_soft", {
	description = "Soft steel plate",
	tiles = {"steelplatesoft.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("steel:plate_hard", {
	description = "Hardened steel plate",
	tiles = {"steelplatehard.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("steel:plate_rusted", {
	description = "Rusted steel plate",
	tiles = {"steel_rusted.png"},
	is_ground_content = true,
	groups = {cracky=1,choppy=1},
	sounds = default.node_sound_stone_defaults(),
})

local base_tex = "strut.png"

local streetsmod = minetest.get_modpath("streets") or minetest.get_modpath("steelsupport")
-- cheapie's fork breaks it into several individual mods, with different names for the same content.

if streetsmod then
	minetest.register_alias("steel:strut","streets:steel_support")
	base_tex = "streets_support.png"
else
	minetest.register_node("steel:strut", {
		drawtype = "glasslike",
		description = "Strut",
		tiles = {"strut.png"},
		is_ground_content = true,
		paramtype= "light",
		groups = {choppy=1,cracky=1},
		sounds =  default.node_sound_stone_defaults(),
	})
	minetest.register_alias("streets:steel_support","steel:strut")
end

minetest.register_node("steel:strut_mount", {
	description = "Strut with mount",
	drawtype = "mesh",
	mesh = "steel_cube.obj",
	tiles = {
		base_tex,
		base_tex,
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
	},
	is_ground_content = true,
	paramtype= "light",
	paramtype2 = "wallmounted",
	groups = {choppy=1,cracky=1},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("steel:grate_soft", {
	description = "Soft Steel Grate",
	drawtype = "fencelike",
	tiles = {"worldgratesoft.png"},
	inventory_image = "gratesoft.png",
	wield_image = "gratesoft.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=2,choppy=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("steel:grate_hard", {
	description = "Hardened Steel Grate",
	drawtype = "fencelike",
	tiles = {"worldgratehard.png"},
	inventory_image = "gratehard.png",
	wield_image = "gratehard.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=1,choppy=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("steel:roofing", {
	description = "Corrugated steel roofing",
	drawtype = "raillike",
	tiles = {"corrugated_steel.png"},
	inventory_image = "corrugated_steel.png",
	wield_image = "corrugated_steel.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2},
	on_place = function(itemstack, placer, pointed_thing)
		steel_rotate_and_place(itemstack, placer, pointed_thing)
		return itemstack
	end
})

minetest.register_node("steel:roofing_wall", {
	description = "Corrugated steel wall",
	drawtype = "nodebox",
	tiles = {"corrugated_steel.png"},
	inventory_image = "corrugated_steel.png",
	wield_image = "corrugated_steel.png",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	walkable = true,
	groups = {bendy=2,snappy=1,dig_immediate=2, not_in_creative_inventory=1},
	drop = "steel:roofing",
	on_place = function(itemstack, placer, pointed_thing)
		steel_rotate_and_place(itemstack, placer, pointed_thing)
		return itemstack
	end,
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.48, 0.5, 0.5, -0.48 }
        },
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, -0.4 }
        },
})

if homedecor_register_slope and homedecor_register_roof then
	homedecor_register_slope("steel", "roofing",
		"steel:roofing",
		{bendy=2,snappy=1,dig_immediate=2},
		{"corrugated_steel.png"},
		"Corrugated steel roofing"
	)
	homedecor_register_roof("steel", "roofing",
		{bendy=2,snappy=1,dig_immediate=2},
		{"corrugated_steel.png"},
		"Corrugated steel roofing"
	)
end

	--steel scrap are only used to recover ingots

minetest.register_craftitem("steel:scrap", {
	description = "Steel scraps",
	inventory_image = "scrap.png",
})

	--recipes

minetest.register_craft({
	output = 'steel:plate_soft 2',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot'},
	}
})



minetest.register_craft({
	type = "cooking",
	output = "steel:plate_hard",
	recipe = "steel:plate_soft",
})


minetest.register_craft({
	output = 'steel:grate_soft 3',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "steel:grate_hard",
	recipe = "steel:grate_soft",
})

-- only register this craft if streets is not loaded

if not streetsmod then
	minetest.register_craft({
		output = 'steel:strut 5',
		recipe = {
			{'', 'default:steel_ingot', ''},
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
			{'', 'default:steel_ingot', ''},
		}
	})
end

minetest.register_craft({
	output = 'steel:roofing 6',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'steel:strut_mount',
	recipe = {
		{'steel:strut', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'steel:strut_mount',
	recipe = {
		{'streets:steel_support', 'default:steel_ingot'},
	}
})


	--remelting recipes

minetest.register_craft({
	output = 'steel:scrap 2',
	recipe = {
		{'steel:strut'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 2',
	recipe = {
		{'steel:grate_soft'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 2',
	recipe = {
		{'steel:grate_hard'},
	}
})

minetest.register_craft({
	output = 'steel:scrap',
	recipe = {
		{'steel:roofing'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 4',
	recipe = {
		{'steel:plate_soft'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 4',
	recipe = {
		{'steel:plate_hard'},
	}
})

minetest.register_craft({
	output = 'default:iron_lump',
	recipe = {
		{'steel:scrap', 'steel:scrap'},
	}
})

if minetest.get_modpath("unifieddyes") then
	-- Colorize default:steel_block

	minetest.register_node("steel:steel_block", {
		description = "Steel block (colorized)",
		tiles = {"steel_default_steel_block.png"},
		paramtype = "light",
		paramtype2 = "color",
		is_ground_content = false,
		palette = "unifieddyes_palette_extended.png",
		groups = {cracky=1, level=2, ud_param2_colorable=1, not_in_creative_inventory=1},
		on_construct = unifieddyes.on_construct,
		sounds = default.node_sound_metal_defaults(),
		on_dig = unifieddyes.on_dig,
	})

	minetest.override_item("default:steelblock", {
		palette = "unifieddyes_palette_extended.png",
		airbrush_replacement_node = "steel:steel_block",
		groups = {cracky=1, level=2, ud_param2_colorable=1},
	})
	
	unifieddyes.register_color_craft({
		output = "steel:steel_block",
		palette = "extended",
		neutral_node = "default:steelblock",
		type = "shapeless",
		recipe = {
			"NEUTRAL_NODE",
			"MAIN_DYE",
		}
	})
end
