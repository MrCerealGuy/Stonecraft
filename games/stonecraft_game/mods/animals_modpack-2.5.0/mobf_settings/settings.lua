--------------------------------------------------------------------------------
-- Mob Framework Settings Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file settings_v3.lua
--! @brief settings gui for mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
--------------------------------------------------------------------------------

--!version
local mobf_settings_version = "1.9.0"

--!path of mod
local modpath = minetest.get_modpath("mobf_settings")

--!basepath of tools
--TODO remove included fstk once minetest is updated
--local basepath = core.get_builtin_path()
local basepath = modpath

--!unique id of ui
local unique_id = "mobf_settings"

dofile(basepath .. DIR_DELIM .. "fstk" .. DIR_DELIM .. "dialog.lua")
dofile(basepath .. DIR_DELIM .. "fstk" .. DIR_DELIM .. "tabview.lua")
dofile(basepath .. DIR_DELIM .. "fstk" .. DIR_DELIM .. "ui_mod.lua")

dofile(modpath .. DIR_DELIM .. "common.lua")
dofile(modpath .. DIR_DELIM .. "tab_main.lua")
dofile(modpath .. DIR_DELIM .. "tab_info.lua")
dofile(modpath .. DIR_DELIM .. "tab_feature_config.lua")
dofile(modpath .. DIR_DELIM .. "tab_factions.lua")
dofile(modpath .. DIR_DELIM .. "tab_mobs.lua")
dofile(modpath .. DIR_DELIM .. "tab_restore_mobs.lua")
dofile(modpath .. DIR_DELIM .. "tab_path_manager.lua")


local function is_admin(playername)
	local privcheck = core.check_player_privs(playername, {mobfw_admin=true})

	return privcheck or (playername == "singleplayer")
end

--------------------------------------------------------------------------------
local function init_player_ui(playername, param)

	local playerui = get_ui_by_unique_id(playername, unique_id)

	if not playerui then
		playerui = create_ui(playername, unique_id)

		assert( playerui ~= nil)

		local tv_main = tabview_create("mainview",{x=8,y=9},{x=0,y=0}, playerui)

		tv_main:add(mobf_settings_tab_main)

		if is_admin(playername) then
			tv_main:add(mobf_settings_tab_features, { is_admin=is_admin(playername) })
			tv_main:add(mobf_settings_tab_mobs, { is_admin=is_admin(playername) })
		end

		tv_main:add(mobf_settings_tab_info)

		if mobf_rtd.factions_available then
			tv_main:add(mobf_settings_tab_factions,
				{
					is_admin   = is_admin(playername),
					playername = playername
				})
		end

		tv_main:add(mobf_settings_tab_preserve,
				{
					is_admin   = is_admin(playername),
					playername = playername
				})

		tv_main:add(mobf_settings_tab_paths,
				{
					is_admin   = is_admin(playername),
					playername = playername
				})
	end

	playerui:hide()

	local main_tab = playerui:find_by_name("mainview")

	if not main_tab then
		return
	end

	main_tab:show()
	playerui:update()
end

--------------------------------------------------------------------------------
minetest.register_chatcommand("mobf",
	{
		params		= "",
		description = "show mobf settings" ,
		privs		= {},
		func		= init_player_ui
	})
minetest.log("action","MOD: mobf_settings mod           version "..mobf_settings_version.." loaded")