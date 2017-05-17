--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-17 MrCerealGuy: added intllib support

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_mesecons = world_conf:get("enable_mesecons")

if enable_mesecons ~= nil and enable_mesecons == "false" then
	minetest.log("info", "[mesecons:switch] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- mesecons_switch

mesecon.register_node("mesecons_switch:mesecon_switch", {
	paramtype2="facedir",
	description=S("Switch"),
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function (pos, node)
		if(mesecon.flipstate(pos, node) == "on") then
			mesecon.receptor_on(pos)
		else
			mesecon.receptor_off(pos)
		end
		minetest.sound_play("mesecons_switch", {pos=pos})
	end
},{
	groups = {dig_immediate=2},
	tiles = {	"mesecons_switch_side.png", "mesecons_switch_side.png",
				"mesecons_switch_side.png", "mesecons_switch_side.png",
				"mesecons_switch_side.png", "mesecons_switch_off.png"},
	mesecons = {receptor = { state = mesecon.state.off }}
},{
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	tiles = {	"mesecons_switch_side.png", "mesecons_switch_side.png",
				"mesecons_switch_side.png", "mesecons_switch_side.png",
				"mesecons_switch_side.png", "mesecons_switch_on.png"},
	mesecons = {receptor = { state = mesecon.state.on }}
})

minetest.register_craft({
	output = "mesecons_switch:mesecon_switch_off 2",
	recipe = {
		{"default:steel_ingot", "default:cobble", "default:steel_ingot"},
		{"group:mesecon_conductor_craftable","", "group:mesecon_conductor_craftable"},
	}
})
