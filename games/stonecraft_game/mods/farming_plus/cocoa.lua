-- main `S` code in init.lua
local S
S = farming.S

minetest.register_node("farming_plus:cocoa_sapling", {
	description = S("Cocoa Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"farming_cocoa_sapling.png"},
	inventory_image = "farming_cocoa_sapling.png",
	wield_image = "farming_cocoa_sapling.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("farming_plus:cocoa_leaves", {
	drawtype = "allfaces_optional",
	tiles = {"farming_banana_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, not_in_creative_inventory=1},
 	drop = {
		max_items = 1,
		items = {
			{
				items = {'farming_plus:cocoa_sapling'},
				rarity = 20,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming_plus:cocoa_sapling"},
	interval = 60,
	chance = 20,
	action = function(pos, node)
		farming.generate_tree(pos, "default:tree", "farming_plus:cocoa_leaves", {"default:sand", "default:desert_sand"}, {["farming_plus:cocoa"]=20})
	end
})

minetest.register_on_generated(function(minp, maxp, blockseed)
	if math.random(1, 100) > 5 then
		return
	end
	local tmp = {x=(maxp.x-minp.x)/2+minp.x, y=(maxp.y-minp.y)/2+minp.y, z=(maxp.z-minp.z)/2+minp.z}
	local pos = minetest.find_node_near(tmp, maxp.x-minp.x, {"default:desert_sand"})
	if pos ~= nil then
		farming.generate_tree({x=pos.x, y=pos.y+1, z=pos.z}, "default:tree", "farming_plus:cocoa_leaves", {"default:sand", "default:desert_sand"}, {["farming_plus:cocoa"]=20})
	end
end)

minetest.register_node("farming_plus:cocoa", {
	description = S("Cocoa"),
	tiles = {"farming_cocoa.png"},
	visual_scale = 0.5,
	inventory_image = "farming_cocoa.png",
	wield_image = "farming_cocoa.png",
	drawtype = "torchlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_craftitem("farming_plus:cocoa_bean", {
	description = "Cocoa Bean",
	inventory_image = "farming_cocoa_bean.png",
})

minetest.register_craft({
	output = "farming_plus:cocoa_bean 10",
	type = "shapeless",
	recipe = {"farming_plus:cocoa"},
})
