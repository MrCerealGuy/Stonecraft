--Stonecraft
--Copyright (C) 2017 MrCerealGuy
--
--This program is free software; you can redistribute it and/or modify
--it under the terms of the GNU Lesser General Public License as published by
--the Free Software Foundation; either version 2.1 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU Lesser General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public License along
--with this program; if not, write to the Free Software Foundation, Inc.,
--51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

--------------------------------------------------------------------------------

-- Gets boolean value from world dialog saved in world.mt
function core.is_world_option(option)
	assert(type(option) == "string")

	local world_conf_option = nil

	local DIR_DELIM = DIR_DELIM or "/"
	local world_file = core.get_worldpath()..DIR_DELIM.."world.mt"
	local world_conf = Settings(world_file)

	if world_conf ~= nil then
		world_conf_option = world_conf:get(option)
	end 

	if world_conf_option == "true" then
		return true
	end

	return false
end

-- Checks active world.mt for loading/skipping mod
function core.skip_mod(mod)
	assert(type(mod) == "string")

	if not core.is_world_option("enable_" .. mod) then
		minetest.log("info", "[" .. mod .. "] skip loading mod.")
		return true
	end

	return false
end

function core.is_mod_setting(mod_setting)
		assert(type(mod_setting) == "string")

	local world_conf = nil

	local DIR_DELIM = DIR_DELIM or "/"
	local world_file = core.get_worldpath()..DIR_DELIM.."world.mt"
	local world_conf_ = Settings(world_file)

	if world_conf ~= nil then
		world_conf_mod_setting = world_conf:get(mod_setting)
	end 

	if world_conf_mod_setting == "true" then
		return true
	end

	return false
end

