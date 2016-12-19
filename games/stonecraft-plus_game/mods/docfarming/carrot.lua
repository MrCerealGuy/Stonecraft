minetest.register_craftitem("docfarming:carrot", {
	description = "Carrot",
	inventory_image = "carrot.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craftitem("docfarming:carrotseed", {
	description = "Carrot Seeds",
	inventory_image = "carrotseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
			if above.name == "air" then
				above.name = "docfarming:carrot1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
	end
})
minetest.register_node("docfarming:carrot1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"carrot1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:carrot2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"carrot2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:carrot3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"carrot3.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:carrot4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"carrot4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'docfarming:carrot'} },
			{ items = {'docfarming:carrot'}, rarity = 2},
			{ items = {'docfarming:carrot'}, rarity = 5},
			{ items = {'docfarming:carrotseed'} },
			{ items = {'docfarming:carrotseed'}, rarity = 2},
			{ items = {'docfarming:carrotseed'}, rarity = 5}
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
interval = 45
chance = 15

whereon = "docfarming:plowed"
wherein = "air"
	minetest.register_abm({
		nodenames = "docfarming:carrot1",
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
			minetest.env:set_node(pos, {name='docfarming:carrot2'})
			
		end
}	)

	minetest.register_abm({
		nodenames = "docfarming:carrot2",
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
			minetest.env:set_node(pos, {name='docfarming:carrot3'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:carrot3",
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
			minetest.env:set_node(pos, {name='docfarming:carrot4'})
			
		end
}	)

