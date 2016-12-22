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

local function create_world_formspec(dialogdata)
	local mapgens = core.get_mapgen_names()

	local current_seed = core.setting_get("fixed_map_seed") or ""
	local current_mg   = core.setting_get("mg_name")

	local mglist = ""
	local selindex = 1
	local i = 1
	for k,v in pairs(mapgens) do
		if current_mg == v then
			selindex = i
		end
		i = i + 1
		mglist = mglist .. v .. ","
	end
	mglist = mglist:sub(1, -2)
	
	local gameid = core.setting_get("menu_last_game")
	
	local game, gameidx = nil , 0
	if gameid ~= nil then
		game, gameidx = gamemgr.find_by_gameid(gameid)
		
		if gameidx == nil then
			gameidx = 0
		end
	end

	current_seed = core.formspec_escape(current_seed)
	local retval = ""
	
	if game.id == "stonecraft-plus" then
		retval = retval .. "size[11.5,6.5,true]"
	else
		retval = retval .. "size[11.5,4.5,true]"
	end
	
	retval = retval ..		
		"label[2,0;" .. fgettext("World name") .. "]"..
		"field[4.5,0.4;6,0.5;te_world_name;;]" ..
		
		"label[2,1;" .. fgettext("Seed") .. "]"..
		"field[4.5,1.4;6,0.5;te_seed;;".. current_seed .. "]" ..
		
		"label[2,2;" .. fgettext("Mapgen") .. "]"..
		"dropdown[4.2,2;6.3;dd_mapgen;" .. mglist .. ";" .. selindex .. "]" ..

		--"label[2,3;" .. fgettext("Game") .. "]"..
		"textlist[-10,3;7,2.3;games;" .. gamemgr.gamelist() ..
		";" .. gameidx .. ";true]"
		
		if game.id == "stonecraft-plus" then
			retval = retval .. "checkbox[0.25,4.50;cb_enable_erosion;" .. fgettext("Enable erosion") .. ";false]" ..
							"checkbox[2.80,4.50;cb_enable_forests;" .. fgettext("Enable more forests") .. ";false]" ..
							"checkbox[6.05,4.50;cb_enable_villages;" .. fgettext("Enable villages") .. ";false]" ..
							"checkbox[8.55,4.50;cb_enable_biomes;" .. fgettext("Enable more biomes") .. ";false]"
		end
		
		if game.id == "stonecraft-plus" then
			retval = retval .. "button[3.25,6;2.5,0.5;world_create_confirm;" .. fgettext("Create") .. "]" ..
				"button[5.75,6;2.5,0.5;world_create_cancel;" .. fgettext("Cancel") .. "]"
		else
			retval = retval .. "button[3.25,4;2.5,0.5;world_create_confirm;" .. fgettext("Create") .. "]" ..
				"button[5.75,4;2.5,0.5;world_create_cancel;" .. fgettext("Cancel") .. "]"
		end
		
	if #gamemgr.games == 0 then
		retval = retval .. "box[2,4;8,1;#ff8800]label[2.25,4;" ..
				fgettext("You have no subgames installed.") .. "]label[2.25,4.4;" ..
				fgettext("Download one from bc547.de/stonecraft") .. "]"
	elseif #gamemgr.games == 1 and gamemgr.games[1].id == "minimal" then
		retval = retval .. "box[1.75,4;8.7,1;#ff8800]label[2,4;" ..
				fgettext("Warning: The minimal development test is meant for developers.") .. "]label[2,4.4;" ..
				fgettext("Download a subgame, such as stonecraft_game, from bc547.de/stonecraft") .. "]"
	elseif game.id == "stonecraft-plus" then
		retval = retval .. "box[1.75,3.30;8.7,1;#ff8800]label[2,3.3;" ..
				fgettext("In Stonecraft Plus you can use enhanced worldgen options.") .. "]label[2,3.70;" ..
				fgettext("Actually you can experience performance lags if activated.") .. "]"
	
	end

	return retval

end

local function create_world_buttonhandler(this, fields)
	
	-- handle Stonecraft Plus selected mods
	if fields["cb_enable_erosion"] ~= nil then
		if core.is_yes(fields["cb_enable_erosion"]) then
			core.setting_set("world_create_enable_erosion", "true")
		else
			core.setting_set("world_create_enable_erosion", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_forests"] ~= nil then
		if core.is_yes(fields["cb_enable_forests"]) then
			core.setting_set("world_create_enable_forests", "true")
		else
			core.setting_set("world_create_enable_forests", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_villages"] ~= nil then
		if core.is_yes(fields["cb_enable_villages"]) then
			core.setting_set("world_create_enable_villages", "true")
		else
			core.setting_set("world_create_enable_villages", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_biomes"] ~= nil then
		if core.is_yes(fields["cb_enable_biomes"]) then
			core.setting_set("world_create_enable_biomes", "true")
		else
			core.setting_set("world_create_enable_biomes", "false")
		end
						
		return true
	end

	
	if fields["world_create_confirm"] or
		fields["key_enter"] then

		local worldname = fields["te_world_name"]
		local gameindex = core.get_textlist_index("games")

		if gameindex ~= nil and
			worldname ~= "" then

			local message = nil
			
			core.setting_set("fixed_map_seed", fields["te_seed"])
			
			if not menudata.worldlist:uid_exists_raw(worldname) then
				core.setting_set("mg_name",fields["dd_mapgen"])
				message = core.create_world(worldname,gameindex)
			else
				message = fgettext("A world named \"$1\" already exists", worldname)
			end

			if message ~= nil then
				gamedata.errormessage = message
			else
				core.setting_set("menu_last_game",gamemgr.games[gameindex].id)
				
				if this.data.update_worldlist_filter then
					menudata.worldlist:set_filtercriteria(gamemgr.games[gameindex].id)
					mm_texture.update("singleplayer", gamemgr.games[gameindex].id)
				end
				
				menudata.worldlist:refresh()
				core.setting_set("mainmenu_last_selected_world",
									menudata.worldlist:raw_index_by_uid(worldname))
									
				
				-- write selected Stonecraft Plus mods in world.mt
				if core.setting_getbool("world_create_enable_erosion") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_erosion", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_erosion", "false")
				end
				
				if core.setting_getbool("world_create_enable_forests") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_forests", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_forests", "false")
				end
				
				if core.setting_getbool("world_create_enable_villages") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_villages", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_villages", "false")
				end
				
				if core.setting_getbool("world_create_enable_biomes") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_biomes", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_biomes", "false")
				end

			end
		else
			gamedata.errormessage =
				fgettext("No worldname given or no game selected")
		end
		this:delete()
		return true
	end
	
	if fields["games"] then
		return true
	end
	
	if fields["world_create_cancel"] then
		this:delete()
		return true
	end

	return false
end

function create_create_world_dlg(update_worldlistfilter)
	core.setting_set("world_create_enable_erosion", "false")
	core.setting_set("world_create_enable_forests", "false")
	core.setting_set("world_create_enable_villages", "false")
	core.setting_set("world_create_enable_biomes", "false")
	
	local dlg = dialog_create("sp_create_world",
					create_world_formspec,
					create_world_buttonhandler,
					nil)
	dlg.update_worldlist_filter = update_worldlistfilter
	
	return dlg
end
