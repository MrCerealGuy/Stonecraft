--[[

2019-02-11 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

function technic.register_freezer(data)
	data.typename = "freezing"
	data.machine_name = "freezer"
	data.machine_desc = S("%s Freezer")
	technic.register_base_machine(data)
end
