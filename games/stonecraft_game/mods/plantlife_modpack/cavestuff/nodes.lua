-- support for i18n
local S = minetest.get_translator("cavestuff")

--Rocks

local cbox = {
	type = "fixed",
	fixed = {-5/16, -8/16, -6/16, 5/16, -1/32, 5/16},
}

minetest.register_node("cavestuff:pebble_1",{
	description = S("Pebble"),
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	tiles = {"undergrowth_pebble.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3, stone=1, attached_node=1, dig_immediate=3},
	selection_box = cbox,
	collision_box = cbox,
	on_place = function(itemstack, placer, pointed_thing)
		-- place a random pebble node
		local stack = ItemStack("cavestuff:pebble_"..math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cavestuff:pebble_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:pebble_2",{
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	tiles = {"undergrowth_pebble.png"},
	drop = "cavestuff:pebble_1",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3, stone=1, attached_node=1, not_in_creative_inventory=1, dig_immediate=3},
	selection_box = cbox,
	collision_box = cbox,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:desert_pebble_1",{
	description = S("Desert Pebble"),
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	 tiles = {"default_desert_stone.png"},
	 paramtype = "light",
	paramtype2 = "facedir",
	 groups = {cracky=3, stone=1, attached_node=1, dig_immediate=3},
	selection_box = cbox,
	collision_box = cbox,
	 on_place = function(itemstack, placer, pointed_thing)
		-- place a random pebble node
		local stack = ItemStack("cavestuff:desert_pebble_"..math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cavestuff:desert_pebble_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
	 sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:desert_pebble_2",{
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	drop = "cavestuff:desert_pebble_1",
	 tiles = {"default_desert_stone.png"},
	 paramtype = "light",
	paramtype2 = "facedir",
	 groups = {cracky=3, stone=1, attached_node=1, not_in_creative_inventory=1, dig_immediate=3},
	selection_box = cbox,
	collision_box = cbox,
	 sounds = default.node_sound_stone_defaults(),
})

--Staclactites

minetest.register_node("cavestuff:stalactite_1",{
	drawtype="nodebox",
	tiles = {"undergrowth_pebble.png"},
	groups = {cracky=3,attached_node=1},
	is_ground_content = false,
	description = S("Stalactite"),
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.187500,-0.425000,-0.150003,0.162500,-0.500000,0.162500},
			{-0.112500,-0.162500,-0.100000,0.087500,-0.475000,0.087500},
			{-0.062500,0.275000,-0.062500,0.062500,-0.500000,0.062500},
			{-0.037500,0.837500,0.037500,0.037500,-0.500000,-0.025000},
		}
	},
	on_place = function(itemstack, placer, pointed_thing)
		local dir = vector.subtract(pointed_thing.above, pointed_thing.under)
		local base = pointed_thing.under
		local place = vector.add(base, dir)
		local above = vector.add(place, dir)

		if not placer then return end
		local playername = placer:get_player_name()
		if minetest.is_protected(place, playername)
		or minetest.is_protected(above, playername) then
			minetest.record_protection_violation(place, playername)
			return
		end

		if minetest.get_node(base).name == "default:stone"
		and minetest.get_node(place).name == "air"
		and minetest.get_node(above).name == "air"
		then
			minetest.swap_node(place, {
				name = "cavestuff:stalactite_"..math.random(1,3),
				param2 = minetest.dir_to_wallmounted(vector.multiply(dir, -1))
			})
			if not minetest.is_creative_enabled(playername) then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})

minetest.register_node("cavestuff:stalactite_2",{
	drawtype="nodebox",
	tiles = {"undergrowth_pebble.png"},
	groups = {cracky=3,attached_node=1,not_in_creative_inventory=1},
	is_ground_content = false,
	drop = "cavestuff:stalactite_1",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.187500,-0.387500,-0.150003,0.162500,-0.500000,0.162500},
			{-0.112500,-0.112500,-0.100000,0.087500,-0.475000,0.087500},
			{-0.062500,0.675000,-0.062500,0.062500,-0.500000,0.062500},
			{-0.037500,0.975000,0.037500,0.037500,-0.500000,-0.025000},
		}
	},
})

minetest.register_node("cavestuff:stalactite_3",{
	drawtype="nodebox",
	tiles = {"undergrowth_pebble.png"},
	groups = {cracky=3,attached_node=1,not_in_creative_inventory=1},
	is_ground_content = false,
	drop = "cavestuff:stalactite_1",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.187500,-0.387500,-0.150003,0.162500,-0.500000,0.162500},
			{-0.112500,-0.037500,-0.100000,0.087500,-0.475000,0.087500},
			{-0.062500,0.437500,-0.062500,0.062500,-0.500000,0.062500},
			{-0.037500,1.237500,0.037500,0.037500,-0.500000,-0.025000},
		}
	},
})
