-- support for i18n
local S = minetest.get_translator("youngtrees")

local youngtree_rarity = minetest.settings:get("youngtrees.youngtree_rarity") or 0.0005

minetest.register_node("youngtrees:bamboo", {
	description = S("Young Bamboo Tree"),
	drawtype="nodebox",
	tiles = {"bamboo.png"},
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	node_box = {
	type = "fixed",
	fixed = {
		{-0.058251,-0.500000,-0.413681,0.066749,0.500000,-0.282500}, --NodeBox 1
		{-0.058251,-0.500000,-0.103123,0.066749,0.500000,0.038672}, --NodeBox 2
		{-0.058251,-0.500000,0.181227,0.066749,0.500000,0.342500}, --NodeBox 3
		}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})


minetest.register_alias("youngtrees:youngtree2_middle", "default:bush_stem")

minetest.register_node("youngtrees:youngtree_top", {
	description = S("Young Tree (top)"),
	drawtype = "plantlike",
	tiles = {"youngtree16xa.png"},
	inventory_image = "youngtree16xa.png",
	wield_image = "youngtree16xa.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_node("youngtrees:youngtree_middle", {
	description = S("Young Tree (middle)"),
	drawtype = "plantlike",
	tiles = {"youngtree16xb.png"},
	inventory_image = "youngtree16xb.png",
	wield_image = "youngtree16xb.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_node("youngtrees:youngtree_bottom", {
	description = S("Young Tree (bottom)"),
	drawtype = "plantlike",
	tiles = {"youngtree16xc.png"},
	inventory_image = "youngtree16xc.png",
	wield_image = "youngtree16xc.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	on_timer = function(pos, elapsed)
		local function validateNode(node)
			if not minetest.registered_nodes[node.name] or minetest.registered_nodes[node.name].drawtype ~= "airlike" then
				return false
			end
			return true
		end

		local onePos, twoPos = vector.new(pos.x, pos.y+1, pos.z), vector.new(pos.x, pos.y+2, pos.z)
		local oneAbove, twoAbove = minetest.get_node_or_nil(onePos), minetest.get_node_or_nil(twoPos)
        if not oneAbove or not twoAbove or not validateNode(oneAbove) or not validateNode(twoAbove) then
			minetest.swap_node(pos, {name="air"})
            return
		end

		if math.random() > 0.5 then
			minetest.set_node(onePos, {name="youngtrees:youngtree_top"})
		else
			minetest.set_node(onePos, {name="youngtrees:youngtree_middle"})
			minetest.set_node(twoPos, {name="youngtrees:youngtree_top"})
		end
	end,
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_decoration({
	name = "youngtrees:youngtree",
	decoration = {
		"youngtrees:youngtree_bottom"
	},
	fill_ratio = youngtree_rarity,
	y_min = 1,
	y_max = 40,
	param2 = 0,
	param2_max = 3,
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
	did = minetest.get_decoration_id("youngtrees:youngtree")
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
        local timer = minetest.get_node_timer({x=pos.x, y=pos.y+1, z=pos.z})
        timer:start(0)
    end
end)
