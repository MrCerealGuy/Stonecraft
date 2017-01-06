function tree_growing(pos, specie)
	local tree = trees[specie]
	local height = math.random(tree.trunk_height.min, tree.trunk_height.max)
	for dy = 0, height - 1 do
		minetest.env:set_node({x = pos.x, y = pos.y + dy, z = pos.z}, {name = tree.nodes.tree})
	end
	local steps = math.floor((height + tree.height_above_trunk) * tree.percent_size / 100)
	local corner_leaf
	for dy = 1, steps do
		for dx = - tree.radius, tree.radius do
			for dz = - tree.radius, tree.radius do
				pos.x = pos.x + dx
				pos.y = pos.y + height + tree.height_above_trunk - dy
				pos.z = pos.z + dz
				if dy == 1 or dy == steps then
					corner_leaf = 1
				end
				if math.abs(dx) == tree.radius then
					corner_leaf = corner_leaf + 1
				end
				if math.abs(dz) == tree.radius then
					corner_leaf = corner_leaf + 1
				end
				if (minetest.env:get_node(pos).name == "air" or minetest.env:get_node(pos).name == "ignore") and math.random(100) <= tree.percent_leaves and corner_leaf <= tree.corners then
					minetest.env:set_node(pos, {name = tree.nodes.leaves})
				end
				pos.x = pos.x - dx
				pos.y = pos.y - height - tree.height_above_trunk + dy
				pos.z = pos.z - dz
				corner_leaf = 0
			end
		end
	end
	if tree.base then
		for dx = -1, 1 do
			for dz = -1, 1 do
				if math.random() * 100 <= tree.base then
					local basepos = {x = pos.x + dx, y = pos.y, z = pos.z + dz}
					minetest.set_node(basepos, {name = tree.nodes.tree})
					if tree.associated then
						local chance = 100
						local above = {x = basepos.x, y = basepos.y + 1, z = basepos.z}
						for plant, def in pairs(tree.associated) do
							if math.random() * chance < def and minetest.get_node(above).name == "air" then
								minetest.set_node(above, {name = plant})
								break
							else
								chance = chance - def
							end
						end
					end
				end
			end
		end
	end
	if tree.associated then
		local grass_area = minetest.find_nodes_in_area({x = pos.x - 2, y = pos.y - 2, z = pos.z - 2}, {x = pos.x + 2, y = pos.y + 2, z = pos.z + 2}, "default:dirt_with_grass")
		for grass, pos in pairs(grass_area) do
			pos.y = pos.y + 1
			local chance = 100
			for plant, def in pairs(tree.associated) do
				if math.random() * chance < def and minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name = plant})
					break
				else
					chance = chance - def
				end
			end
		end
	end
end
