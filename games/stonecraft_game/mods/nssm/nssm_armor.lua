-- Armors
local stats = {
	wolf = {name = "Werewolf", armor = 2.8, heal = 0, use = 800},
	whitewolf = {name = "White Werewolf", armor = 2.8, heal = 0, use = 800},
	bloco = {name = "Bloco", armor = 3.2, heal = 0, use = 500},
	croco = {name = "Crocodile", armor = 3, heal = 0, use = 450},
	ant = {name = "Ant", armor = 3, heal = 0, use = 400},
	ice = {name = "Ice Teeth", armor = 3.2, heal = 0, use = 410},
	felucco = {name = "Felucco", armor = 2.8, heal = 0, use = 800},
	manticore = {name = "Manticore", armor = 3.4, heal = 0, use = 440},
	duck = {name = "Duck", armor = 1.5, heal = 0, use = 1000},
	black_duck = {name = "Black Duck", armor = 1.5, heal = 0, use = 900},
	mor = {name = "Morlu", armor = 5.3, heal = 0, use = 30},
	sky = {name = "Sky", armor = 4.2, heal = 0, use = 100},
	sandworm = {name = "Sandworm", armor = 3.4, heal = 0, use = 400},
	sandbloco = {name = "Sand Bloco", armor = 3.2, heal = 0, use = 500},
	web = {name = "Cobweb String", armor = 2.4, heal = 0, use = 900},
	denseweb = {name = "Dense Cobweb String", armor = 3.5, heal = 0, use = 400}
}

local materials = {
	wolf = "nssm:wolf_fur",
	whitewolf = "nssm:white_wolf_fur",
	bloco = "nssm:bloco_skin",
	croco = "nssm:crocodile_skin",
	ant = "nssm:ant_hard_skin",
	ice = "nssm:little_ice_tooth",
	felucco = "nssm:felucco_fur",
	manticore = "nssm:manticore_fur",
	duck = "nssm:duck_feather",
	black_duck = "nssm:black_duck_feather",
	mor =  "nssm:lustful_moranga",
	sandbloco = "nssm:sand_bloco_skin",
	sandworm = "nssm:sandworm_skin",
	sky = "nssm:sky_iron",
	web = "nssm:web_string",
	denseweb = "nssm:dense_web_string"
}

for k, v in pairs(stats) do

	minetest.register_tool("nssm:helmet_" .. k, {
		description = v.name .. " Helmet",
		inventory_image = "inv_helmet_" .. k .. ".png",
		groups = {
			armor_head = math.floor(4 * v.armor),
			armor_heal = v.heal,
			armor_use = v.use
		},
		wear = 0
	})

	minetest.register_tool("nssm:chestplate_" .. k, {
		description = v.name .. " Chestplate",
		inventory_image = "inv_chestplate_" .. k .. ".png",
		groups = {
			armor_torso = math.floor(6 * v.armor),
			armor_heal = v.heal,
			armor_use = v.use
		},
		wear = 0
	})

	minetest.register_tool("nssm:leggings_" .. k, {
		description = v.name .. " Leggings",
		inventory_image = "inv_leggings_" .. k .. ".png",
		groups = {
			armor_legs = math.floor(5 * v.armor),
			armor_heal = v.heal,
			armor_use = v.use
		},
		wear = 0
	})

	minetest.register_tool("nssm:boots_" .. k, {
		description = v.name .. " Boots",
		inventory_image = "inv_boots_" .. k .. ".png",
		groups = {
			armor_feet = math.floor(3 * v.armor),
			armor_heal = v.heal,
			armor_use = v.use
		},
		wear = 0
	})
end

for k, v in pairs(materials) do

	minetest.register_craft({
		output = "nssm:helmet_" .. k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""}
		}
	})

	minetest.register_craft({
		output = "nssm:chestplate_" .. k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v}
		}
	})

	minetest.register_craft({
		output = "nssm:leggings_" .. k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v}
		}
	})

	minetest.register_craft({
		output = "nssm:boots_" .. k,
		recipe = {
			{v, "", v},
			{v, "", v}
		}
	})
end

--shields
if minetest.get_modpath("shields") then

	local stats = {
		crab = {name = "Crab", armor = 4, heal = 0, use = 500},
		ice = {name = "Ice Teeth", armor = 3.5, heal = 0, use = 600},
		mor = {name = "Morlu", armor = 5, use = 100},
		masticone = {name = "Masticone", armor = 4.5, use = 300},
		mantis = {name = "Mantis", armor = 3, use = 500}
	}

	local materials = {
		crab = "nssm:crab_carapace_fragment",
		ice = "nssm:little_ice_tooth",
		mor = "nssm:lustful_moranga",
		masticone = "nssm:masticone_skull_fragments",
		mantis = "nssm:mantis_skin"
	}

	for k, v in pairs(stats) do

		minetest.register_tool("nssm:shield_" .. k, {
			description = v.name .. " Shield",
			inventory_image = "inv_shield_" .. k .. ".png",
			groups = {
				armor_shield = math.floor(5 * v.armor),
				armor_heal = v.heal,
				armor_use = v.use
			},
			wear = 0
		})

		local m = materials[k]

		minetest.register_craft({
			output = "nssm:shield_" .. k,
			recipe = {
				{m, m, m},
				{m, m, m},
				{"", m, ""}
			}
		})
	end
end


--Special objects (pumpking helmet, masticone helmet, crowned masticone helmet, crown)
local stats = {
	pumpking = {name = "Pumpking Head", armor = 4, heal = 0, use = 100},
	masticone = {name = "Masticone Head", armor = 4, heal = 0, use = 100},
	crown = {name = "Dukking Crown", armor = 2, heal = 0, use = 50},
	masticone_crowned = {name = "Masticone Crowned Head", armor = 6, heal = 0, use = 20}
}

for k, v in pairs(stats) do

	minetest.register_tool("nssm:helmet_" .. k, {
		description = v.name .. " ",
		inventory_image ="inv_helmet_" .. k .. ".png",
		groups = {
			armor_head = math.floor(5 * v.armor),
			armor_heal = v.heal,
			armor_use = v.use
		},
		wear = 0
	})
end

minetest.register_tool("nssm:chestplate_snake", {
	description = "Snake Scute Chestplate",
	inventory_image ="inv_chestplate_snake.png",
	groups = {armor_torso = 40, armor_heal = 0, armor_use = 100},
	wear = 0
})

minetest.register_craft({
	output = "nssm:chestplate_snake",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "nssm:snake_scute", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

local tmp = "nssm:masticone_skull_fragments"

minetest.register_craft({
	output = "nssm:helmet_masticone",
	recipe = {
		{tmp, tmp, tmp},
		{tmp, tmp, tmp},
		{tmp, tmp, tmp}
	}
})

minetest.register_craft({
	output = "nssm:helmet_masticone_crowned",
	recipe = {
		{"", "nssm:helmet_crown", ""},
		{"", "nssm:helmet_masticone", ""},
		{"", "", ""}
	}
})
