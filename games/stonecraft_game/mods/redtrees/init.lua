--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_redtrees = world_conf:get("enable_redtrees")

if enable_redtrees ~= nil and enable_redtrees == "false" then
	minetest.log("info", "[redtrees] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

--Red Trees (AKA Fiery Trees)
--Put together by Glory!.
--Uses code modified from Default and Tiny Trees (bas080)
redtrees = {}
----------------------------------
dofile(minetest.get_modpath("redtrees").."/nodes.lua")
dofile(minetest.get_modpath("redtrees").."/crafting.lua")
--BEGIN TREE GROWING PROCESS!
local random = math.random

local function can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	local name_under = node_under.name
	local is_soil = minetest.get_item_group(name_under, "soil")
	if is_soil == 0 then
		return false
	end
	return true
end

--SAPLINGS!!!
minetest.register_abm({
	nodenames = {"redtrees:rsapling"},
	interval = 10,
	chance = 50,
	action = function(pos, node)
		if not can_grow(pos) then
			return
		end

		minetest.log("action", "A fiery sapling grows into a fiery tree at "..
				minetest.pos_to_string(pos))
		redtrees.grow_tree(pos, random(1, 4) == 1)
	end
})

--DEFAULT CODE!!!
local function add_trunk_and_leaves(vm, data, a, pos, tree_cid, leaves_cid,
		height, size, iters)
	local x, y, z = pos.x, pos.y, pos.z
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")

	--TRUNK!!! EXCITEMENT!!!
	for y_dist = 0, height - 1 do
		local vi = a:index(x, y + y_dist, z)
		local node_id = vm:get_data_from_heap(data, vi)
		if y_dist == 0 or node_id == c_air or node_id == c_ignore
		or node_id == leaves_cid then
			vm:set_data_from_heap(data, vi, tree_cid)
		end
	end

	--CodeSins: Overhype over leaves.
	for z_dist = -1, 1 do
	for y_dist = -size, 1 do
		local vi = a:index(x - 1, y + height + y_dist, z + z_dist)
		for x_dist = -1, 1 do
			if vm:get_data_from_heap(data, vi) == c_air or vm:get_data_from_heap(data, vi) == c_ignore then
				vm:st_data_from_heap(data, vi, leaves_cid)
			end
			vi = vi + 1
		end
	end
	end

	--Random 2^3 leaf clusters
	for i = 1, iters do
		local clust_x = x + random(-size, size - 1)
		local clust_y = y + height + random(-size, 0)
		local clust_z = z + random(-size, size - 1)

		for xi = 0, 1 do
		for yi = 0, 1 do
		for zi = 0, 1 do
			local vi = a:index(clust_x + xi, clust_y + yi, clust_z + zi)
			if vm:get_data_from_heap(data, vi) == c_air or vm:get_data_from_heap(data, vi) == c_ignore then
					vm:set_data_from_heap(data, vi, leaves_cid)
			end
		end
		end
		end
	end
end

--MAKE TREE!!
redtrees.grow_tree = function(pos)
	if bad then
		error("Deprecated use of forked default.grow_tree")
	end

	local x, y, z = pos.x, pos.y, pos.z
	local height = random(4, 5)
	local c_tree = minetest.get_content_id("redtrees:rtree")
	local c_leaves = minetest.get_content_id("redtrees:rleaves")

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = pos.x - 2, y = pos.y, z = pos.z - 2},
		{x = pos.x + 2, y = pos.y + height + 1, z = pos.z + 2}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:load_data_into_heap()

	add_trunk_and_leaves(vm, data, a, pos, c_tree, c_leaves, height, 2, 8)

	vm:save_data_from_heap(data)
	vm:write_to_map()
	vm:update_map()
end

--SUDO PLACE TREE!!!
biome_lib:register_generate_plant({
    surface = "default:dirt_with_grass",
    max_count = 30,
    avoid_nodes = {"group:tree", "default:sand"},
    avoid_radius = 16,
    rarity = 75,
    seed_diff = 666,
    min_elevation = -3,
    max_elevation = 12,
    plantlife_limit = -0.5,
    check_air = false,
    humidity_max = -2,
    humidity_min = 2,
    temp_max = -0.8,
    temp_min = 0.8,
  },
  'redtrees.grow_tree'
)
