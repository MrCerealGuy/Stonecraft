function fir_growing(pos)
	local height = math.random(5,13)
		-- build the trunk
	for dy = 0, height do
		minetest.set_node({x = pos.x, y = pos.y + dy, z = pos.z}, {name = "forest:fir_tree"})
	end
	local steps = math.floor(height * 0.75 + 2.25)
	local dist = 0
		-- add the leaves, cell by cell
	for dy = 1, steps do
		-- define the width of the step : to modelize the conic shape of the tree,
		-- for each step the width is proportionnal to the distance to the top
		dist = math.floor(dy / 3)
		for dx = -dist, dist do
			for dz = -dist, dist do
				pos.x = pos.x + dx
				pos.y = pos.y + height + 3 - dy
				pos.z = pos.z + dz
					-- for each cell we will get 60% chance to have leaves
				if (minetest.get_node(pos).name == "air" or minetest.get_node(pos).name == "ignore") and math.random(1, 5) <= 3 then
					minetest.set_node(pos, {name = "forest:fir_leaves"})
				end
				pos.x = pos.x - dx
				pos.y = pos.y - height - 3 + dy
				pos.z = pos.z - dz
			end
		end
	end
		-- if the leaves node at the top is floating, put another leaves node under
	local node_top = minetest.get_node({x = pos.x, y = pos.y + height + 1, z = pos.z}).name
	if minetest.get_node({x = pos.x, y = pos.y + height + 2, z = pos.z}).name == "forest:fir_leaves" and (node_top == "air" or node_top == "ignore") then
		minetest.set_node({x = pos.x, y = pos.y + height + 1, z = pos.z}, {name = "forest:fir_leaves"})
	end
end
