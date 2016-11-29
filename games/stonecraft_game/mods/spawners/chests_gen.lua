-- Place chests in dungeons and temples
local function place_chest(param)
	local tab = param

	local pos = tab[math.random(1, (#tab or 4))]
	pos.y = pos.y - 1
	
	local n = minetest.get_node_or_nil(pos)

	if n and n.name ~= "air" then
		pos.y = pos.y + 1

		minetest.log("action", "[Mod][Spawners] Chest placed at: "..minetest.pos_to_string(pos))
		
		minetest.set_node(pos, {name = "default:chest"})

		pyramids.fill_chest(pos)
	end
end

minetest.set_gen_notify("dungeon")
minetest.set_gen_notify("temple")

minetest.register_on_generated(function(minp, maxp, blockseed)
	local ntf = minetest.get_mapgen_object("gennotify")
	
	if ntf and ntf.dungeon then
		minetest.after(3, place_chest, table.copy(ntf.dungeon))
	end

	if ntf and ntf.temple then
		minetest.after(3, place_chest, table.copy(ntf.temple))
	end
end)