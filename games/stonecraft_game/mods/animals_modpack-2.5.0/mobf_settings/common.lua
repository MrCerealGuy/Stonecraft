--------------------------------------------------------------------------------
-- Mob Framework Settings Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file tab_feature_config.lua
--! @brief settings gui for mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
--------------------------------------------------------------------------------

assert(not core.global_exists("mobf_settings"))
mobf_settings = {}

COLOR_RED   = "#FF0000"
COLOR_GREEN = "#00FF00"

------------------------------------------------------------------------------
-- name: setting_gettext(name)
-- @function [parent=#mobf_settings] setting_gettext
--
--! @brief convert bool to textual value
--! @ingroup mobf_settings
--
--! @param value string
-------------------------------------------------------------------------------
function mobf_settings.setting_gettext(value)

	local value = mobf_get_world_setting(value)

	if value == nil then
		return "false"
	end

	if value then
		return "true"
	end

	return "false"
end

------------------------------------------------------------------------------
-- name: printfac
-- @function [parent=#mobf_settings] printfac
--
--! @brief update formspec to tools tab
--! @ingroup mobf_settings
--
--! @param name of facility
--! @param data data to add label
--! @param yval ypos of label
--! @param vs formatstring
--
--! @return formspec label element string
-------------------------------------------------------------------------------
function mobf_settings.printfac(name,data,yval,fs)

	return
		"label[0.75," .. yval .. ";" .. string.sub(name,1,20) .. "]" ..
		"label[2.75," .. yval .. ";" ..
			string.format("%10s",string.format(fs,data.current)).. "]" ..
		"label[4.25," .. yval .. ";" ..
			string.format("%10s",data.maxabs).. "]" ..
		"label[6," .. yval .. ";" ..
			string.format("%10s",string.format(fs,data.max)).. "]"
end

------------------------------------------------------------------------------
-- name: contains
--
--! @brief check if element is in table
--! @ingroup mobf_settings
--
--! @param cur_table table to check for element
--! @param element element to find in table
--!
--! @return true/false
-------------------------------------------------------------------------------
function contains(cur_table, element)

	if cur_table == nil then
		return false
	end

	for i,v in ipairs(cur_table) do
		if v == element then
			return true
		end
	end

	return false
end