-- support for i18n
local S = minetest.get_translator("dryplants")

abstract_dryplants = {}

dofile(minetest.get_modpath("dryplants").."/crafting.lua")
dofile(minetest.get_modpath("dryplants").."/reed.lua")

dofile(minetest.get_modpath("dryplants").."/reedmace.lua")
dofile(minetest.get_modpath("dryplants").."/juncus.lua")
dofile(minetest.get_modpath("dryplants").."/moregrass.lua")

--dofile(minetest.get_modpath("dryplants").."/meadowvariation.lua")

-----------------------------------------------------------------------------------------------
-- Sickle
-----------------------------------------------------------------------------------------------
local function sickle_can_break(pos, deff, player)
	local def = ItemStack({name=deff.name}):get_definition()

	if not def.diggable or (def.can_dig and not def.can_dig(pos,player)) then
		minetest.log("info", player:get_player_name() .. " tried to sickle "
		.. def.name .. " which is not diggable "
		.. minetest.pos_to_string(pos))
		return
	end

	if minetest.is_protected(pos, player:get_player_name()) then
		minetest.log("action", player:get_player_name()
			.. " tried to sickle " .. def.name
			.. " at protected position "
			.. minetest.pos_to_string(pos))
		minetest.record_protection_violation(pos, player:get_player_name())
		return
	end

	return true
end
-- turns nodes with group flora=1 & flower=0 into cut grass
local function sickle_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end

	local under = minetest.get_node(pt.under)
	local above_pos = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(above_pos)

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end

	if not sickle_can_break(pt.under, under, user) then
		return
	end
	-- check if something that can be cut using fine tools
	if minetest.get_item_group(under.name, "snappy") > 0 then
		-- check if flora but no flower
		if minetest.get_item_group(under.name, "flora") == 1 and minetest.get_item_group(under.name, "flower") == 0 then
			-- turn the node into cut grass, wear out item and play sound
			minetest.swap_node(pt.under, {name="dryplants:grass"})
		else -- otherwise dig the node
			if not minetest.node_dig(pt.under, under, user) then
				return
			end
		end
		minetest.sound_play("default_dig_crumbly", {
			pos = pt.under,
			gain = 0.5,
		})
		itemstack:add_wear(65535/(uses-1))
		return itemstack
	elseif string.find(under.name, "default:dirt_with_grass") then
		if minetest.is_protected(above_pos, user:get_player_name()) or above.name ~= "air" then
			return
		end
		minetest.swap_node(pt.under, {name="dryplants:grass_short"})
		minetest.swap_node(above_pos, {name="dryplants:grass"})
		minetest.sound_play("default_dig_crumbly", {
			pos = pt.under,
			gain = 0.5,
		})
		itemstack:add_wear(65535/(uses-1))
		return itemstack
	end
end
-- the tool
minetest.register_tool("dryplants:sickle", {
	description = S("Sickle"),
	inventory_image = "dryplants_sickle.png",
	on_use = function(itemstack, user, pointed_thing)
		return sickle_on_use(itemstack, user, pointed_thing, 220)
	end,
})

-----------------------------------------------------------------------------------------------
-- Cut Grass
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:grass", {
	description = S("Cut Grass"),
	inventory_image = "dryplants_grass.png",
	wield_image = "dryplants_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"dryplants_grass.png"},
	use_texture_alpha = "clip",
	drawtype = "nodebox",
	node_box = {
	    type = "fixed",
        fixed = {-0.5   , -0.5   , -0.5   ,   0.5   , -0.4375,  0.5   },
    },
	groups = {snappy=3, flammable=2},
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Cut Grass becomes Hay over time
-----------------------------------------------------------------------------------------------
minetest.register_abm({
	nodenames = {"dryplants:grass"},
	interval = 3600, --1200, -- 20 minutes: a minetest-day/night-cycle
	chance = 1,
	action = function(pos)
		minetest.swap_node(pos, {name="dryplants:hay"})
	end,
})

-----------------------------------------------------------------------------------------------
-- Hay
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:hay", {
	description = S("Hay"),
	inventory_image = "dryplants_hay.png",
	wield_image = "dryplants_hay.png",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"dryplants_hay.png"},
	use_texture_alpha = "clip",
	drawtype = "nodebox",
	node_box = {
	    type = "fixed",
        fixed = {-0.5   , -0.5   , -0.5   ,   0.5   , -0.4375,  0.5   },
    },
	groups = {snappy=3, flammable=2},
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Short Grass
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:grass_short", {
	description = S("Short Grass"),
	tiles = {"default_grass.png^dryplants_grass_short.png", "default_dirt.png", "default_dirt.png^default_grass_side.png^dryplants_grass_short_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1,not_in_creative_inventory=1},
	--drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

-----------------------------------------------------------------------------------------------
-- Short Grass becomes Dirt with Grass over time
-----------------------------------------------------------------------------------------------
minetest.register_abm({
	nodenames = {"dryplants:grass_short"},
	interval = 1200, --1200, -- 20 minutes: a minetest-day/night-cycle
	chance = 100/1200,
	action = function(pos)
		-- Only become dirt with grass if no cut grass or hay lies on top
		local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		if above.name ~= "dryplants:grass" and above.name ~= "dryplants:hay" then
			minetest.swap_node(pos, {name="default:dirt_with_grass"})
		end
	end,
})
