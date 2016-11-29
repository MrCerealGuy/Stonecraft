--------------------------------------------------------------------------------
-- Mob Framework Settings Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file tab_main.lua
--! @brief settings gui for mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
--------------------------------------------------------------------------------

local function get_formspec_cheat_leftclick(tabview, name, tabdata)
	return
		"box[0.25,2.90;7.25,6.05;#000000]" ..
		"label[0.5,3.2;"  .. fgettext("target: own mob,") .. "]" ..
		"label[3,3.2;"    .. fgettext("wielditem: hand") .. "]" ..
		"label[0.75,3.5;"   .. fgettext("-->rotate mob by 45°") .. "]" ..
		"label[0.5,4;"  .. fgettext("target: own mob,") .. "]" ..
		"label[3,4;"    .. fgettext("wielditem: various weapons") .. "]" ..
		"label[0.75,4.3;" .. fgettext("-->attack") .. "]" ..
		"label[0.5,4.8;"  .. fgettext("target: any mob,") .. "]" ..
		"label[3,4.8;"    .. fgettext("wielditem: catching (net/lasso/...)") .. "]" ..
		"label[0.75,5.1;" .. fgettext("-->catch") .."]" ..
		"label[0.5,5.6;"  .. fgettext("target: (small) barn,") .. "]" ..
		"label[3,5.6;"    .. fgettext("wielditem: grass/leaves") .. "]" ..
		"label[0.75,5.9;" .. fgettext("-->fill barn for breeding") .. "]" ..
		"label[0.5,6.4;"  .. fgettext("target: (small) barn,") .. "]" ..
		"label[3,6.4;"    .. fgettext("wielditem: hand/tool") .. "]" ..
		"label[0.75,6.7;" .. fgettext("-->take barn") .. "]" ..
		"label[0.5,7.2;"  .. fgettext("target: mob,") .. "]" ..
		"label[3,7.2;"    .. fgettext("wielditem: harvest-tool") .. "]" ..
		"label[0.75,7.5;"   .. fgettext("-->harvest e.g. gather wool or milk") .. "]" ..
		"label[0.5,8;"  .. fgettext("target: ridable mob,") .. "]" ..
		"label[3,8;"    .. fgettext("wielditem: saddle (mob specific)") .. "]" ..
		"label[0.75,8.3;" .. fgettext("--> mount a mob to ride") .. "]"
end

local function get_formspec_cheat_rightclick(tabview, name, tabdata)
	return
		"box[0.25,2.90;7.25,6.05;#000000]" ..
		"label[0.5,3.2;"  .. fgettext("Rightclicking a mob opens a mob specific rightclick menu,") .. "]" ..
		"label[0.5,3.5;"    .. fgettext("following menu elements are possible:") .. "]" ..
		"label[0.5,4;"  .. fgettext("Show debuginfo") .. "]" ..
		"label[0.75,4.3;" .. fgettext("print debuginfo about this mob to console") .. "]" ..
		"label[0.5,4.8;"  .. fgettext("Select path") .. "]" ..
		"label[0.75,5.1;" .. fgettext("Select a path to put mob in guard mode") .. "]" ..
		"label[0.5,5.6;"  .. fgettext("Factions") .. "]" ..
		"label[0.75,5.9;" .. fgettext("configure factions for this mob") .. "]" ..
		"label[0.5,6.4;"  .. fgettext("heal / nothing to heal(full health)") .. "]" ..
		"label[0.75,6.7;" .. fgettext("heal mob using the currently wielded food") .. "]" ..
		"label[0.5,7.2;"  .. fgettext("Trade") .. "]" ..
		"label[0.75,7.5;"   .. fgettext("open trade inventory") .. "]"
end

local function get_formspec_cheat_mixed(tabview, name, tabdata)

	return "box[0.25,2.90;7.25,6.05;#000000]" ..
		"label[0.5,3.2;"  .. fgettext("Missing mobs") .. "]" ..
		"label[0.75,3.5;"   .. fgettext("Case you're missing any of your mobs have a look at") .. "]" ..
		"label[0.75,3.8;" .. fgettext("\"Lost mobs\" in control panel, they may be preserved") .. "]" ..
		"label[0.5,4.3;"  .. fgettext("Path configuration for guard mode") .. "]" ..
		"label[0.75,4.6;"  .. fgettext("See \"Paths\" in control panel") .. "]"
end


local mobf_settings_tab_cheat_leftclick = {
	name = "cheat_left",
	caption = fgettext("Left click"),
	cbf_formspec = get_formspec_cheat_leftclick
	}
	
local mobf_settings_tab_cheat_rightclick = {
	name = "cheat_left",
	caption = fgettext("Right click"),
	cbf_formspec = get_formspec_cheat_rightclick
	}
	
local mobf_settings_tab_cheat_mixed = {
	name = "cheat_mixed",
	caption = fgettext("Other"),
	cbf_formspec = get_formspec_cheat_mixed
	}

-------------------------------------------------------------------------------
local function init_tab(type, from, to, tabview)
	if (to == "main") then
		local tabdata = tabview:get_tabdata("main")
		assert(tabdata ~= nil)
		
		if tabdata.subtabview == nil then
			tabdata.subtabview = tabview_create("cheatsheets",
				{x=8,y=8},{x=0.5,y=3.25}, tabview.parent_ui)
			tabdata.subtabview:add(mobf_settings_tab_cheat_leftclick)
			tabdata.subtabview:add(mobf_settings_tab_cheat_rightclick)
			tabdata.subtabview:add(mobf_settings_tab_cheat_mixed)
			tabdata.subtabview:set_parent(tabview)
		end
		tabdata.subtabview:show()
	elseif (from == "main") then
		local tabdata = tabview:get_tabdata("main")
		assert(tabdata ~= nil)
		if tabdata.subtabview ~= nil then
			tabdata.subtabview:hide()
		end
	end
end

local function get_formspec(tabview, name, tabdata)

	local retval = ""
	
	retval = retval ..
		"label[0.25,0.25;" .. fgettext("Mob Framework") .. "]" ..
		"label[0.25,0.4;" .. "-------------------------" .. "]" ..
		"label[0.25,0.8;" .. fgettext("You're at mobf control panel various settings and tweeks") .. "]" ..
		"label[0.25,1.1;" .. fgettext("can be controled in here. Some options require \"mobf_admin\"") .."]" ..
		"label[0.25,1.4;" .. fgettext("privilege to be visible.") .. "]" ..
		"label[0.25,8.9;" .. fgettext("For more help see: http://github.com/sapier/animals_modpack") .."]"
		
	return retval
end

mobf_settings_tab_main = {
	name = "main",
	caption = fgettext("Main"),
	cbf_formspec = get_formspec,
	on_change = init_tab
	}