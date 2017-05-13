-- Desert Uses (desert_uses) mod by Menche
-- Makes deserts more useful
-- License: LGPL

--[[

2017-05-13 added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Node definitions --------------------
-- Desert Cobble
minetest.register_node("desert_uses:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"desert_uses_desert_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

-- Make desert stone drop desert cobble
minetest.register_node(":default:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"default_desert_stone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = "desert_uses:desert_cobble",
	sounds = default.node_sound_stone_defaults(),
})

-- Desert Sandstone
minetest.register_node("desert_uses:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"desert_uses_desert_sandstone.png"},
	is_ground_content = true,
	groups = {crumbly=2, cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

-- Stairs -----------------------------
-- Desert Cobble
stairs.register_stair_and_slab("desert_cobble", "desert_uses:desert_cobble",
	{cracky=3},
	{"desert_uses_desert_cobble.png"},
	S("Desert Cobble stair"),
	S("Desert Cobble slab"))

-- Desert Stone
stairs.register_stair_and_slab("desert_stone", "default:desert_stone",
	{cracky=3},
	{"default_desert_stone.png"},
	S("Desert Stone stair"),
	S("Desert Stone slab"))

-- Desert Sandstone
stairs.register_stair_and_slab("desert_sandstone", "desert_uses:desert_sandstone",
	{cracky=2, crumbly=2},
	{"desert_uses_desert_sandstone.png"},
	S("Desert Sandstone stair"),
	S("Desert Sandstone slab"))

-- Tool definitions -------------------
-- Desert stone pickaxe
minetest.register_tool("desert_uses:pick_desert_stone", {
	description = S("Desert Stone Pickaxe"),
	inventory_image = "desert_uses_tool_desert_stonepick.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			cracky={times={[1]=3.00, [2]=1.20, [3]=0.80}, uses=20, maxlevel=1}
		}
	},
})

-- Desert stone shovel
minetest.register_tool("desert_uses:shovel_desert_stone", {
	description = S("Desert Stone Shovel"),
	inventory_image = "desert_uses_tool_desert_stoneshovel.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[1]=1.50, [2]=0.50, [3]=0.30}, uses=20, maxlevel=1}
		}
	},
})

-- Desert stone axe
minetest.register_tool("desert_uses:axe_desert_stone", {
	description = S("Desert Stone Axe"),
	inventory_image = "desert_uses_tool_desert_stoneaxe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.00, [3]=0.60}, uses=20, maxlevel=1},
			fleshy={times={[2]=1.30, [3]=0.70}, uses=20, maxlevel=1},
		}
	}
})

-- Desert stone sword
minetest.register_tool("desert_uses:sword_desert_stone", {
	description = S("Desert Stone Sword"),
	inventory_image = "desert_uses_tool_desert_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			fleshy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
			choppy={times={[3]=0.90}, uses=20, maxlevel=0}
		}
	}
})

-- Craft definitions -------------------
-- Desert sandstone
minetest.register_craft({
	output = "desert_uses:desert_sandstone",
	recipe = {
		{"default:desert_sand", "default:desert_sand"},
		{"default:desert_sand", "default:desert_sand"},
	},
})

minetest.register_craft({
	output = "default:desert_sand 4",
	recipe = {
		{"desert_uses:desert_sandstone"},
	}
})

-- Desert stone pickaxe
minetest.register_craft({
	output = "desert_uses:pick_desert_stone",
	recipe = {
		{"desert_uses:desert_cobble", "desert_uses:desert_cobble", "desert_uses:desert_cobble"},
		{"", "default:stick", ""},
		{"", "default:stick", ""},
	}
})

-- Desert stone shovel
minetest.register_craft({
	output = "desert_uses:shovel_desert_stone",
	recipe = {
		{"desert_uses:desert_cobble"},
		{"default:stick"},
		{"default:stick"},
	}
})

-- Desert stone axe
minetest.register_craft({
	output = "desert_uses:axe_desert_stone",
	recipe = {
		{"desert_uses:desert_cobble", "desert_uses:desert_cobble"},
		{"desert_uses:desert_cobble", "default:stick"},
		{"", "default:stick"},
	}
})

-- Desert stone axe (flipped recipe)
minetest.register_craft({
	output = "desert_uses:axe_desert_stone",
	recipe = {
		{"desert_uses:desert_cobble", "desert_uses:desert_cobble"},
		{"default:stick", "desert_uses:desert_cobble"},
		{"default:stick", ""},
	}
})

-- Desert stone sword
minetest.register_craft({
	output = "desert_uses:sword_desert_stone",
	recipe = {
		{"desert_uses:desert_cobble"},
		{"desert_uses:desert_cobble"},
		{"default:stick"},
	}
})

-- Stick from dry shrub
minetest.register_craft({
	output = "default:stick 4",
	recipe = {
		{"default:dry_shrub"},
	}
})

-- Desert Cobble -> Desert Stone
minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "desert_uses:desert_cobble",
})

-- Furnace
minetest.register_craft({
	output = "desert_uses:desert_furnace",
	recipe = {
		{"desert_uses:desert_cobble", "desert_uses:desert_cobble", "desert_uses:desert_cobble"},
		{"desert_uses:desert_cobble", "", "desert_uses:desert_cobble"},
		{"desert_uses:desert_cobble", "desert_uses:desert_cobble", "desert_uses:desert_cobble"},
	}
})


minetest.register_node("desert_uses:desert_furnace", {
	description = S("Desert Furnace"),
	tiles = {"desert_uses_furnace_top.png", "desert_uses_furnace_bottom.png", "desert_uses_furnace_side.png",
		"desert_uses_furnace_side.png", "desert_uses_furnace_side.png", "desert_uses_furnace_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", S("Desert Furnace"))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

minetest.register_node("desert_uses:desert_furnace_active", {
	description = S("Desert Furnace"),
	tiles = {"desert_uses_furnace_top.png", "desert_uses_furnace_bottom.png", "desert_uses_furnace_side.png",
		"desert_uses_furnace_side.png", "desert_uses_furnace_side.png", "desert_uses_furnace_front_active.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "desert_uses:desert_furnace",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", S("Desert Furnace"));
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

function hacky_swap_node(pos,name)
	local node = minetest.env:get_node(pos)
	local meta = minetest.env:get_meta(pos)
	local meta0 = meta:to_table()
	if node.name == name then
		return
	end
	node.name = name
	local meta0 = meta:to_table()
	minetest.env:set_node(pos,node)
	meta = minetest.env:get_meta(pos)
	meta:from_table(meta0)
end

minetest.register_abm({
	nodenames = {"desert_uses:desert_furnace","desert_uses:desert_furnace_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print(S("Could not insert '@1'", cooked.item:to_string()))
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext",S("Furnace active: @1%", percent))
			hacky_swap_node(pos,"desert_uses:desert_furnace_active")
			meta:set_string("formspec",
				"size[8,9]"..
				"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
						(100-percent)..":default_furnace_fire_fg.png]"..
				"list[current_name;fuel;2,3;1,1;]"..
				"list[current_name;src;2,1;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]")
			return
		end

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext",S("Furnace out of fuel"))
			hacky_swap_node(pos,"desert_uses:desert_furnace")
			meta:set_string("formspec", default.furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext",S("Furnace is empty"))
				hacky_swap_node(pos,"desert_uses:desert_furnace")
				meta:set_string("formspec", default.furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})

print(S("desert_uses 4 loaded."))

