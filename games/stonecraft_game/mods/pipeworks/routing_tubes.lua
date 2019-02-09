--[[

2017-05-17 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- the default tube and default textures
pipeworks.register_tube("pipeworks:tube", S("Pneumatic tube segment"))
minetest.register_craft( {
	output = "pipeworks:tube_1 6",
	recipe = {
	        { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
	        { "", "", "" },
	        { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	},
})

local nodecolor = 0xffff3030

pipeworks.register_tube("pipeworks:broken_tube", {
	description = S("Broken Tube (you hacker you)"),
	plain = { { name = "pipeworks_broken_tube_plain.png", backface_culling = false, color = nodecolor } },
	noctr = { { name = "pipeworks_broken_tube_plain.png", backface_culling = false, color = nodecolor } },
	ends  = { { name = "pipeworks_broken_tube_end.png",   color = nodecolor } },
	short =   { name = "pipeworks_broken_tube_short.png", color = nodecolor },
	node_def = {
		drop = "pipeworks:tube_1",
		groups = {not_in_creative_inventory = 1, tubedevice_receiver = 1},
		tube = {
			insert_object = function(pos, node, stack, direction)
				minetest.item_drop(stack, nil, pos)
				return ItemStack("")
			end,
			can_insert = function(pos,node,stack,direction)
				return true
			end,
			priority = 50,
		},
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = puncher:get_wielded_item()
			local wieldname = itemstack:get_name()
			local playername = puncher:get_player_name()
			print("[Pipeworks] "..playername.." struck a broken tube at "..minetest.pos_to_string(pos))
			if   wieldname == "anvil:hammer"
			  or wieldname == "cottages:hammer"
			  or wieldname == "glooptest:hammer_steel"
			  or wieldname == "glooptest:hammer_bronze"
			  or wieldname == "glooptest:hammer_diamond"
			  or wieldname == "glooptest:hammer_mese"
			  or wieldname == "glooptest:hammer_alatro"
			  or wieldname == "glooptest:hammer_arol" then
				local meta = minetest.get_meta(pos)
				local was_node = minetest.deserialize(meta:get_string("the_tube_was"))
				if was_node and was_node ~= "" then
					print("            with "..wieldname.." to repair it.")
					minetest.swap_node(pos, { name = was_node.name, param2 = was_node.param2 })
					pipeworks.scan_for_tube_objects(pos)
					itemstack:add_wear(1000)
					puncher:set_wielded_item(itemstack)
					return itemstack
				else
					print("            but it can't be repaired.")
				end
			else
				print("            with "..wieldname.." but that tool is too weak.")
			end
		end
	}
})

-- the high priority tube is a low-cpu replacement for sorting tubes in situations
-- where players would use them for simple routing (turning off paths)
-- without doing actual sorting, like at outputs of tubedevices that might both accept and eject items
if pipeworks.enable_priority_tube then
	local color = "#ff3030:128"
	pipeworks.register_tube("pipeworks:priority_tube", {
			description = S("High Priority Tube Segment"),
			inventory_image = "pipeworks_tube_inv.png^[colorize:" .. color,
			plain = { { name = "pipeworks_tube_plain.png", color = nodecolor } },
			noctr = { { name = "pipeworks_tube_noctr.png", color = nodecolor } },
			ends  = { { name = "pipeworks_tube_end.png",   color = nodecolor } },
			short =   { name = "pipeworks_tube_short.png", color = nodecolor },
			node_def = {
				tube = { priority = 150 } -- higher than tubedevices (100)
			},
	})
	minetest.register_craft( {
		output = "pipeworks:priority_tube_1 6",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "default:gold_ingot", "", "default:gold_ingot" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

if pipeworks.enable_accelerator_tube then
	pipeworks.register_tube("pipeworks:accelerator_tube", {
			description = S("Accelerating Pneumatic Tube Segment"),
			inventory_image = "pipeworks_accelerator_tube_inv.png",
			plain = { "pipeworks_accelerator_tube_plain.png" },
			noctr = { "pipeworks_accelerator_tube_noctr.png" },
			ends = { "pipeworks_accelerator_tube_end.png" },
			short = "pipeworks_accelerator_tube_short.png",
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						 velocity.speed = velocity.speed+1
						 return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end}
			},
	})
	minetest.register_craft( {
		output = "pipeworks:accelerator_tube_1 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "default:mese_crystal_fragment", "default:steel_ingot", "default:mese_crystal_fragment" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

if pipeworks.enable_crossing_tube then
	pipeworks.register_tube("pipeworks:crossing_tube", {
			description = S("Crossing Pneumatic Tube Segment"),
			inventory_image = "pipeworks_crossing_tube_inv.png",
			plain = { "pipeworks_crossing_tube_plain.png" },
			noctr = { "pipeworks_crossing_tube_noctr.png" },
			ends = { "pipeworks_crossing_tube_end.png" },
			short = "pipeworks_crossing_tube_short.png",
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack) return {velocity} end }
			},
	})
	minetest.register_craft( {
		output = "pipeworks:crossing_tube_1 5",
		recipe = {
			{ "", "pipeworks:tube_1", "" },
			{ "pipeworks:tube_1", "pipeworks:tube_1", "pipeworks:tube_1" },
			{ "", "pipeworks:tube_1", "" }
		},
	})
end

if pipeworks.enable_one_way_tube then
	minetest.register_node("pipeworks:one_way_tube", {
		description = S("One way tube"),
		tiles = {"pipeworks_one_way_tube_top.png", "pipeworks_one_way_tube_top.png", "pipeworks_one_way_tube_output.png",
			"pipeworks_one_way_tube_input.png", "pipeworks_one_way_tube_side.png", "pipeworks_one_way_tube_top.png"},
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {type = "fixed",
			fixed = {{-1/2, -9/64, -9/64, 1/2, 9/64, 9/64}}},
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1},
		sounds = default.node_sound_wood_defaults(),
		tube = {
			connect_sides = {left = 1, right = 1},
			can_go = function(pos, node, velocity, stack)
				return {velocity}
			end,
			can_insert = function(pos, node, stack, direction)
				local dir = pipeworks.facedir_to_right_dir(node.param2)
				return vector.equals(dir, direction)
			end,
			priority = 75 -- Higher than normal tubes, but lower than receivers
		},
		after_place_node = pipeworks.after_place,
		after_dig_node = pipeworks.after_dig,
		on_rotate = pipeworks.on_rotate,
	})
	minetest.register_craft({
		output = "pipeworks:one_way_tube 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "group:stick", "default:mese_crystal", "basic_materials:plastic_sheet" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end
