--Materials
minetest.register_node("nssb:memoryone", {
	description = "Memoryone",
	tiles = {"very_mossy_stone_brick.png"},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:mossy_stone_brick", {
	description = "Mossy Stone Brick",
	tiles = {"mossy_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:stone_brick", {
	description = "Stone Brick",
	tiles = {"default_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:very_mossy_stone_brick", {
	description = "Very Mossy Stone Brick",
	tiles = {"very_mossy_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:mossy_stone_column", {
	description = "Mossy Stone Column",
	tiles = {"mossy_stone_column.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:stone_column", {
	description = "Stone Column",
	tiles = {"stone_column.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:marine_stone", {
	description = "Seastone",
	tiles = {"marine_stone.png"},
	is_ground_content = false,
	groups = {cracky=1, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:marine_brick", {
	description = "Seastone Brick",
	tiles = {"marine_brick.png"},
	is_ground_content = false,
	groups = {stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:marine_meselamp", {
	description = "Sea Meselamp",
	tiles = {"marine_meselamp.png"},
	is_ground_content = false,
	groups = {cracky=3},
	drop = "",
	light_source = 15,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("nssb:morlamp", {
	description = "Morlamp",
	tiles = {"morlamp.png"},
	is_ground_content = false,
	groups = {cracky=3},
	drop = "",
	light_source = 15,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("nssb:mantis_clay", {
	description = "Mantis Clay",
	tiles = {"mantis_clay.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:hardened_mantis_clay", {
	description = "Hardened Mantis Clay",
	tiles = {"hard_mantis_clay.png"},
	is_ground_content = false,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:ant_stone", {
	description = "Ant Stone",
	tiles = {"ant_stone.png"},
	is_ground_content = false,
	groups = {cracky=1, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:vine", {
	description = "Vine",
	drawtype = "signlike",
	tiles = {"climbing_plant.png"},
	inventory_image = {"vine.png"},
	walkable = false,
	climbable = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	selection_box = {type="wallmounted"},
	legacy_wallmounted = true,
	groups = {flammable=3, snappy = 3},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("nssb:liana", {
	description = "Liana",
	drawtype = "plantlike",
	inventory_image = {"liana.png"},
	tiles = {"liana.png"},
	paramtype = "light",
	walkable = false,
	climbable = true,
	groups = {flammable=3, snappy = 3},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("nssb:vertical_web", {
	description = "Vertical Web",
	inventory_image = "vertical_web.png",
	tile_images = {"vertical_web.png"} ,
    drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "nssm:web",
	drowning = 0,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_range= 0,
	liquid_alternative_flowing = "nssb:vertical_web",
	liquid_alternative_source = "nssb:vertical_web",
	liquid_viscosity = 20,
	groups = {flammable=2, snappy=1, liquid=1},
})

minetest.register_node("nssb:web_cone_up", {
	description = "Web Cone Up",
	inventory_image = "web_cone_up.png",
	tile_images = {"web_cone_up.png"} ,
    drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "nssm:web",
	drowning = 0,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_range= 0,
	liquid_alternative_flowing = "nssb:web_cone_up",
	liquid_alternative_source = "nssb:web_cone_up",
	liquid_viscosity = 20,
	groups = {flammable=2, snappy=1, liquid=1},
})

minetest.register_node("nssb:web_cone_down", {
	description = "Web Cone Down",
	inventory_image = "web_cone_down.png",
	tile_images = {"web_cone_down.png"} ,
    drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "nssm:web",
	drowning = 0,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_range= 0,
	liquid_alternative_flowing = "nssb:web_cone_down",
	liquid_alternative_source = "nssb:web_cone_down",
	liquid_viscosity = 20,
	groups = {flammable=2, snappy=1, liquid=1},
})

minetest.register_craft({
	output = 'nssb:marine_meselamp',
	recipe = {
		{'default:glass', 'bucket:bucket_water', 'default:glass'},
		{'default:glass', 'default:mese_crystal', 'default:glass'},
		{'default:glass', 'bucket:bucket_water', 'default:glass'},
	}
})

minetest.register_craft({
	output = 'nssb:morlamp',
	recipe = {
		{'nssb:morelentir_dust','nssb:morelentir_dust','nssb:morelentir_dust',},
		{'nssb:morelentir_dust','nssb:morelentir_dust','nssb:morelentir_dust',},
		{'nssb:morelentir_dust','nssb:morelentir_dust','nssb:morelentir_dust',},
	}
})

minetest.register_node("nssb:web_cocoon", {
	description = "Web Cocoon",
	tiles = {"web_cocoon.png"},
	drop = {
         max_items = 1,
         items = {
			{
                 items = {'node "nssm:spider_leg" 2'},
                 rarity = 4
             },
			  {
                 items = {'node "nssm:web 1'},
                 rarity = 4
             },
             {
                 items = {'node "nssm:ant_sword" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:sun_sword" 1'},
                 rarity = 100
             },
			 {
                 items = {'node "nssm:night_sword" 1'},
                 rarity = 100
             },
			 {
                 items = {'node "nssm:spear_ant" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:spear_mantis" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:spear_manticore" 1'},
                 rarity = 22
             },
			 {
                 items = {'node "nssm:spear_little_ice_tooth" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:spear_duck_beak" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "default:sword_wood" 1'},
                 rarity = 14
             },
			 {
                 items = {'node "default:sword_steel" 1'},
                 rarity = 20
             },{
                 items = {'node "default:sword_mese" 1'},
                 rarity = 20
             },{
                 items = {'node "default:axe_bronze" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:raw_scrausics_wing" 2'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:nssm:mantis_claw" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "default:axe_mese" 1'},
                 rarity = 20
             },
             {
                 items = {'node "nssm:mantis_sword" 1'},
				 rarity = 20
             },
			 {
                 items = {'node "default:axe_steel" 1'},
                 rarity = 20
             },
			 {
                 items = {'node "nssm:crab_light_mace" 1'},
				 rarity = 20
             },
			 {
                 items = {'node "nssm:masticone_fang_sword" 1'},
				 rarity = 20
             }
         }
    },
	is_ground_content = false,
	groups = {snappy=1, flammable=2},
})


--Eggs

function nssb_register_eggs (
name, -- name of the mobs and the eggs
descr, -- Description of the mob and eggs
int, -- time interval between each birth
wide, -- the radius in wich mobs are generated
troppi, -- maximun number of mobs spawned
neigh, -- block that need to be near for spawning the mobs
night, --if only at night
lumin) --luminosity parameter of the egg_block

	minetest.register_node("nssb:".. name .."_eggs", {
		description = descr .." Eggs",
		tiles = {name .."_eggs.png"},
		light_source = lumin,
		is_ground_content = false,
		groups = {choppy=1},
	})


	minetest.register_abm({
	nodenames = {"nssb:".. name .."_eggs"},
	neighbors = {neigh},
	interval = int,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local pos1 = {x=pos.x+math.random(-wide,wide), y=pos.y+0.5, z=pos.z+math.random(-wide,wide)}
		local n = minetest.env:get_node(pos1).name
		if n ~= "air" and n ~= "default:water_source" then
			return
		end
		local count = 0

		local objects = minetest.env:get_objects_inside_radius(pos, 12)
		for _,obj in ipairs(objects) do
			count = count +1
			--minetest.chat_send_all("Count: "..count)
		end

		local t = minetest.get_timeofday()
		--minetest.chat_send_all("Time of day: "..t)
		if (t>=0.75 and t<=1) or (t>=0 and t<=0.25) or night==false then
			if count < troppi then
				minetest.add_entity(pos1, "nssm:" .. name)
			end
		end
	end
	})

end

nssb_register_eggs ('ant_worker', 'Ant Worker', 16, 2, 4, "air", false, 5)
nssb_register_eggs ('ant_soldier', 'Ant Soldier', 16, 2, 4, "air", false, 5)
nssb_register_eggs ('larva', 'Larva', 16, 2, 4, "air", false, 5)
nssb_register_eggs ('crab', 'Crab', 18, 2, 4, "default:sand", false, 5)
nssb_register_eggs ('black_widow', 'Black Widow', 18, 2, 4, "air", false, 5)
nssb_register_eggs ('uloboros', 'Uloboros', 18, 2, 4, "air", false, 5)
nssb_register_eggs ('daddy_long_legs', 'Daddy Long Legs', 18, 2, 4, "air", false, 5)
nssb_register_eggs ('xgaloctopus', 'Xgaloctopus', 18, 2, 4, "default:water_source", false, 5)
nssb_register_eggs ('bloco', 'Bloco', 14, 2, 4, "default:gravel", false, 5)
nssb_register_eggs ('icesnake', 'Icesnake', 18, 2, 4, "default:ice", false, 5)
nssb_register_eggs ('snow_biter', 'Snowbiter', 18, 2, 4, "default:ice", false, 5)
nssb_register_eggs ('scrausics', 'Scrausics', 18, 2, 4, "air", false, 5)
nssb_register_eggs ('moonheron', 'Moonheron', 18, 2, 4, "air", true, 0)

function nssb_register_eggboss (
name, -- name of the mobs and the eggs
descr, -- Description of the mob and eggs
int, -- time interval between each birth
wide, -- the radius in wich mobs are generated
troppi, -- maximun number of mobs spawned
neigh, -- block that need to be near for spawning the mobs
night, --if only at night
lumin) --luminosity parameter of the egg_block

	minetest.register_node("nssb:".. name .."_eggboss", {
		description = descr .." Eggs",
		tiles = {name .."_eggs.png"},
		light_source = lumin,
		is_ground_content = false,
		groups = {choppy=1},
	})


	minetest.register_abm({
	nodenames = {"nssb:".. name .."_eggboss"},
	neighbors = {neigh},
	interval = int,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local pos1 = {x=pos.x+math.random(-wide,wide), y=pos.y+0.5, z=pos.z+math.random(-wide,wide)}
		local n = minetest.env:get_node(pos1).name
		if n ~= "air" and n ~= "default:water_source" then
			return
		end
		local count = 0

		local objects = minetest.env:get_objects_inside_radius(pos, 12)
		for _,obj in ipairs(objects) do
			count = count +1
			--minetest.chat_send_all("Count: "..count)
		end

		local t = minetest.get_timeofday()
		--minetest.chat_send_all("Time of day: "..t)
		if (t>=0.75 and t<=1) or (t>=0 and t<=0.25) or night==false then
			if count < troppi then
				minetest.add_entity(pos1, "nssm:" .. name)
			end
		end
	end
	})

end
--Bosses of the eggs:
nssb_register_eggboss ('phoenix', 'Phoenix', 900, 10, 1, "air", false, 15)
nssb_register_eggboss ('tarantula', 'Tarantula', 900, 2, 1, "air", false, 5)
nssb_register_eggboss ('night_master', 'Night Master', 900, 10, 1, "air", true, 0)
nssb_register_eggboss ('ant_queen', 'Ant Queen', 900, 10, 1, "air", false, 5)
nssb_register_eggboss ('icelamander', 'Icelamander', 900, 10, 1, "air", false, 5)


minetest.register_node("nssb:giant_sandworm_eggs", {
		description = "Giant Sandworm Egg",
		tiles = {"giant_sandworm_eggs.png"},
		is_ground_content = false,
		groups = {choppy=1},
	})

minetest.register_abm({
	nodenames = {"nssb:giant_sandworm_eggs"},
	neighbors = {"default:desert_stone"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local pos1 = {x=pos.x, y=pos.y+1, z=pos.z}
		local n = minetest.env:get_node(pos1).name
		if n ~= "air" then
			return
		end
		minetest.add_entity(pos1, "nssm:giant_sandworm")
		minetest.remove_node(pos)
end
})

--Morlavala nodes

minetest.register_node("nssb:morentir", {
	description = "Dark Stone",
	tiles = {"morentir.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:boum_morentir", {
	description = "Exploding Dark Stone",
	tiles = {"morentir.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = "nssb:morentir",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:fall_morentir", {
	description = "Falling Dark Stone",
	tiles = {"morentir.png"},
	is_ground_content = true,
	groups = {cracky=1,falling_node = 1},
	drop = "nssb:morentir",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:indistructible_morentir", {
	description = "Dark Indistructible Stone",
	tiles = {"morentir.png"},
	--groups = {oddly_breakable_by_hand = 2},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
})

minetest.register_node("nssb:morelentir", {
	description = "Dark Starred Stone",
	inventory_image = minetest.inventorycube("morelentir.png"),
	light_source = 10,
	drop = "nssm:morelentir_dust",
	tiles = {
		{
			name = "morelentir_animated.png",
			animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 6.0},
		},},
	is_ground_content = false,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:morkemen", {
	description = "Dark Dirt",
	tiles = {"morkemen.png"},
	is_ground_content = true,
	groups = {crumbly=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("nssb:morvilya", {
	description = "Dark Air",
	drawtype = "airlike",
	tiles = {"morvilya.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	damage_per_second = 2,
	post_effect_color = {a=800, r=1, g=1, b=1},
})

minetest.register_node("nssb:mornar", {
	description = "Black Flame",
	drawtype = "firelike",
	tiles = {{
		name = "mornar_animated.png",
		animation = {type = "vertical_frames",
			aspect_w = 16, aspect_h = 16, length = 1},
	}},
	inventory_image = "mornar.png",
	light_source = 12,
	groups = {igniter = 2},
	drop = '',
	walkable = false,
	buildable_to = false,
	damage_per_second = 4,
	})

minetest.register_node("nssb:mornen", {
	description = "Black Water",
	inventory_image = minetest.inventorycube("mornen.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "mornen_animated.png",
			animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
		},
	},
	alpha = 650,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = true,
	drop = "",
	light_source = 14,
	liquid_range= 4,
	drowning = 1,
	liquid_renewable = true,
	damage_per_second = 2,
	liquidtype = "source",
	liquid_alternative_flowing = "nssb:mornen_flowing",
	liquid_alternative_source = "nssb:mornen",
	liquid_viscosity = 6,
	post_effect_color = {a=500, r=1, g=1, b=1},
	groups = {liquid=3, puts_out_fire=1},
})

minetest.register_node("nssb:mornen_flowing", {
	description = "Flowing Dark Water",
	inventory_image = minetest.inventorycube("mornen.png"),
	drawtype = "flowingliquid",
	tiles= {"mornen.png"},
	special_tiles = {
		{
			name = "mornen_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "mornen_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 10,
	alpha = 650,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nssb:mornen_flowing",
	liquid_alternative_source = "nssb:mornen",
	liquid_viscosity = 6,
	liquid_renewable = true,
	damage_per_second = 2,
	post_effect_color = {a=500, r=1, g=1, b=1},
	groups = {liquid=3, puts_out_fire=1, water=1, not_in_creative_inventory=1},
})

minetest.register_node("nssb:portal", {
	description = "Morlendor Portal",
	inventory_image = minetest.inventorycube("mornen.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "mornen_animated.png",
			animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
		},
	},
	alpha = 800,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	light_source = 15,
	liquid_range= 0,
	drowning = 1,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_alternative_flowing = "nssb:portal",
	liquid_alternative_source = "nssb:portal",
	liquid_viscosity = 0,
	post_effect_color = {a=10, r=1, g=1, b=1},
	groups = {liquid=3, puts_out_fire=1},
	on_blast = function() end,
})

minetest.register_node("nssb:portalhome", {
	description = "Home Portal",
	inventory_image = minetest.inventorycube("portalhome.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "portalhome_animated.png",
			animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
		},
	},
	alpha = 800,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	light_source = 15,
	liquid_range= 0,
	drowning = 1,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_alternative_flowing = "nssb:portalhome",
	liquid_alternative_source = "nssb:portalhome",
	liquid_viscosity = 0,
	post_effect_color = {a=10, r=1, g=1, b=1},
	groups = {liquid=3, puts_out_fire=1},
	on_blast = function() end,
})

minetest.register_node("nssb:morlote", {
	description = "Morlote",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"morlote.png"},
	inventory_image = "morlote.png",
	wield_image = "morlote.png",
	paramtype = "light",
	light_source= 14,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node("nssb:moranga", {
	description = "Moranga Ore",
	tiles = {"morentir.png^moranga.png"},
	groups = {cracky = 1},
	drop = 'nssb:moranga_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nssb:life_energy_ore", {
	description = "Life Energy Ore",
	tiles = {"morentir.png^life_energy_ore.png"},
	groups = {cracky = 1},
	light_source = 4,
	drop = 'nssm:energy_globe',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("nssb:moranga_lump", {
	description = "Moranga Lump",
	image = "moranga_lump.png",
})

minetest.register_craft({
	type = "cooking",
	output = "nssb:moranga_ingot",
	recipe = "nssb:moranga_lump",
	cooktime = 160,
})

minetest.register_craftitem("nssb:moranga_ingot", {
	description = "Moranga Ingot",
	image = "moranga_ingot.png",
})


minetest.register_node("nssb:morvalar_block", {
	description = "Morvalar Block",
	tiles = {"morvalar_block.png"},
	light_source = 13,
})

minetest.register_node("nssb:dis_morvalar_block", {
	description = "Disactivated Morvalar Block",
	tiles = {"dis_morvalar_block.png"},
	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "nssm:superior_energy_globe" then
			minetest.set_node(pos, {name="nssb:morvalar_block"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"nssb:morvalar_block"},
	neighbors = {"nssb:indistructible_morentir"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.remove_node(pos)
		minetest.add_entity(pos, "nssm:morvalar")
	end
})
