-- main tables
spawners_env = {}
spawners_env.mob_tables = {}

-- check if mods exists and build tables
for k, mob_mod in ipairs(ENABLED_MODS) do
	local modpath = minetest.get_modpath(mob_mod)
	-- list of mobs and their info
	if (modpath) then
		for j, mob in ipairs(MOBS_PROPS[mob_mod]) do
			local mob_egg = nil
			-- create only environmental spawners
			if mob.env then
				table.insert(spawners_env.mob_tables, {name=mob.name, mod_prefix=mob_mod, egg_name_custom=mob.egg_name_custom, dummy_size=mob.dummy_size, dummy_offset=mob.dummy_offset, dummy_mesh=mob.dummy_mesh, dummy_texture=mob.dummy_texture, night_only=mob.night_only, sound_custom=mob.sound_custom, env=mob.env, boss=mob.boss})
				-- use custom egg or create a default egg
				if mob.egg_name_custom ~= "" then 
					mob_egg = mob.egg_name_custom
				else
					mob_egg = mob_mod..":"..mob.name
				end
			end

		end
	else
		-- print something ?
	end
end

-- start spawning mobs
function spawners_env.start_spawning(pos, how_many, mob_name, mod_prefix, sound_custom)
	
	if not (pos or mob_name) then
		return
	end

	-- remove 'spawners_env:' from the string
	local mob_name = string.sub(mob_name,14)
	local sound_name
	-- use custom sounds
	if sound_custom ~= "" then 
		sound_name = sound_custom
	else
		sound_name = mod_prefix.."_"..mob_name
	end

	if how_many == nil then
		how_many = math.random(1,2)
	end

	for i=1,how_many do
		pos.y = pos.y+1
		local obj = minetest.add_entity(pos, mod_prefix..":"..mob_name)

		if obj then
			if sound_name then
				minetest.sound_play(sound_name, {
					pos = pos,
					max_hear_distance = 100,
					gain = 5,
				})
			end
		end
	end
end

function spawners_env.check_around_radius(pos)
	local player_near = false
	local radius = 21
	local node_ore_pos = nil

	for _,obj in ipairs(minetest.get_objects_inside_radius(pos, radius)) do
		if obj:is_player() then
			player_near = true
		end
	end

	return player_near
end

function spawners_env.check_node_status(pos, mob, night_only, boss)
	local player_near = spawners_env.check_around_radius(pos)

	if player_near or boss then
		local random_pos = false
		local min_node_light = 10
		local tod = minetest.get_timeofday() * 24000
		local node_light = minetest.get_node_light(pos)

		if not node_light then
			return false
		end

		local spawn_positions = {}
		local right = minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z})
		local front = minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1})
		local left = minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z})
		local back = minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1})
		local top = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		local bottom = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})

		-- make sure that at least one side of the spawner is open
		if right.name == "air" then
			table.insert(spawn_positions, {x=pos.x+1.5, y=pos.y, z=pos.z})
		end
		if front.name == "air" then
			table.insert(spawn_positions, {x=pos.x, y=pos.y, z=pos.z+1.5})
		end
		if left.name == "air" then
			table.insert(spawn_positions, {x=pos.x-1.5, y=pos.y, z=pos.z})
		end
		if back.name == "air" then
			table.insert(spawn_positions, {x=pos.x, y=pos.y, z=pos.z-1.5})
		end
		if top.name == "air" then
			table.insert(spawn_positions, {x=pos.x, y=pos.y+1.5, z=pos.z})
		end
		if bottom.name == "air" then
			table.insert(spawn_positions, {x=pos.x, y=pos.y-1.5, z=pos.z})
		end

		-- spawner is closed from all sides
		if #spawn_positions < 1 then
			return false
		
		-- find random position in all posible places
		else
			local possible_spawn_pos = {}
			local pick_random_key

			-- get a position value from the picked/random key
			for k, v in pairs (spawn_positions) do
				local node_above = minetest.get_node({x=v.x, y=v.y+1, z=v.z}).name
				local node_below = minetest.get_node({x=v.x, y=v.y-1, z=v.z}).name

				-- make super sure there is enough place to spawn mob and collect all possible spawn points
				if node_above == "air" or node_below == "air" then
					table.insert(possible_spawn_pos, v)
					-- print("possible pos: "..minetest.pos_to_string(v))
				end
			end

			-- no possible spawn points found - not enough place around the spawner
			if #possible_spawn_pos < 1 then
				return false

			-- only one possible position ?
			elseif #possible_spawn_pos == 1 then
				pick_random_key = #possible_spawn_pos

			-- pick random from the possible open sides
			else
				pick_random_key = math.random(1,#possible_spawn_pos)
			end

			random_pos = possible_spawn_pos[pick_random_key]
			-- print(minetest.pos_to_string(random_pos))
		end

		if night_only ~= "disable" then
			-- spawn only at day
			if not night_only and node_light < min_node_light then
				return false, true
			end

			-- spawn only at night
			if night_only then
				if not (19359 > tod and tod > 5200) or node_light < min_node_light then
					return random_pos
				else
					return false, true
				end
			end
		end
		-- random_pos, waiting
		return random_pos, false
	else
		-- random_pos, waiting
		return false, true
	end
end

local chest_stuff = {
	{name="default:apple", max = 3},
	{name="default:torch", max = 10},
	{name="default:aspen_sapling", max = 5},
	{name="farming:bread", max = 3},
	{name="default:steel_ingot", max = 2},
	{name="default:gold_ingot", max = 2},
	{name="default:bronze_ingot", max = 2},
	{name="default:copper_ingot", max = 2},
	{name="default:diamond", max = 1},
	{name="default:pick_steel", max = 1},
	{name="default:pick_diamond", max = 1},
	{name="default:pick_bronze", max = 1},
	{name="default:pick_mese", max = 1},
	{name="default:pick_stone", max = 1},
	{name="default:pick_wood", max = 1},
	{name="default:sword_bronze", max = 1},
	{name="default:sword_diamond", max = 1},
	{name="default:sword_mese", max = 1},
	{name="default:sword_steel", max = 1},
	{name="default:sword_stone", max = 1},
	{name="default:sword_wood", max = 1},
	{name="default:shovel_bronze", max = 1},
	{name="default:shovel_diamond", max = 1},
	{name="default:shovel_mese", max = 1},
	{name="default:shovel_steel", max = 1},
	{name="default:shovel_stone", max = 1},
	{name="default:shovel_wood", max = 1},
	{name="default:axe_bronze", max = 1},
	{name="default:axe_diamond", max = 1},
	{name="default:axe_mese", max = 1},
	{name="default:axe_steel", max = 1},
	{name="default:axe_stone", max = 1},
	{name="default:axe_wood", max = 1},
	{name="obsidianmese:mese_apple", max = 1},
}

function spawners_env.fill_chest(pos)
	minetest.after(2, function()
		local n = minetest.get_node(pos)

		if n and n.name and n.name == "default:chest" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			inv:set_size("main", 8*4)

			-- if math.random(1,10) < 5 then return end
			
			for i=0,2,1 do
				local stuff = chest_stuff[math.random(1,#chest_stuff)]

				if stuff.name == "farming:bread" and not minetest.get_modpath("farming") then
					stuff = chest_stuff[1]
				end

				if stuff.name == "obsidianmese:mese_apple" and not minetest.get_modpath("obsidianmese") then
					stuff = chest_stuff[1]
				end
				
				local stack = {name=stuff.name, count = math.random(1,stuff.max)}
				
				if not inv:contains_item("main", stack) then
					inv:set_stack("main", math.random(1,32), stack)
				end
			end
		end
	end)
end