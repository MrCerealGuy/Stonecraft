--------------------------------------------------------------------------------
-- Mob Framework Settings Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file tab_info.lua
--! @brief settings gui for mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------
local function get_formspec(tabview, name, tabdata)

	local adv_stats    = nil
	if mobf_rtd.have_adv_spawning then
		adv_stats = adv_spawning.get_statistics()
	end
	local mobs_offline = spawning.total_offline_mobs()
	local statistics   = mobf_get_statistics()

	local retval =
		"label[0.75,1.25;Timesource:]" ..
		"label[2.75,1.25;" .. mobf_fixed_size_string(mobf_rtd.timesource,30) .. "]"
		
		
	if mobf_rtd.have_adv_spawning then
		retval = retval ..
			"label[0.75,2.25;Mobs spawned by adv_spawning this session:]" ..
			"label[6,2.25;" .. string.format("%10d",adv_stats.session.entities_created) .. "]"
	end
	retval = retval ..
		mobf_settings.printfac("Type",{current="cur count",maxabs="",max="max count"},3,"%s") ..
		"box[0.75,3.5;6.75,0.05;#FFFFFF]" ..
		mobf_settings.printfac("Active mobs",statistics.data.mobs,3.5,"%6d") ..
		mobf_settings.printfac("Offline mobs",{current=mobs_offline,maxabs="",max=-1},4,"%6d") ..
		mobf_settings.printfac("Jobs in queue",statistics.data.queue,4.5,"%6d") ..
		"label[0.75,6.0;Daytime:]" ..
		"label[2.5,6.0;" .. string.format("%5d",minetest.get_timeofday()*24000) .. "]"

	return retval
end

-------------------------------------------------------------------------------
mobf_settings_tab_info_sub = {
	name = "info",
	caption = fgettext("Generic"),
	cbf_formspec = get_formspec
	}
	
---------------------------------------------------------------------------------
local function get_formspec(tabview, name, tabdata)
	local adv_stats  = nil
	if mobf_rtd.have_adv_spawning then
		adv_stats = adv_spawning.get_statistics()
	end
	local statistics = mobf_get_statistics()

	local retval =
		mobf_settings.printfac("Facility",
			{
				current = "Current",
				maxabs  = "Abs.Max (ms)",
				max     = "Maximum"
			},
			"0.5","%s") ..
		"box[0.75,1;6.75,0.05;#FFFFFF]" ..
		mobf_settings.printfac("Total",          statistics.data.total,       "1", "%2.2f%%") ..
		mobf_settings.printfac("Onstep",         statistics.data.onstep,      "1.5",   "%2.2f%%") ..
		mobf_settings.printfac("Job processing", statistics.data.queue_load,  "2", "%2.2f%%") ..
		mobf_settings.printfac("ABM",            statistics.data.abm,         "2.5",   "%.2f%%") ..
		mobf_settings.printfac("MapGen",         statistics.data.mapgen,      "3", "%2.2f%%") ..
		mobf_settings.printfac("Spawn onstep",   statistics.data.spawn_onstep,"3.5",   "%2.2f%%") ..
		mobf_settings.printfac("Activate",       statistics.data.activate,    "4", "%2.2f%%") ..
		mobf_settings.printfac("User 1",         statistics.data.user_1,      "7", "%2.2f%%") ..
		mobf_settings.printfac("User 2",         statistics.data.user_2,      "7.5",   "%2.2f%%") ..
		mobf_settings.printfac("User 3",         statistics.data.user_3,      "8", "%2.2f%%")
		
	if mobf_rtd.have_adv_spawning then
		retval = retval ..
			mobf_settings.printfac("Adv.Spawning",
				{
					current = adv_stats.load.cur,
					maxabs  = adv_stats.step.max,
					max     = adv_stats.load.max
				},
				"4.5","%2.2f%%")
	end

	return retval
end

-------------------------------------------------------------------------------
mobf_settings_tab_statistics = {
	name = "statistics",
	caption = fgettext("Statistics"),
	cbf_formspec = get_formspec
	}
	
-------------------------------------------------------------------------------
local function init_tab(type, from, to, tabview)
	if (to == "info_top") then
		local tabdata = tabview:get_tabdata("info_top")
		assert(tabdata ~= nil)
		
		if tabdata.subtabview == nil then
			tabdata.subtabview = tabview_create("infoview",
				{x=8,y=8},{x=0,y=0.75}, tabview.parent_ui)
			tabdata.subtabview:add(mobf_settings_tab_info_sub)
			if core.world_setting_get("mobf_enable_statistics") then
				tabdata.subtabview:add(mobf_settings_tab_statistics)
			end
			tabdata.subtabview:set_parent(tabview)
		end
		tabdata.subtabview:show()
	elseif (from == "info_top") then
		local tabdata = tabview:get_tabdata("info_top")
		assert(tabdata ~= nil)
		if tabdata.subtabview ~= nil then
			tabdata.subtabview:hide()
		end
	end
end

-------------------------------------------------------------------------------
local function get_formspec_tab(tabview, name, tabdata)
	return ""
end

-------------------------------------------------------------------------------
local function btn_handler_tab(tabview, fields, tabname, tabdata)
	return false
end

-------------------------------------------------------------------------------
mobf_settings_tab_info = {
	name = "info_top",
	caption = fgettext("Info"),
	cbf_button_handler = btn_handler_tab,
	cbf_formspec       = get_formspec_tab,
	on_change          = init_tab
}