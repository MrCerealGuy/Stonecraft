
-- function to decide if a node has a wall that's in verticals_list{}
-- returns wall direction of valid node, or nil if invalid.

function biome_lib.find_adjacent_wall(pos, verticals, randomflag)
	local verts = dump(verticals)
	if randomflag then
		local walltab = {}

		if string.find(verts, minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z   }).name) then walltab[#walltab + 1] = 3 end
		if string.find(verts, minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z   }).name) then walltab[#walltab + 1] = 2 end
		if string.find(verts, minetest.get_node({ x=pos.x  , y=pos.y, z=pos.z-1 }).name) then walltab[#walltab + 1] = 5 end
		if string.find(verts, minetest.get_node({ x=pos.x  , y=pos.y, z=pos.z+1 }).name) then walltab[#walltab + 1] = 4 end

		if #walltab > 0 then return walltab[math.random(1, #walltab)] end

	else
		if string.find(verts, minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z   }).name) then return 3 end
		if string.find(verts, minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z   }).name) then return 2 end
		if string.find(verts, minetest.get_node({ x=pos.x  , y=pos.y, z=pos.z-1 }).name) then return 5 end
		if string.find(verts, minetest.get_node({ x=pos.x  , y=pos.y, z=pos.z+1 }).name) then return 4 end
	end
	return nil
end

-- Function to search downward from the given position, looking for the first
-- node that matches the ground table.  Returns the new position, or nil if
-- height limit is exceeded before finding it.

function biome_lib.search_downward(pos, heightlimit, ground)
	for i = 0, heightlimit do
		if string.find(dump(ground), minetest.get_node({x=pos.x, y=pos.y-i, z = pos.z}).name) then
			return {x=pos.x, y=pos.y-i, z = pos.z}
		end
	end
	return false
end

function biome_lib.find_open_side(pos)
	if minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z }).name == "air" then
		return {newpos = { x=pos.x-1, y=pos.y, z=pos.z }, facedir = 2}
	end
	if minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z }).name == "air" then
		return {newpos = { x=pos.x+1, y=pos.y, z=pos.z }, facedir = 3}
	end
	if minetest.get_node({ x=pos.x, y=pos.y, z=pos.z-1 }).name == "air" then
		return {newpos = { x=pos.x, y=pos.y, z=pos.z-1 }, facedir = 4}
	end
	if minetest.get_node({ x=pos.x, y=pos.y, z=pos.z+1 }).name == "air" then
		return {newpos = { x=pos.x, y=pos.y, z=pos.z+1 }, facedir = 5}
	end
	return nil
end
