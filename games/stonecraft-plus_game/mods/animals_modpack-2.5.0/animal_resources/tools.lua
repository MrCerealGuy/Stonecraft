-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file tools.lua
--! @brief tool initialization
--! @copyright Sapier
--! @author Sapier
--! @date 2014-08-11
--
--! @defgroup tools
--! @brief tool entitys used by animals modpack
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


function ar_init_tool_crafts()
	minetest.register_craft({
		output = "animalmaterials:lasso 5",
		recipe = {
			{'', "wool:white",''},
			{"wool:white",'', "wool:white"},
			{'',"wool:white",''},
		}
	})

	minetest.register_craft({
		output = "animalmaterials:net 1",
		recipe = {
			{"wool:white",'',"wool:white"},
			{'', "wool:white",''},
			{"wool:white",'',"wool:white"},
		}
	})

	minetest.register_craft({
	output = 'animalmaterials:sword_deamondeath',
	recipe = {
		{'animalmaterials:bone'},
		{'animalmaterials:bone'},
		{'default:stick'},
	}
	})
end