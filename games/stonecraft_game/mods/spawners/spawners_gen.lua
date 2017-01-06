-- Place spawners in dungeons
local function place_spawner(param)
	local tab = param[1]
	local gen_obj = param[2]

	local pos = tab[math.random(1, (#tab or 3))]
	pos.y = pos.y - 1
	
	local n = minetest.get_node_or_nil(pos)

	if n and n.name ~= "air" then
		pos.y = pos.y + 1

		if gen_obj == "dungeon" then
			minetest.log("action", "[Mod][Spawners] dungeon spawner placed at: "..minetest.pos_to_string(pos))
			
			minetest.set_node(pos, {name = "spawners:spawners_mummy_spawner_env"})
		else
			minetest.log("action", "[Mod][Spawners] temple spawner placed at: "..minetest.pos_to_string(pos))
			
			minetest.set_node(pos, {name = "spawners:mobs_spider_spawner_env"})
		end

	end
end

minetest.set_gen_notify("dungeon")
minetest.set_gen_notify("temple")

minetest.register_on_generated(function(minp, maxp, blockseed)
	local ntf = minetest.get_mapgen_object("gennotify")
	
	if ntf and ntf.dungeon then
		minetest.after(3, place_spawner, {table.copy(ntf.dungeon), "dungeon"})
	end

	if ntf and ntf.temple then
		minetest.after(3, place_spawner, {table.copy(ntf.temple), "temple"})
	end
end)