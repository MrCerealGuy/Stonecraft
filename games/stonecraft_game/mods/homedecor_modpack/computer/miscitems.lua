-- Copyright (C) 2012-2013 Diego Martínez <kaeza@users.sf.net>

-- This file defines some items in order to not have to depend on other mods.

local S = homedecor_i18n.gettext

if (not minetest.get_modpath("homedecor")) then

	minetest.register_craftitem(":basic_materials:plastic_sheet", {
		description = S("Plastic sheet"),
		inventory_image = "homedecor_plastic_sheeting.png",
	})

	minetest.register_craftitem(":homedecor:plastic_base", {
		description = S("Unprocessed Plastic base"),
		wield_image = "homedecor_plastic_base.png",
		inventory_image = "homedecor_plastic_base_inv.png",
	})

	minetest.register_craft({
		type = "shapeless",
		output = 'homedecor:plastic_base 6',
		recipe = { "default:junglegrass",
		   "default:junglegrass",
		   "default:junglegrass"
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = 'homedecor:plastic_base 3',
		recipe = { "default:dry_shrub",
		   "default:dry_shrub",
		   "default:dry_shrub"
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = 'homedecor:plastic_base 4',
		recipe = { "default:leaves",
			   "default:leaves",
			   "default:leaves",
			   "default:leaves",
			   "default:leaves",
			   "default:leaves"
		}
	})

	minetest.register_craft({
		type = "cooking",
		output = "basic_materials:plastic_sheet",
		recipe = "homedecor:plastic_base",
	})

	minetest.register_craft({
		type = 'fuel',
		recipe = 'homedecor:plastic_base',
		burntime = 30,
	})

	minetest.register_craft({
		type = 'fuel',
		recipe = 'basic_materials:plastic_sheet',
		burntime = 30,
	})

end -- not homedecor
