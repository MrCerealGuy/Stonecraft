local S = minetest.get_translator("pipeworks")
minetest.register_node("pipeworks:trashcan", {
	description = S("Trash Can"),
	drawtype = "normal",
	tiles = {
		"pipeworks_trashcan_bottom.png",
		"pipeworks_trashcan_bottom.png",
		"pipeworks_trashcan_side.png",
		"pipeworks_trashcan_side.png",
		"pipeworks_trashcan_side.png",
		"pipeworks_trashcan_side.png",
	},
	groups = {snappy = 3, tubedevice = 1, tubedevice_receiver = 1, dig_generic = 4, axey=1, handy=1, pickaxey=1},
	is_ground_content = false,
	_mcl_hardness=0.8,
	tube = {
		insert_object = function(pos, node, stack, direction)
			return ItemStack("")
		end,
		connect_sides = {left = 1, right = 1, front = 1, back = 1, top = 1, bottom = 1},
		priority = 1, -- Lower than anything else
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local size = "10.2,9"
		local list_background = ""
		if minetest.get_modpath("i3") or minetest.get_modpath("mcl_formspec") then
			list_background = "style_type[box;colors=#666]box[4.5,2;1,1;]"
		end
		meta:set_string("formspec",
			"formspec_version[2]" ..
			"size["..size.."]"..
			pipeworks.fs_helpers.get_prepends(size) ..
			"item_image[0.5,0.5;1,1;pipeworks:trashcan]"..
			"label[1.5,1;"..S("Trash Can").."]"..
			list_background..
			"list[context;trash;4.5,2;1,1;]"..
			--"list[current_player;main;0,3;8,4;]" ..
			pipeworks.fs_helpers.get_inv(4)..
			"listring[context;trash]"..
			"listring[current_player;main]"
		)
		meta:set_string("infotext", S("Trash Can"))
		meta:get_inventory():set_size("trash", 1)
	end,
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.get_meta(pos):get_inventory():set_stack(listname, index, ItemStack(""))
	end,
})
pipeworks.ui_cat_tube_list[#pipeworks.ui_cat_tube_list+1] = "pipeworks:trashcan"
