


---------------------------------------------------------------------------------------
-- helper node that is used during construction of a house; scaffolding
---------------------------------------------------------------------------------------

minetest.register_node("handle_schematics:support", {
        description = "support structure for buildings",
        tiles = {"handle_schematics_support.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        walkable = false,
        climbable = true,
        paramtype = "light",
        drawtype = "plantlike",
})


minetest.register_craft({
	output = "handle_schematics:support",
	recipe = {
		{"default:stick", "", "default:stick", }
        }
})
