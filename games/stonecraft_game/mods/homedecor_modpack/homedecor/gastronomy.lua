
local S = homedecor_i18n.gettext

local cutlery_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16, -8/16, -6/16, 5/16, -7/16, 2/16 },
		{ -2/16, -8/16,  2/16, 2/16, -4/16, 6/16 }
	}
}

homedecor.register("cutlery_set", {
	drawtype = "mesh",
	mesh = "homedecor_cutlery_set.obj",
	tiles = { "homedecor_cutlery_set.png"	},
	inventory_image = "homedecor_cutlery_set_inv.png",
	description = S("Cutlery set"),
	groups = {snappy=3},
	selection_box = cutlery_cbox,
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
})

local bottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0, 0.125}
	}
}

local fbottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.375, -0.5, -0.3125, 0.375, 0, 0.3125 }
	}
}

local bottle_colors = {
	{ "brown", S("Brown bottle"), S("Four brown bottles") },
	{ "green", S("Green bottle"), S("Four green bottles") },
}

for _, b in ipairs(bottle_colors) do

	local name, desc, desc4 = unpack(b)

	homedecor.register("bottle_"..name, {
		tiles = { "homedecor_bottle_"..name..".png" },
		inventory_image = "homedecor_bottle_"..name.."_inv.png",
		description = desc,
		mesh = "homedecor_bottle.obj",
		walkable = false,
		groups = {snappy=3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = bottle_cbox
	})

	-- 4-bottle sets

	homedecor.register("4_bottles_"..name, {
		tiles = {
			"homedecor_bottle_"..name..".png",
			"homedecor_bottle_"..name..".png"
		},
		inventory_image = "homedecor_4_bottles_"..name.."_inv.png",
		description = desc4,
		mesh = "homedecor_4_bottles.obj",
		walkable = false,
		groups = {snappy=3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = fbottle_cbox
	})
end

homedecor.register("4_bottles_multi", {
	tiles = {
		"homedecor_bottle_brown.png",
		"homedecor_bottle_green.png"
	},
	inventory_image = "homedecor_4_bottles_multi_inv.png",
	description = S("Four misc brown/green bottles"),
	mesh = "homedecor_4_bottles.obj",
	groups = {snappy=3},
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
	selection_box = fbottle_cbox
})

local wine_cbox = homedecor.nodebox.slab_z(-0.75)
homedecor.register("wine_rack", {
	description = S("Wine rack"),
	mesh = "homedecor_wine_rack.obj",
	tiles = {
		"homedecor_generic_wood_red.png",
		"homedecor_bottle_brown.png",
		"homedecor_bottle_brown2.png",
		"homedecor_bottle_brown3.png",
		"homedecor_bottle_brown4.png"
	},
	inventory_image = "homedecor_wine_rack_inv.png",
	groups = {choppy=2},
	selection_box = wine_cbox,
	collision_box = wine_cbox,
	sounds = default.node_sound_defaults(),
})

homedecor.register("dartboard", {
	description = S("Dartboard"),
	mesh = "homedecor_dartboard.obj",
	tiles = { "homedecor_dartboard.png" },
	inventory_image = "homedecor_dartboard_inv.png",
	wield_image = "homedecor_dartboard_inv.png",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("beer_tap", {
	description = S("Beer tap"),
	mesh = "homedecor_beer_taps.obj",
	tiles = {
		"homedecor_generic_metal_bright.png",
		{ name = "homedecor_generic_metal.png", color = homedecor.color_black }
	},
	inventory_image = "homedecor_beertap_inv.png",
	groups = { snappy=3 },
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.4375, 0.25, 0.235, 0 }
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local inv = clicker:get_inventory()

		local wieldname = itemstack:get_name()
		if wieldname == "vessels:drinking_glass" then
			if inv:room_for_item("main", "homedecor:beer_mug 1") then
				itemstack:take_item()
				clicker:set_wielded_item(itemstack)
				inv:add_item("main", "homedecor:beer_mug 1")
				minetest.chat_send_player(clicker:get_player_name(),
						S("Ahh, a frosty cold beer - look in your inventory for it!"))
			else
				minetest.chat_send_player(clicker:get_player_name(),
						S("No room in your inventory to add a beer mug!"))
			end
		end
	end
})

minetest.register_craft({
	output = "homedecor:beer_tap",
	recipe = {
		{ "group:stick","default:steel_ingot","group:stick" },
		{ "homedecor:kitchen_faucet","default:steel_ingot","homedecor:kitchen_faucet" },
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" }
	},
})

local beer_cbox = {
	type = "fixed",
	fixed = { -5/32, -8/16, -9/32 , 7/32, -2/16, 1/32 }
}

homedecor.register("beer_mug", {
	description = S("Beer mug"),
	drawtype = "mesh",
	mesh = "homedecor_beer_mug.obj",
	tiles = { "homedecor_beer_mug.png" },
	inventory_image = "homedecor_beer_mug_inv.png",
	groups = { snappy=3, oddly_breakable_by_hand=3 },
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
	selection_box = beer_cbox,
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not creative.is_enabled_for(user:get_player_name()) then
			if inv:room_for_item("main", "vessels:drinking_glass 1") then
				inv:add_item("main", "vessels:drinking_glass 1")
			else
				local pos = user:get_pos()
				local dir = user:get_look_dir()
				local fdir = minetest.dir_to_facedir(dir)
				local pos_fwd = {	x = pos.x + homedecor.fdir_to_fwd[fdir+1][1],
									y = pos.y + 1,
									z = pos.z + homedecor.fdir_to_fwd[fdir+1][2] }
				minetest.add_item(pos_fwd, "vessels:drinking_glass 1")
			end
			minetest.do_item_eat(2, nil, itemstack, user, pointed_thing)
			return itemstack
		end
	end
})

local svm_cbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
}

homedecor.register("soda_machine", {
	description = S("Soda vending machine"),
	mesh = "homedecor_soda_machine.obj",
	tiles = {"homedecor_soda_machine.png"},
	groups = {snappy=3},
	selection_box = svm_cbox,
	collision_box = svm_cbox,
	expand = { top="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.rotate_simple,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local playername = clicker:get_player_name()
		local wielditem = clicker:get_wielded_item()
		local wieldname = wielditem:get_name()
		local fdir_to_fwd = { {0, -1}, {-1, 0}, {0, 1}, {1, 0} }
		local fdir = node.param2
		local pos_drop = { x=pos.x+fdir_to_fwd[fdir+1][1], y=pos.y, z=pos.z+fdir_to_fwd[fdir+1][2] }
		if wieldname == "homedecor:coin" then
			minetest.spawn_item(pos_drop, "homedecor:soda_can")
			minetest.sound_play("insert_coin", {
				pos=pos, max_hear_distance = 5
			})
			if not creative.is_enabled_for(playername) then
				wielditem:take_item()
				clicker:set_wielded_item(wielditem)
				return wielditem
			end
		else
			minetest.chat_send_player(playername, S("Please insert a coin in the machine."))
		end
	end
})
