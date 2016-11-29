--Minetest
--Copyright (C) 2014 sapier
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

2016-06-21 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed game_button_bar
	removed core.set_topleft_text(game.name)

--]]

local function current_game()
	local last_game_id = core.setting_get("menu_last_game")
	local game, index = gamemgr.find_by_gameid(last_game_id)
	
	return game
end

local function singleplayer_refresh_gamebar()
	local function game_buttonbar_button_handler(fields)
		for key,value in pairs(fields) do
			for j=1,#gamemgr.games,1 do
				if ("game_btnbar_" .. gamemgr.games[j].id == key) then
					mm_texture.update("singleplayer", gamemgr.games[j])
					core.set_topleft_text(gamemgr.games[j].name)
					core.setting_set("menu_last_game",gamemgr.games[j].id)
					menudata.worldlist:set_filtercriteria(gamemgr.games[j].id)
					local index = filterlist.get_current_index(menudata.worldlist,
						tonumber(core.setting_get("mainmenu_last_selected_world")))
					if not index or index < 1 then
						local selected = core.get_textlist_index("sp_worlds")
						if selected ~= nil and selected < #menudata.worldlist:get_list() then
							index = selected
						else
							index = #menudata.worldlist:get_list()
						end
					end
					menu_worldmt_legacy(index)
					return true
				end
			end
		end
	end	
end

local function get_formspec(tabview, name, tabdata)
	local retval = ""

	local index = filterlist.get_current_index(menudata.worldlist,
				tonumber(core.setting_get("mainmenu_last_selected_world"))
				)

	retval = retval ..
			"button[4,4.15;2.6,0.5;world_delete;".. fgettext("Delete") .. "]" ..
			"button[6.5,4.15;2.8,0.5;world_create;".. fgettext("New") .. "]" ..
			"button[9.2,4.15;2.55,0.5;world_configure;".. fgettext("Configure") .. "]" ..
			"button[8.5,4.95;3.25,0.5;play;".. fgettext("Play") .. "]" ..
			"label[4,-0.25;".. fgettext("Select World:") .. "]"..
			"checkbox[0.25,0.25;cb_creative_mode;".. fgettext("Creative Mode") .. ";" ..
			dump(core.setting_getbool("creative_mode")) .. "]"..
			"checkbox[0.25,0.7;cb_enable_damage;".. fgettext("Enable Damage") .. ";" ..
			dump(core.setting_getbool("enable_damage")) .. "]"..
			"textlist[4,0.25;7.5,3.7;sp_worlds;" ..
			menu_render_worldlist() ..
			";" .. index .. "]"
	return retval
end

local function main_button_handler(this, fields, name, tabdata)

	assert(name == "singleplayer")

	local world_doubleclick = false

	if fields["sp_worlds"] ~= nil then
		local event = core.explode_textlist_event(fields["sp_worlds"])
		local selected = core.get_textlist_index("sp_worlds")

		menu_worldmt_legacy(selected)

		if event.type == "DCL" then
			world_doubleclick = true
		end

		if event.type == "CHG" and selected ~= nil then
			core.setting_set("mainmenu_last_selected_world",
				menudata.worldlist:get_raw_index(selected))
			return true
		end
	end

	if menu_handle_key_up_down(fields,"sp_worlds","mainmenu_last_selected_world") then
		return true
	end

	if fields["cb_creative_mode"] then
		core.setting_set("creative_mode", fields["cb_creative_mode"])
		local selected = core.get_textlist_index("sp_worlds")
		menu_worldmt(selected, "creative_mode", fields["cb_creative_mode"])

		return true
	end

	if fields["cb_enable_damage"] then
		core.setting_set("enable_damage", fields["cb_enable_damage"])
		local selected = core.get_textlist_index("sp_worlds")
		menu_worldmt(selected, "enable_damage", fields["cb_enable_damage"])

		return true
	end

	if fields["play"] ~= nil or
		world_doubleclick or
		fields["key_enter"] then
		local selected = core.get_textlist_index("sp_worlds")
		gamedata.selected_world = menudata.worldlist:get_raw_index(selected)
		
		if selected ~= nil and gamedata.selected_world ~= 0 then
			gamedata.singleplayer = true
			core.start()
		else
			gamedata.errormessage =
				fgettext("No world created or selected!")
		end
		return true
	end

	if fields["world_create"] ~= nil then
		local create_world_dlg = create_create_world_dlg(true)
		create_world_dlg:set_parent(this)
		this:hide()
		create_world_dlg:show()
		mm_texture.update("singleplayer",current_game())
		return true
	end

	if fields["world_delete"] ~= nil then
		local selected = core.get_textlist_index("sp_worlds")
		if selected ~= nil and
			selected <= menudata.worldlist:size() then
			local world = menudata.worldlist:get_list()[selected]
			if world ~= nil and
				world.name ~= nil and
				world.name ~= "" then
				local index = menudata.worldlist:get_raw_index(selected)
				local delete_world_dlg = create_delete_world_dlg(world.name,index)
				delete_world_dlg:set_parent(this)
				this:hide()
				delete_world_dlg:show()
				mm_texture.update("singleplayer",current_game())
			end
		end
		
		return true
	end

	if fields["world_configure"] ~= nil then
		local selected = core.get_textlist_index("sp_worlds")
		if selected ~= nil then
			local configdialog =
				create_configure_world_dlg(
						menudata.worldlist:get_raw_index(selected))
			
			if (configdialog ~= nil) then
				configdialog:set_parent(this)
				this:hide()
				configdialog:show()
				mm_texture.update("singleplayer",current_game())
			end
		end
		
		return true
	end
end

local function on_change(type, old_tab, new_tab)
	if (type == "ENTER") then
		local game = current_game()
		
		if game then
			menudata.worldlist:set_filtercriteria(game.id)
			mm_texture.update("singleplayer",game)
		end
	else
		menudata.worldlist:set_filtercriteria(nil)
		
		core.set_topleft_text("")
		mm_texture.update(new_tab,nil)
	end
end

--------------------------------------------------------------------------------
return {
	name = "singleplayer",
	caption = fgettext("Singleplayer"),
	cbf_formspec = get_formspec,
	cbf_button_handler = main_button_handler,
	on_change = on_change
}
