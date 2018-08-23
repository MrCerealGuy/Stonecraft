
--[[

2017-05-26 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

function technic.register_compressor(data)
	data.typename = "compressing"
	data.machine_name = "compressor"
	data.machine_desc = S("Compressor")
	technic.register_base_machine(data)
end
