local load_time_start = minetest.get_us_time()


--------------------------------------Settings----------------------------------------------

-- default settings
treecapitator = {
	drop_items = false,
	drop_leaf = false,
	play_sound = true,
	moretrees_support = false,
	delay = 0,
	default_tree = {	--replaces not defined stuff (see below)
		trees = {"default:tree"},
		leaves = {"default:leaves"},
		range = 2,
		fruits = {},
		type = "default",
	},
}

-- load custom settings
for name,v in pairs(treecapitator) do
	local setting = "treecapitator."..name
	--local typ = type(v)
	local neuv
	if type(v) == "boolean" then
		neuv = minetest.setting_getbool(setting)
	else--if typ == "number" then
		neuv = tonumber(minetest.setting_get(setting))
	end
	if neuv ~= nil then
		treecapitator[name] = neuv
	end
end


---------------------------------------------------------------------------------------------


--the table where the trees are stored at
treecapitator.trees = {}

--a table of trunks which couldn't be redefined
treecapitator.rest_tree_nodes = {}


--------------------------------------------fcts----------------------------------------------

local poshash = minetest.hash_node_position

-- don't use minetest.get_node more times for the same position (caching)
local known_nodes
local function clean_cache()
	known_nodes = {}
	setmetatable(known_nodes, {__mode = "kv"})
end
clean_cache()

local function remove_node(pos)
	known_nodes[poshash(pos)] = {name="air", param2=0}
	minetest.remove_node(pos)
end

local function dig_node(pos, node, digger)
	known_nodes[poshash(pos)] = {name="air", param2=0}
	minetest.node_dig(pos, node, digger)
end

local function get_node(pos)
	local vi = poshash(pos)
	local node = known_nodes[vi]
	if node then
		return node
	end
	node = minetest.get_node(pos)
	known_nodes[vi] = node
	return node
end

--definitions of functions for the destruction of nodes
local destroy_node, drop_leaf, remove_leaf
if treecapitator.drop_items then
	function drop_leaf(pos, item, inv)
		minetest.add_item(pos, item)
	end

	function destroy_node(pos, node, digger)
		local drops = minetest.get_node_drops(node.name)
		for _,item in pairs(drops) do
			minetest.add_item(pos, item)
		end
		remove_node(pos)
	end
else
	function drop_leaf(pos, item, inv)
		if inv
		and inv:room_for_item("main", item) then
			inv:add_item("main", item)
		else
			minetest.add_item(pos, item)
		end
	end

	destroy_node = dig_node
end

if not treecapitator.drop_leaf then
	function remove_leaf(p, leaf, inv)
		local leaves_drops = minetest.get_node_drops(leaf)
		for _, itemname in pairs(leaves_drops) do
			if itemname ~= leaf then
				drop_leaf(p, itemname, inv)
			end
		end
		remove_node(p)	--remove the leaves
	end
else
	function remove_leaf(p, _, _, node, digger)
		destroy_node(p, node, digger)
	end
end


table.icontains = table.icontains or function(t, v)
	for i = 1,#t do
		if t[i] == v then
			return true
		end
	end
	return false
end

--tests if the node is a trunk
local function findtree(node)
	if node == 0 then
		return true
	end
	return table.icontains(treecapitator.rest_tree_nodes, node.name)
end

--returns positions for leaves allowed to be dug
local function find_next_trees(pos, range, trees, leaves, fruits)
	local tab = {}
	local r = 2*range
	for i = -r, r do
		for j = -r, r do
			for h = r,-r,-1 do
				local p = {x=pos.x+j, y=pos.y+h, z=pos.z+i}

				-- tests if a trunk is at the current pos
				local nd = get_node(p)
				if table.icontains(trees, nd.name)
				and nd.param2 == 0
				and (pos.x ~= p.x or pos.z ~= p.z) then
					-- search for a leaves or fruit node next to the trunk
					local leaf = get_node({x=p.x, y=p.y+1, z=p.z}).name
					local leaf_found = table.icontains(leaves, leaf) or table.icontains(fruits, leaf)
					if not leaf_found then
						leaf = get_node({x=p.x, y=p.y, z=p.z+1}).name
						leaf_found = table.icontains(leaves, leaf) or table.icontains(fruits, leaf)
					end

					if leaf_found then
						local z1 = math.max(-range+i, -range)
						local z2 = math.min(range+i, range)
						local y1 = math.max(-range+h, -range)
						local y2 = math.min(range+h, range)
						local x1 = math.max(-range+j, -range)
						local x2 = math.min(range+j, range)
						for z = z1,z2 do
							for y = y1,y2 do
								for x = x1,x2 do
									tab[poshash{x=x, y=y, z=z}] = true
								end
							end
						end
					end
				end
			end
		end
	end
	--minetest.chat_send_all(dump(tab))	<— I used these to find my mistake
	local tab2,n = {},1
	for z = -range,range do
		for y = -range,range do
			for x = -range,range do
				local p = {x=x, y=y, z=z}
				if not tab[poshash(p)] then
					tab2[n] = p
					n = n+1
				end
			end
		end
	end
	return tab2, n-1
end

-- table iteration instead of recursion
local function get_tab(pos, func, max)
	local todo = {pos}
	local n = 1
	local tab_avoid = {[poshash(pos)] = true}
	local tab_done,num = {pos},2
	while n ~= 0 do
		local p = todo[n]
		n = n-1
		--[[
		for i = -1,1,2 do
			for _,p2 in pairs{
				{x=p.x+i, y=p.y, z=p.z},
				{x=p.x, y=p.y+i, z=p.z},
				{x=p.x, y=p.y, z=p.z+i},
			} do]]
		for i = -1,1 do
			for j = -1,1 do
				for k = -1,1 do
					local p2 = {x=p.x+i, y=p.y+j, z=p.z+k}
					local vi = poshash(p2)
					if not tab_avoid[vi]
					and func(p2) then
						n = n+1
						todo[n] = p2

						tab_avoid[vi] = true

						tab_done[num] = p2
						num = num+1

						if max
						and num > max then
							return false
						end
					end
				end
			end
		end
	end
	return tab_done
end


-- the functions for the available types
local capitate_funcs = {}

function capitate_funcs.default(pos, tr, node_above, digger)
	local trees = tr.trees

	-- fill tab with the stem trunks
	local tab, n = {{{x=pos.x, y=pos.y+1, z=pos.z}, node_above}}, 2
	local np = {x=pos.x, y=pos.y+2, z=pos.z}
	local nd = get_node(np)
	while table.icontains(trees, nd.name) and nd.param2 == 0 do
		tab[n] = {vector.new(np), nd}
		n = n+1
		np.y = np.y+1
		nd = get_node(np)
	end
	np.y = np.y-1

	local leaves = tr.leaves
	local fruits = tr.fruits

	-- abort if the tree lacks leaves/fruits
	if not table.icontains(leaves, nd.name)
	and not table.icontains(fruits, nd.name) then
		local leaf = get_node{x=np.x, y=np.y, z=np.z+1}.name
		if not table.icontains(leaves, leaf)
		and not table.icontains(fruits, leaf) then
			return
		end
	end

	-- play the sound, then dig the stem
	if treecapitator.play_sound then
		minetest.sound_play("tree_falling", {pos = pos, max_hear_distance = 32})
	end
	for i = 1,n-1 do
		local pos,node = unpack(tab[i])
		destroy_node(pos, node, digger)
	end

	-- remove leaves and fruits
	local range = tr.range
	local inv = digger:get_inventory()
	local head_ps,n = find_next_trees(np, range, trees, leaves, fruits)	--definition of the leavespositions
	for i = 1,n do
		local p = vector.add(np, head_ps[i])
		local node = get_node(p)
		local nodename = node.name
		if not table.icontains(trees, nodename)
		or node.param2 ~= 0 then
			if table.icontains(leaves, nodename) then
				remove_leaf(p, nodename, inv, node, digger)
			elseif table.icontains(fruits, nodename) then
				destroy_node(p, node, digger)
			end
		end
	end
	return true
end

function capitate_funcs.acacia(pos, tr, node_above, digger)
	local trunk = tr.trees[1]

	-- fill tab with the stem trunks
	local tab, n = {{{x=pos.x, y=pos.y+1, z=pos.z}, node_above}}, 2
	local np = {x=pos.x, y=pos.y+2, z=pos.z}
	local nd = get_node(np)
	while trunk == nd.name
	and nd.param2 < 4 do
		tab[n] = {vector.new(np), nd}
		n = n+1
		np.y = np.y+1
		nd = get_node(np)
	end
	np.y = np.y-1

	local siden = 1
	local sidedata = {}
	for z = -1,1,2 do
		for x = -1,1,2 do
			-- add the other trunks to tab
			local p = vector.new(np)
			p.x = p.x+x
			p.z = p.z+z
			local nd = get_node(p)
			if nd.name ~= trunk then
				p.y = p.y+1
				nd = get_node(p)
				if nd.name ~= trunk then
					return
				end
			end
			tab[n] = {vector.new(p), nd}

			p.x = p.x+x
			p.z = p.z+z
			p.y = p.y+1

			if get_node(p).name ~= trunk then
				return
			end
			tab[n+1] = {vector.new(p), nd}
			n = n+2

			-- get neighbouring acacia trunks for delimiting
			local no_rms = {}
			for z = -4,4 do
				for x = -4,4 do
					if math.abs(x+z) ~= 8
					and (x ~= 0 or z ~= 0) then
						if get_node{x=p.x+x, y=p.y, z=p.z+z}.name == trunk
						and get_node{x=p.x+x, y=p.y+1, z=p.z+z}.name == tr.leaf then
							for z = math.max(-4, z-2), math.min(4, z+2) do
								for x = math.max(-4, x-2), math.min(4, x+2) do
									no_rms[(z+4)*9 + x+4] = true
								end
							end
						end
					end
				end
			end

			-- remove leaves
			local inv = digger:get_inventory()
			p.y = p.y+1
			local i = 0
			for z = -4,4 do
				for x = -4,4 do
					if not no_rms[i] then
						local p = {x=p.x+x, y=p.y, z=p.z+z}
						local node = get_node(p)
						if node.name == tr.leaf then
							remove_leaf(p, tr.leaf, inv, node, digger)
						end
					end
					i = i+1
				end
			end
		end
	end

	-- play the sound, then dig the stem
	if treecapitator.play_sound then
		minetest.sound_play("tree_falling", {pos = pos, max_hear_distance = 32})
	end
	for i = 1,n-1 do
		local pos,node = unpack(tab[i])
		destroy_node(pos, node, digger)
	end
	return true
end

function capitate_funcs.moretrees(pos, tr, _, digger)
	local trees = tr.trees
	local leaves = tr.leaves
	local fruits = tr.fruits
	local minx = pos.x-tr.range
	local maxx = pos.x+tr.range
	local minz = pos.z-tr.range
	local maxz = pos.z+tr.range
	local maxy = pos.z+tr.height
	local num_trunks = 0
	local num_leaves = 0
	local ps = get_tab({x=pos.x, y=pos.y+1, z=pos.z}, function(pos)
		if pos.x < minx
		or pos.x > maxx
		or pos.z < minz
		or pos.z > maxz
		or pos.y > maxy then
			return false
		end
		local nam = get_node(pos).name
		if table.icontains(trees, nam) then
			num_trunks = num_trunks+1
		elseif table.icontains(leaves, nam) then
			num_leaves = num_leaves+1
		elseif not table.icontains(fruits, nam) then
			return false
		end
		return true
	end, tr.max_nodes)
	if not ps then
		print"no ps found"
		return
	end
	if num_trunks < tr.num_trunks_min
	or num_trunks > tr.num_trunks_max then
		print("wrong trunks num: "..num_trunks)
		return
	end
	if num_leaves < tr.num_leaves_min
	or num_leaves > tr.num_leaves_max then
		print("wrong leaves num: "..num_leaves)
		return
	end
	if treecapitator.play_sound then
		minetest.sound_play("tree_falling", {pos = pos, max_hear_distance = 32})
	end
	local inv = digger:get_inventory()
	for _,p in pairs(ps) do
		local node = get_node(p)
		local nodename = node.name
		if table.icontains(leaves, nodename) then
			remove_leaf(p, nodename, inv, node, digger)
		else
			destroy_node(p, node, digger)
		end
	end
	return true
end


--the function which is used for capitating
local capitating = false	--necessary if minetest.node_dig is used
local function capitate_tree(pos, node, digger)
	if capitating
	or not digger
	or digger:get_player_control().sneak
	or not findtree(node) then
		return
	end
	local t1 = minetest.get_us_time()
	capitating = true
	local node_above = get_node{x=pos.x, y=pos.y+1, z=pos.z}
	for i = 1,#treecapitator.trees do
		local tr = treecapitator.trees[i]
		if table.icontains(tr.trees, node_above.name)
		and node_above.param2 < 4
		and capitate_funcs[tr.type](pos, tr, node_above, digger) then
			break
		end
	end
	clean_cache()
	capitating = false
	minetest.log("info", "[treecapitator] tree capitated at ("..pos.x.."|"..pos.y.."|"..pos.z..") after ca. " .. (minetest.get_us_time() - t1) / 1000000 .. " s")
end

local delay = treecapitator.delay
if delay > 0 then
	local oldfunc = capitate_tree
	function capitate_tree(...)
		minetest.after(delay, function(...)
			oldfunc(...)
		end, ...)
	end
end

--adds trunks to rest_tree_nodes if they were overwritten by other mods
local tmp_trees = {}
local function test_overwritten(tree)
	tmp_trees[#tmp_trees+1] = tree
end

minetest.after(0, function()
	for _,tree in pairs(tmp_trees) do
		if not minetest.registered_nodes[tree].after_dig_node then
			minetest.log("error", "[treecapitator] Error: Overwriting "..tree.." went wrong.")
			treecapitator.rest_tree_nodes[#treecapitator.rest_tree_nodes+1] = tree
		end
	end
	tmp_trees = nil
end)

-- the function to overide trunks
local override
if minetest.override_item then
	function override(name)
		minetest.override_item(name, {
			after_dig_node = function(pos, _, _, digger)
				capitate_tree(pos, 0, digger)
			end
		})
	end
else
	minetest.log("deprecated", "minetest.override_item isn't supported")
	table.copy = table.copy or function(tab)
		local tab2 = {}
		for n,i in pairs(tab) do
			tab2[n] = i
		end
		return tab2
	end
	function override(name, data)
		data = table.copy(data)
		data.after_dig_node = function(pos, _, _, digger)
			capitate_tree(pos, 0, digger)
		end
		minetest.register_node(":"..name, data)
	end
end

--the function to register trees to become capitated
local num = 1
function treecapitator.register_tree(tab)
	for name,value in pairs(treecapitator.default_tree) do
		tab[name] = tab[name] or value	--replaces not defined stuff
	end
	treecapitator.trees[num] = tab
	num = num+1

	for _,tree in pairs(tab.trees) do
		local data = minetest.registered_nodes[tree]
		if not data then
			minetest.log("info", "[treecapitator] Info: "..tree.." isn't registered yet.")
			treecapitator.rest_tree_nodes[#treecapitator.rest_tree_nodes+1] = tree
		else
			if data.after_dig_node then
				minetest.log("info", "[treecapitator] Info: "..tree.." already has an after_dig_node.")
				treecapitator.rest_tree_nodes[#treecapitator.rest_tree_nodes+1] = tree
			else
				override(tree, data)
				test_overwritten(tree)
			end
		end
	end
end

dofile(minetest.get_modpath"treecapitator".."/trees.lua")

---------------------------------------------------------------------------------------------


--use register_on_dignode if trunks are left
if treecapitator.rest_tree_nodes[1] then
	minetest.register_on_dignode(capitate_tree)
end


local time = (minetest.get_us_time() - load_time_start) / 1000000
local msg = "[treecapitator] loaded after ca. " .. time .. " seconds."
if time > 0.01 then
	print(msg)
else
	minetest.log("info", msg)
end
