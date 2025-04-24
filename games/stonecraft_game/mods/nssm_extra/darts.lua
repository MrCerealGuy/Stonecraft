
-- crystalgas arrow

mobs:register_arrow("nssm:crystal_gas_arrow", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"crystal_arrow.png"},
	velocity = 8,

	hit_player = function(self, player)
		crystal_gas_explosion(player:get_pos())
	end,

	hit_node = function(self, pos, node)
		crystal_gas_explosion(pos)
	end
})


function crystal_gas_explosion(pos)

	if minetest.is_protected(pos, "") then
		return
	end

	for dx = 0, 0 do
		for dy = -1, 2 do
			for dz = 0, 0 do

				local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}

				if minetest.is_protected(p, "") then
					return
				end

				local n = minetest.get_node(p).name

				if n == "air" then
					minetest.set_node(p, {name = "nssm:crystal_gas"})
				end
			end
		end
	end
end

-- Pumpkid bomb

mobs:register_arrow("nssm:pumpkid_bomb", {
	visual = "cube",
	visual_size = {x = 1, y = 1},
	textures = {
		"pumpbomb_top.png", "pumpbomb_bottom.png", "pumpbomb_side.png",
		"pumpbomb_side.png", "pumpbomb_side.png", "pumpbomb_front.png"
	},
	velocity = 8,

	hit_player = function(self, player)

		local p = player:get_pos()

		if not minetest.is_protected(p, "")
		or not minetest.get_item_group(minetest.get_node(p).name, "unbreakable") == 1 then

			tnt.boom(p, {damage_radius = 3,radius = 2,ignore_protection = false})
		end
	end,

	hit_node = function(self, pos, node)

		if not minetest.is_protected(pos, "")
		or not minetest.get_item_group(minetest.get_node(pos).name, "unbreakable") == 1 then

			tnt.boom(pos, {damage_radius = 3,radius = 2,ignore_protection = false})
		end
	end
})

-- Lava_block bomb

mobs:register_arrow("nssm:lava_block_bomb", {
	visual = "cube",
	visual_size = {x = 1, y = 1},
	textures = {
		"default_lava.png", "default_lava.png", "default_lava.png",
		"default_lava.png", "default_lava.png", "default_lava.png"
	},
	velocity = 8,

	hit_player = function(self, player)

		local p = player:get_pos()

		if not minetest.is_protected(p, "")
		or not minetest.get_item_group(minetest.get_node(p).name, "unbreakable") == 1 then

			minetest.set_node(p, {name = "default:lava_source"})
		end
	end,

	hit_node = function(self, pos, node)

		if not minetest.is_protected(pos, "")
		or not minetest.get_item_group(minetest.get_node(pos).name, "unbreakable") == 1 then

			minetest.set_node(pos, {name = "default:lava_source"})
		end
	end
})

