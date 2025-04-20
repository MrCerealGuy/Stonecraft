
-- Override grass to drop wheat and oat seeds

local rarity_lookup = {[1] = 50, [2] = 50, [3] = 50, [4] = 5, [5] = 5}

if minetest.registered_nodes["default:grass_1"] then

	for i = 1, 5 do

		minetest.override_item("default:grass_" .. i, {
			drop = {
				max_items = 1,
				items = {
					{items = {"farming:seed_wheat"}, rarity = rarity_lookup[i]},
					{items = {"farming:seed_oat"},rarity = rarity_lookup[i]},
					{items = {"default:grass_1"}}
				}
			}
		})
	end
end

-- override dry grass to drop barley and rye seeds

if minetest.registered_nodes["default:dry_grass_1"] then

	for i = 1, 5 do

		minetest.override_item("default:dry_grass_" .. i, {
			drop = {
				max_items = 1,
				items = {
					{items = {"farming:seed_barley"}, rarity = rarity_lookup[i]},
					{items = {"farming:seed_rye"}, rarity = rarity_lookup[i]},
					{items = {"default:dry_grass_1"}}
				}
			}
		})
	end
end

-- override jungle grass to drop cotton and rice seeds

if minetest.registered_nodes["default:junglegrass"] then

	minetest.override_item("default:junglegrass", {
		drop = {
			max_items = 1,
			items = {
				{items = {"farming:seed_cotton"}, rarity = 8},
				{items = {"farming:seed_rice"}, rarity = 8},
				{items = {"default:junglegrass"}}
			}
		}
	})
end

-- override mineclone tallgrass to drop all sof the above seeds

if farming.mcl then

	minetest.override_item("mcl_flowers:tallgrass", {
		drop = {
			max_items = 1,
			items = {
				{items = {"mcl_farming:wheat_seeds"}, rarity = 5},
				{items = {"farming:seed_oat"},rarity = 5},
				{items = {"farming:seed_barley"}, rarity = 5},
				{items = {"farming:seed_rye"},rarity = 5},
				{items = {"farming:seed_cotton"}, rarity = 8},
				{items = {"farming:seed_rice"},rarity = 8}
			}
		}
	})
end

