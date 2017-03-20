


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
	-- the small selection box allows the player to dig one or two nodes below
	selection_box = {
                type = "fixed",
                fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 0.5, 2 / 16}
        },
})


minetest.register_craft({
	output = "handle_schematics:support 4",
	recipe = {
		{"group:stick", "", "group:stick" }
        }
})


-- no craft receipe for this node as it's only an indicator that the player shall dig here
minetest.register_node("handle_schematics:dig_here", {
	description = "dig the node below this one",
	tiles = {"default_tool_mesepick.png^[colorize:#FF0000^[transformFXR90"},
	inventory_image = "default_tool_mesepick.png^[colorize:#FF0000^[transformFXR90";
	-- falling node; will notice if the node below it is beeing digged; cannot be destroyed the normal way
	groups = {falling_node = 1},
	visual_scale = 0.6,
	walkable = false,
	climbable = true,
	paramtype = "light",
	drawtype = "torchlike",
	-- this node's purpose is to indicate that the player shall dig here;
	-- that requires beeing able to actually aim at that node below
	selection_box = {
                type = "fixed",
                fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}
        },

})
