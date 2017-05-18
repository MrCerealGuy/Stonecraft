--[[


2016-05-03 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed flying_duck

2017-05-18 MrCerealGuy: added intllib support

--]] 


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


--non eatable craftitems

function nssm_register_noneatcraftitems (name, descr)

minetest.register_craftitem("nssm:"..name, {
	description = descr,
	image = name ..".png",
})

end

nssm_register_noneatcraftitems ('sky_feather',S('Sky Feather'))
nssm_register_noneatcraftitems ('snake_scute',S('Snake Scute'))
nssm_register_noneatcraftitems ('eyed_tentacle',S('Eyed Tentacle'))
nssm_register_noneatcraftitems ('king_duck_crown',S('King Duck Crown'))
nssm_register_noneatcraftitems ('great_energy_globe',S('Great Energy Globe'))
nssm_register_noneatcraftitems ('superior_energy_globe',S('Superior Energy Globe'))
nssm_register_noneatcraftitems ('ant_queen_abdomen',S('Ant Queen Abdomen'))
nssm_register_noneatcraftitems ('masticone_skull',S('Masticone Skull'))
nssm_register_noneatcraftitems ('masticone_skull_fragments',S('Masticone Skull Fragments'))
nssm_register_noneatcraftitems ('masticone_skull_crowned',S('Masticone Skull Crowned'))
nssm_register_noneatcraftitems ('tentacle_curly',S('Kraken Tentacle'))
nssm_register_noneatcraftitems ('lava_titan_eye',S('Lava Titan Eye'))
nssm_register_noneatcraftitems ('duck_beak',S('Duck Beak'))
nssm_register_noneatcraftitems ('ice_tooth',S('Ice Tooth'))
nssm_register_noneatcraftitems ('little_ice_tooth',S('Little Ice Tooth'))
nssm_register_noneatcraftitems ('black_sand',S("Black Sand"))
nssm_register_noneatcraftitems ('black_ice_tooth',S('Black Ice Tooth'))
nssm_register_noneatcraftitems ('tarantula_chelicerae',S('Tarantula Chelicerae'))
nssm_register_noneatcraftitems ('crab_chela',S('Crab Chela'))
nssm_register_noneatcraftitems ('cursed_pumpkin_seed',S('Cursed Pumpkin Seed'))
nssm_register_noneatcraftitems ('mantis_claw',S('Mantis Claw'))
--nssm_register_noneatcraftitems ('manticore_fur','Manticore Fur')
--nssm_register_noneatcraftitems ('ant_hard_skin','Ant Hard Skin')
--nssm_register_noneatcraftitems ('bloco_skin','Bloco Skin')
--nssm_register_noneatcraftitems ('crab_carapace_fragment','Crab Carapace Fragment')
--nssm_register_noneatcraftitems ('crocodile_skin','Crocodile Skin')
nssm_register_noneatcraftitems ('manticore_spine',S('Manticore Spine'))
nssm_register_noneatcraftitems ('night_feather',S('Night Feather'))
nssm_register_noneatcraftitems ('sun_feather',S('Sun Feather'))
nssm_register_noneatcraftitems ('masticone_fang',S('Masticone Fang'))
nssm_register_noneatcraftitems ('white_wolf_fur',S('White Wolf Fur'))
nssm_register_noneatcraftitems ('stoneater_mandible',S('Stoneater Mandible'))
nssm_register_noneatcraftitems ('ant_mandible',S('Ant Mandible'))
nssm_register_noneatcraftitems ('life_energy',S('Life Energy'))
nssm_register_noneatcraftitems ('wolf_fur',S('Wolf Fur'))
nssm_register_noneatcraftitems ('energy_globe',S('Energy Globe'))

function nssm_register_eatcraftitems (name, descr, gnam)

minetest.register_craftitem("nssm:"..name, {
	description = descr,
	image = name..".png",
	on_use = minetest.item_eat(gnam),
	groups = { meat=1, eatable=1 },
})

end

nssm_register_eatcraftitems ('werewolf_leg','Werewolf Leg',3)
nssm_register_eatcraftitems ('heron_leg','Moonheron Leg',2)
nssm_register_eatcraftitems ('chichibios_heron_leg',"Chichibio's Moonheron Leg",4)
nssm_register_eatcraftitems ('crocodile_tail','Crocodile Tail',3)
nssm_register_eatcraftitems ('roasted_crocodile_tail','Roasted Crocodile Tail',6)
nssm_register_eatcraftitems ('roasted_werewolf_leg','Roasted_Werewolf Leg',6)
nssm_register_eatcraftitems ('duck_legs','Duck Legs',1)
nssm_register_eatcraftitems ('roasted_duck_legs','Roasted Duck Leg',3)
nssm_register_eatcraftitems ('ant_leg','Ant Leg',1)
nssm_register_eatcraftitems ('roasted_ant_leg','Roasted Ant Leg',4)
nssm_register_eatcraftitems ('spider_leg','Spider Leg',1)
nssm_register_eatcraftitems ('roasted_spider_leg','Roasted Spider Leg',4)
--nssm_register_eatcraftitems ('brain','Brain',3)
--nssm_register_eatcraftitems ('roasted_brain','Roasted Brain',8)
nssm_register_eatcraftitems ('tentacle','Tentacle',2)
nssm_register_eatcraftitems ('roasted_tentacle','Roasted Tentacle',5)
nssm_register_eatcraftitems ('worm_flesh','Worm Flesh',-1)
nssm_register_eatcraftitems ('roasted_worm_flesh','Roasted Worm Flesh',3)
nssm_register_eatcraftitems ('amphibian_heart','Amphibian Heart',1)
nssm_register_eatcraftitems ('roasted_amphibian_heart','Roasted Amphibian Heart',8)
nssm_register_eatcraftitems ('raw_scrausics_wing','Raw Scrausics Wing',1)
nssm_register_eatcraftitems ('spicy_scrausics_wing','Spicy Scrausics Wing',6)
nssm_register_eatcraftitems ('phoenix_nuggets','Phoenix Nuggets',20)
nssm_register_eatcraftitems ('phoenix_tear','Phoenix Tear',20)
nssm_register_eatcraftitems ('frosted_amphibian_heart','Frosted Amphibian Heart',-1)
nssm_register_eatcraftitems ('surimi','Surimi',4)

--ore generation

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:modders_block",
		wherein        = "default:stone",
		clust_scarcity = 50*50*50,
		clust_num_ores = 1,
		clust_size     = 1,
		y_min     = -115,
		y_max     = -95,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "default:cobble",
		clust_scarcity = 1,
		clust_num_ores = 27,
		clust_size     = 3,
		y_min     = -1,
		y_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "default:mossycobble",
		clust_scarcity = 1,
		clust_num_ores = 27,
		clust_size     = 3,
		y_min     = -1000,
		y_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "default:sandstonebrick",
		clust_scarcity = 1,
		clust_num_ores = 27,
		clust_size     = 3,
		y_min     = -1000,
		y_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "stairs:stair_sandstonebrick",
		clust_scarcity = 1,
		clust_num_ores = 27,
		clust_size     = 3,
		y_min     = -1000,
		y_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "stairs:stair_cobble",
		clust_scarcity = 1,
		clust_num_ores = 27,
		clust_size     = 3,
		y_min     = -1000,
		y_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:web",
		wherein        = "default:junglegrass",
		clust_scarcity = 2*2*2,
		clust_num_ores = 2,
		clust_size     = 2,
		y_min     = -20,
		y_max     = 200,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:web",
		wherein        = "default:jungleleaves",
		clust_scarcity = 4*4*4,
		clust_num_ores = 5,
		clust_size     = 5,
		y_min     = -20,
		y_max     = 200,
			}
)

--nodes

minetest.register_node("nssm:ant_dirt", {
	description = S("Ant Dirt"),
	tiles = {"ant_dirt.png"},
	groups = {crumbly=3},
})

minetest.register_node("nssm:venomous_gas", {
	description = S("Venomous Gas"),
	inventory_image = minetest.inventorycube("venomous_gas.png"),
	drawtype = "airlike",
	tiles = {
		{name="venomous_gas_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	damage_per_second = 1,
	post_effect_color = {a=100, r=1, g=100, b=1},
	groups = {flammable = 2},
})

minetest.register_node("nssm:modders_block", {
	description = S("Modders Block"),
	tiles = {"modders_block.png"},
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory =1},
})

minetest.register_node("nssm:web", {
	description = S("Web"),
	inventory_image = "web.png",
	tiles = {"web.png"} ,
    drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	drowning = 0,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_range= 0,
	liquid_alternative_flowing = "nssm:web",
	liquid_alternative_source = "nssm:web",
	liquid_viscosity = 20,
	groups = {flammable=2, snappy=1, liquid=1},
})

minetest.register_node("nssm:ink", {
	description = S("Ink"),
	inventory_image = minetest.inventorycube("ink.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "ink_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	--alpha = 420,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	liquid_range= 0,
	drowning = 1,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_alternative_flowing = "nssm:ink",
	liquid_alternative_source = "nssm:ink",
	liquid_viscosity = 1,
	post_effect_color = {a=2000, r=30, g=30, b=30},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("nssm:mese_meteor", {
	description = S("Mese Meteor"),
	tiles = {"mese_meteor.png"} ,
	paramtype = "light",
	drop = "",
	groups = {crumbly=1, falling_node=1, flammable = 2},
})

minetest.register_node("nssm:pumpbomb", {
	tiles = {"pumpbomb_top.png","pumpbomb_bottom.png", "pumpbomb_side.png", "pumpbomb_side.png", "pumpbomb_side.png", "pumpbomb_front.png"},
	light_source = 5,
	groups = {not_in_creative_inventory =1},
	drop = "",
	on_timer = function(pos, elapsed)
		nssm:explosion(pos, 3, 1)
		minetest.env:set_node(pos, {name="air"})
	end,
})

--abms

minetest.register_abm({
	nodenames = {"nssm:mese_meteor"},
	neighbors = {"air"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		--local under = {x=pos.x, y=pos.y-1, z=pos.z}
		--local n = minetest.env:get_node(under).name
		--if n~= "air" then
		minetest.set_node({x=pos.x+1, y=pos.y, z=pos.z}, {name = "fire:basic_flame"})
		minetest.set_node({x=pos.x-1, y=pos.y, z=pos.z}, {name = "fire:basic_flame"})
		minetest.set_node({x=pos.x, y=pos.y, z=pos.z-1}, {name = "fire:basic_flame"})
		minetest.set_node({x=pos.x, y=pos.y, z=pos.z+1}, {name = "fire:basic_flame"})
		minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name = "fire:basic_flame"})

	end
})

minetest.register_abm({
	nodenames = {"nssm:web"},
	neighbors = {"default:junglegrass"},
	interval = 20.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local n = minetest.env:get_node(pos).name
		if n== "air" then
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "nssm:web"})
		end
	end
})

minetest.register_abm({
	nodenames = {"nssm:web"},
	neighbors = {"default:junglegrass"},
	interval = 20.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local n = minetest.env:get_node(pos).name
		if n== "air" then
			minetest.set_node({x = pos.x + 1, y = pos.y, z = pos.z}, {name = "nssm:web"})
		end
	end
})

minetest.register_abm({
	nodenames = {"nssm:web"},
	neighbors = {"default:junglegrass"},
	interval = 20.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local n = minetest.env:get_node(pos).name
		if n== "air" then
			minetest.set_node({x = pos.x - 1, y = pos.y, z = pos.z}, {name = "nssm:web"})
		end
	end
})



--tools

minetest.register_tool('nssm:sun_sword', {
	description = S('Sun Sword'),
	inventory_image = 'sun_sword.png',
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.80, [2]=0.40, [3]=0.20}, uses=70, maxlevel=1},
			fleshy={times={[2]=0.6, [3]=0.2}, uses=70, maxlevel=1}
		},
		damage_groups = {fleshy=10},
	},
	minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
		if puncher:get_wielded_item():get_name() == 'nssm:sun_sword' then
			if node.name ~= "air" then
				minetest.add_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
	end)
})

minetest.register_tool("nssm:masticone_fang_sword", {
	description = S("Masticone Fang Sword"),
	inventory_image = "masticone_fang_sword.png",
	tool_capabilities = {
		full_punch_interval =0.7 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=200, maxlevel=1},
			fleshy={times={[2]=0.8, [3]=0.4}, uses=200, maxlevel=1}
		},
		damage_groups = {fleshy=8},
	},
})

minetest.register_tool("nssm:night_sword", {
	description = S("Night Sword")
	inventory_image = "night_sword.png",
	tool_capabilities = {
		full_punch_interval =0.4 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.4, [2]=0.3, [3]=0.2}, uses=300, maxlevel=1},
			fleshy={times={[2]=0.7, [3]=0.3}, uses=300, maxlevel=1}
		},
		damage_groups = {fleshy=12},
	},
})

minetest.register_tool("nssm:crab_light_mace", {
	description = S("Light Crab Mace"),
	inventory_image = "crab_light_mace.png",
	tool_capabilities = {
		full_punch_interval =2 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=1.4, [3]=1}, uses=120, maxlevel=1}
		},
		damage_groups = {fleshy=8},
	},
})

minetest.register_tool("nssm:crab_heavy_mace", {
	description = S("Heavy Crab Mace"),
	inventory_image = "crab_heavy_mace.png",
	tool_capabilities = {
		full_punch_interval =4 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=2, [3]=1.4}, uses=120, maxlevel=1}
		},
		damage_groups = {fleshy=12},
	},
})

minetest.register_node("nssm:rope", {
    description = S("Rope"),
    paramtype = "light",
	walkable = false,
    climbable = true,
    sunlight_propagates = true,
	drawtype = "plantlike",
    drops = "nssm:rope",
    tiles = { "rope.png" },
    groups = {snappy=1},
    })

minetest.register_tool("nssm:stoneater_pick", {
	description = S("Stoneater Pickaxe"),
	inventory_image = "stoneater_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=0.0}, uses=200, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("nssm:mantis_sword", {
	description = S("Mantis Sword"),
	inventory_image = "mantis_sword.png",
	tool_capabilities = {
		full_punch_interval =0.7 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=1.0, [3]=0.4}, uses=50, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.3}, uses=100, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("nssm:ant_sword", {
	description = S("Ant Sword"),
	inventory_image = "ant_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.30, [2]=0.90, [3]=0.40}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
})

--recipes

minetest.register_craft({
	output = 'nssm:mantis_sword',
	recipe = {
		{'', 'nssm:mantis_claw', ''},
		{'', 'nssm:mantis_claw', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:masticone_fang_sword',
	recipe = {
		{'', 'nssm:masticone_fang', 'nssm:masticone_fang'},
		{'', 'nssm:masticone_fang', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:black_ice_tooth',
	recipe = {
		{'', 'nssm:black_sand', ''},
		{'', 'nssm:ice_tooth', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'nssm:crab_light_mace',
	recipe = {
		{'', 'nssm:crab_chela', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:crab_heavy_mace',
	recipe = {
		{'', 'nssm:crab_chela', ''},
		{'nssm:crab_chela', 'nssm:crab_chela', 'nssm:crab_chela'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:energy_globe',
	recipe = {
		{'nssm:life_energy', 'nssm:life_energy', 'nssm:life_energy'},
		{'nssm:life_energy', 'nssm:life_energy', 'nssm:life_energy'},
		{'nssm:life_energy', 'nssm:life_energy', 'nssm:life_energy'},
	}
})

minetest.register_craft({
	output = 'nssm:great_energy_globe',
	recipe = {
		{'nssm:energy_globe', 'nssm:energy_globe', 'nssm:energy_globe'},
		{'nssm:energy_globe', 'nssm:energy_globe', 'nssm:energy_globe'},
		{'nssm:energy_globe', 'nssm:energy_globe', 'nssm:energy_globe'},
	}
})

minetest.register_craft({
	output = 'nssm:superior_energy_globe',
	recipe = {
		{'nssm:great_energy_globe', 'nssm:great_energy_globe', 'nssm:great_energy_globe'},
		{'nssm:great_energy_globe', 'nssm:great_energy_globe', 'nssm:great_energy_globe'},
		{'nssm:great_energy_globe', 'nssm:great_energy_globe', 'nssm:great_energy_globe'},
	}
})

minetest.register_craft({
	output = 'nssm:mese_egg',
	recipe = {
		{'nssm:tarantula_chelicerae', 'nssm:masticone_skull_crowned', 'nssm:eyed_tentacle'},
		{'nssm:black_ice_tooth', 'nssm:superior_energy_globe', 'nssm:sky_feather'},
		{'nssm:cursed_pumpkin_seed', 'nssm:ant_queen_abdomen', 'nssm:snake_scute'},
	}
})

minetest.register_craft({
	output = 'nssm:masticone_skull_crowned',
	recipe = {
		{'', 'nssm:king_duck_crown', ''},
		{'', 'nssm:masticone_skull', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'nssm:eyed_tentacle',
	recipe = {
		{'', 'nssm:lava_titan_eye', ''},
		{'', 'nssm:tentacle_curly', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'nssm:masticone_skull',
	recipe = {
		{'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments'},
		{'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments'},
		{'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments'},
	}
})

minetest.register_craft({
	output = 'nssm:rope 16',
	recipe = {
		{'', 'nssm:wolf_fur', ''},
		{'', 'nssm:wolf_fur', ''},
		{'', 'nssm:wolf_fur', ''},
	}
})


minetest.register_craft({
	output = 'nssm:rope 16',
	recipe = {
		{'', 'nssm:white_wolf_fur', ''},
		{'', 'nssm:white_wolf_fur', ''},
		{'', 'nssm:white_wolf_fur', ''},
	}
})

minetest.register_craft({
	output = 'nssm:sky_feather',
	recipe = {
		{'', '', ''},
		{'nssm:sun_feather', '', 'nssm:night_feather'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'nssm:sun_sword',
	recipe = {
		{'', 'default:diamond', ''},
		{'', 'nssm:sun_feather', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:night_sword',
	recipe = {
		{'', 'default:diamond', ''},
		{'', 'nssm:night_feather', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_worm_flesh",
	recipe = "nssm:worm_flesh",
	cooktime = 12,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_duck_legs",
	recipe = "nssm:duck_legs",
	cooktime = 6,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_spider_leg",
	recipe = "nssm:spider_leg",
	cooktime = 6,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_werewolf_leg",
	recipe = "nssm:werewolf_leg",
	cooktime = 10,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_brain",
	recipe = "nssm:brain",
	cooktime = 6,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_amphibian_heart",
	recipe = "nssm:amphibian_heart",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_tentacle",
	recipe = "nssm:tentacle",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:amphibian_heart",
	recipe = "nssm:frosted_amphibian_heart",
	cooktime = 8,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:chichibios_heron_leg",
	recipe = "nssm:heron_leg",
	cooktime = 20,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:spicy_scrausics_wing",
	recipe = "nssm:raw_scrausics_wing",
	cooktime = 12,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_ant_leg",
	recipe = "nssm:ant_leg",
	cooktime = 10,
})

minetest.register_craft({
	type = "cooking",
	output = "nssm:roasted_crocodile_tail",
	recipe = "nssm:crocodile_tail",
	cooktime = 16,
})


minetest.register_craft({
	output = 'nssm:ant_sword',
	recipe = {
		{'', 'nssm:ant_mandible', ''},
		{'', 'nssm:ant_mandible', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:stoneater_pick',
	recipe = {
		{'nssm:stoneater_mandible', 'nssm:stoneater_mandible', 'nssm:stoneater_mandible'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

--Eggs

function nssm_register_egg (name, descr)


minetest.register_craftitem("nssm:".. name .."_egg", {
	description = descr .. S(" Egg"),
	image = name .. "_egg.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pos1=minetest.get_pointed_thing_position(pointed_thing, true)
		pos1.y=pos1.y+1.5
		core.after(0.1, function()
			minetest.add_entity(pos1, "nssm:".. name)
		end)
		itemstack:take_item()
		return itemstack
	end,
})

end

--nssm_register_egg ('flying_duck', 'Flying Duck')
nssm_register_egg ('stone_eater', S('Stoneater'))
nssm_register_egg ('signosigno', S('Signosigno'))
nssm_register_egg ('bloco', S('Bloco'))
nssm_register_egg ('sand_bloco', S('Sand Bloco'))
nssm_register_egg ('swimming_duck', S('Swimming Duck'))
nssm_register_egg ('duck', S('Duck'))
nssm_register_egg ('duckking', S('Duckking'))
nssm_register_egg ('enderduck', S('Enderduck'))
nssm_register_egg ('spiderduck', S('Spiderduck'))
nssm_register_egg ('echidna', S('Echidna'))
nssm_register_egg ('werewolf', S('Werewolf'))
nssm_register_egg ('white_werewolf', S('White Werewolf'))
nssm_register_egg ('snow_biter', S('Snow Biter'))
nssm_register_egg ('icelamander', S('Icelamander'))
nssm_register_egg ('icesnake', S('Icesnake'))
nssm_register_egg ('lava_titan', S('Lava Titan'))
nssm_register_egg ('masticone', S('Masticone'))
nssm_register_egg ('mantis_beast', S('Mantis Beast'))
nssm_register_egg ('mantis', S('Mantis'))
nssm_register_egg ('larva', S('Larva'))
nssm_register_egg ('phoenix', S('Phoenix'))
nssm_register_egg ('night_master', S('Night Master'))
nssm_register_egg ('scrausics', S('Scrausics'))
nssm_register_egg ('moonheron', S('Moonheron'))
nssm_register_egg ('sandworm', S('Sandworm'))
nssm_register_egg ('giant_sandworm', S('Giant Sandworm'))
nssm_register_egg ('ant_queen', S('Ant Queen'))
nssm_register_egg ('ant_soldier', S('Ant Soldier'))
nssm_register_egg ('ant_worker', S('Ant Worker'))
nssm_register_egg ('crocodile', S('Crocodile'))
nssm_register_egg ('dolidrosaurus', S('Dolidrosaurus'))
nssm_register_egg ('crab', S('Crab'))
nssm_register_egg ('octopus', S('Octopus'))
nssm_register_egg ('xgaloctopus', S('Xgaloctopus'))
nssm_register_egg ('black_widow', S('Black Widow'))
nssm_register_egg ('uloboros', S('Uloboros'))
nssm_register_egg ('tarantula', S('Tarantula'))
nssm_register_egg ('daddy_long_legs', S('Daddy Long Legs'))
nssm_register_egg ('kraken', S('Kraken'))
nssm_register_egg ('pumpking', S('Pumpking'))
nssm_register_egg ('manticore', S('Manticore'))
nssm_register_egg ('pumpboom_large', S('Large Pumpboom'))
nssm_register_egg ('pumpboom_small', S('Small Pumpboom'))
nssm_register_egg ('pumpboom_medium', S('Medium Pumpboom'))


minetest.register_craftitem("nssm:mese_egg", {
	description = S("Mese Egg"),
	image = "mese_egg.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pos1=minetest.get_pointed_thing_position(pointed_thing, true)
		pos1.y=pos1.y+1.5
		minetest.add_particlespawner({
			amount = 1000,
			time = 0.2,
			minpos = {x=pos1.x-1, y=pos1.y-1, z=pos1.z-1},
			maxpos = {x=pos1.x+1, y=pos1.y+4, z=pos1.z+1},
			minvel = {x=0, y=0, z=0},
			maxvel = {x=1, y=5, z=1},
			minacc = {x=-0.5,y=5,z=-0.5},
			maxacc = {x=0.5,y=5,z=0.5},
			minexptime = 1,
			maxexptime = 3,
			minsize = 2,
			maxsize = 4,
			collisiondetection = false,
			vertical = false,
			texture = "tnt_smoke.png",
		})
		core.after(0.4, function()
			minetest.add_entity(pos1, "nssm:mese_dragon")
		end)
		itemstack:take_item()
		return itemstack
	end,
})
