--[[
More Blocks: registrations

Copyright © 2011-2019 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

--[[

2018-08-21 added intllib support

--]]

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


local descriptions = {
	["micro"] = S("@1 Microblock"),
	["slab"] = S("@1 Slab"),
	["slope"] = S("@1 Slope"),
	["panel"] = S("@1 Panel"),
	["stair"] = S("@1 Stairs"),
}

stairsplus.register_single = function(category, alternate, info, modname, subname, recipeitem, fields)
	local desc_base = descriptions[category]:format(fields.description)
	local def = {}

	if category ~= "slab" then
		def = table.copy(info)
	end

	-- copy fields to def
	for k, v in pairs(fields) do
		def[k] = v
	end

	def.drawtype = "nodebox"
	def.paramtype = "light"
	def.paramtype2 = def.paramtype2 or "facedir"

	-- This makes node rotation work on placement
	def.place_param2 = nil

	def.on_place = minetest.rotate_node
	def.groups = stairsplus:prepare_groups(fields.groups)

	if category == "slab" then
		if type(info) ~= "table" then
			def.node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, (info/16)-0.5, 0.5},
			}
			def.description = ("%s (%d/16)"):format(desc_base, info)
		else
			def.node_box = {
				type = "fixed",
				fixed = info,
			}
			def.description = desc_base .. alternate:gsub("_", " "):gsub("(%a)(%S*)", function(a, b) return S(a:upper()) .. S(b) end)
		end
	else
		def.description = desc_base
		if category == "slope" then
			def.drawtype = "mesh"
		elseif category == "stair" and alternate == "" then
			def.groups.stair = 1
		end
	end

	if fields.drop and not (type(fields.drop) == "table") then
		def.drop = modname.. ":" .. category .. "_" .. fields.drop .. alternate
	end

	minetest.register_node(":" ..modname.. ":" .. category .. "_" .. subname .. alternate, def)
	stairsplus.register_recipes(category, alternate, modname, subname, recipeitem)
end
