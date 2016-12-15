-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief animalmaterials
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

core.log("action","MOD: animalmaterials loading ...")
local version = "0.1.3"


animalmaterialsdata = {}
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Node definitions
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Item definitions
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- deamondeath sword
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_tool("animalmaterials:sword_deamondeath", {
	description = S("Sword (Deamondeath)"),
	inventory_image = "default_tool_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.50,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=10, maxlevel=1},
			snappy={times={[2]=0.70, [3]=0.30}, uses=40, maxlevel=1},
			choppy={times={[3]=0.70}, uses=40, maxlevel=0},
			deamon={times={[1]=0.25, [2]=0.10, [3]=0.05}, uses=20, maxlevel=3},
		}
	}
	})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- scissors
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_tool("animalmaterials:scissors", {
	description = S("Scissors"),
	inventory_image = "animalmaterials_scissors.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			wool  = {uses=40,maxlevel=1}
		}
	},
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- lasso
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:lasso", {
	description = S("Lasso"),
	image = "animalmaterials_lasso.png",
	stack_max=10,
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- net
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:net", {
	description = S("Net"),
	image = "animalmaterials_net.png",
	stack_max=10,
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- saddle
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:saddle", {
	description = S("Saddle"),
	image = "animalmaterials_saddle.png",
	stack_max=1
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- contract
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:contract", {
	description = S("Contract"),
	image = "animalmaterials_contract.png",
	stack_max=10,
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- meat
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:meat_raw", {
	description = S("Raw meat"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
minetest.register_craftitem("animalmaterials:meat_pork", {
	description = S("Pork (raw)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
minetest.register_craftitem("animalmaterials:meat_beef", {
	description = S("Beef (raw)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
minetest.register_craftitem("animalmaterials:meat_chicken", {
	description = S("Chicken (raw)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
minetest.register_craftitem("animalmaterials:meat_lamb", {
	description = S("Lamb (raw)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
minetest.register_craftitem("animalmaterials:meat_venison", {
	description = S("Venison (raw)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
minetest.register_craftitem("animalmaterials:meat_undead", {
	description = S("Meat (not quite dead)"),
	image = "animalmaterials_meat_undead_raw.png",
	on_use = minetest.item_eat(-2),
	groups = { meat=1, eatable=1 },
	stack_max=5
})
minetest.register_craftitem("animalmaterials:meat_toxic", {
	description = S("Toxic Meat"),
	image = "animalmaterials_meat_toxic_raw.png",
	on_use = minetest.item_eat(-5),
	groups = { meat=1, eatable=1 },
	stack_max=5
})
minetest.register_craftitem("animalmaterials:meat_ostrich", {
	description = S("Ostrich Meat"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(3),
	groups = { meat=1, eatable=1 },
	stack_max=5
})
minetest.register_craftitem("animalmaterials:pork_raw", {
	description = S("Pork"),
	image = "animalmaterials_pork_raw.png",
	on_use = minetest.item_eat(4),
	groups = { meat=1, eatable=1 },
	stack_max=5
})

minetest.register_craftitem("animalmaterials:fish_bluewhite", {
	description = S("Fish (bluewhite)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})

minetest.register_craftitem("animalmaterials:fish_clownfish", {
	description = S("Fish (clownfish)"),
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- feather
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:feather", {
	description = S("Feather"),
	image = "animalmaterials_feather.png",
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- milk
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:milk", {
	description = S("Milk"),
	image = "animalmaterials_milk.png",
	on_use = minetest.item_eat(1),
	groups = { eatable=1 },
	stack_max=10
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- egg
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:egg", {
	description = S("Egg"),
	image = "animalmaterials_egg.png",
	stack_max=10
})

minetest.register_craftitem("animalmaterials:egg_big", {
	description = S("Egg (big)"),
	image = "animalmaterials_egg_big.png",
	stack_max=5
})

animalmaterialsdata["animalmaterials_egg"] = {
			graphics_3d = {
				visual = "mesh",
				mesh   = "animalmaterials_egg_ent.b3d",
				textures = { "animalmaterials_egg_ent_mesh.png" },
				collisionbox = { -0.12,-0.125,-0.12,0.12,0.125,0.12 },
				visual_size     = {x=1,y=1,z=1},
				}
	}
	
animalmaterialsdata["animalmaterials_egg_big"] = {
			graphics_3d = {
				visual = "mesh",
				mesh   = "animalmaterials_egg_ent.b3d",
				textures = { "animalmaterials_egg_ent_mesh.png" },
				collisionbox = { -0.24,-0.25,-0.24,0.24,0.25,0.24 },
				visual_size     = {x=2,y=2,z=2},
				}
	}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- bone
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:bone", {
	description = S("Bone"),
	image = "animalmaterials_bone.png",
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- furs
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:fur", {
	description = S("Fur"),
	image = "animalmaterials_fur.png",
	stack_max=25
})

minetest.register_craftitem("animalmaterials:fur_deer", {
	description = S("Deer fur"),
	image = "animalmaterials_deer_fur.png",
	stack_max=10
})

minetest.register_craftitem("animalmaterials:coat_cattle", {
	description = S("Cattle coat"),
	image = "animalmaterials_cattle_coat.png",
	stack_max=10
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- horns
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:deer_horns", {
	description = S("Deer horns"),
	image = "animalmaterials_deer_horns.png",
	stack_max=20
})

minetest.register_craftitem("animalmaterials:ivory", {
	description = S("Ivory"),
	image = "animalmaterials_ivory.png",
	stack_max=20
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- scale
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:scale_golden", {
	description = S("Scale (golden)"),
	image = "animalmaterials_scale_golden.png",
	stack_max=25
})
minetest.register_craftitem("animalmaterials:scale_white", {
	description = S("Scale (white)"),
	image = "animalmaterials_scale_white.png",
	stack_max=25
})
minetest.register_craftitem("animalmaterials:scale_grey", {
	description = S("Scale (grey)"),
	image = "animalmaterials_scale_grey.png",
	stack_max=25
})
minetest.register_craftitem("animalmaterials:scale_blue", {
	description = S("Scale (blue)"),
	image = "animalmaterials_scale_blue.png",
	stack_max=25
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- recipes
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"animalmaterials:feather","animalmaterials:feather","animalmaterials:feather"},
		{"animalmaterials:feather", "animalmaterials:feather","animalmaterials:feather"},
		{"animalmaterials:feather","animalmaterials:feather","animalmaterials:feather"},
	}
})

minetest.register_craft({
	output = "animalmaterials:contract",
	recipe = {
		{"default:paper"},
		{"default:paper"},
	}
})

core.log("action","MOD: animalmaterials mod version " .. version .. " loaded")

