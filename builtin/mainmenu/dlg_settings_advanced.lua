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
	-- Final formspec will be created at the end of this function
	-- Default values below, may be changed depending on setting type
	local width = 10
	local height = 3.5
	local description_height = 3
	local formspec = ""

	-- Setting-specific formspec elements
	if setting.type == "bool" then
		local selected_index = 1
		if core.is_yes(get_current_value(setting)) then
			selected_index = 2
		end
		formspec = "dropdown[3," .. height .. ";4,1;dd_setting_value;"
				.. fgettext("Disabled") .. "," .. fgettext("Enabled") .. ";"
				.. selected_index .. "]"
		height = height + 1.25

	elseif setting.type == "enum" then
		local selected_index = 0
		formspec = "dropdown[3," .. height .. ";4,1;dd_setting_value;"
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
		height = height + 1.25

	elseif setting.type == "path" or setting.type == "filepath" then
		local current_value = dialogdata.selected_path
		if not current_value then
			current_value = get_current_value(setting)
		end
		formspec = "field[0.28," .. height + 0.15 .. ";8,1;te_setting_value;;"
				.. core.formspec_escape(current_value) .. "]"
				.. "button[8," .. height - 0.15 .. ";2,1;btn_browser_"
				.. setting.type .. ";" .. fgettext("Browse") .. "]"
		height = height + 1.15

	elseif setting.type == "noise_params_2d" or setting.type == "noise_params_3d" then
		local t = get_current_np_group(setting)
		local dimension = 3
		if setting.type == "noise_params_2d" then
			dimension = 2
		end

		-- More space for 3x3 fields
		description_height = description_height - 1.5
		height = height - 1.5

		local fields = {}
		local function add_field(x, name, label, value)
			fields[#fields + 1] = ("field[%f,%f;3.3,1;%s;%s;%s]"):format(
				x, height, name, label, core.formspec_escape(value or "")
			)
		end
		-- First row
		height = height + 0.3
		add_field(0.3, "te_offset", fgettext("Offset"), t[1])
		add_field(3.6, "te_scale",  fgettext("Scale"),  t[2])
		add_field(6.9, "te_seed",   fgettext("Seed"),   t[6])
		height = height + 1.1

		-- Second row
		add_field(0.3, "te_spreadx", fgettext("X spread"), t[3])
		if dimension == 3 then
			add_field(3.6, "te_spready", fgettext("Y spread"), t[4])
		else
			fields[#fields + 1] = "label[4," .. height - 0.2 .. ";" ..
					fgettext("2D Noise") .. "]"
		end
		add_field(6.9, "te_spreadz", fgettext("Z spread"), t[5])
		height = height + 1.1

		-- Third row
		add_field(0.3, "te_octaves", fgettext("Octaves"),     t[7])
		add_field(3.6, "te_persist", fgettext("Persistance"), t[8])
		add_field(6.9, "te_lacun",   fgettext("Lacunarity"),  t[9])
		height = height + 1.1


		local enabled_flags = flags_to_table(t[10])
		local flags = {}
		for _, name in ipairs(enabled_flags) do
			-- Index by name, to avoid iterating over all enabled_flags for every possible flag.
			flags[name] = true
		end
		for _, name in ipairs(setting.flags) do
			local checkbox_name = "cb_" .. name
			local is_enabled = flags[name] == true -- to get false if nil
			checkboxes[checkbox_name] = is_enabled
		end
		-- Flags
		formspec = table.concat(fields)
				.. "checkbox[0.5," .. height - 0.6 .. ";cb_defaults;"
				.. fgettext("defaults") .. ";" -- defaults
				.. tostring(flags["defaults"] == true) .. "]" -- to get false if nil
				.. "checkbox[5," .. height - 0.6 .. ";cb_eased;"
				.. fgettext("eased") .. ";" -- eased
				.. tostring(flags["eased"] == true) .. "]"
				.. "checkbox[5," .. height - 0.15 .. ";cb_absvalue;"
				.. fgettext("absvalue") .. ";" -- absvalue
				.. tostring(flags["absvalue"] == true) .. "]"
		height = height + 1

	elseif setting.type == "v3f" then
		local val = get_current_value(setting)
		local v3f = {}
		for line in val:gmatch("[+-]?[%d.-e]+") do -- All numeric characters
			table.insert(v3f, line)
		end

		height = height + 0.3
		formspec = formspec
				.. "field[0.3," .. height .. ";3.3,1;te_x;"
				.. fgettext("X") .. ";" -- X
				.. core.formspec_escape(v3f[1] or "") .. "]"
				.. "field[3.6," .. height .. ";3.3,1;te_y;"
				.. fgettext("Y") .. ";" -- Y
				.. core.formspec_escape(v3f[2] or "") .. "]"
				.. "field[6.9," .. height .. ";3.3,1;te_z;"
				.. fgettext("Z") .. ";" -- Z
				.. core.formspec_escape(v3f[3] or "") .. "]"
		height = height + 1.1

	elseif setting.type == "flags" then
		local enabled_flags = flags_to_table(get_current_value(setting))
		local flags = {}
		for _, name in ipairs(enabled_flags) do
			-- Index by name, to avoid iterating over all enabled_flags for every possible flag.
			flags[name] = true
		end
		local flags_count = #setting.possible
		local max_height = flags_count / 4

		-- More space for flags
		description_height = description_height - 1
		height = height - 1

		local fields = {} -- To build formspec
		for i, name in ipairs(setting.possible) do
			local x = 0.5
			local y = height + i / 2 - 0.75
			if i - 1 >= flags_count / 2 then -- 2nd column
				x = 5
				y = y - max_height
			end
			local checkbox_name = "cb_" .. name
			local is_enabled = flags[name] == true -- to get false if nil
			checkboxes[checkbox_name] = is_enabled

			fields[#fields + 1] = ("checkbox[%f,%f;%s;%s;%s]"):format(
				x, y, checkbox_name, name, tostring(is_enabled)
			)
		end
		formspec = table.concat(fields)
		height = height + max_height + 0.25

	else
		-- TODO: fancy input for float, int
		local text = get_current_value(setting)
		if dialogdata.error_message and dialogdata.entered_text then
			text = dialogdata.entered_text
		end
		formspec = "field[0.28," .. height + 0.15 .. ";" .. width .. ",1;te_setting_value;;"
				.. core.formspec_escape(text) .. "]"
		height = height + 1.15
	end

	-- Box good, textarea bad. Calculate textarea size from box.
	local function create_textfield(size, label, text, bg_color)
		local textarea = {
			x = size.x + 0.3,
			y = size.y,
			w = size.w + 0.25,
			h = size.h * 1.16 + 0.12
		}
		return ("box[%f,%f;%f,%f;%s]textarea[%f,%f;%f,%f;;%s;%s]"):format(
			size.x, size.y, size.w, size.h, bg_color or "#000",
			textarea.x, textarea.y, textarea.w, textarea.h,
			core.formspec_escape(label), core.formspec_escape(text)
		)

	end

	-- When there's an error: Shrink description textarea and add error below
	if dialogdata.error_message then
		local error_box = {
			x = 0,
			y = description_height - 0.4,
			w = width - 0.25,
			h = 0.5
		}
		formspec = formspec ..
			create_textfield(error_box, "", dialogdata.error_message, "#600")
		description_height = description_height - 0.75
	end

	-- Get description field
	local description_box = {
		x = 0,
		y = 0.2,
		w = width - 0.25,
		h = description_height
	}

	local setting_name = setting.name
	if setting.readable_name then
		setting_name = fgettext_ne(setting.readable_name) ..
			" (" .. setting.name .. ")"
	end

	local comment_text = ""
	if setting.comment == "" then
		comment_text = fgettext_ne("(No description of setting given)")
	else
		comment_text = fgettext_ne(setting.comment)
	end

	return (
		"size[" .. width .. "," .. height + 0.25 .. ",true]" ..
		create_textfield(description_box, setting_name, comment_text) ..
		formspec ..
		"button[" .. width / 2 - 2.5 .. "," .. height - 0.4 .. ";2.5,1;btn_done;" ..
			fgettext("Save") .. "]" ..
		"button[" .. width / 2 .. "," .. height - 0.4 .. ";2.5,1;btn_cancel;" ..
			fgettext("Cancel") .. "]"
	)
end

local function handle_change_setting_buttons(this, fields)
	local setting = settings[selected_setting]
	if fields["btn_done"] or fields["key_enter"] then
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

		elseif setting.type == "flags" then
			local values = {}
			for _, name in ipairs(setting.possible) do
				if checkboxes["cb_" .. name] then
					table.insert(values, name)
				end
			end

			checkboxes = {}

			local new_value = table.concat(values, ", ")
			core.settings:set(setting.name, new_value)

		elseif setting.type == "noise_params_2d" or setting.type == "noise_params_3d" then
			local np_flags = {}
			for _, name in ipairs(setting.flags) do
				if checkboxes["cb_" .. name] then
					table.insert(np_flags, name)
				end
			end

			checkboxes = {}

			if setting.type == "noise_params_2d" then
				 fields["te_spready"] = fields["te_spreadz"]
			end
			local new_value = {
				offset = fields["te_offset"],
				scale = fields["te_scale"],
				spread = {
					x = fields["te_spreadx"],
					y = fields["te_spready"],
					z = fields["te_spreadz"]
				},
				seed = fields["te_seed"],
				octaves = fields["te_octaves"],
				persistence = fields["te_persist"],
				lacunarity = fields["te_lacun"],
				flags = table.concat(np_flags, ", ")
			}
			core.settings:set_np_group(setting.name, new_value)

		elseif setting.type == "v3f" then
			local new_value = "("
					.. fields["te_x"] .. ", "
					.. fields["te_y"] .. ", "
					.. fields["te_z"] .. ")"
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

	if setting.type == "flags"
			or setting.type == "noise_params_2d"
			or setting.type == "noise_params_3d" then
		for name, value in pairs(fields) do
			if name:sub(1, 3) == "cb_" then
				checkboxes[name] = value == "true"
			end
		end
	end

	return false
end

local function create_settings_formspec(tabview, name, tabdata)
	local formspec = "size[12,5.4;true]" ..
			"tablecolumns[color;tree;text,width=28;text]" ..
			"tableoptions[background=#00000000;border=false]" ..
			"field[0.3,0.1;10.2,1;search_string;;" .. core.formspec_escape(search_string) .. "]" ..
			"field_close_on_enter[search_string;false]" ..
			"button[10.2,-0.2;2,1;search;" .. fgettext("Search") .. "]" ..
			"table[0,0.8;12,3.5;list_settings;"

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

		elseif entry.type == "noise_params_2d" or entry.type == "noise_params_3d" then
			formspec = formspec .. "," .. (current_level + 1) .. "," .. core.formspec_escape(name) .. ","
					.. core.formspec_escape(get_current_np_group_as_string(entry)) .. ","

		else
			formspec = formspec .. "," .. (current_level + 1) .. "," .. core.formspec_escape(name) .. ","
					.. core.formspec_escape(get_current_value(entry)) .. ","
		end
	end

	if #settings > 0 then
		formspec = formspec:sub(1, -2) -- remove trailing comma
	end
	formspec = formspec .. ";" .. selected_setting .. "]" ..
			"button[0,4.9;4,1;btn_back;".. fgettext("< Back to Settings page") .. "]" ..
			"button[10,4.9;2,1;btn_edit;" .. fgettext("Edit") .. "]" ..
			"button[7,4.9;3,1;btn_restore;" .. fgettext("Restore Default") .. "]" ..
			"checkbox[0,4.3;cb_tech_settings;" .. fgettext("Show technical names") .. ";"
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
			core.settings:remove(setting.name)
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

-- Uncomment to generate stonecraft.conf.example and settings_translation_file.cpp
-- For RUN_IN_PLACE the generated files may appear in the bin folder

--assert(loadfile(core.get_builtin_path().."mainmenu"..DIR_DELIM.."generate_from_settingtypes.lua"))(parse_config_file(true, false))
