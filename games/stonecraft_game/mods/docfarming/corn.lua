minetest.register_craftitem("docfarming:cornseed", {
	description = "Corn Seeds",
	inventory_image = "cornseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "docfarming:corn1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})
minetest.register_craftitem("docfarming:corn", {
	description = "Corn Ear",
	inventory_image = "corn.png",
	on_use = minetest.item_eat(4),
})
minetest.register_node("docfarming:corn1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn3.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn4.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn21", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn21.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn22", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn22.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn23", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn23.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'docfarming:corn'} },
			{ items = {'docfarming:corn'}, rarity = 2},
			{ items = {'docfarming:corn'}, rarity = 5},
			{ items = {'docfarming:cornseed'} },
			{ items = {'docfarming:cornseed'}, rarity = 2 },
			{ items = {'docfarming:cornseed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn31", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn31.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:corn32", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn32.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'docfarming:corn'} },
			{ items = {'docfarming:corn'}, rarity = 2},
			{ items = {'docfarming:corn'}, rarity = 5},
			{ items = {'docfarming:cornseed'} },
			{ items = {'docfarming:cornseed'}, rarity = 2 },
			{ items = {'docfarming:cornseed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

chance = 10
interval = 45
whereon = "docfarming:plowed"
wherein = "air"

	minetest.register_abm({
		nodenames = "docfarming:corn1",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "docfarming:plowed" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			if minetest.env:get_node(pos).name ~= wherein then
				return
			end
			pos.y=pos.y-1
			
			minetest.env:set_node(pos, {name='docfarming:corn2'})
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:corn2",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "docfarming:plowed" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='docfarming:corn21'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='docfarming:corn3'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:corn3",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "docfarming:plowed" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='docfarming:corn31'})
			pos.y=pos.y-1
			
			minetest.env:set_node(pos, {name='docfarming:corn22'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='docfarming:corn4'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:corn22",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='docfarming:corn32'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='docfarming:corn23'})
			
		end
}	)