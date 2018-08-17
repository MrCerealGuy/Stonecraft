-- Home Decor mod by VanessaE
--
-- Mostly my own code, with bits and pieces lifted from Minetest's default
-- lua files and from ironzorg's flowers mod.  Many thanks to GloopMaster
-- for helping me figure out the inventories used in the nightstands/dressers.
--
-- The code for ovens, nightstands, refrigerators are basically modified
-- copies of the code for chests and furnaces.

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("homedecor") then return end

local modpath = minetest.get_modpath("homedecor")

local S = homedecor_i18n.gettext

homedecor = {}
homedecor.modpath = modpath

-- Determine if the item being pointed at is the underside of a node (e.g a ceiling)
function homedecor.find_ceiling(itemstack, placer, pointed_thing)
	-- most of this is copied from the rotate-and-place function in builtin
	local unode = core.get_node_or_nil(pointed_thing.under)
	if not unode then
		return
	end
	local undef = core.registered_nodes[unode.name]
	if undef and undef.on_rightclick then
		undef.on_rightclick(pointed_thing.under, unode, placer,
				itemstack, pointed_thing)
		return
	end

	local above = pointed_thing.above
	local under = pointed_thing.under
	local iswall = (above.y == under.y)
	local isceiling = not iswall and (above.y < under.y)
	local anode = core.get_node_or_nil(above)
	if not anode then
		return
	end
	local pos = pointed_thing.above
	local node = anode

	if undef and undef.buildable_to then
		pos = pointed_thing.under
		node = unode
	end

	if core.is_protected(pos, placer:get_player_name()) then
		core.record_protection_violation(pos,
				placer:get_player_name())
		return
	end

	local ndef = core.registered_nodes[node.name]
	if not ndef or not ndef.buildable_to then
		return
	end
	return isceiling, pos
end

screwdriver = screwdriver or {}

homedecor.plain_wood    = { name = "homedecor_generic_wood_plain.png",  color = 0xffa76820 }
homedecor.mahogany_wood = { name = "homedecor_generic_wood_plain.png",  color = 0xff7d2506 }
homedecor.white_wood    = "homedecor_generic_wood_plain.png"
homedecor.dark_wood     = { name = "homedecor_generic_wood_plain.png",  color = 0xff39240f }
homedecor.lux_wood      = { name = "homedecor_generic_wood_luxury.png", color = 0xff643f23 }

homedecor.color_black     = 0xff303030
homedecor.color_dark_grey = 0xff606060
homedecor.color_med_grey  = 0xffa0a0a0

-- load different handler subsystems
dofile(modpath.."/handlers/init.lua")

-- load various other components
dofile(modpath.."/misc-nodes.lua")					-- the catch-all for all misc nodes
dofile(modpath.."/tables.lua")
dofile(modpath.."/electronics.lua")
dofile(modpath.."/shutters.lua")

dofile(modpath.."/roofing.lua")

dofile(modpath.."/foyer.lua")

dofile(modpath.."/doors_and_gates.lua")

dofile(modpath.."/fences.lua")

dofile(modpath.."/lighting.lua")

dofile(modpath.."/kitchen_appliances.lua")
dofile(modpath.."/kitchen_furniture.lua")
dofile(modpath.."/gastronomy.lua")

dofile(modpath.."/bathroom_furniture.lua")
dofile(modpath.."/bathroom_sanitation.lua")

dofile(modpath.."/bedroom.lua")

dofile(modpath.."/laundry.lua")

dofile(modpath.."/office.lua")

dofile(modpath.."/clocks.lua")
dofile(modpath.."/electrics.lua")

dofile(modpath.."/window_treatments.lua")

dofile(modpath.."/furniture.lua")
dofile(modpath.."/furniture_medieval.lua")
dofile(modpath.."/furniture_recipes.lua")
dofile(modpath.."/climate-control.lua")

dofile(modpath.."/cobweb.lua")
dofile(modpath.."/books.lua")
dofile(modpath.."/exterior.lua")
dofile(modpath.."/trash_cans.lua")
dofile(modpath.."/wardrobe.lua")

dofile(modpath.."/crafts.lua")

if minetest.settings:get_bool("log_mod") then
	minetest.log("action", "[HomeDecor] " .. S("Loaded!"))
end
