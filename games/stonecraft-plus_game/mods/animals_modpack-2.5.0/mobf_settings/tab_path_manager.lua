--------------------------------------------------------------------------------
-- Mob Framework Settings Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file tab_restore_mobs.lua
--! @brief settings gui for mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
--------------------------------------------------------------------------------

local function get_formspec(tabview, name, tabdata)

	if tabdata.selected_entry == nil then
		tabdata.selected_entry = 0
	end

		if tabdata.selected_point_entry == nil then
		tabdata.selected_point_entry = 0
	end

	local retval = "button[0.25,0.0;6,0.5;btn_give_pathmarker; Give pathmarker tool]" ..
					"label[0.25,0.5;Pathname]" ..
					"label[4,0.5;Owner]"

	local content = ""

	local all_paths = mobf_path.get_pathlist(tabdata.playername,tabdata.is_admin)

	if all_paths ~= nil then
		for i=1,#all_paths,1 do
			content = content .. all_paths[i].pathname .. ",(" ..
						all_paths[i].ownername .. ")"

			if i ~= #all_paths then
				content = content .. ","
			end
		end
	end

	retval = retval ..
		"tablecolumns[text,width=16;text]" ..
		"table[0.25,1;6,8;tbl_pathlist;" .. content .. ";"
				.. tabdata.selected_entry .. "]"

	if tabdata.selected_entry ~= 0 then
		local selected_path = all_paths[tabdata.selected_entry]

		if selected_path == nil then
			return retval
		end

		local path_data = mobf_rtd.path_data.users
				[selected_path.ownername].paths[selected_path.pathname]

		if path_data == nil then
			return retval
		end

		local point_content = ""
		local first = true

		for i,v in ipairs(path_data.points) do

			if not first then
				point_content = point_content ..","
			else
				first = false
			end

			point_content = point_content ..
				i .. ":," ..
				v.x .. "," ..
				v.y .. "," ..
				v.z
		end

		retval = retval ..
		"tablecolumns[text,width=5,align=right;"..
				"text,align=right;" ..
				"text,align=right;" ..
				"text,align=right]" ..
		"table[6.5,0;5.25,8;tbl_path_points;" .. point_content .. ";"
				.. tabdata.selected_point_entry .. "]"

		if path_data.locked then
			retval = retval ..
				"button[6.5,8.5;1.5,0.5;btn_unlock_path;unlock]"
		else
			retval = retval ..
				"button[6.5,8.5;1.5,0.5;btn_lock_path;lock]"
		end

		retval = retval ..
			"button[8,8.5;2,0.5;btn_show_points;show points]" ..
			"button[10,8.5;2,0.5;btn_delete_path;delete path]"
	end

	return retval
end

local function handle_settings_buttons(self, fields, tabname, tabdata)

	if fields["btn_give_pathmarker"] then
		local player = core.get_player_by_name(tabdata.playername)

		if not player then
			return true
		end
		player:get_inventory():add_item("main", "mobf:path_marker 1")
		return true
	end

	if fields["tbl_pathlist"] then
		local event = core.explode_table_event(fields["tbl_pathlist"])

		if event.type == "CHG" then
			tabdata.selected_entry = event.row
		end

		return true;
	end

	if fields["btn_lock_path"] or fields["btn_unlock_path"] then
		local all_paths = mobf_path.get_pathlist(tabdata.playername,tabdata.is_admin)
		local selected_path = all_paths[tabdata.selected_entry]

		if selected_path == nil then
			return true
		end

		local path_data = mobf_rtd.path_data.users
				[selected_path.ownername].paths[selected_path.pathname]

		if path_data == nil then
			return true
		end

		if fields["btn_unlock_path"] then
			path_data.locked = false
		else
			path_data.locked = true
		end
		mobf_path.save()
		return true
	end

	if fields["btn_show_points"] then
		local all_paths = mobf_path.get_pathlist(tabdata.playername,tabdata.is_admin)
		local selected_path = all_paths[tabdata.selected_entry]

		if selected_path == nil then
			return true
		end

		mobf_path.show_pathmarkers(selected_path.ownername,selected_path.pathname)
		return true
	end

	if fields["btn_delete_path"] then
		local all_paths = mobf_path.get_pathlist(tabdata.playername,tabdata.is_admin)
		local selected_path = all_paths[tabdata.selected_entry]

		if selected_path == nil then
			return true
		end

		--TODO add confirmation dialog
		mobf_path.delete_path(selected_path.ownername,selected_path.pathname)
		return true
	end

	return false
end

mobf_settings_tab_paths = {
	name = "paths",
	caption = fgettext("Paths"),
	cbf_formspec = get_formspec,
	cbf_button_handler = handle_settings_buttons,
	tabsize = {width=12,height=9}
	}