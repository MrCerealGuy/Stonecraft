-- 
-- Decorative Carved Sand Stones
-- 

local img = {"eye", "men", "sun", "bird"}

for i=1, #img do
	minetest.register_node("spawners_mobs:deco_stone_"..img[i], {
		description = "Sandstone with "..img[i],
		tiles = {"spawners_mobs_sandstone_carved_"..img[i]..".png"},
		is_ground_content = false,
		groups = {cracky = 2},
		sounds = default.node_sound_stone_defaults(),
	})
end
