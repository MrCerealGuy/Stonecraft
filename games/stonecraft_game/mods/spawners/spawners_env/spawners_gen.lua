-- Place chests in dungeons and temples
local function place_chest(param)
	local skip = math.random(0,1)

	-- skip chest
	if skip == 1 then
		return
	end

	local tab = param

	local pos = tab[math.random(1, (#tab or 4))]
	pos.y = pos.y - 1
	
	local n = minetest.get_node_or_nil(pos)

	if n and n.name ~= "air" then
		pos.y = pos.y + 1

		minetest.log("action", "[Mod][Spawners] Chest placed at: "..minetest.pos_to_string(pos))
		
		minetest.set_node(pos, {name = "default:chest"})

		spawners_env.fill_chest(pos)
	end
end

-- Place spawners in dungeons
local function place_spawner(param)
	local skip = math.random(0,1)
	
	-- skip spawner
	if skip == 1 then
		return
	end

	local tab = param[1]
	local gen_obj = param[2]

	local pos = tab[math.random(1, (#tab or 4))]
	pos.y = pos.y - 1
	
	local n = minetest.get_node_or_nil(pos)
	local n2 = minetest.get_node_or_nil({x=pos.x, y=pos.y+1, z=pos.z})

	if n and n.name ~= "air" then
		pos.y = pos.y + 1

		-- pos the same as chest, putting spawner above the chest
		if n2 and n2.name == "default:chest" then
			-- print("pos the same as chest, putting spawner above the chest")
			pos.y = pos.y + 1
		end

		if gen_obj == "dungeon" then
			minetest.log("action", "[Mod][Spawners] dungeon spawner placed at: "..minetest.pos_to_string(pos))
			
			minetest.set_node(pos, {name = "spawners_env:spawners_mobs_uruk_hai_spawner"})
		else
			minetest.log("action", "[Mod][Spawners] temple spawner placed at: "..minetest.pos_to_string(pos))
			
			minetest.set_node(pos, {name = "spawners_env:mobs_spider_spawner"})
		end

	end
end

minetest.set_gen_notify("dungeon")
minetest.set_gen_notify("temple")

minetest.register_on_generated(function(minp, maxp, blockseed)
	local notify = minetest.get_mapgen_object("gennotify")
	
	if notify and notify.dungeon then
		minetest.after(2, place_chest, table.copy(notify.dungeon))
		minetest.after(3, place_spawner, {table.copy(notify.dungeon), "dungeon"})
	end

	if notify and notify.temple then
		minetest.after(2, place_chest, table.copy(notify.temple))
		minetest.after(3, place_spawner, {table.copy(notify.temple), "temple"})
	end
end)