--[[

2017-02-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("boost_cart") then return end

boost_cart = {}
boost_cart.modpath = minetest.get_modpath("boost_cart")


if not minetest.settings then
	error("[boost_cart] Your Minetest version is no longer supported."
		.. " (Version <= 0.4.15)")
end

local function getNum(setting)
	return tonumber(minetest.settings:get(setting))
end

-- Maximal speed of the cart in m/s
boost_cart.speed_max = getNum("boost_cart.speed_max") or 10
-- Set to -1 to disable punching the cart from inside
boost_cart.punch_speed_max = getNum("boost_cart.punch_speed_max") or 7
-- Maximal distance for the path correction (for dtime peaks)
boost_cart.path_distance_max = 3


-- Support for non-default games
if not default.player_attached then
	default.player_attached = {}
end

minetest.after(0, function()
	boost_cart.old_player_model = not minetest.global_exists("player_api")
end)

dofile(boost_cart.modpath.."/functions.lua")
dofile(boost_cart.modpath.."/rails.lua")

if minetest.global_exists("mesecon") then
	dofile(boost_cart.modpath.."/detector.lua")
--else
--	minetest.register_alias("carts:powerrail", "boost_cart:detectorrail")
--	minetest.register_alias("carts:powerrail", "boost_cart:detectorrail_on")
end

boost_cart.mtg_compat = minetest.global_exists("carts") and carts.pathfinder
if boost_cart.mtg_compat then
	minetest.log("action", "[boost_cart] Overwriting definitions of similar carts mod")
end
dofile(boost_cart.modpath.."/cart_entity.lua")
