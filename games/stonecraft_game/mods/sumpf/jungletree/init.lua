sumpf = rawget(_G, "sumpf") or {}

local jungletree_seed = 112

function jungletree_get_random(pos)
	return PseudoRandom(math.abs(pos.x+pos.y*3+pos.z*5)+jungletree_seed)
end


-- Nodes

local leaves = {"green","yellow","red"}
local spawn_jungletree
minetest.register_node("jungletree:sapling", {
	description = "jungle tree sapling",
	drawtype = "plantlike",
	tiles = {"jungletree_sapling.png"},
	inventory_image = "jungletree_sapling.png",
	wield_image = "jungletree_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	on_construct = function(pos)
		if minetest.setting_getbool("creative_mode") then
			spawn_jungletree(pos)
		end
	end
})

local plantlike_leaves = not minetest.setting_getbool("new_style_leaves")
local rt2 = math.sqrt(2)
local tex_sc = (1-(1/rt2))*100-4 --doesn't seem to work right
local tab = {
	description = "jungle tree leaves",
	is_ground_content = false, -- because default:jungletree's is_ground_content
	waving = 1, --warum 1?
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'jungletree:sapling'},
				rarity = 20,
			},
			{
				items = {},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
}
if plantlike_leaves then
	for color = 1, 3 do
		local leaf_name = "jungletree:leaves_"..leaves[color]
		tab.visual_scale = math.sqrt(rt2)
		tab.drawtype = "plantlike"
		tab.tiles = {"jungletree_leaves_"..leaves[color]..".png^[lowpart:"..tex_sc..":jungletree_invmat.png^[makealpha:255,126,126"}
		tab.inventory_image = minetest.inventorycube("jungletree_leaves_"..leaves[color]..".png")
		tab.drop.items[2].items[1] = leaf_name
		minetest.register_node(leaf_name, table.copy(tab))
	end
else
	for color = 1, 3 do
		local leaf_name = "jungletree:leaves_"..leaves[color]
		tab.visual_scale = math.sqrt(rt2)
		tab.drawtype = "allfaces_optional"
		tab.tiles = {"jungletree_leaves_"..leaves[color]..".png"}
		tab.drop.items[2].items[1] = leaf_name
		minetest.register_node(leaf_name, table.copy(tab))
	end
end


-- tree functions and abm

local c_leaves_green = minetest.get_content_id("jungletree:leaves_green")
local c_leaves_red = minetest.get_content_id("jungletree:leaves_red")
local c_leaves_yellow = minetest.get_content_id("jungletree:leaves_yellow")
local c_jungletree = minetest.get_content_id("default:jungletree")
local ndtable = {c_leaves_green, c_leaves_red, c_leaves_yellow}

local airlike_cs = {minetest.get_content_id("air"), minetest.get_content_id("ignore")}
local function soft_node(id)
	for i = 1,#airlike_cs do
		if airlike_cs[i] == id then
			return true
		end
	end
	return false
end

local function tree_branch(pos, area, nodes, pr)

	--choose random leaves
	--green leaves are more common
	local leaf = 1
	if pr:next(1,5) < 2 then
		leaf = pr:next(1,3)
	end

	nodes[area:index(pos.x, pos.y, pos.z)] = c_jungletree
	for i = pr:next(1,2), -pr:next(1,2), -1 do
		for k = pr:next(1,2), -pr:next(1,2), -1 do
			local p_p = area:index(pos.x+i, pos.y, pos.z+k)
			if soft_node(nodes[p_p]) then
				nodes[p_p] = ndtable[leaf]
			end
			if math.abs(i+k) < 1 then
				local p_p = area:index(pos.x+i, pos.y+1, pos.z+k)
				if soft_node(nodes[p_p]) then
					nodes[p_p] = ndtable[leaf]
				end
			end
		end
	end
end


local function small_jungletree(pos, height, area, nodes, pr)
	for _,p in ipairs({
		{x=pos.x, y=pos.y+height+pr:next(0,1), z=pos.z},
		{x=pos.x, y=pos.y+height+pr:next(0,1), z=pos.z},

		{x=pos.x+1, y=pos.y+height-pr:next(1,2), z=pos.z},
		{x=pos.x-1, y=pos.y+height-pr:next(1,2), z=pos.z},
		{x=pos.x, y=pos.y+height-pr:next(1,2), z=pos.z+1},
		{x=pos.x, y=pos.y+height-pr:next(1,2), z=pos.z-1},
	}) do
		tree_branch(p, area, nodes, pr)
	end

	for i = -1, height do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c_jungletree
	end

	for i = height, 4, -1 do
		if math.sin(i*i/height) < 0.2
		and pr:next(0,2) < 1.5 then
			tree_branch({x=pos.x+pr:next(0,1), y=pos.y+i, z=pos.z-pr:next(0,1)}, area, nodes, pr)
		end
	end
end

local function big_jungletree(pos, height, area, nodes, pr)
	local h_root = pr:next(0,1)-1
	for i = -2, h_root do
		nodes[area:index(pos.x+1, pos.y+i, pos.z+1)] = c_jungletree
		nodes[area:index(pos.x+2, pos.y+i, pos.z-1)] = c_jungletree
		nodes[area:index(pos.x, pos.y+i, pos.z-2)] = c_jungletree

		nodes[area:index(pos.x-1, pos.y+i, pos.z)] = c_jungletree
	end
	for i = height, -2, -1 do
		if i > 3
		and math.sin(i*i/height) < 0.2
		and pr:next(0,2) < 1.5 then
			tree_branch({x=pos.x+pr:next(0,1), y=pos.y+i, z=pos.z-pr:next(0,1)}, area, nodes, pr)
		end

		if i == height then
			for _,p in ipairs({
				{x=pos.x+1, y=pos.y+i, z=pos.z+1},
				{x=pos.x+2, y=pos.y+i, z=pos.z-1},

				{x=pos.x, y=pos.y+i, z=pos.z-2},
				{x=pos.x-1, y=pos.y+i, z=pos.z},
				{x=pos.x+1, y=pos.y+i, z=pos.z+2},
				{x=pos.x+3, y=pos.y+i, z=pos.z-1},
				{x=pos.x, y=pos.y+i, z=pos.z-3},

				{x=pos.x-2, y=pos.y+i, z=pos.z},
				{x=pos.x+1, y=pos.y+i, z=pos.z},
				{x=pos.x+1, y=pos.y+i, z=pos.z-1},
				{x=pos.x, y=pos.y+i, z=pos.z-1},
				{x=pos.x, y=pos.y+i, z=pos.z},
			}) do
				tree_branch(p, area, nodes, pr)
			end
		else
			for _,p in pairs({
				{pos.x+1, pos.y+i, pos.z},
				{pos.x+1, pos.y+i, pos.z-1},
				{pos.x, pos.y+i, pos.z-1},
				{pos.x, pos.y+i, pos.z},
			}) do
				nodes[area:index(p[1], p[2], p[3])] = c_jungletree
			end
		end
	end
end

function sumpf.generate_jungletree(pos, area, nodes, pr, ymax)
	local h_max = 15
	-- should fix trees on upper chunk corners
	local max_heigth = ymax+16-pos.y
	if max_heigth < 21 then
		h_max = max_heigth-5-1
	end

	local height = 5 + pr:next(1,h_max)

	if height < 10 then
		small_jungletree(pos, height, area, nodes, pr)
	else
		big_jungletree(pos, height, area, nodes, pr)
	end
end

function spawn_jungletree(pos)
	local t1 = os.clock()

	local pr = jungletree_get_random(pos)
	local height = 5 + pr:next(1,15)
	local small = height < 10

	local vwidth, vheight, vdepth
	if small then
		vheight = 2
		vdepth = -1
		vwidth = 3
	else
		vheight = 1
		vdepth = -2
		vwidth = 5
	end
	vheight = height+vheight

	local manip = minetest.get_voxel_manip()
	local emerged_pos1, emerged_pos2 = manip:read_from_map({x=pos.x-vwidth, y=pos.y+vdepth, z=pos.z-vwidth},
		{x=pos.x+vwidth, y=pos.y+vheight, z=pos.z+vwidth})
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:get_data()

	if small then
		small_jungletree(pos, height, area, nodes, pr)
	else
		big_jungletree(pos, height, area, nodes, pr)
	end

	manip:set_data(nodes)
	manip:write_to_map()
	sumpf.inform("a jungletree grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", 2, t1)
	t1 = os.clock()
	manip:update_map()
	sumpf.inform("map updated", 2, t1)
end

minetest.register_abm({
	nodenames = {"jungletree:sapling"},
	neighbors = {"group:soil"},
	interval = 40,
	chance = 5,
	action = function(pos)
		if sumpf.tree_allowed(pos, 7) then
			spawn_jungletree(pos)
		end
	end
})

--very old mod compatible
--minetest.register_alias("jungletree:leaves", "jungletree:leaves_green")

minetest.log("info", "[jungletree] loaded!")
