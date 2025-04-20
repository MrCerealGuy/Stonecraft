--grab schematics
local fortress = minetest.get_modpath("caverealms").."/schems/DMFort.mts"
local fountain = minetest.get_modpath("caverealms").."/schems/DMFountain.mts"

local DM_TOP = caverealms.config.dm_top -- -4000 --level at which Dungeon Master Realms start to appear

--place Dungeon Master Statue fountains
minetest.register_abm({
	nodenames = {"caverealms:s_fountain"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if pos.y > DM_TOP then
			minetest.remove_node(pos)
			return
		end
		minetest.place_schematic(pos, fountain, "random", {}, true)
	end,
})

--place Dungeon Master Fortresses
minetest.register_abm({
	nodenames = {"caverealms:s_fortress"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if pos.y > DM_TOP then
			minetest.remove_node(pos)
			return
		end
		npos = {x=pos.x,y=pos.y-7,z=pos.z}
		minetest.place_schematic(npos, fortress, "random", {}, true)
	end,
})

local MIN_ITEMS = caverealms.config.min_items--2 --minimum number of items to put in chests - do not set to greater than MAX_ITEMS
local MAX_ITEMS = caverealms.config.max_items--5 --maximum number of items to put in chests - do not set to less than MIN_ITEMS

--table of itemstrings
local ITEMS = {
	"default:diamond",
	"default:obsidian 33",
	"default:mese",
	"default:pick_diamond",
	"default:stonebrick 50",
	"default:sandstone 75",
	"default:torch 99",
	"default:water_source 4",
}

--spawn and fill chests
minetest.register_abm({
	nodenames = {"caverealms:s_chest"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		oldparam = minetest.get_node(pos).param2
		minetest.set_node(pos, {name="default:chest", param2=oldparam})
		minetest.after(1.0, function()
			local inv = minetest.get_inventory({type="node", pos=pos})
			local item_num = math.random(MIN_ITEMS, MAX_ITEMS)
			for i = 1, item_num do
				item_i = math.random(8) --if you add or subtract items from ITEMS, be sure to change this value to reflect it
				inv:add_item("main", ITEMS[item_i])
			end
		end)
	end,
})