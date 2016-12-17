minetest.register_craftitem("docfarming:raspberryseed", {
	description = "Raspberry Seeds",
	inventory_image = "raspberryseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "docfarming:raspberry1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})
minetest.register_craftitem("docfarming:raspberry", {
	description = "Raspberries",
	inventory_image = "raspberries.png",
	on_use = minetest.item_eat(5),
})
minetest.register_node("docfarming:raspberry1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"raspberry1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:raspberry2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"raspberry2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:raspberry3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"raspberry3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:raspberry4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"raspberry4.png"},
	after_dig_node = function(pos)
		minetest.env:add_node(pos, {name='docfarming:raspberry2'})
	end,
	drop = {
		max_items = 4,
		items = {
			{ items = {'docfarming:raspberry'} },
			{ items = {'docfarming:raspberry'}, rarity = 2},
			{ items = {'docfarming:raspberry'}, rarity = 5},
			{ items = {'docfarming:raspberryseed'}, rarity = 10},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
chance = 20
interval = 45
whereon = "docfarming:plowed", "default:dirt_with_grass"
wherein = "air"

	minetest.register_abm({
		nodenames = "docfarming:raspberry1",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "docfarming:plowed" and minetest.env:get_node(pos).name ~= "default_dirt_with_grass" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			minetest.env:set_node(pos, {name='docfarming:raspberry2'})
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:raspberry2",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= whereon and minetest.env:get_node(pos).name ~= "default:dirt_with_grass" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			
			minetest.env:set_node(pos, {name='docfarming:raspberry3'})
			
		end
}	)

	minetest.register_abm({
		nodenames = "docfarming:raspberry3",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= whereon and minetest.env:get_node(pos).name ~= "default:dirt_with_grass" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			minetest.env:set_node(pos, {name='docfarming:raspberry4'})
			
		end
}	)
num = PseudoRandom(111)
	minetest.register_abm({
		nodenames = "docfarming:raspberry4",
		interval = 30,
		chance = 20,
		action = function(pos, node)
			
			pos.x = pos.x-1
			x = num:next(1, 3)
			if x > 1 then
				pos.x = pos.x+1
				if x > 2 then	
					pos.x = pos.x+1
				end
			end
			pos.z=pos.z-1
			z = num:next(1, 3)
			if z > 1 then
				pos.z = pos.z+1
				if z > 2 then	
					pos.z = pos.z+1
				end
			end
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:dirt" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:raspberry2'})
				end
				if name=="default:dirt_with_grass" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:raspberry2'})
				end
				if name=="air" then
					pos.y=pos.y-1
					name = minetest.env:get_node(pos).name
					if name=="default:dirt" then								pos.y=pos.y+1
							minetest.env:set_node(pos, {name='docfarming:raspberry2'})
					end
					if name=="default:dirt_with_grass" then																		pos.y=pos.y+1
						minetest.env:set_node(pos, {name='docfarming:raspberry2'})
					end
				end
				
			end
			pos.y=pos.y+1
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:dirt" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:raspberry2'})
				end
				if name=="default:dirt_with_grass" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:raspberry2'})
				end
			end
			
			
		end
}	)