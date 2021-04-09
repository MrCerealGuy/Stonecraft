--[[

2017-02-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("boost_cart") then return end

if not minetest.features.object_use_texture_alpha then
	error("[boost_cart] Your Minetest version is no longer supported."
		.. " (Version < 5.0.0)")
end

boost_cart = {}
boost_cart.modpath = minetest.get_modpath("boost_cart")
boost_cart.MESECONS = minetest.global_exists("mesecon") and not core.skip_mod("mesecons")
boost_cart.MTG_CARTS = minetest.global_exists("carts") and carts.pathfinder
boost_cart.PLAYER_API = minetest.global_exists("player_api")
boost_cart.player_attached = {}

local function getNum(setting)
	return tonumber(minetest.settings:get(setting))
end

-- Maximal speed of the cart in m/s
boost_cart.speed_max = getNum("boost_cart.speed_max") or 10
-- Set to -1 to disable punching the cart from inside
boost_cart.punch_speed_max = getNum("boost_cart.punch_speed_max") or 7
-- Maximal distance for the path correction (for dtime peaks)
boost_cart.path_distance_max = 3


if boost_cart.PLAYER_API then
	-- This is a table reference!
	boost_cart.player_attached = player_api.player_attached
end

dofile(boost_cart.modpath.."/functions.lua")
dofile(boost_cart.modpath.."/rails.lua")

if boost_cart.MESECONS then
	dofile(boost_cart.modpath.."/detector.lua")
--else
--	minetest.register_alias("carts:powerrail", "boost_cart:detectorrail")
--	minetest.register_alias("carts:powerrail", "boost_cart:detectorrail_on")
end

if boost_cart.MTG_CARTS then
	minetest.log("action", "[boost_cart] Overwriting definitions of similar carts mod")
end
dofile(boost_cart.modpath.."/cart_entity.lua")
