--[[

2017-02-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_carts = world_conf:get("enable_carts")

if enable_carts ~= nil and enable_carts == "false" then
	minetest.log("info", "[carts] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

carts = {}
carts.modpath = minetest.get_modpath("carts")
carts.railparams = {}

-- Maximal speed of the cart in m/s (min = -1)
carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
carts.punch_speed_max = 5


dofile(carts.modpath.."/functions.lua")
dofile(carts.modpath.."/rails.lua")

-- Support for non-default games
if not default.player_attached then
	default.player_attached = {}
end

dofile(carts.modpath.."/cart_entity.lua")
