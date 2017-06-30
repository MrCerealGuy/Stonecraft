--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-17 MrCerealGuy: added intllib support

--]]

if core.skip_mod("mesecons") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Sticky blocks can be used together with pistons or movestones to push / pull
-- structures that are "glued" together using sticky blocks

-- All sides sticky block
minetest.register_node("mesecons_stickyblocks:sticky_block_all", {
	description = S("All-sides sticky block"),
	tiles = {"default_grass.png^default_footprint.png"},
	groups = {dig_immediate=2},
	mvps_sticky = function (pos, node)
		local connected = {}
		for _, r in ipairs(mesecon.rules.alldirs) do
			table.insert(connected, vector.add(pos, r))
		end
		return connected
	end
})
