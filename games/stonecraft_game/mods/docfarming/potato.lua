--[[

2017-05-18 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_craftitem("docfarming:potato", {
	description = S("Potato"),
	inventory_image = "potato.png",
	on_use = minetest.item_eat(3),
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "docfarming:potato1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end

})
minetest.register_craftitem("docfarming:potatoseed", {
	description = S("Potato Seeds"),
	inventory_image = "potatoseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "docfarming:potato1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end

})
minetest.register_craftitem("docfarming:bakedpotato", {
	description = S("Baked Potato"),
	inventory_image = "baked_potato.png",
	on_use = minetest.item_eat(6),
})
minetest.register_craft({
	type = "cooking",
	output = "docfarming:bakedpotato",
	recipe = "docfarming:potato",
})
minetest.register_node("docfarming:potato1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"potato1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:potato2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"potato2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:potato3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"potato3.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:potato4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"potato4.png"},
	drop = {
		max_items = 3,
		items = {
			{ items = {'docfarming:potato'} },
			{ items = {'docfarming:potato'}, rarity = 2},
			{ items = {'docfarming:potato'}, rarity = 5},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
interval = 45
chance = 14
whereon = "docfarming:plowed"
wherein = "air"
	minetest.register_abm({
		nodenames = "docfarming:potato1",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= whereon then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			minetest.env:set_node(pos, {name='docfarming:potato2'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:potato2",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= whereon then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			minetest.env:set_node(pos, {name='docfarming:potato3'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:potato3",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= whereon then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			minetest.env:set_node(pos, {name='docfarming:potato4'})
			
		end
}	)