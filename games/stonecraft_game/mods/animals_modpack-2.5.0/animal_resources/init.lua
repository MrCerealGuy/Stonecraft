-------------------------------------------------------------------------------
-- Animal Resources Mod by Sapier
--
--
--! @file init.lua
--! @brief main init file for animal resources
--! @copyright Sapier
--! @author Sapier
--! @date 2014-08-11
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
local ar_version = "0.0.1"

core.log("action", "MOD: loading animal resources mod ...")

--!path of mod
local ar_modpath = minetest.get_modpath("animal_resources")

dofile (ar_modpath .. "/tools.lua")
dofile (ar_modpath .. "/weapons.lua")

ar_init_weapons();
ar_init_tool_crafts();

core.log("action", "MOD: animal resources mod " .. ar_version .. " loaded.")