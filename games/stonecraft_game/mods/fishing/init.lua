--todo: item wear, automatic re-baiting option, different types of fish/sushi, add sound

local FISH_CHANCE = 15
local WORM_CHANCE = 30

minetest.register_craftitem("fishing:fish_raw", {
	description = "Raw Fish",
    groups = {},
    inventory_image = "fishing_fish.png",
	 on_use = minetest.item_eat(2),
})

minetest.register_craftitem("fishing:fish", {
	description = "Cooked Fish",
    groups = {},
    inventory_image = "fishing_fish_cooked.png",
	 on_use = minetest.item_eat(4),
})

minetest.register_craftitem("fishing:sushi", {
	description = "Sushi (Hoso Maki)",
    groups = {},
    inventory_image = "fishing_sushi.png",
	 on_use = minetest.item_eat(8),
})

minetest.register_craftitem("fishing:bait_worm", {
	description = "Worms",
    groups = { fishing_bait=1 },
    inventory_image = "fishing_worm.png",
--    wield_image = "fishing_worm_wield.png",
})


minetest.register_craftitem("fishing:pole", {
	description = "Fishing Pole",
    groups = {},
    inventory_image = "fishing_pole.png",
--    wield_image = "", [MAYBE REVERSE IMAGE]
--    wield_scale = {x=1,y=1,z=1},
    stack_max = 1,
    liquids_pointable = true,
})

minetest.register_craftitem("fishing:pole_baited", {
	description = "Baited Fishing Pole",
	groups = {},
	inventory_image = "fishing_pole_baited.png",
--    wield_image = "",
--    wield_scale = {x=1,y=1,z=1},
	stack_max = 1,
	liquids_pointable = true,
	on_use = function (itemstack, user, pointed_thing)
		if pointed_thing and pointed_thing.under then
			local node = minetest.env:get_node(pointed_thing.under)
			if string.find(node.name, "default:water") then
				if math.random(1, 100) < FISH_CHANCE then
					local inv = user:get_inventory()
					if inv:room_for_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""}) then
						inv:add_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""})
					end
				end
				return {name="fishing:pole", count=1, wear=0, metadata=""}
			end
		end
		return nil
	end,
--     ^  default: nil
--     ^ Function must return either nil if no item shall be removed from
--       inventory, or an itemstack to replace the original itemstack.
--         eg. itemstack:take_item(); return itemstack
--     ^ Otherwise, the function is free to do what it wants.
--     ^ The default functions handle regular use cases.
})


--Crafts:
if minetest.get_modpath("ropes") ~= nil then
	minetest.register_craft({
		type = "shapeless",
		output = "fishing:pole",
		recipe = {"default:stick","default:stick","ropes:rope"},
	})
end

if minetest.get_modpath("moreblocks") ~= nil then
minetest.register_craft({
		type = "shapeless",
		output = "fishing:pole",
		recipe = {"default:stick","default:stick","moreblocks:rope"},
	})
end

if minetest.get_modpath("farming") ~= nil then
	minetest.register_craft({
		type = "shapeless",
		output = "fishing:pole",
		recipe = {"default:stick","default:stick","farming:string","farming:string"},
	})
end

minetest.register_craft({
	type = "cooking",
	output = "fishing:fish",
	recipe = "fishing:fish_raw",
	cooktime = 2,
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:sushi",
	recipe = {"fishing:fish_raw","flowers:flower_seaweed"},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:pole_baited",
	recipe = {"fishing:pole", "group:fishing_bait"},
})

--get worms from digging in dirt:
minetest.register_node(":default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	--sounds = default.node_sound_dirt_defaults(),
 	after_dig_node = function (pos, oldnode, oldmetadata, digger)
 		if math.random(1, 100) < WORM_CHANCE then
			local tool_in_use = digger:get_wielded_item():get_name()
			if tool_in_use == "" or tool_in_use == "default:dirt" then
				local inv = digger:get_inventory()
 				if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
 					inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
 				end
 			end
 		end
 	end,
})