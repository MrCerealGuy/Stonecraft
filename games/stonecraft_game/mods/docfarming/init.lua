dofile(minetest.get_modpath("docfarming").."/corn.lua")
dofile(minetest.get_modpath("docfarming").."/potato.lua")
dofile(minetest.get_modpath("docfarming").."/carrot.lua")
dofile(minetest.get_modpath("docfarming").."/raspberry.lua")
dofile(minetest.get_modpath("docfarming").."/cucumber.lua")

minetest.register_node("docfarming:plowed", {
	description = "You hacker you!",
	tile_images = {'dirt.png^plowed.png', 'dirt.png', 	'dirt.png'},
     is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	drop = "default:dirt",
})

minetest.register_node("docfarming:grass", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"grass.png"},
	drop = {
		max_items = 1,
		items = {
			{ items = {'docfarming:cornseed'}, rarity = 100},
			{ items = {'docfarming:raspberryseed'}, rarity = 120},
			{ items = {'docfarming:carrotseed'}, rarity = 120},
			{ items = {'docfarming:potatoseed'}, rarity = 140},
			{ items = {'docfarming:cucumberseed'}, rarity = 120},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_on_generated(function(minp, maxp, seed)
		-- Generate grass
		local perlin1 = minetest.env:get_perlin(329, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0,divs-1 do
		for divz=0,divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine cactus amount from perlin noise
			local amount = 1
			-- Find random positions for grass based on this random
			local pr = PseudoRandom(seed+1)
			for i=0,amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=30,0,-1 do
					if minetest.env:get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end
				-- If desert sand, make cactus
				if ground_y and minetest.env:get_node({x=x,y=ground_y,z=z}).name == "default:dirt_with_grass" then
					minetest.env:set_node({x=x,y=ground_y+1,z=z}, {name="docfarming:grass"})
				end
			end
		end
	end
end
)
local function create_soil(pos, inv, p)
	if pos == nil then
		return false
	end
	local node = minetest.env:get_node(pos)
	local name = node.name
	local above = minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if name == "default:dirt" or name == "default:dirt_with_grass" then
		if above.name == "air" then
			node.name = "docfarming:plowed"
			minetest.env:set_node(pos, node)
			return true
		end
	end
	return false
end

minetest.register_tool("docfarming:hoe_wood", {
	description = "Wood Hoe",
	inventory_image = "farming_hoe_wood.png",
	on_use = function(itemstack, user, pointed_thing)
		if create_soil(pointed_thing.under, user:get_inventory(), 0) then
			itemstack:add_wear(65535/30)
			return itemstack
		end
	end
})

minetest.register_craft({
	output = "docfarming:hoe_wood",
	recipe = {
		{"", "default:wood", "default:wood"},
		{"", "default:stick", ""},
		{"", "default:stick", ""}
	}
})

minetest.register_tool("docfarming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_hoe_stone.png",
	on_use = function(itemstack, user, pointed_thing)
		if create_soil(pointed_thing.under, user:get_inventory(), 5) then
			itemstack:add_wear(65535/50)
			return itemstack
		end
	end
})

minetest.register_craft({
	output = "docfarming:hoe_stone",
	recipe = {
		{"", "default:cobble", "default:cobble"},
		{"", "default:stick", ""},
		{"", "default:stick", ""}
	}
})

minetest.register_tool("docfarming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_hoe_steel.png",
	on_use = function(itemstack, user, pointed_thing)
		if create_soil(pointed_thing.under, user:get_inventory(), 10) then
			itemstack:add_wear(65535/80)
			return itemstack
		end
	end
})

minetest.register_craft({
	output = "docfarming:hoe_steel",
	recipe = {
		{"", "default:steel_ingot", "default:steel_ingot"},
		{"", "default:stick", ""},
		{"", "default:stick", ""}
	}
})

