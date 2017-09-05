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

local function create_change_setting_formspec(dialogdata)
	local setting = settings[selected_setting]
	local formspec = "size[10,5.2,true]" ..
			"button[5,4.5;2,1;btn_done;" .. fgettext("Save") .. "]" ..
			"button[3,4.5;2,1;btn_cancel;" .. fgettext("Cancel") .. "]" ..
			"tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[0,0;10,3;info;"

	if setting.readable_name then
		formspec = formspec .. "#FFFF00," .. fgettext(setting.readable_name)
				.. " (" .. core.formspec_escape(setting.name) .. "),"
	else
		formspec = formspec .. "#FFFF00," .. core.formspec_escape(setting.name) .. ","
	end

	formspec = formspec .. ",,"

	local comment_text = ""

	if setting.comment == "" then
		comment_text = fgettext_ne("(No description of setting given)")
	else
		comment_text = fgettext_ne(setting.comment)
	end
	for _, comment_line in ipairs(comment_text:split("\n", true)) do
		formspec = formspec .. "," .. core.formspec_escape(comment_line) .. ","
	end

	if setting.type == "flags" then
		formspec = formspec .. ",,"
				.. "," .. fgettext("Please enter a comma seperated list of flags.") .. ","
				.. "," .. fgettext("Possible values are: ")
				.. core.formspec_escape(setting.possible:gsub(",", ", ")) .. ","
	elseif setting.type == "noise_params" then
		formspec = formspec .. ",,"
				.. "," .. fgettext("Format:") .. ","
				.. "," .. fgettext("<offset>, <scale>, (<spreadX>, <spreadY>, <spreadZ>),") .. ","
				.. "," .. fgettext("<seed>, <octaves>, <persistence>, <lacunarity>") .. ","
	elseif setting.type == "v3f" then
		formspec = formspec .. ",,"
				.. "," .. fgettext_ne("Format is 3 numbers separated by commas and inside brackets.") .. ","
	end

	formspec = formspec:sub(1, -2) -- remove trailing comma

	formspec = formspec .. ";1]"

	if setting.type == "bool" then
		local selected_index
		if core.is_yes(get_current_value(setting)) then
			selected_index = 2
		else
			selected_index = 1
		end
		formspec = formspec .. "dropdown[0.5,3.5;3,1;dd_setting_value;"
				.. fgettext("Disabled") .. "," .. fgettext("Enabled") .. ";"
				.. selected_index .. "]"

	elseif setting.type == "enum" then
		local selected_index = 0
		formspec = formspec .. "dropdown[0.5,3.5;3,1;dd_setting_value;"
		for index, value in ipairs(setting.values) do
			-- translating value is not possible, since it's the value
			--  that we set the setting to
			formspec = formspec ..  core.formspec_escape(value) .. ","
			if get_current_value(setting) == value then
				selected_index = index
			end
		end
		if #setting.values > 0 then
			formspec = formspec:sub(1, -2) -- remove trailing comma
		end
		formspec = formspec .. ";" .. selected_index .. "]"

	elseif setting.type == "path" or setting.type == "filepath" then
		local current_value = dialogdata.selected_path
		if not current_value then
			current_value = get_current_value(setting)
		end
		formspec = formspec .. "field[0.5,4;7.5,1;te_setting_value;;"
				.. core.formspec_escape(current_value) .. "]"
				.. "button[8,3.75;2,1;btn_browser_" .. setting.type .. ";" .. fgettext("Browse") .. "]"

	else
		-- TODO: fancy input for float, int, flags, noise_params, v3f
		local width = 10
		local text = get_current_value(setting)
		if dialogdata.error_message then
			formspec = formspec .. "tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[5,3.9;5,0.6;error_message;#FF0000,"
					.. core.formspec_escape(dialogdata.error_message) .. ";0]"
			width = 5
			if dialogdata.entered_text then
				text = dialogdata.entered_text
			end
		end
		formspec = formspec .. "field[0.5,4;" .. width .. ",1;te_setting_value;;"
				.. core.formspec_escape(text) .. "]"
	end
	return formspec
end

local function handle_change_setting_buttons(this, fields)
	if fields["btn_done"] or fields["key_enter"] then
		local setting = settings[selected_setting]
		if setting.type == "bool" then
			local new_value = fields["dd_setting_value"]
			-- Note: new_value is the actual (translated) value shown in the dropdown
			core.settings:set_bool(setting.name, new_value == fgettext("Enabled"))

		elseif setting.type == "enum" then
			local new_value = fields["dd_setting_value"]
			core.settings:set(setting.name, new_value)

		elseif setting.type == "int" then
			local new_value = tonumber(fields["te_setting_value"])
			if not new_value or math.floor(new_value) ~= new_value then
				this.data.error_message = fgettext_ne("Please enter a valid integer.")
				this.data.entered_text = fields["te_setting_value"]
				core.update_formspec(this:get_formspec())
				return true
			end
			if setting.min and new_value < setting.min then
				this.data.error_message = fgettext_ne("The value must be at least $1.", setting.min)
				this.data.entered_text = fields["te_setting_value"]
				core.update_formspec(this:get_formspec())
				return true
			end
			if setting.max and new_value > setting.max then
				this.data.error_message = fgettext_ne("The value must not be larger than $1.", setting.max)
				this.data.entered_text = fields["te_setting_value"]
				core.update_formspec(this:get_formspec())
				return true
			end
			core.settings:set(setting.name, new_value)

		elseif setting.type == "float" then
			local new_value = tonumber(fields["te_setting_value"])
			if not new_value then
				this.data.error_message = fgettext_ne("Please enter a valid number.")
				this.data.entered_text = fields["te_setting_value"]
				core.update_formspec(this:get_formspec())
				return true
			end
			core.settings:set(setting.name, new_value)

		elseif setting.type == "flags" then
			local new_value = fields["te_setting_value"]
			for _,value in ipairs(new_value:split(",", true)) do
				value = value:trim()
				local possible = "," .. setting.possible .. ","
				if not possible:find("," .. value .. ",", 0, true) then
					this.data.error_message = fgettext_ne("\"$1\" is not a valid flag.", value)
					this.data.entered_text = fields["te_setting_value"]
					core.update_formspec(this:get_formspec())
					return true
				end
			end
			core.settings:set(setting.name, new_value)

		else
			local new_value = fields["te_setting_value"]
			core.settings:set(setting.name, new_value)
		end
		core.settings:write()
		this:delete()
		return true
	end

	if fields["btn_cancel"] then
		this:delete()
		return true
	end

	if fields["btn_browser_path"] then
		core.show_path_select_dialog("dlg_browse_path",
			fgettext_ne("Select directory"), false)
	end

	if fields["btn_browser_filepath"] then
		core.show_path_select_dialog("dlg_browse_path",
			fgettext_ne("Select file"), true)
	end

	if fields["dlg_browse_path_accepted"] then
		this.data.selected_path = fields["dlg_browse_path_accepted"]
		core.update_formspec(this:get_formspec())
	end

	return false
end

local function create_world_formspec(dialogdata)
	local mapgens = core.get_mapgen_names()

	local current_worldname = core.settings:get("worldname") or ""
	local current_seed = core.settings:get("fixed_map_seed") or ""
	local current_mg = core.settings:get("mg_name")

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
		
	retval = retval .. "size[10,5.5,true]" ..
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

		-- cache worldname/seeds/mapgen
		core.settings:set("worldname", fields["te_world_name"])
		core.settings:set("fixed_map_seed", fields["te_seed"])
		core.settings:set("mg_name", fields["dd_mapgen"])

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

	if list_enter then
		local setting = settings[selected_setting]

		if setting and setting.type ~= "category" then
			local edit_dialog = dialog_create("change_setting", create_change_setting_formspec,
					handle_change_setting_buttons)
			edit_dialog:set_parent(this)
			this:hide()
			edit_dialog:show()
		end
		return true
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
