


---------------------------------------------------------------------------------------
-- helper node that is used during construction of a house; scaffolding
---------------------------------------------------------------------------------------

minetest.register_node("handle_schematics:support", {
        description = "support structure for buildings",
        tiles = {"handle_schematics_support.png"},
	groups = {snappy=3,choppy=3,oddly_breakable_by_hand=3},
	visual_scale = 1.2,
        walkable = false,
        climbable = true,
        paramtype = "light",
        drawtype = "plantlike",
})


minetest.register_craft({
	output = "handle_schematics:support 4",
	recipe = {
		{"group:stick", "", "group:stick" }
        }
})
