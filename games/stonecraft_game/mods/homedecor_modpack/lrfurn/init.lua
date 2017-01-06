--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_homedecor = world_conf:get("enable_homedecor")

if enable_homedecor ~= nil and enable_homedecor == "false" then
	minetest.log("info", "[homedecor:Irfurn] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

lrfurn = {}
screwdriver = screwdriver or {}

lrfurn.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

lrfurn.colors = { -- mod changed to use colorize feature of minetest engine (cg72)
	{ "black",       "#000000:230" }, 
	{ "brown",       "#251005:225" },
	{ "blue",        "#0000d0:225" },
	{ "cyan",        "#009fa7:250" }, 
	{ "dark_grey",   "#101010:175" },
	{ "dark_green",  "#007000:230" },
	{ "green",       "#00d000:250" },
	{ "grey",        "#101010:100" },
	{ "magenta",     "#e0048b:250" },
	{ "orange",      "#ee9000:240" },
	{ "pink",        "#ff90b0:250" },	
	{ "red",         "#800000:240" },
	{ "violet",      "#9000d0:250" },
	{ "white",       "#000000:000" },
	{ "yellow",      "#dde000:240" }
}

function lrfurn.check_forward(pos, fdir, long, placer)
	if not fdir or fdir > 3 then fdir = 0 end

	local pos2 = { x = pos.x + lrfurn.fdir_to_fwd[fdir+1][1],     y=pos.y, z = pos.z + lrfurn.fdir_to_fwd[fdir+1][2]     }
	local pos3 = { x = pos.x + lrfurn.fdir_to_fwd[fdir+1][1] * 2, y=pos.y, z = pos.z + lrfurn.fdir_to_fwd[fdir+1][2] * 2 }

	local node2 = minetest.get_node(pos2)
	if node2 and node2.name ~= "air" then
		return false
	elseif minetest.is_protected(pos2, placer:get_player_name()) then
		if not long then
			minetest.chat_send_player(placer:get_player_name(), "Someone else owns the spot where other end goes!")
		else
			minetest.chat_send_player(placer:get_player_name(), "Someone else owns the spot where the middle or far end goes!")
		end
		return false
	end

	if long then
		local node3 = minetest.get_node(pos3)
		if node3 and node3.name ~= "air" then
			return false
		elseif minetest.is_protected(pos3, placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "Someone else owns the spot where the other end goes!")
			return false
		end
	end

	return true
end

dofile(minetest.get_modpath("lrfurn").."/longsofas.lua")
dofile(minetest.get_modpath("lrfurn").."/sofas.lua")
dofile(minetest.get_modpath("lrfurn").."/armchairs.lua")
dofile(minetest.get_modpath("lrfurn").."/coffeetable.lua")
dofile(minetest.get_modpath("lrfurn").."/endtable.lua")
