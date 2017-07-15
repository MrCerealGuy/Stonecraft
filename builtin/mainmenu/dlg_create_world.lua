--Minetest
--Copyright (C) 2014 sapier
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

--[[

2017-06-11 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added option Minecraft-like item drop/pick-up

2017-07-13 redesigned dialog

--]]

local FILENAME = "worldoptions.txt"

-- include dlg_settings_helper.lua
local basepath = core.get_builtin_path()
dofile(basepath .. DIR_DELIM .. "common" .. DIR_DELIM .. "dlg_settings_helper.lua")

local full_settings = parse_config_file(false, false, FILENAME)
local search_string = ""
local settings = full_settings
local selected_setting = 1

local function create_world_formspec(dialogdata)
	local mapgens = core.get_mapgen_names()

	local current_worldname = core.settings:get("worldname") or ""
	local current_seed = core.settings:get("fixed_map_seed") or ""
	local current_mg   = core.settings:get("mg_name")

	local mglist = ""
	local selindex = 1
	local i = 1
	for k,v in pairs(mapgens) do
		if current_mg == v then
			selindex = i
		end
		i = i + 1
		mglist = mglist .. v .. ","
	end
	mglist = mglist:sub(1, -2)
	
	local gameid = core.settings:get("menu_last_game")
	
	local game, gameidx = nil , 0
	if gameid ~= nil then
		game, gameidx = gamemgr.find_by_gameid(gameid)
		
		if gameidx == nil then
			gameidx = 0
		end
	end

	current_seed = core.formspec_escape(current_seed)
	local retval = ""
	
	if game ~= nil and game.id == "stonecraft" then
		retval = retval .. "size[11.5,8.0,true]"
	else
		retval = retval .. "size[11.5,3.0,true]label[1.25,1;" ..
			fgettext("Cannot find Stonecraft game data! Download from mrcerealguy.github.io/stonecraft.") .. "]" ..
			"button[1.25,2.5;2.5,0.5;world_create_cancel;" .. fgettext("Cancel") .. "]"

		return retval
	end
	
	retval = retval ..		
		"label[2,0;" .. fgettext("World name") .. "]"..
		"field[4.5,0.4;6,0.5;te_world_name;;".. current_worldname .."]" ..
		
		"label[2,1;" .. fgettext("Seed-Code") .. "]"..
		"field[4.5,1.4;6,0.5;te_seed;;".. current_seed .. "]" ..
		
		"label[2,2;" .. fgettext("Mapgen") .. "]"..
		"dropdown[4.2,2;6.3;dd_mapgen;" .. mglist .. ";" .. selindex .. "]" ..

		"textlist[-10,3;7,2.3;games;" .. gamemgr.gamelist() ..
		";" .. gameidx .. ";true]"
		
	retval = retval .. "size[10,5.5;true]" ..
		"tablecolumns[color;tree;text,width=32;text]" ..
		"tableoptions[background=#00000000;border=false]" ..
		"table[0.25,3.50;10,3.5;list_world_options;"

	local current_level = 0
	for _, entry in ipairs(settings) do

		local name

		if entry.readable_name then
			name = fgettext_ne(entry.readable_name)
		else
			name = entry.name
		end

		if entry.type == "category" then
			current_level = entry.level
			retval = retval .. "#FFFF00," .. current_level .. "," .. fgettext(name) .. ",,"

		elseif entry.type == "bool" then
			local value = get_current_value(entry)
			if core.is_yes(value) then
				value = fgettext("Enabled")
			else
				value = fgettext("Disabled")
			end
			retval = retval .. "," .. (current_level + 1) .. "," .. core.formspec_escape(name) .. ","
					.. value .. ","

		elseif entry.type == "key" then
			-- ignore key settings, since we have a special dialog for them

		else
			retval = retval .. "," .. (current_level + 1) .. "," .. core.formspec_escape(name) .. ","
					.. core.formspec_escape(get_current_value(entry)) .. ","
		end
	end

	if #settings > 0 then
		retval = retval:sub(1, -2) -- remove trailing comma
	end

	retval = retval .. ";" .. selected_setting .. "]"

		

	retval = retval .. "button[3.25,7.5;2.5,0.5;world_create_confirm;" .. fgettext("Create") .. "]" ..
		"button[5.75,7.5;2.5,0.5;world_create_cancel;" .. fgettext("Cancel") .. "]"

	if #gamemgr.games == 0 then
		retval = retval .. "box[2,4;8,1;#ff8800]label[2.25,4;" ..
				fgettext("You have no subgames installed.") .. "]label[2.25,4.4;" ..
				fgettext("Download one from mrcerealguy.github.io/stonecraft") .. "]"
	elseif #gamemgr.games == 1 and gamemgr.games[1].id == "minimal" then
		retval = retval .. "box[1.75,4;8.7,1;#ff8800]label[2,4;" ..
				fgettext("Warning: The minimal development test is meant for developers.") .. "]label[2,4.4;" ..
				fgettext("Download a subgame, such as stonecraft_game, from mrcerealguy.github.io/stonecraft") .. "]"
	end

	return retval

end

local function create_world_buttonhandler(this, fields)
	
	-- handle Stonecraft selected world options
	local list_enter = false
	if fields["list_world_options"] then

		-- cache worldname/seeds
		core.settings:set("worldname", fields["te_world_name"])
		core.settings:set("fixed_map_seed", fields["te_seed"])

		selected_setting = core.get_table_index("list_world_options")
		if core.explode_table_event(fields["list_world_options"]).type == "DCL" then
			-- Directly toggle booleans
			local setting = settings[selected_setting]
			if setting and setting.type == "bool" then
				local current_value = get_current_value(setting)
				core.settings:set_bool(setting.name, not core.is_yes(current_value))
				core.settings:write()
				return true
			else
				list_enter = true
			end
		else
			return true
		end
	end

	if fields["world_create_confirm"] or
		fields["key_enter"] then

		local worldname = fields["te_world_name"]
		local gameindex = core.get_textlist_index("games")

		if gameindex ~= nil and
			worldname ~= "" then

			local message = nil

			core.settings:set("fixed_map_seed", fields["te_seed"])

			if not menudata.worldlist:uid_exists_raw(worldname) then
				core.settings:set("mg_name",fields["dd_mapgen"])
				message = core.create_world(worldname,gameindex)
			else
				message = fgettext("A world named \"$1\" already exists", worldname)
			end

			if message ~= nil then
				gamedata.errormessage = message
			else
				core.settings:set("menu_last_game",gamemgr.games[gameindex].id)
				if this.data.update_worldlist_filter then
					menudata.worldlist:set_filtercriteria(gamemgr.games[gameindex].id)
					mm_texture.update("singleplayer", gamemgr.games[gameindex].id)
				end
				menudata.worldlist:refresh()
				core.settings:set("mainmenu_last_selected_world",
									menudata.worldlist:raw_index_by_uid(worldname))
		
				-- write selected Stonecraft mods in world.mt
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_erosion", core.settings:get("enable_erosion"))

				-- forests
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_forests", core.settings:get("enable_forests"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_redtrees", core.settings:get("enable_forests"))

				-- villages
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_villages", core.settings:get("enable_villages"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_darkage", "false")  --deactivated
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mobf_trader", core.settings:get("enable_villages"))

				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_biomes", core.settings:get("enable_biomes"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_caverealms", core.settings:get("enable_caverealms"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_creatures", core.settings:get("enable_creatures"))

				-- homedecor/technic
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_homedecor", core.settings:get("enable_homedecor_technic"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mesecons", core.settings:get("enable_homedecor_technic"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pipeworks", core.settings:get("enable_homedecor_technic"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_technic", core.settings:get("enable_homedecor_technic"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_digilines", core.settings:get("enable_homedecor_technic"))

				-- not so simple mobs
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssm", core.settings:get("enable_nssm"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssb", core.settings:get("enable_nssm"))

				-- pyramids
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pyramids", core.settings:get("enable_pyramids"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_spawners", core.settings:get("enable_pyramids"))

				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_giantmushrooms", core.settings:get("enable_giantmushrooms"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_seaplants", core.settings:get("enable_seaplants"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_swamps", core.settings:get("enable_swamps"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_snow", core.settings:get("enable_snow"))

				-- mg_villages needs the mod more_snow
				if core.settings:get("enable_snow") or core.settings:get("enable_villages") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_moresnow", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_moresnow", "false")
				end

				-- wood soils/vines
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_woodsoils", core.settings:get("enable_woodsoils_vines"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_vines", core.settings:get("enable_woodsoils_vines"))

				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_surprise", core.settings:get("enable_surprise"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_itemdrop", core.settings:get("enable_itemdrop"))

				-- mines
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mines", core.settings:get("enable_mines"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_carts", core.settings:get("enable_mines"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_boost_carts", core.settings:get("enable_mines"))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_railcorridors", core.settings:get("enable_mines"))

			end
		else
			gamedata.errormessage =
				fgettext("No worldname given or no game selected")
		end
		this:delete()
		return true
	end

	if fields["games"] then
		return true
	end
	
	if fields["world_create_cancel"] then
		this:delete()
		return true
	end

	return false
end

function create_create_world_dlg(update_worldlistfilter)

	core.settings:set("worldname", "")
	core.settings:set("fixed_map_seed", "")

	local dlg = dialog_create("sp_create_world",
					create_world_formspec,
					create_world_buttonhandler,
					nil)
	dlg.update_worldlist_filter = update_worldlistfilter
	
	return dlg
end
