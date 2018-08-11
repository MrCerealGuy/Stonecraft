
--[[

2017-05-14 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Raw Fish (Thanks to Altairas for her Fish image on DeviantArt)
minetest.register_craftitem("ethereal:fish_raw", {
	description = S("Raw Fish"),
	inventory_image = "fish_raw.png",
	wield_image = "fish_raw.png",
	groups = {food_fish_raw = 1, flammable = 3},
	on_use = minetest.item_eat(2),
})

-- Cooked Fish
minetest.register_craftitem("ethereal:fish_cooked", {
	description = S("Cooked Fish"),
	inventory_image = "fish_cooked.png",
	wield_image = "fish_cooked.png",
	groups = {food_fish = 1, flammable = 3},
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "cooking",
	output = "ethereal:fish_cooked",
	recipe = "ethereal:fish_raw",
	cooktime = 2,
})

-- Sashimi (Thanks to Natalia Grosner for letting me use the sashimi image)
minetest.register_craftitem("ethereal:sashimi", {
	description = S("Sashimi"),
	inventory_image = "sashimi.png",
	wield_image = "sashimi.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	output = "ethereal:sashimi 2",
	recipe = {
		{'group:food_seaweed','group:food_fish_raw','group:food_seaweed'},
	}
})

-- Worm
minetest.register_craftitem("ethereal:worm", {
	description = S("Worm"),
	inventory_image = "worm.png",
	wield_image = "worm.png",
})

-- Fishing Rod
minetest.register_craftitem("ethereal:fishing_rod", {
	description = S("Fishing Rod"),
	inventory_image = "fishing_rod.png",
	wield_image = "fishing_rod.png",
})

minetest.register_craft({
	output = "ethereal:fishing_rod",
	recipe = {
			{"","","default:stick"},
			{"", "default:stick", "farming:string"},
			{"default:stick", "", "farming:string"},
		}
})

-- Sift through 2 Dirt Blocks to find Worm
minetest.register_craft({
	output = "ethereal:worm",
	recipe = {
		{"default:dirt","default:dirt"},
	}
})

-- default ethereal fish
ethereal.fish = {
	{"ethereal:fish_raw"},
}

-- xanadu server additional fish
if minetest.get_modpath("xanadu") then
	ethereal.fish[2] = {"mobs:clownfish_raw"}
	ethereal.fish[3] = {"mobs:bluefish_raw"}
end

-- Fishing Rod (Baited)
minetest.register_craftitem("ethereal:fishing_rod_baited", {
	description = S("Baited Fishing Rod"),
	inventory_image = "fishing_rod_baited.png",
	wield_image = "fishing_rod_wield.png",
	stack_max = 1,
	liquids_pointable = true,

	on_use = function (itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end
		
		local node = minetest.get_node(pointed_thing.under).name

		if (node == "default:water_source"
		or node == "default:river_water_source")
		and math.random(1, 100) < 5 then

			local type = ethereal.fish[math.random(1, #ethereal.fish)][1]
			local inv = user:get_inventory()

			if inv:room_for_item("main", {name = type}) then

				inv:add_item("main", {name = type})

				return ItemStack("ethereal:fishing_rod")
			else
				minetest.chat_send_player(user:get_player_name(),
					S("Inventory full, Fish Got Away!"))
			end
		end
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = "ethereal:fishing_rod_baited",
	recipe = {"ethereal:fishing_rod", "ethereal:worm"},
})
