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

local function get_formspec(tabview, name, tabdata)

	if not tabdata.is_admin then
		return "label[0.75,0.25;" ..
		fgettext("Insufficient permissions to view this tab.")
		.. "]"
	end
	
	local retval = ""
	
	if tabdata.lastselected ~= nil then
		local mobdef = minetest.registered_entities[tabdata.lastselected]
		
		if mobdef ~= nil and mobdef.data ~= nil then
		
			retval = retval ..
				"label[2.25,0.25;Name:]label[4,0.25;" .. mobdef.data.name .. "]" ..
				"label[2.25,0.75;Mod:]label[4,0.75;" .. mobdef.data.modname .. "]" ..
				"label[2.25,1.25;Description:]label[4,1.25;" .. mobdef.data.generic.description .. "]" ..
				"image[0.25,0.25;2,2;" .. mobdef.data.modname  .. "_" .. mobdef.data.name .. "_item.png]"
		end
	end

	retval = retval ..
			"label[0.5,2;Mobs:]"
			.. "label[0.5,8.5;doubleclick to change!]"
			.. "label[4,8.5;green=enabled, red=disabled]"
			.. "textlist[0.5,2.5;7,6;tl_mobs_moblist;"

	local mobf_mob_blacklist_string = minetest.world_setting_get("mobf_blacklist")
	local mobf_mobs_blacklisted = nil
	if mobf_mob_blacklist_string ~= nil then
		mobf_mobs_blacklisted = core.deserialize(mobf_mob_blacklist_string)
	end

	local toadd = ""

	for i,val in ipairs(mobf_rtd.registred_mob) do
		if toadd ~= "" then
			toadd = toadd .. ","
		end
		if contains(mobf_mobs_blacklisted,val) then
			toadd = toadd .. COLOR_RED .. val
		else
			toadd = toadd .. COLOR_GREEN .. val
		end
	end

	retval = retval .. toadd .. ";]"
	return retval
end

local function handle_settings_buttons(self, fields, tabname, tabdata)

	if not tabdata.is_admin then
		core.log("error", "MOBF_Settings: someone managed to press a button " ..
			"she/he shouldn't even see!")
		return false
	end

	if fields["tl_mobs_moblist"] then
		local tl_event = core.explode_textlist_event(fields["tl_mobs_moblist"])
		if tl_event.type == "DCL" and
			tl_event.index <= #mobf_rtd.registred_mob then
			local clicked_mob = mobf_rtd.registred_mob[tl_event.index]

			local mobf_mob_blacklist_string = minetest.world_setting_get("mobf_blacklist")
			local mobf_mobs_blacklisted = nil
			if mobf_mob_blacklist_string ~= nil then
				mobf_mobs_blacklisted = core.deserialize(mobf_mob_blacklist_string)
			else
				mobf_mobs_blacklisted = {}
			end

			local new_blacklist = {}

			if contains(mobf_mobs_blacklisted,clicked_mob) then
				for i=1,#mobf_mobs_blacklisted,1 do
					if mobf_mobs_blacklisted[i] ~= clicked_mob then
						table.insert(new_blacklist,mobf_mobs_blacklisted[i])
					end
				end
			else
				new_blacklist = mobf_mobs_blacklisted
				table.insert(mobf_mobs_blacklisted,clicked_mob)
			end

			minetest.world_setting_set("mobf_blacklist",core.serialize(new_blacklist))
		end
		
		if tl_event.type == "CHG" and
			tl_event.index <= #mobf_rtd.registred_mob then
			tabdata.lastselected = mobf_rtd.registred_mob[tl_event.index]
		end
		return true
	end

	return false
end

mobf_settings_tab_mobs = {
	name = "mobs",
	caption = fgettext("Mobs"),
	cbf_formspec = get_formspec,
	cbf_button_handler = handle_settings_buttons
	}