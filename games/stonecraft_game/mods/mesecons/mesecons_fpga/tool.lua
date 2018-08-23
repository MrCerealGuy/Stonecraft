return function(plg)

--[[

2018-08-23 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2018-08-23 MrCerealGuy: added intllib support

--]]

if core.skip_mod("mesecons") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


minetest.register_tool("mesecons_fpga:programmer", {
	description = S("FPGA Programmer"),
	inventory_image = "jeija_fpga_programmer.png",
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name:find("mesecons_fpga:fpga") ~= 1 then
			return itemstack
		end

		local meta = minetest.get_meta(pos)
		if meta:get_string("instr") == "//////////////" then
			minetest.chat_send_player(placer:get_player_name(), "This FPGA is unprogrammed.")
			return itemstack
		end
		itemstack:set_metadata(meta:get_string("instr"))
		minetest.chat_send_player(placer:get_player_name(), "FPGA gate configuration was successfully copied!")
		
		return itemstack
	end,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name:find("mesecons_fpga:fpga") ~= 1 then
			return itemstack
		end

		local imeta = itemstack:get_metadata()
		if imeta == "" then
			minetest.chat_send_player(user:get_player_name(), "Use shift+right-click to copy a gate configuration first.")
			return itemstack
		end

		local meta = minetest.get_meta(pos)
		meta:set_string("instr", imeta)
		plg.update_formspec(pos, imeta)
		minetest.chat_send_player(user:get_player_name(), "Gate configuration was successfully written to FPGA!")

		return itemstack
	end
})

minetest.register_craft({
	output = "mesecons_fpga:programmer",
	recipe = {
		{'group:mesecon_conductor_craftable'},
		{'mesecons_materials:silicon'},
	}
})


end
