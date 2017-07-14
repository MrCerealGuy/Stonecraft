--Minetest
--Copyright (C) 2015 PilzAdam
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

2017-07-13 moved parse_xxx functions to dlg_settings_helper.lua by MrCerealGuy <mrcerealguy@gmx.de>

--]]

local FILENAME = "settingtypes.txt"

-- include dlg_settings_helper.lua
local basepath = core.get_builtin_path()
dofile(basepath .. DIR_DELIM .. "common" .. DIR_DELIM .. "dlg_settings_helper.lua")

local function filter_settings(settings, searchstring)
	if not searchstring or searchstring == "" then
		return settings, -1
	end

	-- Setup the keyword list
	local keywords = {}
	for word in searchstring:lower():gmatch("%S+") do
		table.insert(keywords, word)
	end

	local result = {}
	local category_stack = {}
	local current_level = 0
	local best_setting = nil
	for _, entry in pairs(settings) do
		if entry.type == "category" then
			-- Remove all settingless categories
			while #category_stack > 0 and entry.level <= current_level do
				table.remove(category_stack, #category_stack)
				if #category_stack > 0 then
					current_level = category_stack[#category_stack].level
				else
					current_level = 0
				end
			end

			-- Push category onto stack
			category_stack[#category_stack + 1] = entry
			current_level = entry.level
		else
			-- See if setting matches keywords
			local setting_score = 0
			for k = 1, #keywords do
				local keyword = keywords[k]

				if string.find(entry.name:lower(), keyword, 1, true) then
					setting_score = setting_score + 1
				end

				if entry.readable_name and
						string.find(fgettext(entry.readable_name):lower(), keyword, 1, true) then
					setting_score = setting_score + 1
				end

				if entry.comment and
						string.find(fgettext_ne(entry.comment):lower(), keyword, 1, true) then
					setting_score = setting_score + 1
				end
			end

			-- Add setting to results if match
			if setting_score > 0 then
				-- Add parent categories
				for _, category in pairs(category_stack) do
					result[#result + 1] = category
				end
				category_stack = {}

				-- Add setting
				result[#result + 1] = entry
				entry.score = setting_score

				if not best_setting or
						setting_score > result[best_setting].score then
					best_setting = #result
				end
			end
		end
	end
	return result, best_setting or -1
end

local full_settings = parse_config_file(false, true, FILENAME)
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

local function create_settings_formspec(tabview, name, tabdata)
	local formspec = "size[12,6.5;true]" ..
			"tablecolumns[color;tree;text,width=32;text]" ..
			"tableoptions[background=#00000000;border=false]" ..
			"field[0.3,0.1;10.2,1;search_string;;" .. core.formspec_escape(search_string) .. "]" ..
			"field_close_on_enter[search_string;false]" ..
			"button[10.2,-0.2;2,1;search;" .. fgettext("Search") .. "]" ..
			"table[0,0.8;12,4.5;list_settings;"

	local current_level = 0
	for _, entry in ipairs(settings) do
		local name
		if not core.settings:get_bool("main_menu_technical_settings") and entry.readable_name then
			name = fgettext_ne(entry.readable_name)
		else
			name = entry.name
		end

		if entry.type == "category" then
			current_level = entry.level
			formspec = formspec .. "#FFFF00," .. current_level .. "," .. fgettext(name) .. ",,"

		elseif entry.type == "bool" then
			local value = get_current_value(entry)
			if core.is_yes(value) then
				value = fgettext("Enabled")
			else
				value = fgettext("Disabled")
			end
			formspec = formspec .. "," .. (current_level + 1) .. "," .. core.formspec_escape(name) .. ","
					.. value .. ","

		elseif entry.type == "key" then
			-- ignore key settings, since we have a special dialog for them

		else
			formspec = formspec .. "," .. (current_level + 1) .. "," .. core.formspec_escape(name) .. ","
					.. core.formspec_escape(get_current_value(entry)) .. ","
		end
	end

	if #settings > 0 then
		formspec = formspec:sub(1, -2) -- remove trailing comma
	end
	formspec = formspec .. ";" .. selected_setting .. "]" ..
			"button[0,6;4,1;btn_back;".. fgettext("< Back to Settings page") .. "]" ..
			"button[10,6;2,1;btn_edit;" .. fgettext("Edit") .. "]" ..
			"button[7,6;3,1;btn_restore;" .. fgettext("Restore Default") .. "]" ..
			"checkbox[0,5.3;cb_tech_settings;" .. fgettext("Show technical names") .. ";"
					.. dump(core.settings:get_bool("main_menu_technical_settings")) .. "]"

	return formspec
end

local function handle_settings_buttons(this, fields, tabname, tabdata)
	local list_enter = false
	if fields["list_settings"] then
		selected_setting = core.get_table_index("list_settings")
		if core.explode_table_event(fields["list_settings"]).type == "DCL" then
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

	if fields.search or fields.key_enter_field == "search_string" then
		if search_string == fields.search_string then
			if selected_setting > 0 then
				-- Go to next result on enter press
				local i = selected_setting + 1
				local looped = false
				while i > #settings or settings[i].type == "category" do
					i = i + 1
					if i > #settings then
						-- Stop infinte looping
						if looped then
							return false
						end
						i = 1
						looped = true
					end
				end
				selected_setting = i
				core.update_formspec(this:get_formspec())
				return true
			end
		else
			-- Search for setting
			search_string = fields.search_string
			settings, selected_setting = filter_settings(full_settings, search_string)
			core.update_formspec(this:get_formspec())
		end
		return true
	end

	if fields["btn_edit"] or list_enter then
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

	if fields["btn_restore"] then
		local setting = settings[selected_setting]
		if setting and setting.type ~= "category" then
			core.settings:set(setting.name, setting.default)
			core.settings:write()
			core.update_formspec(this:get_formspec())
		end
		return true
	end

	if fields["btn_back"] then
		this:delete()
		return true
	end

	if fields["cb_tech_settings"] then
		core.settings:set("main_menu_technical_settings", fields["cb_tech_settings"])
		core.settings:write()
		core.update_formspec(this:get_formspec())
		return true
	end

	return false
end

function create_adv_settings_dlg()
	local dlg = dialog_create("settings_advanced",
				create_settings_formspec,
				handle_settings_buttons,
				nil)

				return dlg
end

-- Generate minetest.conf.example and settings_translation_file.cpp

--assert(loadfile(core.get_builtin_path().."mainmenu"..DIR_DELIM.."generate_from_settingtypes.lua"))(parse_config_file(true, false))
