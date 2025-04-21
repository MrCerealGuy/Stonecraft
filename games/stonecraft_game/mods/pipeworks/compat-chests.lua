-- this bit of code overrides the default chests from common games (mtg, hades, minclone*) to be
-- compatible with pipeworks. Where possible, it overrides their formspec to add a splitstacks switch

local fs_helpers = pipeworks.fs_helpers

-- formspec helper to add the splitstacks switch
local function add_pipeworks_switch(formspec, pos)
	-- based on the sorting tubes
	formspec = formspec ..
			fs_helpers.cycling_button(
				minetest.get_meta(pos),
				pipeworks.button_base,
				"splitstacks",
				{
					pipeworks.button_off,
					pipeworks.button_on
				}
			)..pipeworks.button_label
	return formspec
end

-- helper to add the splitstacks switch to a node-formspec
local function update_node_formspec(pos)
	local meta = minetest.get_meta(pos)
	local old_fs = meta:get_string("formspec")
	local new_fs = add_pipeworks_switch(old_fs, pos)
	meta:set_string("formspec", new_fs)
end


if minetest.get_modpath("default") then
	-- add the pipeworks switch into the default chest formspec
	local old_get_chest_formspec = default.chest.get_chest_formspec
	-- luacheck: ignore 122
	default.chest.get_chest_formspec = function(pos)
		local old_fs = old_get_chest_formspec(pos)
		local node = minetest.get_node(pos)
		-- not all chests using this formspec necessary connect to pipeworks
		if pipeworks.chests[node.name] then
			local new_fs = add_pipeworks_switch(old_fs, pos)
			return new_fs
		else
			return old_fs
		end
	end

	-- get the fields from the chest formspec, we can do this bc. newest functions are called first
	-- https://github.com/minetest/minetest/blob/d4b10db998ebeb689b3d27368e30952a42169d03/doc/lua_api.md?plain=1#L5840
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		if fields.quit or formname ~= "default:chest" then
			return
		end
		local pn = player:get_player_name()
		local chest_open = default.chest.open_chests[pn]
		if not chest_open or not chest_open.pos then
			-- chest already closed before formspec
			return
		end
		local pos = chest_open.pos
		local node = minetest.get_node(pos)
		if pipeworks.chests[node.name] and pipeworks.may_configure(pos, player) then
			-- Pipeworks Switch
			fs_helpers.on_receive_fields(pos, fields)
			minetest.show_formspec(pn,
				"default:chest",
				default.chest.get_chest_formspec(pos))
		end
		-- Do NOT return true here, the callback from default still needs to run
		return false
	end)

	local connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
	local connect_sides_open = {left = 1, right = 1, back = 1, bottom = 1}

	pipeworks.override_chest("default:chest", {}, connect_sides)
	pipeworks.override_chest("default:chest_open", {}, connect_sides_open)
	pipeworks.override_chest("default:chest_locked", {}, connect_sides)
	pipeworks.override_chest("default:chest_locked_open", {}, connect_sides_open)
elseif minetest.get_modpath("hades_chests") then
	local chest_colors = {"", "white", "grey", "dark_grey", "black", "blue", "cyan", "dark_green", "green", "magenta",
						  "orange", "pink", "red", "violet", "yellow"}
	for _, color in ipairs(chest_colors) do
		local chestname = (color == "" and "hades_chests:chest")
				or "hades_chests:chest_" .. color
		local chestname_protected = (color == "" and "hades_chests:chest_locked")
				or "hades_chests:chest_" .. color .. "_locked"
		local old_def = minetest.registered_nodes[chestname]

		-- chest formspec-creation functions are local, we need to find other ways
		-- normal chests use node formspecs, we can hack into these
		local old_on_construct = old_def.on_construct
		local override = {
			on_construct = function(pos)
				old_on_construct(pos)
				update_node_formspec(pos)
			end,
			on_receive_fields = function(pos, formname, fields, player)
				if not fields.quit and pipeworks.may_configure(pos, player) then
					-- Pipeworks Switch
					fs_helpers.on_receive_fields(pos, fields)
					update_node_formspec(pos)
				end
			end,
			-- chest's on_rotate is "simple", but we assumed the api from the mtg screwdriver mod
			-- this will keep the same behavior, but supports the code above
			on_rotate = screwdriver.rotate_simple
		}

		-- locked chests uses local functions to create their formspec - we need to copy these
		-- https://codeberg.org/Wuzzy/Hades_Revisited/src/branch/master/mods/hades_chests/init.lua
		local function get_locked_chest_formspec(pos)
			local spos = pos.x .. "," .. pos.y .. "," ..pos.z
			local formspec =
				"size[10,9]"..
				"list[nodemeta:".. spos .. ";main;0,0;10,4;]"..
				"list[current_player;main;0,5;10,4;]"..
				"listring[]"..
				"background9[8,8;10,9;hades_chests_chestui.png;true;8]"

			-- change from pipeworks
			local new_fs = add_pipeworks_switch(formspec, pos)
			return new_fs
		end

		local function has_locked_chest_privilege(meta, player)
			local name = player:get_player_name()
			if name ~= meta:get_string("owner") and not minetest.check_player_privs(name, "protection_bypass") then
				return false
			end
			return true
		end

		-- store, which chest a formspec submission belongs to
		-- {player1 = pos1, player2 = pos2, ...}
		local open_chests = {}
		minetest.register_on_leaveplayer(function(player)
			open_chests[player:get_player_name()] = nil
		end)

		local override_protected = {
			on_rightclick = function(pos, node, clicker)
				local meta = minetest.get_meta(pos)
				if has_locked_chest_privilege(meta, clicker) then
					minetest.show_formspec(
							clicker:get_player_name(),
							"hades_chests:chest_locked",
							get_locked_chest_formspec(pos)
					)
					open_chests[clicker:get_player_name()] = pos
				else
					minetest.sound_play({ name = "hades_chests_locked", gain = 0.3 }, { max_hear_distance = 10 }, true)
				end
			end,
			on_rotate = screwdriver.rotate_simple
		}

		-- get the fields from the chest formspec, we can do this bc. newest functions are called first
		-- https://github.com/minetest/minetest/blob/d4b10db998ebeb689b3d27368e30952a42169d03/doc/lua_api.md?plain=1#L5840
		minetest.register_on_player_receive_fields(function(player, formname, fields)
			if fields.quit or formname ~= "hades_chests:chest_locked" then
				return
			end
			local pn = player:get_player_name()
			local pos = open_chests[pn]
			if pos and pipeworks.may_configure(pos, player) then
				-- Pipeworks Switch
				fs_helpers.on_receive_fields(pos, fields)
				minetest.show_formspec(pn, "hades_chests:chest_locked", get_locked_chest_formspec(pos))
			end
			-- Do NOT return true here, the callback from hades still needs to run (if they add one)
			return false
		end)

		local connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
		pipeworks.override_chest(chestname, override, connect_sides)
		pipeworks.override_chest(chestname_protected, override_protected, connect_sides)
	end
elseif minetest.get_modpath("mcl_barrels") then
	-- TODO: bring splitstacks switch in the formspec
	-- with the current implementation of mcl_barrels this would mean to duplicate a lot of code from there...
	local connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1}
	pipeworks.override_chest("mcl_barrels:barrel_closed", {}, connect_sides)
	pipeworks.override_chest("mcl_barrels:barrel_open", {}, connect_sides)
end
