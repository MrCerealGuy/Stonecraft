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

local world_create_enable_erosion = false
local world_create_enable_forests = false
local world_create_enable_villages = false
local world_create_enable_biomes = false
local world_create_enable_caverealms = false
local world_create_enable_creatures = false
local world_create_enable_homedecor = false
local world_create_enable_mesecons = false
local world_create_enable_nssm = false
local world_create_enable_pyramids = false
local world_create_enable_giantmushrooms = false
local world_create_enable_seaplants = false
local world_create_enable_swamps = false
local world_create_enable_snow = false
local world_create_enable_woodsoils = false
local world_create_enable_surprise = false
local world_create_enable_mines = false

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
			retval = retval .. "label[0.25,3.00;" .. fgettext("World options: (some options can cause lag issues.)") .. "]"..
							
							"checkbox[0.25,3.50;cb_enable_creatures;" .. fgettext("Enable creatures") .. ";false]" ..
							"checkbox[6.05,3.50;cb_enable_villages;" .. fgettext("Enable villages") .. ";false]" ..
							"checkbox[0.25,4.00;cb_enable_forests;" .. fgettext("Enable more forests/red trees") .. ";false]" ..
							"checkbox[6.05,4.00;cb_enable_woodsoils;" .. fgettext("Enable wood soils/vines") .. ";false]" ..
							"checkbox[0.25,4.50;cb_enable_biomes;" .. fgettext("Enable Ethereal biomes") .. ";false]" ..
							"checkbox[6.05,4.50;cb_enable_snow;" .. fgettext("Enable snow biomes") .. ";false]" ..
							"checkbox[0.25,5.00;cb_enable_seaplants;" .. fgettext("Enable sea plants") .. ";false]" ..
							"checkbox[6.05,5.00;cb_enable_swamps;" .. fgettext("Enable swamps") .. ";false]" ..
							"checkbox[0.25,5.50;cb_enable_caverealms;" .. fgettext("Enable cave realms") .. ";false]" ..							
							"checkbox[6.05,5.50;cb_enable_mines;" .. fgettext("Enable mines") .. ";false]" ..
							"checkbox[0.25,6.00;cb_enable_surprise;" .. fgettext("Enable surprise blocks") .. ";false]" ..
							"checkbox[6.05,6.00;cb_enable_homedecor;" .. fgettext("Enable home decor/technic") .. ";false]" ..
							--"checkbox[0.25,6.50;cb_enable_mesecons;" .. fgettext("Enable mesecons/pipes/technic") .. ";false]" ..
							"checkbox[6.05,6.50;cb_enable_nssm;" .. fgettext("Enable not so simple mobs") .. ";false]" ..
							"checkbox[0.25,6.50;cb_enable_pyramids;" .. fgettext("Enable pyramids/spawners") .. ";false]" ..
							"checkbox[6.05,7.00;cb_enable_giantmushrooms;" .. fgettext("Enable giant mushrooms") .. ";false]" ..
							"checkbox[0.25,7.00;cb_enable_erosion;" .. fgettext("Enable erosion") .. ";false]"
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
				fgettext("Download one from mrcerealguy.github.io/stonecraft") .. "]"
	elseif #gamemgr.games == 1 and gamemgr.games[1].id == "minimal" then
		retval = retval .. "box[1.75,4;8.7,1;#ff8800]label[2,4;" ..
				fgettext("Warning: The minimal development test is meant for developers.") .. "]label[2,4.4;" ..
				fgettext("Download a subgame, such as stonecraft_game, from mrcerealguy.github.io/stonecraft") .. "]"
	end

	return retval

end

local function b2s(value)
	if value then
		return "true"
	else
		return "false"
	end
end

local function create_world_buttonhandler(this, fields)
	
	-- handle Stonecraft selected optional mods
	--[[if fields["cb_enable_erosion"] ~= nil then
		if core.is_yes(fields["cb_enable_erosion"]) then
			world_create_enable_erosion = true
		else
			world_create_enable_erosion = false
		end
						
		return true
	end]]--

	if fields["cb_enable_erosion"] ~= nil then
		world_create_enable_erosion = core.is_yes(fields["cb_enable_erosion"])						
		return true
	end

	
	if fields["cb_enable_forests"] ~= nil then
		world_create_enable_forests = core.is_yes(fields["cb_enable_forests"])			
		return true
	end

	
	if fields["cb_enable_villages"] ~= nil then
		world_create_enable_villages = core.is_yes(fields["cb_enable_villages"])	
		return true
	end
	
	if fields["cb_enable_biomes"] ~= nil then
		world_create_enable_biomes = core.is_yes(fields["cb_enable_biomes"])			
		return true
	end
	
	if fields["cb_enable_caverealms"] ~= nil then
		world_create_enable_caverealms = core.is_yes(fields["cb_enable_caverealms"])
		return true
	end
	
	if fields["cb_enable_creatures"] ~= nil then
		world_create_enable_creatures = core.is_yes(fields["cb_enable_creatures"])
		return true
	end
	
	if fields["cb_enable_homedecor"] ~= nil then
		world_create_enable_homedecor = core.is_yes(fields["cb_enable_homedecor"])			
		return true
	end
	
--	if fields["cb_enable_mesecons"] ~= nil then
--		world_create_enable_mesecons = core.is_yes(fields["cb_enable_mesecons"])
--		return true
--	end
	
	
	if fields["cb_enable_nssm"] ~= nil then
		world_create_enable_nssm = core.is_yes(fields["cb_enable_nssm"])			
		return true
	end
	
	if fields["cb_enable_pyramids"] ~= nil then
		world_create_enable_pyramids = core.is_yes(fields["cb_enable_pyramids"])
		return true
	end
	
	if fields["cb_enable_giantmushrooms"] ~= nil then
		world_create_enable_giantmushrooms = core.is_yes(fields["cb_enable_giantmushrooms"])				
		return true
	end
	
	if fields["cb_enable_seaplants"] ~= nil then
		world_create_enable_seaplants = core.is_yes(fields["cb_enable_seaplants"])		
		return true
	end
	
	if fields["cb_enable_swamps"] ~= nil then
		world_create_enable_swamps = core.is_yes(fields["cb_enable_swamps"])			
		return true
	end
	
	if fields["cb_enable_snow"] ~= nil then
		world_create_enable_snow = core.is_yes(fields["cb_enable_snow"])	
		return true
	end
	
	if fields["cb_enable_woodsoils"] ~= nil then
		world_create_enable_woodsoils = core.is_yes(fields["cb_enable_woodsoils"])			
		return true
	end

	if fields["cb_enable_surprise"] ~= nil then
		world_create_enable_surprise = core.is_yes(fields["cb_enable_surprise"])			
		return true
	end

	if fields["cb_enable_mines"] ~= nil then
		world_create_enable_mines = core.is_yes(fields["cb_enable_mines"])
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
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_erosion", b2s(world_create_enable_erosion))

				-- forests
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_forests", b2s(world_create_enable_forests))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_redtrees", b2s(world_create_enable_forests))

				-- villages
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_villages", b2s(world_create_enable_villages))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_darkage", "false")  --deactivated
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mobf_trader", b2s(world_create_enable_villages))

				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_biomes", b2s(world_create_enable_biomes))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_caverealms", b2s(world_create_enable_caverealms))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_creatures", b2s(world_create_enable_creatures))

				-- homedecor/technic
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_homedecor", b2s(world_create_enable_homedecor))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mesecons", b2s(world_create_enable_homedecor))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pipeworks", b2s(world_create_enable_homedecor))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_technic", b2s(world_create_enable_homedecor))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_digilines", b2s(world_create_enable_homedecor))

				-- not so simple mobs
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssm", b2s(world_create_enable_nssm))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_nssb", b2s(world_create_enable_nssm))

				-- pyramids
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_pyramids", b2s(world_create_enable_pyramids))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_spawners", b2s(world_create_enable_pyramids))

				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_giantmushrooms", b2s(world_create_enable_giantmushrooms))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_seaplants", b2s(world_create_enable_seaplants))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_swamps", b2s(world_create_enable_swamps))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_snow", b2s(world_create_enable_snow))

				-- mg_villages needs the mod more_snow
				if world_create_enable_snow or world_create_enable_villages then
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_moresnow", "true")
				else
					menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_moresnow", "false")
				end

				-- wood soils/vines
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_woodsoils", b2s(world_create_enable_woodsoils))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_vines", b2s(world_create_enable_woodsoils))


				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_surprise", b2s(world_create_enable_surprise))

				-- mines
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_mines", b2s(world_create_enable_mines))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_carts", b2s(world_create_enable_mines))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_boost_carts", b2s(world_create_enable_mines))
				menu_worldmt(menudata.worldlist:raw_index_by_uid(worldname), "enable_railcorridors", b2s(world_create_enable_mines))

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
	local retval = dialog_create("sp_create_world",
					create_world_formspec,
					create_world_buttonhandler,
					nil)
	retval.update_worldlist_filter = update_worldlistfilter
	
	return retval
end
