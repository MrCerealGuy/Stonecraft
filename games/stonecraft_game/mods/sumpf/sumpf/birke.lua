--[[

2017-05-15 MrCerealGuy: added intllib support

2018-03-21 MrCerealGuy: disallow abms when the server is lagging

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local sumpf_birch_seed = 113

local function get_random(pos)
	return PseudoRandom(math.abs(pos.x+pos.y*3+pos.z*5)+sumpf_birch_seed)
end


-- Nodes and crafting

minetest.register_node("sumpf:sapling", {
	description = S("birch"),
	drawtype = "plantlike",
	tiles = {"birke_sapling.png"},
	inventory_image = "birke_sapling.png",
	wield_image = "birke_sapling.png",
	paramtype = "light",
	waving = 1,
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	furnace_burntime = 9,
})

local spawn_birch
minetest.register_node("sumpf:birk", {
	tiles = {"birke_tree_top.png"},
	inventory_image = "birke_tree_top.png^birke_sapling.png",
	paramtype = "light",
	stack_max = 1024,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		spawn_birch(pos)
	end,
})

minetest.register_node("sumpf:leaves", {
	description = S("birch leaves"),
	drawtype = "glasslike",
	tiles = {"birke_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'sumpf:sapling'},
				rarity = 20,
			},
			{
				items = {'sumpf:leaves'},
				rarity = 20,
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("sumpf:tree", {
	description = S("birch trunk"),
	tiles = {"birke_tree_top.png",	"birke_tree_top.png",
		{name = "birke_tree.png", tileable_vertical = false}
	},
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("sumpf:mossytree", {
	description = S("mossy birch trunk"),
	tiles = {"birke_tree_top.png",	"sumpf.png", {
			name = "birke_tree.png^(sumpf_transition.png^[transformR180)",
			tileable_vertical = false
		}
	},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

if minetest.register_fence then
	minetest.register_fence({fence_of = "sumpf:leaves"})
	minetest.register_fence(
		{fence_of = "sumpf:tree", texture = "birke_tree.png"},
		{tiles = {"birke_tree.png"}}
	)
	minetest.register_fence({fence_of = "sumpf:mossytree",
		texture = "birke_tree.png^(sumpf_transition.png^[transformR180)"},
		{tiles = {"birke_tree.png^(sumpf_transition.png^[transformR180)"}})
end

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {{"sumpf:tree"}}
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {{"sumpf:mossytree"}}
})


-- tree functions and abm

local sumpf_c_mossytree = minetest.get_content_id("sumpf:mossytree")
local sumpf_c_tree = minetest.get_content_id("sumpf:tree")
local sumpf_c_leaves = minetest.get_content_id("sumpf:leaves")

local airlike_cs = {minetest.get_content_id"air",
	minetest.get_content_id"ignore"}
local function soft_node(id)
	for i = 1,#airlike_cs do
		if airlike_cs[i] == id then
			return true
		end
	end
	return false
end


local function tree_branch(manip, pos, dir, area, nodes, pr, param2s)

	local vi = area:indexp(pos)
	manip:set_data_from_heap(nodes, vi, sumpf_c_tree)
	if dir == 0 then
		manip:set_param2_data_from_heap(param2s, vi, 4)
	else
		manip:set_param2_data_from_heap(param2s, vi, 12)
	end

	for i = pr:next(1,2), -pr:next(1,2), -1 do
		for k = pr:next(1,2), -pr:next(1,2), -1 do
			local vi = area:index(pos.x+i, pos.y, pos.z+k)
			if soft_node(manip:get_data_from_heap(nodes, vi)) then
				manip:set_data_from_heap(nodes, vi, sumpf_c_leaves)
			end
			if math.abs(i + k) < 1 then
				vi = vi + area.ystride
				if soft_node(manip:get_data_from_heap(nodes, vi)) then
					manip:set_data_from_heap(nodes, vi, sumpf_c_leaves)
				end
			end
		end
	end
end

local function birch(manip, pos, height, area, nodes, pr, param2s)
	local vi = area:indexp(pos)	
	manip:set_data_from_heap(nodes, vi, sumpf_c_mossytree)
	for _ = 1, height do
		vi = vi + area.ystride
		manip:set_data_from_heap(nodes, vi, sumpf_c_tree)
		manip:set_param2_data_from_heap(param2s, vi, 0)
	end

	for i = height, 4, -1 do
		if math.sin(i*i/height) < 0.2
		and pr:next(0,2) < 1.5 then
			tree_branch(manip,
				{x=pos.x+pr:next(0,1), y=pos.y+i, z=pos.z-pr:next(0,1)},
				pr:next(0,1),
			area, nodes, pr, param2s)
		end
	end

	for _,i in ipairs({
		{{x=pos.x, y=pos.y+height+pr:next(0,1), z=pos.z}, pr:next(0,1)},

		{{x=pos.x+1, y=pos.y+height-pr:next(1,2), z=pos.z,}, 1},
		{{x=pos.x-1, y=pos.y+height-pr:next(1,2), z=pos.z}, 1},
		{{x=pos.x, y=pos.y+height-pr:next(1,2), z=pos.z+1}, 0},
		{{x=pos.x, y=pos.y+height-pr:next(1,2), z=pos.z-1}, 0},
	}) do
		tree_branch(manip, i[1], i[2], area, nodes, pr, param2s)
	end
end

function sumpf.generate_birch(manip, pos, area, nodes, pr, param2s)
	birch(manip, pos, 3+pr:next(1,2), area, nodes, pr, param2s)
end

function spawn_birch(pos)
	local t1 = minetest.get_us_time()

	local pr = get_random(pos)
	local height = 3 + pr:next(1,2)

	local vwidth = 3
	local vheight = height+2

	local manip = minetest.get_voxel_manip()
	local emin, emax = manip:read_from_map(
		{x = pos.x - vwidth, y = pos.y, z = pos.z - vwidth},
		{x = pos.x + vwidth, y = pos.y + vheight, z = pos.z + vwidth}
	)
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:load_data_into_heap()
	local param2s = manip:load_param2_data_into_heap()

	birch(manip, pos, height, area, nodes, pr, param2s)

	manip:save_data_from_heap(nodes)
	manip:save_param2_data_from_heap(param2s)
	manip:write_to_map()
	sumpf.inform("a birch grew at " .. minetest.pos_to_string(pos), 2, t1)
end

minetest.register_abm({
	nodenames = {"sumpf:sapling"},
	neighbors = {"group:soil"},
	interval = 20,
	chance = 8,
	action = function(pos)
		if sumpf.tree_allowed(pos, 8) then
			spawn_birch(pos)
		end
	end
})


-- treecapitator support

if rawget(_G, "treecapitator") then
	treecapitator.register_tree{
		trees = {"sumpf:tree", "sumpf:mossytree"},
		leaves = {"sumpf:leaves"},
		range = 3,
		fruits = {"sumpf:tree"}
	}
end


-- habitat support

if sumpf.spawn_plants
and rawget(_G, "habitat") then
	habitat:generate("sumpf:sapling", "default:dirt_with_grass", nil, nil, 20,
		25, 100, 500, {"default:water_source"},30,{"default:desert_sand"})
	habitat:generate("sumpf:gras", "default:dirt_with_grass", nil, nil, 0, 25,
		90, 100, {"default:water_source"},30,{"default:desert_sand"})
end


-- legacy

minetest.register_node("sumpf:tree_horizontal", {
	description = "horizontal birch trunk",
	tiles = {"birke_tree.png", "birke_tree.png", "birke_tree.png^[transformR90",
		"birke_tree.png^[transformR90", "birke_tree_top.png"},
	paramtype2 = "facedir",
	drop = "sumpf:tree",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2,
		not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(stack)
		local backup = ItemStack(stack)
		if stack:set_name("sumpf:tree") then
			return stack
		end
		return backup
	end
})

minetest.register_craft({
	output = "sumpf:tree",
	recipe = {{"sumpf:tree_horizontal"}}
})

minetest.register_lbm({
	name = "sumpf:birch_legacy",
	nodenames = {"sumpf:tree_horizontal"},
	--run_at_every_load = true,
	action = function(pos, node)
		local t1 = minetest.get_us_time()
		node.name = "sumpf:tree"
		if node.param2 == 0
		or node.param2 == 2 then
			node.param2 = 4
		elseif node.param2 == 1 then
			node.param2 = 12
		else
			minetest.log("error",
				"[sumpf] legacy: unknown birch trunk param2 " .. node.param2 ..
				" " .. minetest.pos_to_string(pos))
			return	-- don't destroy houses
		end
		minetest.set_node(pos, node)
		sumpf.inform("legacy: a horizontal tree node became changed at " ..
			minetest.pos_to_string(pos), 3, t1)
	end
})
