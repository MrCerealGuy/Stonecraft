-- Copyright (C) 2012-2013 Diego Martínez <kaeza@users.sf.net>

minetest.register_craft({
	output = "computer:shefriendSOO",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:glass", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "group:wood", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:slaystation",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "group:wood", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:vanio",
	recipe = {
		{ "basic_materials:plastic_sheet", "", "" },
		{ "default:glass", "", "" },
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:specter",
	recipe = {
		{ "", "", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:slaystation2",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:steel_ingot", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:admiral64",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "group:wood", "group:wood", "group:wood" }
	}
})

minetest.register_craft({
	output = "computer:admiral128",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	}
})

minetest.register_craft({
	output = "computer:wee",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:copper_ingot", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:piepad",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:glass", "basic_materials:plastic_sheet" }
	}
})

--new stuff

minetest.register_craft({
	output = "computer:monitor",
	recipe = {
		{ "basic_materials:plastic_sheet", "default:glass","" },
		{ "basic_materials:plastic_sheet", "default:glass","" },
		{ "basic_materials:plastic_sheet", "default:mese_crystal_fragment", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:router",
	recipe = {
		{ "default:steel_ingot","","" },
		{ "default:steel_ingot" ,"basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "default:mese_crystal_fragment","basic_materials:plastic_sheet", "basic_materials:plastic_sheet"  }
	}
})

minetest.register_craft({
	output = "computer:tower",
	recipe = {
		{ "basic_materials:plastic_sheet", "default:steel_ingot", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:mese_crystal", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:steel_ingot", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:printer",
	recipe = {
		{ "basic_materials:plastic_sheet", "default:steel_ingot","" },
		{ "basic_materials:plastic_sheet", "default:mese_crystal", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:coal_lump", "basic_materials:plastic_sheet" }
	}
})

minetest.register_craft({
	output = "computer:printer",
	recipe = {
		{ "basic_materials:plastic_sheet", "default:steel_ingot","" },
		{ "basic_materials:plastic_sheet", "default:mese_crystal", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "dye:black", "basic_materials:plastic_sheet", }
	}
})

minetest.register_craft({
	output = "computer:server",
	recipe = {
		{ "computer:tower", "computer:tower", "computer:tower", },
		{ "computer:tower", "computer:tower", "computer:tower" },
		{ "computer:tower", "computer:tower", "computer:tower" }
	}
})

minetest.register_craft({
	output = "computer:tetris_arcade",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:energy_crystal", "basic_materials:plastic_sheet", },
		{ "dye:black", "default:glass", "dye:black" },
		{ "basic_materials:plastic_sheet", "basic_materials:energy_crystal", "basic_materials:plastic_sheet" }
	}
})
