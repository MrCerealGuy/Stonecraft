--[[

Unified Dyes

This mod provides an extension to the Minetest 0.4.x dye system

==============================================================================

Copyright (C) 2012-2013, Vanessa Ezekowitz
Email: vanessaezekowitz@gmail.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

==============================================================================

--]]

--=====================================================================

unifieddyes = {}
unifieddyes.last_used_dye = {}
unifieddyes.last_dyed_node = {}

local creative_mode = minetest.setting_getbool("creative_mode")

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

-- helper functions for other mods that use this one

unifieddyes.HUES = {
	"red",
	"orange",
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet"
}

-- the names of the various colors here came from http://www.procato.com/rgb+index/

unifieddyes.HUES_EXTENDED = {
	{ "red",        0xff, 0x00, 0x00 },
	{ "vermilion",  0xff, 0x40, 0x00 },
	{ "orange",     0xff, 0x80, 0x00 },
	{ "amber",      0xff, 0xbf, 0x00 },
	{ "yellow",     0xff, 0xff, 0x00 },
	{ "lime",       0xbf, 0xff, 0x00 },
	{ "chartreuse", 0x80, 0xff, 0x00 },
	{ "harlequin",  0x40, 0xff, 0x00 },
	{ "green",      0x00, 0xff, 0x00 },
	{ "malachite",  0x00, 0xff, 0x40 },
	{ "spring",     0x00, 0xff, 0x80 },
	{ "turquoise",  0x00, 0xff, 0xbf },
	{ "cyan",       0x00, 0xff, 0xff },
	{ "cerulean",   0x00, 0xbf, 0xff },
	{ "azure",      0x00, 0x80, 0xff },
	{ "sapphire",   0x00, 0x40, 0xff },
	{ "blue",       0x00, 0x00, 0xff },
	{ "indigo",     0x40, 0x00, 0xff },
	{ "violet",     0x80, 0x00, 0xff },
	{ "mulberry",   0xbf, 0x00, 0xff },
	{ "magenta",    0xff, 0x00, 0xff },
	{ "fuchsia",    0xff, 0x00, 0xbf },
	{ "rose",       0xff, 0x00, 0x80 },
	{ "crimson",    0xff, 0x00, 0x40 }
}

unifieddyes.SATS = {
	"",
	"_s50"
}

unifieddyes.VALS = {
	"",
	"medium_",
	"dark_"
}

unifieddyes.VALS_EXTENDED = {
	"faint_",
	"pastel_",
	"light_",
	"bright_",
	"",
	"medium_",
	"dark_"
}

unifieddyes.GREYS = {
	"white",
	"light_grey",
	"grey",
	"dark_grey",
	"black"
}

local default_dyes = {
	"black",
	"blue",
	"brown",
	"cyan",
	"dark_green",
	"dark_grey",
	"green",
	"grey",
	"magenta",
	"orange",
	"pink",
	"red",
	"violet",
	"white",
	"yellow"
}

-- automatically recolor a placed node to match the last-used dye
-- should be called in the node's `after_place_node` callback.

function unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)

	local playername = placer:get_player_name()
	local stackname = itemstack:get_name()

	if unifieddyes.last_dyed_node[playername] ~= stackname then
		if unifieddyes.last_used_dye[playername] then
			minetest.chat_send_player(playername, "Switched to \""..stackname.."\" while auto-coloring, color reset to neutral.")
		end
		unifieddyes.last_used_dye[playername] = nil
		unifieddyes.last_dyed_node[playername] = nil
	end

	unifieddyes.last_dyed_node[playername] = stackname

	if unifieddyes.last_used_dye[playername] then
		local lastdye = unifieddyes.last_used_dye[playername]

		local inv = placer:get_inventory()
		if (lastdye and lastdye ~= "" and inv:contains_item("main", lastdye.." 1")) or creative_mode then

			local nodedef = minetest.registered_nodes[stackname]
			local newname = nodedef.ud_replacement_node or stackname
			local node = minetest.get_node(pos)

			local palette_type = true -- default to 89-color split, because the others are easier to check for.
			local oldfdir = node.param2 % 32

			if nodedef.palette == "unifieddyes_palette.png" then
				palette_type = false
				oldfdir = 0
			elseif nodedef.palette == "unifieddyes_palette_colorwallmounted.png" then
				palette_type = "wallmounted"
				oldfdir = node.param2 % 8
			elseif nodedef.palette == "unifieddyes_palette_extended.png" then
				palette_type = "extended"
				oldfdir = 0
			end

			local paletteidx, hue = unifieddyes.getpaletteidx(lastdye, palette_type)
			if palette_type == true then newname = string.gsub(newname, "_grey", "_"..unifieddyes.HUES[hue]) end

			minetest.set_node(pos, { name = newname, param2 = oldfdir + paletteidx })

			local meta = minetest.get_meta(pos)
			meta:set_string("dye", lastdye)

			if not creative_mode then
				inv:remove_item("main", lastdye.." 1")
			end
		else
			minetest.chat_send_player(playername, "Ran out of "..unifieddyes.last_used_dye[playername]..", resetting to neutral.")
			unifieddyes.last_used_dye[playername] = nil
		end
	end
end

minetest.register_on_leaveplayer(function(player)
	local playername = player:get_player_name()
	unifieddyes.last_used_dye[playername] = nil
	unifieddyes.last_dyed_node[playername] = nil
end)

-- code borrowed from homedecor
-- call this function to reset the rotation of a "wallmounted" object on place

function unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node(pos)
	local yaw = placer:get_look_yaw()
	local dir = minetest.yaw_to_dir(yaw-1.5)
	local pitch = placer:get_look_vertical()

	local fdir = minetest.dir_to_wallmounted(dir)

	if pitch < -(math.pi/8) then
		fdir = 0
	elseif pitch > math.pi/8 then
		fdir = 1
	end
	minetest.swap_node(pos, { name = node.name, param2 = fdir })
end

-- use this when you have a "wallmounted" node that should never be oriented
-- to floor or ceiling...

function unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node(pos)
	local yaw = placer:get_look_yaw()
	local dir = minetest.yaw_to_dir(yaw)
	local fdir = minetest.dir_to_wallmounted(dir)
	minetest.swap_node(pos, { name = node.name, param2 = fdir })
end

-- ... and use this one to force that kind of node off of floor/ceiling
-- orientation after the screwdriver rotates it.

function unifieddyes.fix_after_screwdriver_nsew(pos, node, user, mode, new_param2)
	local new_fdir = new_param2 % 8
	local color = new_param2 - new_fdir
	if new_fdir < 2 then
		new_fdir = 2
		minetest.swap_node(pos, { name = node.name, param2 = new_fdir + color })
		return true
	end
end

function unifieddyes.select_node(pointed_thing)
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local def = node and minetest.registered_nodes[node.name]

	if not def or not def.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		def = node and minetest.registered_nodes[node.name]
	end
	return def and pos, def
end

function unifieddyes.is_buildable_to(placer_name, ...)
	for _, pos in ipairs({...}) do
		local node = minetest.get_node_or_nil(pos)
		local def = node and minetest.registered_nodes[node.name]
		if not (def and def.buildable_to) or minetest.is_protected(pos, placer_name) then
			return false
		end
	end
	return true
end

function unifieddyes.get_hsv(name) -- expects a node/item name
	local hue = ""
	local a,b
	for _, i in ipairs(unifieddyes.HUES) do
		a,b = string.find(name, "_"..i)
		if a and not ( string.find(name, "_redviolet") and i == "red" ) then
			hue = i
			break
		end
	end

	if string.find(name, "_light_grey")     then hue = "light_grey"
	elseif string.find(name, "_lightgrey")  then hue = "light_grey"
	elseif string.find(name, "_dark_grey")  then hue = "dark_grey"
	elseif string.find(name, "_darkgrey")   then hue = "dark_grey"
	elseif string.find(name, "_grey")       then hue = "grey"
	elseif string.find(name, "_white")      then hue = "white"
	elseif string.find(name, "_black")      then hue = "black"
	end

	local sat = ""
	if string.find(name, "_s50")    then sat = "_s50" end

	local val = ""
	if string.find(name, "dark_")   then val = "dark_"   end
	if string.find(name, "medium_") then val = "medium_" end
	if string.find(name, "light_")  then val = "light_"  end

	return hue, sat, val
end

-- code partially borrowed from cheapie's plasticbox mod

-- in the function below, color is just a color string, while
-- palette_type can be:
--
-- false/nil = standard 89 color palette
-- true = 89 color palette split into pieces for colorfacedir
-- "wallmounted" = 32-color abridged palette
-- "extended" = 256 color palette

function unifieddyes.getpaletteidx(color, palette_type)

	local origcolor = color
	local aliases = {
		["pink"] = "light_red",
		["brown"] = "dark_orange",
	}

	local grayscale = {
		["white"] = 1,
		["light_grey"] = 2,
		["grey"] = 3,
		["dark_grey"] = 4,
		["black"] = 5,
	}

	local grayscale_extended = {
		["white"] = 0,
		["grey_14"] = 1,
		["grey_13"] = 2,
		["grey_12"] = 3,
		["light_grey"] = 3,
		["grey_11"] = 4,
		["grey_10"] = 5,
		["grey_9"] = 6,
		["grey_8"] = 7,
		["grey"] = 7,
		["grey_7"] = 8,
		["grey_6"] = 9,
		["grey_5"] = 10,
		["grey_4"] = 11,
		["dark_grey"] = 11,
		["grey_3"] = 12,
		["grey_2"] = 13,
		["grey_1"] = 14,
		["black"] = 15,
	}

	local grayscale_wallmounted = {
		["white"] = 0,
		["light_grey"] = 1,
		["grey"] = 2,
		["dark_grey"] = 3,
		["black"] = 4,
	}

	local hues = {
		["red"] = 1,
		["orange"] = 2,
		["yellow"] = 3,
		["lime"] = 4,
		["green"] = 5,
		["aqua"] = 6,
		["cyan"] = 7,
		["skyblue"] = 8,
		["blue"] = 9,
		["violet"] = 10,
		["magenta"] = 11,
		["redviolet"] = 12,
	}

	local hues_extended = {
		["red"] = 0,
		["vermilion"] = 1,
		["orange"] = 2,
		["amber"] = 3,
		["yellow"] = 4,
		["lime"] = 5,
		["chartreuse"] = 6,
		["harlequin"] = 7,
		["green"] = 8,
		["malachite"] = 9,
		["spring"] = 10,
		["turquoise"] = 11,
		["cyan"] = 12,
		["cerulean"] = 13,
		["azure"] = 14,
		["sapphire"] = 15,
		["blue"] = 16,
		["indigo"] = 17,
		["violet"] = 18,
		["mulberry"] = 19,
		["magenta"] = 20,
		["fuchsia"] = 21,
		["rose"] = 22,
		["crimson"] = 23,
	}

	local hues_wallmounted = {
		["red"] = 0,
		["orange"] = 1,
		["yellow"] = 2,
		["green"] = 3,
		["cyan"] = 4,
		["blue"] = 5,
		["violet"] = 6,
		["magenta"] = 7
	}

	local shades = {
		[""] = 1,
		["s50"] = 2,
		["light"] = 3,
		["medium"] = 4,
		["mediums50"] = 5,
		["dark"] = 6,
		["darks50"] = 7,
	}

	local shades_extended = {
		["faint"] = 0,
		["pastel"] = 1,
		["light"] = 2,
		["bright"] = 3,
		[""] = 4,
		["s50"] = 5,
		["medium"] = 6,
		["mediums50"] = 7,
		["dark"] = 8,
		["darks50"] = 9
	}

	local shades_wallmounted = {
		[""] = 1,
		["medium"] = 2,
		["dark"] = 3
	}

	if string.sub(color,1,4) == "dye:" then
		color = string.sub(color,5,-1)
	elseif string.sub(color,1,12) == "unifieddyes:" then
		color = string.sub(color,13,-1)
	else
		return
	end

	if palette_type == "wallmounted" then
		if grayscale_wallmounted[color] then
			return (grayscale_wallmounted[color] * 8), 0
		end
	elseif palette_type == true then
		if grayscale[color] then
			return (grayscale[color] * 32), 0
		end
	elseif palette_type == "extended" then
		if grayscale_extended[color] then
			return grayscale_extended[color]+240, 0
		end
	else
		if grayscale[color] then
			return grayscale[color], 0
		end
	end

	local shade = "" -- assume full
	if string.sub(color,1,6) == "faint_" then
		shade = "faint"
		color = string.sub(color,7,-1)
	elseif string.sub(color,1,7) == "pastel_" then
		shade = "pastel"
		color = string.sub(color,8,-1)
	elseif string.sub(color,1,6) == "light_" then
		shade = "light"
		color = string.sub(color,7,-1)
	elseif string.sub(color,1,7) == "bright_" then
		shade = "bright"
		color = string.sub(color,8,-1)
	elseif string.sub(color,1,7) == "medium_" then
		shade = "medium"
		color = string.sub(color,8,-1)
	elseif string.sub(color,1,5) == "dark_" then
		shade = "dark"
		color = string.sub(color,6,-1)
	end
	if string.sub(color,-4,-1) == "_s50" then
		shade = shade.."s50"
		color = string.sub(color,1,-5)
	end

	if palette_type == "wallmounted" then
		if color == "brown" then return 48,1
		elseif color == "pink" then return 56,7
		elseif color == "blue" and shade == "light" then return 40,5
		elseif hues_wallmounted[color] and shades_wallmounted[shade] then
			return (shades_wallmounted[shade] * 64 + hues_wallmounted[color] * 8), hues_wallmounted[color]
		end
	else
		if color == "brown" then
			color = "orange"
			shade = "dark"
		elseif color == "pink" then
			color = "red"
			shade = "light"
		end
		if palette_type == true then -- it's colorfacedir
			if hues[color] and shades[shade] then
				return (shades[shade] * 32), hues[color]
			end
		elseif palette_type == "extended" then
			if hues_extended[color] and shades_extended[shade] then
				return (hues_extended[color] + shades_extended[shade]*24), hues_extended[color]
			end
		else -- it's the 89-color palette

			-- If using this palette, translate new color names back to old.

			if shade == "" then
				if color == "spring" then
					color = "aqua"
				elseif color == "azure" then
					color = "skyblue"
				elseif color == "rose" then
					color = "redviolet"
				end
			end
			if hues[color] and shades[shade] then
				return (hues[color] * 8 + shades[shade]), hues[color]
			end
		end
	end
end

-- if your node was once 89-color and uses an LBM to convert to the 256-color palette,
-- call this in that node def's on_construct:

function unifieddyes.on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("palette", "ext")
end

-- call this in your node's after_dig_node to get the last-used dye back.

function unifieddyes.after_dig_node(pos, oldnode, oldmetadata, digger)
	local prevdye

	if oldmetadata and oldmetadata.fields then
		prevdye = oldmetadata.fields.dye
	end

	local inv = digger:get_inventory()

	if prevdye and not (inv:contains_item("main", prevdye) and creative_mode) and minetest.registered_items[prevdye] then
		if inv:room_for_item("main", prevdye) then
			inv:add_item("main", prevdye)
		else
			minetest.add_item(pos, prevdye)
		end
	end
end

function unifieddyes.on_use(itemstack, player, pointed_thing)
	local stackname = itemstack:get_name()
	local playername = player:get_player_name()

	if pointed_thing and pointed_thing.type == "node" then
		if minetest.is_protected(unifieddyes.select_node(pointed_thing), playername)
		  and not minetest.check_player_privs(playername, "protection_bypass") then
			minetest.chat_send_player(playername, "Sorry, someone else owns that spot.")
			return
		end
	end

	if pointed_thing and pointed_thing.type == "object" then
		pointed_thing.ref:punch(player, 0, itemstack:get_tool_capabilities())
		return player:get_wielded_item() -- punch may modified the wielded item, load the new and return it
	end

	if not (pointed_thing and pointed_thing.type == "node") then return end  -- if "using" the dye on nothing at all (e.g. air)

	local pos = minetest.get_pointed_thing_position(pointed_thing)
	local node = minetest.get_node(pos)

	local nodedef = minetest.registered_nodes[node.name]

	if not nodedef then return end -- target was an unknown node, just bail out

	-- if the node has an on_punch defined, bail out and call that instead, unless "sneak" is pressed.
	if not player:get_player_control().sneak then
		local onpunch = nodedef.on_punch(pos, node, player, pointed_thing)
		if onpunch then
			return onpunch
		end
	end

	if player:get_player_control().sneak then
		if unifieddyes.last_used_dye[playername] then
			minetest.chat_send_player(playername, "Shift-punched a node, switching back to neutral color." )
		end
		unifieddyes.last_used_dye[playername] = nil
		return
	end

	-- if the target is unknown, has no groups defined, or isn't UD-colorable, just bail out
	if not (nodedef and nodedef.groups and nodedef.groups.ud_param2_colorable) then
		minetest.chat_send_player(playername, "That node can't be colored.")
		return
	end

	local newnode = nodedef.ud_replacement_node
	local palette_type

	if nodedef.palette == "unifieddyes_palette_extended.png" then
		palette_type = "extended"
	elseif nodedef.palette == "unifieddyes_palette.png" then
		palette_type = false
	elseif nodedef.paramtype2 == "colorfacedir" then
		palette_type = true
	elseif nodedef.paramtype2 == "colorwallmounted" then
		palette_type = "wallmounted"
	end

	if minetest.is_protected(pos, playername) and not minetest.check_player_privs(playername, {protection_bypass=true}) then
		minetest.record_protection_violation(pos, playername)
		return
	end

	local pos2 = unifieddyes.select_node(pointed_thing)
	local paletteidx, hue = unifieddyes.getpaletteidx(stackname, palette_type)

	if paletteidx then

		if unifieddyes.last_used_dye[playername] ~= stackname then
			minetest.chat_send_player(playername, "Color "..stackname.." selected, auto-coloring activated." )
			unifieddyes.last_used_dye[playername] = stackname
		end

		local meta = minetest.get_meta(pos)
		local prevdye = meta:get_string("dye")
		local inv = player:get_inventory()

		if not (inv:contains_item("main", prevdye) and creative_mode) and minetest.registered_items[prevdye] then
			if inv:room_for_item("main", prevdye) then
				inv:add_item("main", prevdye)
			else
				minetest.add_item(pos, prevdye)
			end
		end

		meta:set_string("dye", stackname)

		if prevdye == stackname then
			local a,b = string.find(stackname, ":")
			minetest.chat_send_player(playername, "That node is already "..string.sub(stackname, a + 1).."." )
			return
		elseif not creative_mode then
			itemstack:take_item()
		end

		node.param2 = paletteidx

		local oldpaletteidx, oldhuenum = unifieddyes.getpaletteidx(prevdye, palette_type)
		local oldnode = minetest.get_node(pos)

		local oldhue = nil
		for _, i in ipairs(unifieddyes.HUES) do
			if string.find(oldnode.name, "_"..i) and not
				( string.find(oldnode.name, "_redviolet") and i == "red" ) then
				oldhue = i
				break
			end
		end

		if newnode then -- this path is used when the calling mod want to supply a replacement node
			if palette_type == "wallmounted" then
				node.param2 = paletteidx + (minetest.get_node(pos).param2 % 8)
			elseif palette_type == true then  -- it's colorfacedir
				if oldhue ~=0 then -- it's colored, not grey
					if oldhue ~= nil then -- it's been painted before
						if hue ~= 0 then -- the player's wielding a colored dye
							newnode = string.gsub(newnode, "_"..oldhue, "_"..unifieddyes.HUES[hue])
						else -- it's a greyscale dye
							newnode = string.gsub(newnode, "_"..oldhue, "_grey")
						end
					else -- it's never had a color at all
						if hue ~= 0 then -- and if the wield is greyscale, don't change the node name
							newnode = string.gsub(newnode, "_grey", "_"..unifieddyes.HUES[hue])
						end
					end
				else
					if hue ~= 0 then  -- greyscale dye on greyscale node = no hue change
						newnode = string.gsub(newnode, "_grey", "_"..unifieddyes.HUES[hue])
					end
				end
				node.param2 = paletteidx + (minetest.get_node(pos).param2 % 32)
			else -- it's the 89-color palette, or the extended palette
				node.param2 = paletteidx
			end
			node.name = newnode
			minetest.swap_node(pos, node)
			if palette_type == "extended" then
				meta:set_string("palette", "ext")
			end
			if not creative_mode then
				return itemstack
			end
		else -- this path is used when you're just painting an existing node, rather than replacing one.
			newnode = oldnode  -- note that here, newnode/oldnode are a full node, not just the name.
			if palette_type == "wallmounted" then
				newnode.param2 = paletteidx + (minetest.get_node(pos).param2 % 8)
			elseif palette_type == true then -- it's colorfacedir
				if oldhue then
					if hue ~= 0 then
						newnode.name = string.gsub(newnode.name, "_"..oldhue, "_"..unifieddyes.HUES[hue])
					else
						newnode.name = string.gsub(newnode.name, "_"..oldhue, "_grey")
					end
				elseif string.find(minetest.get_node(pos).name, "_grey") and hue ~= 0 then
					newnode.name = string.gsub(newnode.name, "_grey", "_"..unifieddyes.HUES[hue])
				end
				newnode.param2 = paletteidx + (minetest.get_node(pos).param2 % 32)
			else -- it's the 89-color palette, or the extended palette
				newnode.param2 = paletteidx
			end
			minetest.swap_node(pos, newnode)
			if palette_type == "extended" then
				meta:set_string("palette", "ext")
			end
			if not creative_mode then
				return itemstack
			end
		end
	else
		local a,b = string.find(stackname, ":")
		if a then
			minetest.chat_send_player(playername, "That node can't be colored "..string.sub(stackname, a + 1).."." )
		end
	end
end

-- re-define default dyes slightly, to add on_use

for _, color in ipairs(default_dyes) do
	minetest.override_item("dye:"..color, {
		on_use = unifieddyes.on_use
	})
end

-- build a table to convert from classic/89-color palette to extended palette

-- the first five entries are for the old greyscale - white, light, grey, dark, black
unifieddyes.convert_classic_palette = {
	240,
	244,
	247,
	251,
	253
}

for hue = 0, 11 do
	-- light
	local paletteidx = unifieddyes.getpaletteidx("dye:light_"..unifieddyes.HUES[hue+1], false)
	unifieddyes.convert_classic_palette[paletteidx] = hue*2 + 48
	for sat = 0, 1 do
		for val = 0, 2 do
			-- all other shades
			local paletteidx = unifieddyes.getpaletteidx("dye:"..unifieddyes.VALS[val+1]..unifieddyes.HUES[hue+1]..unifieddyes.SATS[sat+1], false)
			unifieddyes.convert_classic_palette[paletteidx] = hue*2 + sat*24 + (val*48+96)
		end
	end
end

-- Generate all dyes that are not part of the default minetest_game dyes mod

for _, h in ipairs(unifieddyes.HUES_EXTENDED) do
	local hue = h[1]
	local r = h[2]
	local g = h[3]
	local b = h[4]

	for v = 0, 6 do
		local val = unifieddyes.VALS_EXTENDED[v+1]

		local factor = 40
		if v > 3 then factor = 75 end

		local r2 = math.max(math.min(r + (4-v)*factor, 255), 0)
		local g2 = math.max(math.min(g + (4-v)*factor, 255), 0)
		local b2 = math.max(math.min(b + (4-v)*factor, 255), 0)

		-- full-sat color

		local desc = hue:gsub("%a", string.upper, 1).." Dye"

		if val ~= "" then
			desc = val:sub(1, -2):gsub("%a", string.upper, 1) .." "..desc
		end

		local color = string.format("%02x", r2)..string.format("%02x", g2)..string.format("%02x", b2)
		if minetest.registered_items["dye:"..val..hue] then
			minetest.override_item("dye:"..val..hue, {
				inventory_image = "unifieddyes_dye.png^[colorize:#"..color..":200",
				on_use = unifieddyes.on_use
			})
		else
			minetest.register_craftitem(":dye:"..val..hue, {
				description = S(desc),
				inventory_image = "unifieddyes_dye.png^[colorize:#"..color..":200",
				groups = { dye=1, not_in_creative_inventory=1 },
				on_use = unifieddyes.on_use
			})
		end
		minetest.register_alias("unifieddyes:"..val..hue, "dye:"..val..hue)

		if v > 3 then -- also register the low-sat version

			local pr = 0.299
			local pg = 0.587
			local pb = 0.114

			local p = math.sqrt(r2*r2*pr + g2*g2*pg + b2*b2*pb)
			local r3 = math.floor(p+(r2-p)*0.5)
			local g3 = math.floor(p+(g2-p)*0.5)
			local b3 = math.floor(p+(b2-p)*0.5)

			local color = string.format("%02x", r3)..string.format("%02x", g3)..string.format("%02x", b3)

			minetest.register_craftitem(":dye:"..val..hue.."_s50", {
				description = S(desc.." (low saturation)"),
				inventory_image = "unifieddyes_dye.png^[colorize:#"..color..":200",
				groups = { dye=1, not_in_creative_inventory=1 },
				on_use = unifieddyes.on_use
			})
			minetest.register_alias("unifieddyes:"..val..hue.."_s50", "dye:"..val..hue.."_s50")
		end
	end
end

-- register the greyscales too :P

for y = 1, 14 do -- colors 0 and 15 are black and white, default dyes

	if y ~= 4 and y ~= 8 and y~= 11 then -- don't register the three greys, they're done separately.

		local rgb = string.format("%02x", y*17)..string.format("%02x", y*17)..string.format("%02x", y*17)
		local name = "grey_"..y
		local desc = "Grey Dye #"..y

		minetest.register_craftitem(":dye:"..name, {
			description = S(desc),
			inventory_image = "unifieddyes_dye.png^[colorize:#"..rgb..":200",
			groups = { dye=1, not_in_creative_inventory=1 },
			on_use = unifieddyes.on_use
		})
		minetest.register_alias("unifieddyes:"..name, "dye:"..name)
	end
end

minetest.override_item("dye:grey", {
	inventory_image = "unifieddyes_dye.png^[colorize:#888888:200",
	on_use = unifieddyes.on_use
})

minetest.override_item("dye:dark_grey", {
	inventory_image = "unifieddyes_dye.png^[colorize:#444444:200",
	on_use = unifieddyes.on_use
})

minetest.register_craftitem(":dye:light_grey", {
	description = S("Light grey Dye"),
	inventory_image = "unifieddyes_dye.png^[colorize:#cccccc:200",
	groups = { dye=1, not_in_creative_inventory=1 },
	on_use = unifieddyes.on_use
})

unifieddyes.base_color_crafts = {
	{ "red",		"flowers:rose",				nil,				nil,			nil,			nil,		4 },
	{ "vermilion",	"dye:red",					"dye:orange",		nil,			nil,			nil,		3 },
	{ "orange",		"flowers:tulip",			nil,				nil,			nil,			nil,		4 },
	{ "orange",		"dye:red",					"dye:yellow",		nil,			nil,			nil,		2 },
	{ "amber",		"dye:orange",				"dye:yellow",		nil,			nil,			nil,		2 },
	{ "yellow",		"flowers:dandelion_yellow",	nil,				nil,			nil,			nil,		4 },
	{ "lime",		"dye:yellow",				"dye:chartreuse",	nil,			nil,			nil,		2 },
	{ "lime",		"dye:yellow",				"dye:yellow",		"dye:green",	nil,			nil,		3 },
	{ "chartreuse",	"dye:yellow",				"dye:green",		nil,			nil,			nil,		2 },
	{ "harlequin",	"dye:chartreuse",			"dye:green",		nil,			nil,			nil,		2 },
	{ "harlequin",	"dye:yellow",				"dye:green",		"dye:green",	nil,			nil,		3 },
	{ "green", 		"default:cactus",			nil,				nil,			nil,			nil,		4 },
	{ "green", 		"dye:yellow",				"dye:blue",			nil,			nil,			nil,		2 },
	{ "malachite",	"dye:green",				"dye:spring",		nil,			nil,			nil,		2 },
	{ "malachite",	"dye:green",				"dye:green",		"dye:cyan",		nil,			nil,		3 },
	{ "malachite",	"dye:green",				"dye:green",		"dye:green",	"dye:blue",		nil,		4 },
	{ "spring",		"dye:green",				"dye:cyan",			nil,			nil,			nil,		2 },
	{ "spring",		"dye:green",				"dye:green",		"dye:blue",		nil,			nil,		3 },
	{ "turquoise",	"dye:spring",				"dye:cyan",			nil,			nil,			nil,		2 },
	{ "turquoise",	"dye:green",				"dye:cyan",			"dye:cyan",		nil,			nil,		3 },
	{ "turquoise",	"dye:green",				"dye:green",		"dye:green",	"dye:blue",		"dye:blue",	5 },
	{ "cyan",		"dye:green",				"dye:blue",			nil,			nil,			nil,		2 },
	{ "cerulean",	"dye:cyan",					"dye:azure",		nil,			nil,			nil,		2 },
	{ "cerulean",	"dye:cyan",					"dye:cyan",			"dye:blue",		nil,			nil,		3 },
	{ "cerulean",	"dye:green",				"dye:green",		"dye:blue",		"dye:blue",		"dye:blue",	5 },
	{ "azure",		"dye:cyan",					"dye:blue",			nil,			nil,			nil,		2 },
	{ "azure",		"dye:green",				"dye:blue",			"dye:blue",		nil,			nil,		3 },
	{ "sapphire",	"dye:azure",				"dye:blue",			nil,			nil,			nil,		2 },
	{ "sapphire",	"dye:cyan",					"dye:blue",			"dye:blue",		nil,			nil,		3 },
	{ "sapphire",	"dye:green",				"dye:blue",			"dye:blue",		"dye:blue",		nil,		4 },
	{ "blue",		"flowers:geranium",			nil,				nil,			nil,			nil,		4 },
	{ "indigo",		"dye:blue",					"dye:violet",		nil,			nil,			nil,		2 },
	{ "violet",		"flowers:viola",			nil,				nil,			nil,			nil,		4 },
	{ "violet",		"dye:blue",					"dye:magenta",		nil,			nil,			nil,		2 },
	{ "mulberry",	"dye:violet",				"dye:magenta",		nil,			nil,			nil,		2 },
	{ "mulberry",	"dye:violet",				"dye:blue",			"dye:red",		nil,			nil,		3 },
	{ "magenta",	"dye:blue",					"dye:red",			nil,			nil,			nil,		2 },
	{ "fuchsia",	"dye:magenta",				"dye:rose",			nil,			nil,			nil,		2 },
	{ "fuchsia",	"dye:blue",					"dye:red",			"dye:rose",		nil,			nil,		3 },
	{ "fuchsia",	"dye:red",					"dye:violet",		nil,			nil,			nil,		2 },
	{ "rose",		"dye:magenta",				"dye:red",			nil,			nil,			nil,		2 },
	{ "rose",		"dye:red",					"dye:red",			"dye:blue",		nil,			nil,		3 },
	{ "crimson",	"dye:rose",					"dye:red",			nil,			nil,			nil,		2 },
	{ "crimson",	"dye:magenta",				"dye:red",			"dye:red",		nil,			nil,		3 },
	{ "crimson",	"dye:red",					"dye:red",			"dye:red",		"dye:blue",		nil,		4 },

	{ "black",		"default:coal_lump",		nil,				nil,			nil,			nil,		4 },
	{ "white",		"flowers:dandelion_white",	nil,				nil,			nil,			nil,		4 },
}

unifieddyes.shade_crafts = {
	{ "faint_",		"",			"dye:white",		"dye:white",	"dye:white",	4 },
	{ "pastel_",	"",			"dye:white",		"dye:white",	nil,			3 },
	{ "light_",		"",			"dye:white",		nil,			nil,			2 },
	{ "bright_",	"",			"color",			"dye:white",	nil,			3 },
	{ "",			"_s50",		"dye:light_grey",	nil,			nil,			2 },
	{ "",			"_s50",		"dye:black",		"dye:white",	"dye:white",	3 },
	{ "medium_",	"",			"dye:black",		nil,			nil,			2 },
	{ "medium_",	"_s50",		"dye:grey",			nil,			nil,			2 },
	{ "medium_",	"_s50",		"dye:black",		"dye:white",	nil,			3 },
	{ "dark_",		"",			"dye:black",		"dye:black",	nil,			3 },
	{ "dark_",		"_s50",		"dye:dark_grey",	nil,			nil,			2 },
	{ "dark_",		"_s50",		"dye:black",		"dye:black",	"dye:white",	4 },
}

for _,i in ipairs(unifieddyes.base_color_crafts) do
	local color = i[1]
	local yield = i[7]

	minetest.register_craft( {
		type = "shapeless",
		output = "dye:"..color.." "..yield,
		recipe = {
			i[2],
			i[3],
			i[4],
			i[5],
			i[6],
		},
	})

	for _,j in ipairs(unifieddyes.shade_crafts) do
		local firstdye = j[3]
		if firstdye == "color" then firstdye = "dye:"..color end

		if color ~= "black" and color ~= "white" and not string.find(color, "grey") then

			minetest.register_craft( {
				type = "shapeless",
				output = "dye:"..j[1]..color..j[2].." "..yield,
				recipe = {
					"dye:"..color,
					firstdye,
					j[4],
					j[5]
				},
			})
		end
	end
end

unifieddyes.greymixes = {
	{ 1,	"dye:black",			"dye:black",		"dye:black",		"dye:dark_grey",	4 },
	{ 2,	"dye:black",			"dye:black",		"dye:dark_grey",	nil,				3 },
	{ 3,	"dye:black",			"dye:dark_grey",	nil,				nil,				2 },
	{ 4,	"dye:white",			"dye:black",		"dye:black",		nil,				3 },
	{ 5,	"dye:dark_grey",		"dye:dark_grey",	"dye:grey",			nil,				3 },
	{ 6,	"dye:dark_grey",		"dye:grey",			nil,				nil,				2 },
	{ 7,	"dye:dark_grey",		"dye:grey",			"dye:grey",			nil,				3 },
	{ 8,	"dye:white",			"dye:black",		nil,				nil,				2 },
	{ 9,	"dye:grey", 			"dye:grey",			"dye:light_grey",	nil,				3 },
	{ 10,	"dye:grey",				"dye:light_grey",	"dye:light_grey",	nil,				3 },
	{ 11,	"dye:white",			"dye:white",		"dye:black",		nil,				3 },
	{ 12,	"dye:light_grey",		"dye:light_grey",	"dye:white",		nil,				3 },
	{ 13,	"dye:light_grey",		"dye:white",		nil,				nil,				2 },
	{ 14,	"dye:white", 			"dye:white",		"dye:light_grey",	nil,				3 },
}

for _, i in ipairs(unifieddyes.greymixes) do
	local shade = i[1]
	local dye1 = i[2]
	local dye2 = i[3]
	local dye3 = i[4]
	local dye4 = i[5]
	local yield = i[6]
	local color = "grey_"..shade
	if shade == 4 then
		color = "dark_grey"
	elseif shade == 8 then
		color = "grey"
	elseif shade == 11 then
		color = "light_grey"
	end

	minetest.register_craft( {
		type = "shapeless",
		output = "dye:"..color.." "..yield,
		recipe = {
			dye1,
			dye2,
			dye3,
			dye4,
		},
	})
end

minetest.register_alias("unifieddyes:light_red",  "dye:pink")
minetest.register_alias("unifieddyes:dark_green", "dye:dark_green")
minetest.register_alias("unifieddyes:black",      "dye:black")
minetest.register_alias("unifieddyes:darkgrey",   "dye:dark_grey")
minetest.register_alias("unifieddyes:dark_grey",  "dye:dark_grey")
minetest.register_alias("unifieddyes:grey",       "dye:grey")
minetest.register_alias("unifieddyes:lightgrey",  "dye:light_grey")
minetest.register_alias("unifieddyes:light_grey", "dye:light_grey")
minetest.register_alias("unifieddyes:white",      "dye:white")

minetest.register_alias("unifieddyes:grey_0",     "dye:black")
minetest.register_alias("unifieddyes:grey_4",     "dye:dark_grey")
minetest.register_alias("unifieddyes:grey_8",     "dye:grey")
minetest.register_alias("unifieddyes:grey_11",    "dye:light_grey")
minetest.register_alias("unifieddyes:grey_15",    "dye:white")

minetest.register_alias("unifieddyes:white_paint", "dye:white")
minetest.register_alias("unifieddyes:titanium_dioxide", "dye:white")
minetest.register_alias("unifieddyes:lightgrey_paint", "dye:light_grey")
minetest.register_alias("unifieddyes:grey_paint", "dye:grey")
minetest.register_alias("unifieddyes:darkgrey_paint", "dye:dark_grey")
minetest.register_alias("unifieddyes:carbon_black", "dye:black")

-- aqua -> spring, skyblue -> azure, and redviolet -> rose aliases
-- note that technically, lime should be aliased, but can't be (there IS
-- lime in the new color table, it's just shifted up a bit)

minetest.register_alias("unifieddyes:aqua", "unifieddyes:spring")
minetest.register_alias("unifieddyes:skyblue", "unifieddyes:azure")
minetest.register_alias("unifieddyes:redviolet", "unifieddyes:rose")

print(S("[UnifiedDyes] Loaded!"))

