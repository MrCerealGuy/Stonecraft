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
	
	if game.id == "stonecraft" then
		retval = retval .. "size[11.5,9.0,true]"
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
		
		if game.id == "stonecraft" then
			retval = retval .. "label[0.25,3.00;" .. fgettext("World options") .. "]"..
							"checkbox[0.25,3.50;cb_enable_erosion;" .. fgettext("Enable erosion") .. ";false]" ..
							"checkbox[0.25,4.00;cb_enable_forests;" .. fgettext("Enable more forests/red trees") .. ";false]" ..
							"checkbox[6.05,3.50;cb_enable_villages;" .. fgettext("Enable villages") .. ";false]" ..
							"checkbox[6.05,4.00;cb_enable_biomes;" .. fgettext("Enable more biomes") .. ";false]" ..
							"checkbox[0.25,4.50;cb_enable_caverealms;" .. fgettext("Enable cave realms") .. ";false]" ..
							"checkbox[6.05,4.50;cb_enable_creatures;" .. fgettext("Enable creatures") .. ";false]" ..
							"checkbox[0.25,5.00;cb_enable_homedecor;" .. fgettext("Enable home decor") .. ";false]" ..
							"checkbox[6.05,5.00;cb_enable_mesecons;" .. fgettext("Enable mesecons/pipes/technic") .. ";false]" ..
							"checkbox[0.25,5.50;cb_enable_nssm;" .. fgettext("Enable not so simple mobs") .. ";false]" ..
							"checkbox[6.05,5.50;cb_enable_pyramids;" .. fgettext("Enable pyramids/spawners") .. ";false]" ..
							"checkbox[0.25,6.00;cb_enable_giantmushrooms;" .. fgettext("Enable giant mushrooms") .. ";false]" ..
							"checkbox[6.05,6.00;cb_enable_seaplants;" .. fgettext("Enable sea plants") .. ";false]" ..
							"checkbox[0.25,6.50;cb_enable_swamps;" .. fgettext("Enable swamps") .. ";false]" ..
							"checkbox[6.05,6.50;cb_enable_snow;" .. fgettext("Enable snow biomes") .. ";false]" ..
							"checkbox[0.25,7.00;cb_enable_woodsoils;" .. fgettext("Enable wood soils/vines") .. ";false]"
		end
		
		if game.id == "stonecraft" then
			retval = retval .. "button[3.25,8.5;2.5,0.5;world_create_confirm;" .. fgettext("Create") .. "]" ..
				"button[5.75,8.5;2.5,0.5;world_create_cancel;" .. fgettext("Cancel") .. "]"
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
	end

	return retval

end

local function create_world_buttonhandler(this, fields)
	
	-- handle Stonecraft selected optional mods
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
			core.setting_set("world_create_enable_redtrees", "true")
		else
			core.setting_set("world_create_enable_forests", "false")
			core.setting_set("world_create_enable_redtrees", "false")
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
	
	if fields["cb_enable_caverealms"] ~= nil then
		if core.is_yes(fields["cb_enable_caverealms"]) then
			core.setting_set("world_create_enable_caverealms", "true")
		else
			core.setting_set("world_create_enable_caverealms", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_creatures"] ~= nil then
		if core.is_yes(fields["cb_enable_creatures"]) then
			core.setting_set("world_create_enable_creatures", "true")
		else
			core.setting_set("world_create_enable_creatures", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_homedecor"] ~= nil then
		if core.is_yes(fields["cb_enable_homedecor"]) then
			core.setting_set("world_create_enable_homedecor", "true")
		else
			core.setting_set("world_create_enable_homedecor", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_mesecons"] ~= nil then
		if core.is_yes(fields["cb_enable_mesecons"]) then
			core.setting_set("world_create_enable_mesecons", "true")
			core.setting_set("world_create_enable_pipeworks", "true")
			core.setting_set("world_create_enable_technic", "true")
			core.setting_set("world_create_enable_digilines", "true")
		else
			core.setting_set("world_create_enable_mesecons", "false")
			core.setting_set("world_create_enable_pipeworks", "false")
			core.setting_set("world_create_enable_technic", "false")
			core.setting_set("world_create_enable_digilines", "false")
		end
						
		return true
	end
	
	
	if fields["cb_enable_nssm"] ~= nil then
		if core.is_yes(fields["cb_enable_nssm"]) then
			core.setting_set("world_create_enable_nssm", "true")
			core.setting_set("world_create_enable_nssb", "true")
		else
			core.setting_set("world_create_enable_nssm", "false")
			core.setting_set("world_create_enable_nssb", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_pyramids"] ~= nil then
		if core.is_yes(fields["cb_enable_pyramids"]) then
			core.setting_set("world_create_enable_pyramids", "true")
			core.setting_set("world_create_enable_spawners", "true")
		else
			core.setting_set("world_create_enable_pyramids", "false")
			core.setting_set("world_create_enable_spawners", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_giantmushrooms"] ~= nil then
		if core.is_yes(fields["cb_enable_giantmushrooms"]) then
			core.setting_set("world_create_enable_giantmushrooms", "true")
		else
			core.setting_set("world_create_enable_giantmushrooms", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_seaplants"] ~= nil then
		if core.is_yes(fields["cb_enable_seaplants"]) then
			core.setting_set("world_create_enable_seaplants", "true")
		else
			core.setting_set("world_create_enable_seaplants", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_swamps"] ~= nil then
		if core.is_yes(fields["cb_enable_swamps"]) then
			core.setting_set("world_create_enable_swamps", "true")
		else
			core.setting_set("world_create_enable_swamps", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_snow"] ~= nil then
		if core.is_yes(fields["cb_enable_snow"]) then
			core.setting_set("world_create_enable_snow", "true")
			core.setting_set("world_create_enable_moresnow", "true")
		else
			core.setting_set("world_create_enable_snow", "false")
			core.setting_set("world_create_enable_moresnow", "false")
		end
						
		return true
	end
	
	if fields["cb_enable_woodsoils"] ~= nil then
		if core.is_yes(fields["cb_enable_woodsoils"]) then
			core.setting_set("world_create_enable_woodsoils", "true")
			core.setting_set("world_create_enable_vines", "true")
		else
			core.setting_set("world_create_enable_woodsoils", "false")
			core.setting_set("world_create_enable_vines", "false")
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
									
				
				-- write selected Stonecraft mods in world.mt
				if core.setting_getbool("world_create_enable_erosion") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_erosion", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_erosion", "false")
				end
				
				if core.setting_getbool("world_create_enable_forests") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_forests", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_redtrees", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_forests", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_redtrees", "false")
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
				
				if core.setting_getbool("world_create_enable_caverealms") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_caverealms", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_caverealms", "false")
				end
				
				if core.setting_getbool("world_create_enable_creatures") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_creatures", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_creatures", "false")
				end
				
				if core.setting_getbool("world_create_enable_homedecor") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_homedecor", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_homedecor", "false")
				end
				
				if core.setting_getbool("world_create_enable_mesecons") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mesecons", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pipeworks", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_technic", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_digilines", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mesecons", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pipeworks", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_technic", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_digilines", "false")
				end

				if core.setting_getbool("world_create_enable_nssm") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssm", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssb", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssm", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssb", "false")
				end
				
				if core.setting_getbool("world_create_enable_pyramids") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pyramids", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_spawners", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pyramids", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_spawners", "false")
				end
				
				if core.setting_getbool("world_create_enable_giantmushrooms") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_giantmushrooms", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_giantmushrooms", "false")
				end
				
				if core.setting_getbool("world_create_enable_seaplants") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_seaplants", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_seaplants", "false")
				end
				
				if core.setting_getbool("world_create_enable_swamps") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_swamps", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_swamps", "false")
				end
				
				if core.setting_getbool("world_create_enable_snow") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_snow", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_moresnow", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_snow", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_moresnow", "false")
				end
				
				if core.setting_getbool("world_create_enable_woodsoils") then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_woodsoils", "true")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_vines", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_woodsoils", "false")
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_vines", "false")
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
