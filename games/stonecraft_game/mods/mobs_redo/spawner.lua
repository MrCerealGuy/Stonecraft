
local S = minetest.get_translator("mobs")
local max_per_block = tonumber(minetest.settings:get("max_objects_per_block") or 99)

-- helper functions

local function is_player(player)

	if player and type(player) == "userdata" and minetest.is_player(player) then
		return true
	end
end

local square = math.sqrt

local get_distance = function(a, b)

	if not a or not b then return 50 end -- nil check and default distance

	local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z

	return square(x * x + y * y + z * z)
end

-- mob spawner

local spawner_default = "mobs_animal:pumba 10 15 0 0 0"

minetest.register_node("mobs:spawner", {
	tiles = {"mob_spawner.png"},
	drawtype = "glasslike",
	paramtype = "light",
	walkable = true,
	description = S("Mob Spawner"),
	groups = {cracky = 1, pickaxey = 3},
	is_ground_content = false,
	_mcl_hardness = 1,
	_mcl_blast_resistance = 5,
	sounds = mobs.node_sound_stone_defaults(),

	on_construct = function(pos)

		local meta = minetest.get_meta(pos)

		-- setup formspec
		local head = S("(mob name) (min light) (max light) (amount)"
				.. " (player distance) (Y offset)")

		-- text entry formspec
		meta:set_string("formspec", "size[10,3.5]"
			.. "label[0.15,0.5;" .. minetest.formspec_escape(head) .. "]"
			.. "field[1,2.5;8.5,0.8;text;" .. S("Command:")
			.. ";${command}]")

		meta:set_string("infotext", S("Spawner Not Active (enter settings)"))
		meta:set_string("command", spawner_default)
	end,

	on_right_click = function(pos, placer)

		if minetest.is_protected(pos, placer:get_player_name()) then return end
	end,

	on_receive_fields = function(pos, formname, fields, sender)

		if not fields.text or fields.text == "" then return end

		local meta = minetest.get_meta(pos)
		local comm = fields.text:split(" ")
		local name = sender:get_player_name()

		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return
		end

		local mob = comm[1] or "" -- mob to spawn
		local mlig = tonumber(comm[2]) -- min light
		local xlig = tonumber(comm[3]) -- max light
		local num = tonumber(comm[4]) -- total mobs in area
		local pla = tonumber(comm[5]) -- player distance (0 to disable)
		local yof = tonumber(comm[6]) or 0 -- Y offset to spawn mob

		if mob ~= "" and mobs.spawning_mobs[mob] and num and num >= 0 and num <= 10
		and mlig and mlig >= 0 and mlig <= 15 and xlig and xlig >= 0 and xlig <= 15
		and pla and pla >= 0 and pla <= 20 and yof and yof > -10 and yof < 10 then

			meta:set_string("command", fields.text)
			meta:set_string("infotext", S("Spawner Active (@1)", mob))
		else
			minetest.chat_send_player(name, S("Mob Spawner settings failed!"))
			minetest.chat_send_player(name,
				S("Syntax: “name min_light[0-14] max_light[0-14] "
				.. "max_mobs_in_area[0 to disable] player_distance[1-20] "
				.. "y_offset[-10 to 10]”"))
		end
	end
})

-- spawner abm

minetest.register_abm({
	label = "Mob spawner node",
	nodenames = {"mobs:spawner"},
	interval = 10,
	chance = 4,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)

		-- return if too many entities already
		if active_object_count_wider >= max_per_block then return end

		-- get meta and command
		local meta = minetest.get_meta(pos)
		local comm = meta:get_string("command"):split(" ")

		-- get settings from command
		local mob = comm[1]
		local mlig = tonumber(comm[2])
		local xlig = tonumber(comm[3])
		local num = tonumber(comm[4])
		local pla = tonumber(comm[5]) or 0
		local yof = tonumber(comm[6]) or 0

		-- if amount is 0 then do nothing
		if num == 0 then return end

		-- are we spawning a registered mob?
		if not mobs.spawning_mobs[mob] then
			--print ("--- mob doesn't exist", mob)
			return
		end

		-- check objects inside 9x9 area around spawner
		local objs = minetest.get_objects_inside_radius(pos, 9)
		local count = 0
		local ent

		-- count mob objects of same type in area
		for _, obj in ipairs(objs) do

			ent = obj:get_luaentity()

			if ent and ent.name and ent.name == mob then count = count + 1 end
		end

		-- is there too many of same type?
		if count >= num then return end

		-- when player distance above 0, spawn mob if player detected and in range
		if pla > 0 then

			local in_range, player
			local players = minetest.get_connected_players()

			for i = 1, #players do

				player = players[i]

				if get_distance(player:get_pos(), pos) <= pla then

					in_range = true

					break
				end
			end

			-- player not found
			if not in_range then return end
		end

		-- set medium mob usually spawns in (defaults to air)
		local reg = minetest.registered_entities[mob].fly_in

		if not reg or type(reg) == "string" then reg = {(reg or "air")} end

		-- find air blocks within 5 nodes of spawner
		local air = minetest.find_nodes_in_area(
				{x = pos.x - 5, y = pos.y + yof, z = pos.z - 5},
				{x = pos.x + 5, y = pos.y + yof, z = pos.z + 5}, reg)

		-- spawn in random air block
		if air and #air > 0 then

			local pos2 = air[math.random(#air)]
			local lig = minetest.get_node_light(pos2) or 0

			pos2.y = pos2.y + 0.5

			-- only if light levels are within range
			if lig >= mlig and lig <= xlig and minetest.registered_entities[mob] then
				minetest.add_entity(pos2, mob)
			end
		end
	end
})
