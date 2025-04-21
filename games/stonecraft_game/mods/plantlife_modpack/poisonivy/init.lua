-- This file supplies poison ivy for the plantlife modpack

-- support for i18n
local S = minetest.get_translator("poisonivy")

local walls_list = {
	"default:dirt",
	"default:dirt_with_grass",
	"default:stone",
	"default:cobble",
	"default:mossycobble",
	"default:brick",
	"default:tree",
	"default:jungletree",
	"default:stone_with_coal",
	"default:stone_with_iron"
}
minetest.register_node('poisonivy:seedling', {
	description = S("Poison ivy (seedling)"),
	drawtype = 'plantlike',
	waving = 1,
	tiles = { 'poisonivy_seedling.png' },
	inventory_image = 'poisonivy_seedling.png',
	wield_image = 'poisonivy_seedling.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, poisonivy=1, flora_block=1, attached_node=1 },
	sounds = default.node_sound_leaves_defaults(),
	buildable_to = true,
})

minetest.register_node('poisonivy:sproutling', {
	description = S("Poison ivy (sproutling)"),
	drawtype = 'plantlike',
	waving = 1,
	tiles = { 'poisonivy_sproutling.png' },
	inventory_image = 'poisonivy_sproutling.png',
	wield_image = 'poisonivy_sproutling.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, poisonivy=1, flora_block=1, attached_node=1 },
	sounds = default.node_sound_leaves_defaults(),
	buildable_to = true,
})

minetest.register_node('poisonivy:climbing', {
	description = S("Poison ivy (climbing plant)"),
	drawtype = 'signlike',
	tiles = { 'poisonivy_climbing.png' },
	inventory_image = 'poisonivy_climbing.png',
	wield_image = 'poisonivy_climbing.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	walkable = false,
	groups = { snappy = 3, poisonivy=1, flora_block=1, attached_node=1 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "wallmounted",
		--wall_side = = <default>
	},
	buildable_to = true,
})

local function find_adjacent_wall(pos, verticals, randomflag)
	local verts = dump(verticals)

	if string.find(verts, minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z  }).name) then return 3 end
	if string.find(verts, minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z  }).name) then return 2 end
	if string.find(verts, minetest.get_node({x=pos.x  , y=pos.y, z=pos.z-1}).name) then return 5 end
	if string.find(verts, minetest.get_node({x=pos.x  , y=pos.y, z=pos.z+1}).name) then return 4 end

	return nil
end

minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	interval = 1000,
	chance = 20,
	label = "[poisoninvy] spawn plants",
	min_y = -16,
	max_y = 48,
	action = function(pos, node)
		local p_top = {x = pos.x, y = pos.y + 1, z = pos.z}
		local n_top = minetest.get_node_or_nil(p_top)
		if not n_top or n_top.name ~= "air" then return end

		local n_light = minetest.get_node_light(p_top)
		if n_light < 7 then
			return
		end

		if minetest.find_node_near(p_top, 10 + math.random(-1.5,2), {"group:poisonivy", "group:flower"}) then
			return -- Nodes to avoid are nearby
		end

		local walldir = find_adjacent_wall(p_top, walls_list)
		if walldir then
			minetest.swap_node(p_top, {name = "poisonivy:climbing", param2 = walldir})
			return
		end

		minetest.swap_node(p_top, {name = "poisonivy:seedling", param2 = 0})
	end
})

minetest.register_abm({
	nodenames = {"poisonivy:seedling"},
	interval = 1000,
	chance = 30,
	label = "grow poisonivy",
	action = function(pos, node)
		local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
		local n_top = minetest.get_node(p_top)

		if n_top.name == "air" then
			minetest.swap_node(pos, {name = "poisonivy:sproutling"})
		end
	end
})

minetest.register_abm({
	nodenames = {"poisonivy:climbing"},
	interval = 500,
	chance = 60,
	label = "grow climbing poisonivy",
	action = function(pos, node)
		local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
		local n_top = minetest.get_node(p_top)

		local walldir = find_adjacent_wall(p_top, walls_list)
		if n_top.name == "air" and walldir then
			minetest.swap_node(p_top, {name = "poisonivy:climbing", param2 = walldir})
		end
	end
})