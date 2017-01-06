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
	local ypos = 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_disable_animal_spawning;" ..
				"Disable mob spawning;" ..
				mobf_settings.setting_gettext("mobf_disable_animal_spawning") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_disable_3d_mode;" ..
				"Disable 3D mobs;" ..
				mobf_settings.setting_gettext("mobf_disable_3d_mode") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_animal_spawning_secondary;" ..
				"Enable secondary spawning;" ..
				mobf_settings.setting_gettext("mobf_animal_spawning_secondary") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_delete_disabled_mobs;" ..
				"Delete disabled mobs+spawners;" ..
				mobf_settings.setting_gettext("mobf_delete_disabled_mobs") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_log_bug_warnings;" ..
				"Log MOBF bug warnings;" ..
				mobf_settings.setting_gettext("mobf_log_bug_warnings") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_vombie_3d_burn_animation_enabled;" ..
				"Vombie 3D burn animation;" ..
				mobf_settings.setting_gettext("vombie_3d_burn_animation_enabled") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_log_removed_entities;" ..
				"Log all removed mobs;" ..
				mobf_settings.setting_gettext("mobf_log_removed_entities") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_grief_protection;" ..
				"Enable grief protection;" ..
				mobf_settings.setting_gettext("mobf_grief_protection") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_lifebar;" ..
				"Show mob lifebar;" ..
				mobf_settings.setting_gettext("mobf_lifebar") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_enable_statistics;" ..
				"Enable statistics;" ..
				mobf_settings.setting_gettext("mobf_enable_statistics") .."]"
	ypos = ypos + 0.5

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_disable_pathfinding;" ..
				"Disable core pathfinding support;" ..
				mobf_settings.setting_gettext("mobf_disable_pathfinding") .."]"
	ypos = ypos + 0.5

	local showspawner = core.setting_get("adv_spawning.debug")
	local spawner_setting_text = "false"
	if (showspawner) then
		spawner_setting_text = "true"
	end

	retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_features_show_spawners;" ..
				"Show spawner entities;" .. spawner_setting_text .."]"
	ypos = ypos + 0.5
	
		retval = retval .. "checkbox[1," .. ypos .. ";" ..
				"cb_adv_spawning_refresh_spawners;" ..
				"Refresh spawners (spawn mobs in old maps);" ..
				(core.setting_get("adv_spawning_validate_spawners") or "false") .."]"
	ypos = ypos + 0.5
	
	

	return retval
end

local function handle_settings_buttons(self, fields, tabname, tabdata)

	if not tabdata.is_admin then
		core.log("error", "MOBF_Settings: someone managed to press a button " ..
			"she/he shouldn't even see!")
		return false
	end

	if fields["cb_features_disable_animal_spawning"] then
		mobf_set_world_setting("mobf_disable_animal_spawning",
				core.is_yes(fields["cb_features_disable_animal_spawning"]))
		return true
	end

	if fields["cb_features_disable_3d_mode"] then
		mobf_set_world_setting("mobf_disable_3d_mode",
				core.is_yes(fields["cb_features_disable_3d_mode"]))
		return true
	end

	if fields["cb_features_animal_spawning_secondary"] then
		mobf_set_world_setting("mobf_animal_spawning_secondary",
				core.is_yes(fields["cb_features_animal_spawning_secondary"]))
		return true
	end

	if fields["cb_features_delete_disabled_mobs"] then
		mobf_set_world_setting("mobf_delete_disabled_mobs",
				core.is_yes(fields["cb_features_delete_disabled_mobs"]))
		return true
	end

	if fields["cb_features_log_bug_warnings"] then
		mobf_set_world_setting("mobf_log_bug_warnings",
				core.is_yes(fields["cb_features_log_bug_warnings"]))
		return true
	end

	if fields["cb_features_vombie_3d_burn_animation_enabled"] then
		mobf_set_world_setting("vombie_3d_burn_animation_enabled",
				core.is_yes(fields["cb_features_vombie_3d_burn_animation_enabled"]))
		return true
	end

	if fields["cb_features_log_removed_entities"] then
		mobf_set_world_setting("mobf_log_removed_entities",
				core.is_yes(fields["cb_features_log_removed_entities"]))
		return true
	end

	if fields["cb_features_grief_protection"] then
		mobf_set_world_setting("mobf_grief_protection",
				core.is_yes(fields["cb_features_grief_protection"]))
		return true
	end

	if fields["cb_features_lifebar"] then
		mobf_set_world_setting("mobf_lifebar",
				core.is_yes(fields["cb_features_lifebar"]))
		return true
	end

	if fields["cb_features_enable_statistics"] then
		mobf_set_world_setting("mobf_enable_statistics",
				core.is_yes(fields["cb_features_enable_statistics"]))
		return true
	end

	if fields["cb_features_delayed_spawning"] then
		mobf_set_world_setting("mobf_delayed_spawning",
				core.is_yes(fields["cb_features_delayed_spawning"]))
		return true
	end

	if fields["cb_features_disable_pathfinding"] then
		mobf_set_world_setting("mobf_disable_pathfinding",
				core.is_yes(fields["cb_features_disable_pathfinding"]))
		return true
	end

	if fields["cb_features_show_spawners"] then
		core.setting_set("adv_spawning.debug",
			fields["cb_features_show_spawners"])
		return true
	end
	
	if fields["cb_adv_spawning_refresh_spawners"] then
		core.setting_set("adv_spawning_validate_spawners",
			fields["cb_adv_spawning_refresh_spawners"])
		return true
	end

	return false
end

mobf_settings_tab_features = {
	name = "features",
	caption = fgettext("Features"),
	cbf_formspec = get_formspec,
	cbf_button_handler = handle_settings_buttons
	}