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

	if tabdata.available_factions_selected == nil then
		tabdata.available_factions_selected = 0
	end

	if tabdata.faction_reputation_selected == nil then
		tabdata.faction_reputation_selected = 0
	end

	local retval = ""
	retval = retval ..
		"label[0.25,-0.25;Available factions:]" ..
		"textlist[0.25,0.25;3.5,7.5;tl_factions_available_factions;"

	local factionlist = factions.get_faction_list()

	local first_element = true
	if #factionlist ~= 0 then
		for i=1,#factionlist,1 do
			if not first_element then
				retval = retval .. ","
			else
				first_element = false
			end
			retval = retval .. factionlist[i]
		end
	else
		retval = retval .. "no factions available"
	end

	retval = retval .. ";" .. tabdata.available_factions_selected .. "]"

	if tabdata.is_admin then
		retval = retval ..
			"button[0.25,8;3.75,0.5;btn_factions_delete;Delete]" ..
			"field[4.3,0.75;4,0.5;te_factionname;New Faction;]" ..
			"button[4,1.25;4,0.25;btn_factions_create;Create]"
	end

	if core.check_player_privs(tabdata.playername, {faction_admin=true}) or
		core.check_player_privs(tabdata.playername, {faction_user=true})
		or tabdata.playername == "singleplayer" then
		retval = retval ..
			"field[4.3,2.75;4,0.5;te_inviteename;Playername:;]" ..
			"button[4,3.25;4,0.25;btn_factions_invite;Invite]"
	end


	local selected_rep = ""
	retval = retval ..
		"label[4,3.75;Base reputation:]" ..
		"textlist[4,4.25;3.75,3.5;tl_factions_faction_reputation;"

	if tabdata.available_factions_selected > 0 and
		tabdata.available_factions_selected <= #factionlist then
		local first_rep = true
		for i=1,#factionlist,1 do
			local current_rep = factions.get_base_reputation(
					factionlist[i],
					factionlist[tabdata.available_factions_selected])

			if not first_rep then
				retval = retval .. ","
			else
				first_rep = false
			end
			if tonumber(current_rep) > 0 then
				retval = retval .. COLOR_GREEN
			elseif tonumber(current_rep) < 0 then
				retval = retval .. COLOR_RED
			end
			retval = retval .. "(" .. current_rep .. ") " .. factionlist[i]
		end

		if tabdata.faction_reputation_selected > 0 and
			tabdata.faction_reputation_selected <= #factionlist then
			selected_rep = factions.get_base_reputation(
					factionlist[tabdata.faction_reputation_selected],
					factionlist[tabdata.available_factions_selected])
		end
	end

	retval = retval ..
		";" .. tabdata.faction_reputation_selected .."]" ..
		"label[4,7.9;New Baserep:]" ..
		"field[6.2,8.3;1.1,0.5;te_baserep;;" .. selected_rep .."]" ..
		"button[6.9,8;1,0.5;btn_factions_set_reputation;set]"

	if tabdata.errormessage then
		retval = retval ..
			"label[0.25,8.5;" .. tabdata.errormessage .. "]"
	end

	return retval
end

local function handle_settings_buttons(self, fields, tabname, tabdata)

	if not tabdata.is_admin then
		core.log("error", "MOBF_Settings: someone managed to press a button " ..
			"she/he shouldn't even see!")
	end

	if fields["btn_factions_delete"] then
		tabdata.errormessage = "delete faction is not implemented yet"
		return true
	end

	if fields["btn_factions_create"] then
		if fields["te_factionname"] ~= nil then
			if fields["te_factionname"] == "" then
				tabdata.errormessage ="Refusing to create faction with no name!"
			elseif not factions.exists(fields["te_factionname"]) then
				if not factions.add_faction(fields["te_factionname"]) then
					tabdata.errormessage = "Failed to add faction \""
						.. fields["te_factionname"] .. "\""
				else
					local player = minetest.get_player_by_name(tabdata.playername)
					if not player or not factions.member_add(
							fields["te_factionname"], player) then
						tabdata.errormessage = "Unable to add creator to faction!"
					elseif not factions.set_admin(
							fields["te_factionname"],
							tabdata.playername, true) then
						tabdata.errormessage = "Unable to give admin privileges to creator!"
					end
				end
			else
				tabdata.errormessage = "Faction \""
					.. sender_data.fields["te_factionname"] .. "\" already exists"
			end
		end
		return true
	end

	if fields["btn_factions_invite"] then
		--get faction from faction list
		local factionlist = factions.get_faction_list()
		if tabdata.available_factions_selected > 0 and
			tabdata.available_factions_selected < #factionlist then

			local faction_to_invite = factionlist[tabdata.available_factions_selected]

			--check if player is in faction he wants to invite for
			--TODO privs check
			if factions.is_admin(faction_to_invite, tabdata.playername) or
				factions.is_free(faction_to_invite) then
				if fields["te_inviteename"] ~= nil and
					fields["te_inviteename"] ~= "" then
						factions.member_invite(faction_to_invite,fields["te_inviteename"])
				else
					tabdata.errormessage = "You can't invite nobody!"
				end
			else
				tabdata.errormessage = "Not allowed to invite for faction " .. faction_to_invite
			end
		else
			tabdata.errormessage = "No faction selected to invite to"
		end
		return true
	end

	if fields["btn_factions_set_reputation"] then
		if tabdata.available_factions_selected ==
			tabdata.faction_reputation_selected then
			tabdata.errormessage = "Can't set base reputation of faction to itself!"
		else
			local factionlist = factions.get_faction_list()
			local faction1 = factionlist[tabdata.available_factions_selected]
			local faction2 = factionlist[tabdata.faction_reputation_selected]

			if faction1 ~= nil and faction2 ~= nil and
				fields["te_baserep"] ~= nil and
				fields["te_baserep"] ~= "" then
				if not factions.set_base_reputation(faction1, faction2,
						fields["te_baserep"]) then
					tabdata.errormessage = "Failed to set base reputation"
				end
			else
				tabdata.errormessage = "Only one faction selected or no value given!"
			end
		end
		return true
	end

	if fields["tl_factions_available_factions"] then
		local event = core.explode_textlist_event(
			fields["tl_factions_available_factions"])

		if event.typ ~= "INV" then
			tabdata.available_factions_selected = event.index
		end
		return true
	end

	if fields["tl_factions_faction_reputation"] then
		local event = core.explode_textlist_event(
				fields["tl_factions_faction_reputation"])

		if event.typ ~= "INV" then
			tabdata.faction_reputation_selected = event.index
		end
		return true
	end

	return false
end

mobf_settings_tab_factions = {
	name = "factions",
	caption = fgettext("Factions"),
	cbf_formspec = get_formspec,
	cbf_button_handler = handle_settings_buttons
	}