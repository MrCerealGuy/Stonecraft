-------------------------------------------------------------------------------
-- Mob Framework Settings Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file init.lua
--! @brief settings gui for mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

function fgettext(text)
	return text
end

--!path of mod
local modpath = minetest.get_modpath("mobf_settings")
dofile (modpath .. DIR_DELIM .. "settings.lua")

