local img = {"eye", "men", "sun"}

for i=1,3 do
	minetest.register_node("pyramids:deco_stone"..i, {
		description = "Sandstone with "..img[i],
		tiles = {"default_sandstone.png^pyramids_"..img[i]..".png"},
		is_ground_content = true,
		groups = {crumbly=2,cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

trap_on_timer = function (pos, elapsed)
	local objs = minetest.env:get_objects_inside_radius(pos, 2)
	for i, obj in pairs(objs) do
		if obj:is_player() then
			local n = minetest.get_node(pos)
			if n and n.name then
				if minetest.registered_nodes[n.name].crack and minetest.registered_nodes[n.name].crack < 2 then
					minetest.set_node(pos, {name="pyramids:trap_2"})
					nodeupdate(pos)
				end
			end
		end
	end
	return true
end

minetest.register_node("pyramids:trap", {
	description = "Cracked sandstone brick",
	tiles = {"default_sandstone_brick.png^pyramids_crack.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(0.1)
	end,
	crack = 1,
	on_timer = trap_on_timer,
	drop = "",
})

minetest.register_node("pyramids:trap_2", {
	description = "trapstone",
	tiles = {"default_sandstone_brick.png^pyramids_crack.png^[transformR90"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=3,falling_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	drop = "",
})
