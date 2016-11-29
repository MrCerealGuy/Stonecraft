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

	local tablehead = "Mobtype,Reason,Owner,"

	local content = ""

	for n=1,#mobf.current_preserve_list, 1 do
		if mobf.current_preserve_list[n].owner == tabdata.playername or
			tabdata.is_admin then
			content = content ..
				mobf.current_preserve_list[n].modname .. ":" ..
				mobf.current_preserve_list[n].name .. "," ..
				mobf.current_preserve_list[n].reason .. "," ..
				mobf.current_preserve_list[n].owner

			if n ~= #mobf.current_preserve_list then
				content = content .. ","
			end
		end
	end

	local retval =
		"tablecolumns[text,width=16;text,width=25;text,width=6]" ..
		"table[0.25,0.25;11.25,8;tbl_lost_and_found;" .. tablehead .. content .. ";"
				.. tabdata.selected_entry .. "]"

	if tabdata.selected_entry ~= 0 then

		retval = retval ..
			"button[0.25,8.5;3.75,0.5;btn_restore_mob;" .. fgettext("Take") .. "]"
	end

	return retval
end

local function handle_settings_buttons(self, fields, tabname, tabdata)

	if fields["tbl_lost_and_found"] then

		local event = core.explode_table_event(fields["tbl_lost_and_found"])

		if event.type == "CHG" then
			tabdata.selected_entry = event.row
		end

		return true;
	end

	if fields["btn_restore_mob"] then

		local elementcount = 0
		local player = core.get_player_by_name(tabdata.playername)

		if not player then
			return true
		end

		for i=1,#mobf.current_preserve_list,1 do
			mobf_assert_backtrace(tabdata ~= nil)
			mobf_assert_backtrace(mobf.current_preserve_list[i] ~= nil)

			if mobf.current_preserve_list[i].owner == tabdata.playername or
				tabdata.isadmin then
				elementcount = elementcount +1
			end

			if elementcount == (tabdata.selected_entry-1) then
				--ADD to inventory
				local inventory_add_result = player:get_inventory():add_item("main",
						mobf.current_preserve_list[i].modname ..":"..
						mobf.current_preserve_list[i].name.." 1")

				--remove from list
				if inventory_add_result:is_empty() then
					table.remove(mobf.current_preserve_list,i)
					mobf_set_world_setting("mobf_preserve_mobs",
							core.serialize(mobf.current_preserve_list))
				end
				return true
			end
		end

		return true
	end


	return false
end

mobf_settings_tab_preserve = {
	name = "preserve",
	caption = fgettext("Lost mobs"),
	cbf_formspec = get_formspec,
	cbf_button_handler = handle_settings_buttons,
	tabsize = {width=12,height=9}
	}