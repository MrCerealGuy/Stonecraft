--[[

2017-05-13 added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

beds = {}
beds.player = {}
beds.bed_position = {}
beds.pos = {}
beds.spawn = {}

beds.formspec = "size[8,11;true]" ..
	"no_prepend[]" ..
	"bgcolor[#080808BB;true]" ..
	"button_exit[2,10;4,0.75;leave;"..S("Leave Bed").."]"

local modpath = minetest.get_modpath("beds")

-- Load files

dofile(modpath .. "/functions.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/beds.lua")
dofile(modpath .. "/spawns.lua")
