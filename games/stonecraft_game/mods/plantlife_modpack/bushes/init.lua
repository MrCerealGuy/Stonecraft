-- Bushes Mod by Mossmanikin, Evergreen, & Neuromancer
-- The initial code for this was taken from Mossmanikin's Grasses Mod,
-- then heavilly modified by Neuromancer for this mod.
-- Mossmanikin also greatly helped with providing samples for coding.
-- bush leaf textures are from VannessaE's moretrees mod.
-- (Leaf texture created by RealBadAngel or VanessaE)
-- Branch textures created by Neuromancer.

-- support for i18n
local S = minetest.get_translator("bushes")

local bush_rarity = minetest.settings:get("bushes.bush_rarity") or 0.008
local youngtree_rarity = minetest.settings:get("youngtree.bush_rarity") or 0.006

minetest.register_node("bushes:youngtree2_bottom", {
	description = S("Young Tree 2 (bottom)"),
	drawtype="nodebox",
	tiles = {"bushes_youngtree2trunk.png"},
	inventory_image = "bushes_youngtree2trunk_inv.png",
	wield_image = "bushes_youngtree2trunk_inv.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0612,-0.500000,-0.500000,0.0612,0.500000,-0.375000}, --NodeBox 1
		}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:stick'
})

local BushBranchCenter = { {1,1}, {3,2} }
for i in pairs(BushBranchCenter) do
	local Num = BushBranchCenter[i][1]
	local TexNum = BushBranchCenter[i][2]
	minetest.register_node("bushes:bushbranches"..Num, {
		description = S("Bush Branches @1", Num),
		drawtype = "nodebox",
		tiles = {
			"bushes_leaves_"..TexNum..".png",
			"bushes_branches_center_"..TexNum..".png"
		},
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = {
				{0, -1/2, -1/2, -1/4, 1/2, 1/2},
				{0, -1/2, -1/2, 1/4, 1/2, 1/2}
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
		},
		inventory_image = "bushes_branches_center_"..TexNum..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = {
		--	tree=1, -- MM: disabled because some recipes use group:tree for trunks
			snappy=3,
			flammable=2,
			leaves=1,
			attached_node=1
		},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'default:stick 4'
	})
end

local BushBranchSide = { {2,1}, {4,2} }
for i in pairs(BushBranchSide) do
	local Num = BushBranchSide[i][1]
	local TexNum = BushBranchSide[i][2]
	minetest.register_node("bushes:bushbranches"..Num, {
		description = S("Bush Branches @1", Num),
		drawtype = "nodebox",
		tiles = {
--[[top]]	"bushes_leaves_"..TexNum..".png",
--[[bottom]]"bushes_branches_center_"..TexNum..".png",
--[[right]]	"bushes_branches_left_"..TexNum..".png",
--[[left]]	"bushes_branches_right_"..TexNum..".png", -- MM: We could also mirror the previous here,
--[[back]]	"bushes_branches_center_"..TexNum..".png",--		 unless U really want 'em 2 B different
--[[front]]	"bushes_branches_right_"..TexNum..".png"
		},
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = {
--				{ left	 , bottom	, front, right	 , top		 , back		}
				{0.137748,-0.491944, 0.5	,-0.125000,-0.179444,-0.007790}, --NodeBox 1
				{0.262748,-0.185995, 0.5	,-0.237252, 0.126505,-0.260269}, --NodeBox 2
				{0.500000, 0.125000, 0.5	,-0.500000, 0.500000,-0.500000}, --NodeBox 3
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
		},
		inventory_image = "bushes_branches_right_"..TexNum..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = {
		--	tree=1, -- MM: disabled because some recipes use group:tree for trunks
			snappy=3,
			flammable=2,
			leaves=1,
			attached_node=1
		},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'default:stick 3'
	})
end

local BushLeafNode = { {1}, {2}}
for i in pairs(BushLeafNode) do
	local Num = BushLeafNode[i][1]
	minetest.register_node("bushes:BushLeaves"..Num, {
		description = S("Bush Leaves @1", Num),
		drawtype = "allfaces_optional",
		tiles = {"bushes_leaves_"..Num..".png"},
		use_texture_alpha = "clip",
		paramtype = "light",
		groups = {	-- MM: Should we add leafdecay?
			snappy=3,
			flammable=2,
			attached_node=1,
			leaves=1
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

local function grow_bush_node(pos, dir, leaf_type)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	local above_right_here = {x=pos.x, y=pos.y+2, z=pos.z}

	local bush_branch_type = 2

	if dir ~= 5 and leaf_type == 1 then
		bush_branch_type = 2
	end
	if dir ~= 5 and leaf_type == 2 then
		bush_branch_type = 4
	end
	if dir == 5 and leaf_type == 1 then
		bush_branch_type = 1
		dir = 1
	end
	if dir == 5 and leaf_type == 2 then
		bush_branch_type = 3
		dir = 1
	end

	local nodename = minetest.get_node(right_here).name
	if nodename == "air" or nodename == "default:junglegrass" then -- instead of check_air = true,
		minetest.swap_node(right_here, {name="bushes:bushbranches"..bush_branch_type , param2=dir})
		minetest.swap_node(above_right_here, {name="bushes:BushLeaves"..leaf_type})

		local chance_of_high_leaves = math.random(1,10)
		if chance_of_high_leaves > 5 then
			local two_above_right_here = {x=pos.x, y=pos.y+3, z=pos.z}
			minetest.swap_node(two_above_right_here, {name="bushes:BushLeaves"..leaf_type})
		end
	end
end

local function grow_bush(pos)
	-- replace possible grass nodes
	minetest.swap_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="air"})

	local leaf_type = math.random(1,2)
	local bush_side_height = math.random(0,1)

	local chance_of_bush_node_right = math.random(1,10)
	if chance_of_bush_node_right > 5 then
		local right_pos = {x=pos.x+1, y=pos.y+bush_side_height, z=pos.z}
		grow_bush_node(right_pos,3,leaf_type)
	end

	local chance_of_bush_node_left = math.random(1,10)
	if chance_of_bush_node_left > 5 then
		local left_pos = {x=pos.x-1, y=pos.y+bush_side_height, z=pos.z}
		grow_bush_node(left_pos,1,leaf_type)
	end

	local chance_of_bush_node_front = math.random(1,10)
	if chance_of_bush_node_front > 5 then
		local front_pos = {x=pos.x, y=pos.y+bush_side_height, z=pos.z+1}
		grow_bush_node(front_pos,2,leaf_type)
	end

	local chance_of_bush_node_back = math.random(1,10)
	if chance_of_bush_node_back > 5 then
		local back_pos = {x=pos.x, y=pos.y+bush_side_height, z=pos.z-1}
		grow_bush_node(back_pos,0,leaf_type)
	end

	grow_bush_node(pos,5,leaf_type)
end

minetest.register_decoration({
	name = "bushes:bush",
	decoration = {
		"air"
	},
	fill_ratio = bush_rarity,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
	deco_type = "simple",
	flags = "all_floors",
})

--[[
	this is purposefully wrapped in a on mods loaded callback to that it gets the proper ids
	if other mods clear the registered decorations
]]
local did
minetest.register_on_mods_loaded(function()
	did = minetest.get_decoration_id("bushes:bush")
	minetest.set_gen_notify("decoration", {did})
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	local g = minetest.get_mapgen_object("gennotify")
	local locations = {}

	local deco_locations = g["decoration#" .. did] or {}
	for _, pos in pairs(deco_locations) do
		locations[#locations+1] = pos
	end

	if #locations == 0 then return end
	for _, pos in ipairs(locations) do
		grow_bush(pos)
	end
end)

local function grow_youngtree_node2(pos, height)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	local above_right_here = {x=pos.x, y=pos.y+2, z=pos.z}
	local two_above_right_here = {x=pos.x, y=pos.y+3, z=pos.z}
	local three_above_right_here = {x=pos.x, y=pos.y+4, z=pos.z}

	local nodename = minetest.get_node(right_here).name
	if nodename == "air" or nodename == "default:junglegrass" then -- instead of check_air = true,
		if height == 4 then
			local two_above_right_here_south = {x=pos.x, y=pos.y+3, z=pos.z-1}
			local three_above_right_here_south = {x=pos.x, y=pos.y+4, z=pos.z-1}

			minetest.swap_node(right_here, {name="bushes:youngtree2_bottom"})
			minetest.swap_node(above_right_here, {name="bushes:youngtree2_bottom"})
			minetest.swap_node(two_above_right_here, {name="bushes:bushbranches2"	, param2=2})
			minetest.swap_node(two_above_right_here_south, {name="bushes:bushbranches2"	, param2=0})
			minetest.swap_node(three_above_right_here, {name="bushes:BushLeaves1" })
			minetest.swap_node(three_above_right_here_south, {name="bushes:BushLeaves1" })
		end
	end
end

local function grow_youngtree2(pos)
	local height = math.random(4,5)
	grow_youngtree_node2(pos,height)
end

minetest.register_decoration({
	name = "bushes:youngtree",
	decoration = {
		"air"
	},
	fill_ratio = youngtree_rarity,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
	deco_type = "simple",
	flags = "all_floors",
})

--[[
	this is purposefully wrapped in a on mods loaded callback to that it gets the proper ids
	if other mods clear the registered decorations
]]
local did2
minetest.register_on_mods_loaded(function()
	did2 = minetest.get_decoration_id("bushes:youngtree")
	minetest.set_gen_notify("decoration", {did2})
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	local g = minetest.get_mapgen_object("gennotify")
	local locations = {}

	local deco_locations = g["decoration#" .. did2] or {}
	for _, pos in pairs(deco_locations) do
		locations[#locations+1] = pos
	end

	if #locations == 0 then return end
	for _, pos in ipairs(locations) do
		grow_youngtree2(pos)
	end
end)