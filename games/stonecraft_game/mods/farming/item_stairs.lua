
-- check and register stairs

if minetest.global_exists("stairs") then

	if stairs.mod and stairs.mod == "redo" then

		stairs.register_all("straw", "farming:straw",
			{snappy = 3, flammable = 4},
			{"farming_straw.png"},
			"Straw",
			farming.node_sound_leaves_defaults())

		stairs.register_all("hemp_block", "farming:hemp_block",
			{snappy = 2, oddly_breakable_by_hand = 1, flammable = 2},
			{"farming_hemp_block.png"},
			"Hemp Block",
			farming.node_sound_leaves_defaults())
	else

		stairs.register_stair_and_slab("straw", "farming:straw",
			{snappy = 3, flammable = 4},
			{"farming_straw.png"},
			"Straw Stair",
			"Straw Slab",
			farming.node_sound_leaves_defaults())

		stairs.register_stair_and_slab("hemp_block", "farming:hemp_block",
			{snappy = 2, oddly_breakable_by_hand = 1, flammable = 2},
			{"farming_hemp_block.png"},
			"Hemp Block Stair",
			"Hemp Block Slab",
			farming.node_sound_leaves_defaults())
	end
end
