minetest.register_craftitem("docfarming:cucumberseed", {
	description = "Cucumber Seeds",
	inventory_image = "cucumberseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "docfarming:cucumber1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end

})
minetest.register_craftitem("docfarming:cucumber", {
	description = "Cucumber",
	inventory_image = "cucumber.png",
	on_use = minetest.item_eat(4),
})
minetest.register_node("docfarming:cucumber1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:cucumber2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:cucumber3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("docfarming:cucumber4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"cucumber4.png"},
	after_dig_node = function(pos)
	end,
	drop = {
		max_items = 6,
		items = {
			{ items = {'docfarming:cucumber'} },
			{ items = {'docfarming:cucumber'}, rarity = 2},
			{ items = {'docfarming:cucumber'}, rarity = 5},
			{ items = {'docfarming:cucumberseed'} },
			{ items = {'docfarming:cucumberseed'}, rarity = 2},
			{ items = {'docfarming:cucumberseed'}, rarity = 5},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
chance = 10
interval = 30
whereon = "docfarming:plowed"
wherein = "air"

	minetest.register_abm({
		nodenames = "docfarming:cucumber1",
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
			minetest.env:set_node(pos, {name='docfarming:cucumber2'})
		end
}	)
	minetest.register_abm({
		nodenames = "docfarming:cucumber2",
		interval = 30,
		chance = 10,
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
			
			minetest.env:set_node(pos, {name='docfarming:cucumber3'})
			
		end
}	)

	minetest.register_abm({
		nodenames = "docfarming:cucumber3",
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
			minetest.env:set_node(pos, {name='docfarming:cucumber4'})
			
		end
}	)
num = PseudoRandom(111)
	minetest.register_abm({
		nodenames = "docfarming:cucumber3",
		interval = 30,
		chance = 10,
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
					minetest.env:set_node(pos, {name='docfarming:cucumber3'})
				end
				if name=="default:dirt_with_grass" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:cucumber3'})
				end
				if name=="air" then
					pos.y=pos.y-1
					name = minetest.env:get_node(pos).name
					if name=="default:dirt" then								pos.y=pos.y+1
							minetest.env:set_node(pos, {name='docfarming:cucumber3'})
					end
					if name=="default:dirt_with_grass" then																		pos.y=pos.y+1
						minetest.env:set_node(pos, {name='docfarming:cucumber3'})
					end
				end
				
			end
			pos.y=pos.y+1
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:dirt" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:cucumber3'})
				end
				if name=="default:dirt_with_grass" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='docfarming:cucumber3'})
				end
			end
			
			
		end
}	)