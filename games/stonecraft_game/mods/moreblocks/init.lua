--[[
=====================================================================
** More Blocks **
By Calinou, with the help of ShadowNinja and VanessaE.

Copyright © 2011-2019 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
=====================================================================
--]]

--[[

2017-05-10 added intllib support

--]]

moreblocks = {}

local modpath = minetest.get_modpath("moreblocks")

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

dofile(modpath .. "/config.lua")
dofile(modpath .. "/circular_saw.lua")
dofile(modpath .. "/stairsplus/init.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/redefinitions.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/aliases.lua")
