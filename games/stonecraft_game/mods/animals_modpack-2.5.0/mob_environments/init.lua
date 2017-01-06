-------------------------------------------------------------------------------
-- mob_environments Mod by Sapier
--
--
--! @file init.lua
--! @brief main init file for environment definitions
--! @copyright Sapier
--! @author Sapier
--! @date 2014-08-11
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
local ar_version = "0.0.1"

core.log("action", "MOD: Loading mob_environments mod ...")

--!path of mod
local me_modpath = minetest.get_modpath("mob_environments")

dofile (me_modpath .. "/general_env_sets.lua")
dofile (me_modpath .. "/flight_1.lua")
dofile (me_modpath .. "/meadow.lua")
dofile (me_modpath .. "/on_ground_2.lua")
dofile (me_modpath .. "/open_waters.lua")
dofile (me_modpath .. "/shallow_waters.lua")
dofile (me_modpath .. "/deep_water.lua")
dofile (me_modpath .. "/simple_air.lua")

core.log("action", "MOD: mob_environments mod " .. ar_version .. " loaded.")