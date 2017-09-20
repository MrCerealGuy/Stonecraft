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
	image = name..".png",
})

end

nssm_register_noneatcraftitems ('sky_feather',S('Sky Feather'))
nssm_register_noneatcraftitems ('snake_scute',S('Snake Scute'))
nssm_register_noneatcraftitems ('eyed_tentacle',S('Eyed Tentacle'))
--nssm_register_noneatcraftitems ('king_duck_crown',S('King Duck Crown'))
nssm_register_noneatcraftitems ('great_energy_globe',S('Great Energy Globe'))
nssm_register_noneatcraftitems ('superior_energy_globe',S('Superior Energy Globe'))
nssm_register_noneatcraftitems ('ant_queen_abdomen',S('Ant Queen Abdomen'))
--nssm_register_noneatcraftitems ('masticone_skull',S('Masticone Skull'))
nssm_register_noneatcraftitems ('masticone_skull_fragments',S('Masticone Skull Fragments'))
--nssm_register_noneatcraftitems ('masticone_skull_crowned',S('Masticone Skull Crowned'))
nssm_register_noneatcraftitems ('tentacle_curly',S('Kraken Tentacle'))
nssm_register_noneatcraftitems ('lava_titan_eye',S('Lava Titan Eye'))
nssm_register_noneatcraftitems ('duck_beak',S('Duck Beak'))
nssm_register_noneatcraftitems ('ice_tooth',S('Ice Tooth'))
nssm_register_noneatcraftitems ('little_ice_tooth',S('Little Ice Tooth'))
nssm_register_noneatcraftitems ('digested_sand',S('Digested Sand'))
nssm_register_noneatcraftitems ('black_ice_tooth',S('Black Ice Tooth'))
nssm_register_noneatcraftitems ('tarantula_chelicerae',S('Tarantula Chelicerae'))
nssm_register_noneatcraftitems ('crab_chela',S('Crab Chela'))
nssm_register_noneatcraftitems ('cursed_pumpkin_seed',S('Cursed Pumpkin Seed'))
nssm_register_noneatcraftitems ('mantis_claw',S('Mantis Claw'))
--nssm_register_noneatcraftitems ('manticore_fur',S('Manticore Fur'))
--nssm_register_noneatcraftitems ('ant_hard_skin',S('Ant Hard Skin'))
--nssm_register_noneatcraftitems ('bloco_skin',S('Bloco Skin'))
--nssm_register_noneatcraftitems ('crab_carapace_fragment',S('Crab Carapace Fragment'))
--nssm_register_noneatcraftitems ('crocodile_skin',S('Crocodile Skin'))
nssm_register_noneatcraftitems ('manticore_spine',S('Manticore Spine'))
nssm_register_noneatcraftitems ('night_feather',S('Night Feather'))
nssm_register_noneatcraftitems ('sun_feather',S('Sun Feather'))
nssm_register_noneatcraftitems ('duck_feather',S('Duck Feather'))
nssm_register_noneatcraftitems ('black_duck_feather',S('Black Duck Feather'))
nssm_register_noneatcraftitems ('masticone_fang',S('Masticone Fang'))
nssm_register_noneatcraftitems ('white_wolf_fur',S('White Wolf Fur'))
nssm_register_noneatcraftitems ('stoneater_mandible',S('Stoneater Mandible'))
nssm_register_noneatcraftitems ('ant_mandible',S('Ant Mandible'))
nssm_register_noneatcraftitems ('life_energy',S('Life Energy'))
nssm_register_noneatcraftitems ('wolf_fur',S('Wolf Fur'))
nssm_register_noneatcraftitems ('felucco_fur',S('Felucco Fur'))
nssm_register_noneatcraftitems ('felucco_horn',S('Felucco Horn'))
nssm_register_noneatcraftitems ('energy_globe',S('Energy Globe'))
nssm_register_noneatcraftitems ('greedy_soul_fragment',S('Greedy Soul Fragment'))
nssm_register_noneatcraftitems ('lustful_soul_fragment',S('Lustful Soul Fragment'))
nssm_register_noneatcraftitems ('wrathful_soul_fragment',S('Wrathful Soul Fragment'))
nssm_register_noneatcraftitems ('proud_soul_fragment',S('Proud Soul Fragment'))
nssm_register_noneatcraftitems ('slothful_soul_fragment',S('Slothful Soul Fragment'))
nssm_register_noneatcraftitems ('envious_soul_fragment',S('Envious Soul Fragment'))
nssm_register_noneatcraftitems ('gluttonous_soul_fragment',S('Gluttonous Soul Fragment'))
nssm_register_noneatcraftitems ('gluttonous_moranga',S('Gluttonous Moranga'))
nssm_register_noneatcraftitems ('envious_moranga',S('Envious Moranga'))
nssm_register_noneatcraftitems ('proud_moranga',S('Proud Moranga'))
nssm_register_noneatcraftitems ('slothful_moranga',S('Slothful Moranga'))
nssm_register_noneatcraftitems ('lustful_moranga',S('Lustful Moranga'))
nssm_register_noneatcraftitems ('wrathful_moranga',S('Wrathful Moranga'))
nssm_register_noneatcraftitems ('greedy_moranga',S('Greedy Moranga'))
nssm_register_noneatcraftitems ('mantis_skin',S('Mantis_skin'))
nssm_register_noneatcraftitems ('sand_bloco_skin',S('Sand Bloco Skin'))
nssm_register_noneatcraftitems ('sandworm_skin',S('Sandworm Skin'))
nssm_register_noneatcraftitems ('sky_iron',S('Sky Iron'))
nssm_register_noneatcraftitems ('web_string',S('Cobweb String'))
nssm_register_noneatcraftitems ('dense_web_string',S('Dense Cobweb String'))
nssm_register_noneatcraftitems ('black_powder',S('Black Powder'))
nssm_register_noneatcraftitems ('morelentir_dust',S('Dark Starred Stone Dust'))
nssm_register_noneatcraftitems ('empty_evocation_bomb',S('Empty Evocation Bomb'))

function nssm_register_eatcraftitems (name, descr, gnam)

minetest.register_craftitem("nssm:"..name, {
	description = descr,
	image =name..".png",
	on_use = minetest.item_eat(gnam),
	groups = { meat=1, eatable=1 },
})

end

nssm_register_eatcraftitems ('werewolf_leg',S('Werewolf Leg'),3)
nssm_register_eatcraftitems ('felucco_steak',S('Felucco Steak'),3)
nssm_register_eatcraftitems ('roasted_felucco_steak',S('Roasted Felucco Steak'),6)
nssm_register_eatcraftitems ('heron_leg',S('Moonheron Leg'),2)
nssm_register_eatcraftitems ('chichibios_heron_leg',S("Chichibio's Moonheron Leg"),4)
nssm_register_eatcraftitems ('crocodile_tail',S('Crocodile Tail'),3)
nssm_register_eatcraftitems ('roasted_crocodile_tail',S('Roasted Crocodile Tail'),6)
nssm_register_eatcraftitems ('roasted_werewolf_leg',S('Roasted Werewolf Leg'),6)
nssm_register_eatcraftitems ('duck_legs',S('Duck Legs'),1)
nssm_register_eatcraftitems ('roasted_duck_legs',S('Roasted Duck Leg'),3)
nssm_register_eatcraftitems ('ant_leg',S('Ant Leg'),-1)
nssm_register_eatcraftitems ('roasted_ant_leg',S('Roasted Ant Leg'),4)
nssm_register_eatcraftitems ('spider_leg',S('Spider Leg'),-1)
nssm_register_eatcraftitems ('roasted_spider_leg',S('Roasted Spider Leg'),4)
--nssm_register_eatcraftitems ('brain','Brain',3)
--nssm_register_eatcraftitems ('roasted_brain','Roasted Brain',8)
nssm_register_eatcraftitems ('tentacle',S('Tentacle'),2)
nssm_register_eatcraftitems ('roasted_tentacle',S('Roasted Tentacle'),5)
nssm_register_eatcraftitems ('worm_flesh',S('Worm Flesh'),-2)
nssm_register_eatcraftitems ('roasted_worm_flesh',S('Roasted Worm Flesh'),4)
nssm_register_eatcraftitems ('amphibian_heart',S('Amphibian Heart'),1)
nssm_register_eatcraftitems ('roasted_amphibian_heart',S('Roasted Amphibian Heart'),8)
nssm_register_eatcraftitems ('raw_scrausics_wing',S('Raw Scrausics Wing'),1)
nssm_register_eatcraftitems ('spicy_scrausics_wing',S('Spicy Scrausics Wing'),6)
nssm_register_eatcraftitems ('phoenix_nuggets',S('Phoenix Nuggets'),20)
nssm_register_eatcraftitems ('phoenix_tear',S('Phoenix Tear'),20)
nssm_register_eatcraftitems ('frosted_amphibian_heart',S('Frosted Amphibian Heart'),-1)
nssm_register_eatcraftitems ('surimi',S('Surimi'),4)
nssm_register_eatcraftitems ('amphibian_ribs',S('Amphibian Ribs'),2)
nssm_register_eatcraftitems ('roasted_amphibian_ribs',S('Roasted Amphibian Ribs'),6)
nssm_register_eatcraftitems ('dolidrosaurus_fin',S('Dolidrosaurus Fin'),-2)
nssm_register_eatcraftitems ('roasted_dolidrosaurus_fin',S('Roasted Dolidrosaurus Fin'),4)
nssm_register_eatcraftitems ('larva_meat',S('Larva Meat'),-1)
nssm_register_eatcraftitems ('larva_juice',S('Larva Juice'),-3)
nssm_register_eatcraftitems ('larva_soup',S('Larva Soup'),10)
nssm_register_eatcraftitems ('mantis_meat',S('Mantis Meat'),1)
nssm_register_eatcraftitems ('roasted_mantis_meat',S('Roasted Mantis Meat'),4)
nssm_register_eatcraftitems ('spider_meat',S('Spider Meat'),-1)
nssm_register_eatcraftitems ('roasted_spider_meat',S('Roasted Spider Meat'),3)
nssm_register_eatcraftitems ('silk_gland',S('Silk Gland'),-1)
nssm_register_eatcraftitems ('roasted_silk_gland',S('Roasted Silk Gland'),3)
nssm_register_eatcraftitems ('super_silk_gland',S('Super Silk Gland'),-8)
nssm_register_eatcraftitems ('roasted_super_silk_gland',S('Roasted Super Silk Gland'),2)

--ore generation

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:modders_block",
		wherein        = "default:stone",
		clust_scarcity = 50*50*50,
		clust_num_ores = 1,
		clust_size     = 1,
		height_min     = -115,
		height_max     = -95,
			})
for i=1,9 do
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "default:cobble",
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size     = 1,
		height_min     = -1,
		height_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "default:mossycobble",
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size     = 1,
		height_min     = -1000,
		height_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "default:sandstonebrick",
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size     = 1,
		height_min     = -1000,
		height_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "stairs:stair_sandstonebrick",
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size     = 1,
		height_min     = -1000,
		height_max     = 40,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:ant_dirt",
		wherein        = "stairs:stair_cobble",
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size     = 1,
		height_min     = -1000,
		height_max     = 40,
			})
end

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:web",
		wherein        = "default:junglegrass",
		clust_scarcity = 2*2*2,
		clust_num_ores = 2,
		clust_size     = 2,
		height_min     = -20,
		height_max     = 200,
			})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nssm:web",
		wherein        = "default:jungleleaves",
		clust_scarcity = 4*4*4,
		clust_num_ores = 5,
		clust_size     = 5,
		height_min     = -20,
		height_max     = 200,
			}
)

--nodes

minetest.register_node("nssm:ant_dirt", {
	description = S("Ant Dirt"),
	tiles = {"ant_dirt.png"},
	groups = {crumbly=3},
})

minetest.register_node("nssm:dead_leaves", {
	description = S("Dead leaves"),
	tiles = {"dead_leaves.png"},
	groups = {snappy=3,leaves=1},
})

minetest.register_node("nssm:invisible_light", {
	description = S("Invisible light source"),
	tiles = {"transparent.png"},
	paramtype = "light",
	drawtype = "airlike",
	walkable = false,
	sunlight_propagates = true,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	groups = {unbreakable=1},
	drop = "",
	light_source = 15,
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
	tile_images = {"web.png"} ,
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

minetest.register_node("nssm:thick_web", {
	description = S("Thick Web"),
	inventory_image = "thick_web.png",
	tile_images = {"thick_web.png"} ,
    drawtype = "firelike",
	paramtype = "light",
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	drowning = 2,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_range= 0,
	liquid_alternative_flowing = "nssm:thick_web",
	liquid_alternative_source = "nssm:thick_web",
	liquid_viscosity = 30,
	groups = {flammable=2, liquid=1},
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
	tile_images = {"mese_meteor.png"} ,
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
		tnt_boom_nssm(pos, {damage_radius=4,radius=3,ignore_protection=false})
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
		if minetest.is_protected(pos, "") then
			return
		end
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

minetest.register_node("nssm:phoenix_fire", {
	description = S("Phoenix Fire"),
	drawtype = "firelike",
	tiles = {{
		name = "phoenix_fire_animated.png",
		animation = {type = "vertical_frames",
			aspect_w = 16, aspect_h = 16, length = 1},
	}},
	inventory_image = "phoenix_fire.png",
	light_source = 15,
	groups = {igniter = 1, snappy=1},
	drop = '',
	walkable = false,
	buildable_to = false,
	damage_per_second = 4,
	})

minetest.register_abm({
	nodenames = {"nssm:phoenix_fire"},
	neighbors = {"air"},
	interval = 3,
	chance = 2,
	action = function(pos, node)
			minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name = "air"})
		end
})

minetest.register_abm({
	nodenames = {"nssm:dead_leaves"},
	neighbors = {"air"},
	interval = 15,
	chance = 3,
	action = function(pos, node)
			minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name = "air"})
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
			if node.name ~= "air" and not minetest.is_protected(pos, "") then
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
	description = S("Night Sword"),
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
			fleshy={times={[2]=1.4, [3]=1}, uses=20, maxlevel=1}
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
			fleshy={times={[2]=2, [3]=1.4}, uses=20, maxlevel=1}
		},
		damage_groups = {fleshy=12},
	},
})

minetest.register_tool("nssm:mantis_battleaxe", {
	description = S("Mantis Battleaxe"),
	inventory_image = "mantis_battleaxe.png",
	tool_capabilities = {
		full_punch_interval =3 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=2, [3]=1.4}, uses=20, maxlevel=1}
		},
		damage_groups = {fleshy=10},
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
    tile_images = { "rope.png" },
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
			fleshy={times={[2]=1.0, [3]=0.4}, uses=30, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.3}, uses=40, maxlevel=1},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_tool("nssm:little_ice_tooth_knife", {
	description = S("Little Ice Tooth Knife"),
	inventory_image = "little_ice_tooth_knife.png",
	tool_capabilities = {
		full_punch_interval =0.3 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=1.0, [3]=0.4}, uses=4, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.3}, uses=7, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("nssm:manticore_spine_knife", {
	description = S("Manticore Spine Knife"),
	inventory_image = "manticore_spine_knife.png",
	tool_capabilities = {
		full_punch_interval =0.4 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=1.0, [3]=0.4}, uses=6, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.3}, uses=6, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("nssm:felucco_knife", {
	description = S("Felucco Knife"),
	inventory_image = "felucco_knife.png",
	tool_capabilities = {
		full_punch_interval =0.4 ,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=1.0, [3]=0.4}, uses=6, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.3}, uses=6, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	},
})

if minetest.get_modpath("farming") then

farming.register_hoe(":farming:felucco_hoe", {
	description = S("Felucco Hoe"),
	inventory_image = "felucco_hoe.png",
	max_uses = 290,
	material = "nssm:felucco_horn"
})

farming.register_hoe(":farming:ant_hoe", {
	description = S("Ant Hoe"),
	inventory_image = "ant_hoe.png",
	max_uses = 350,
	material = "nssm:ant_mandible"
})

minetest.register_craft({
	output = 'nssm:ant_hoe',
	recipe = {
		{'nssm:ant_mandible', 'nssm:ant_mandible'},
		{'', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:felucco_hoe',
	recipe = {
		{'nssm:felucco_horn', 'nssm:felucco_horn'},
		{'', 'group:stick'},
		{'', 'group:stick'},
	}
})

end

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



minetest.register_tool("nssm:ant_shovel", {
	description = S("Ant Shovel"),
	inventory_image = "ant_shovel.png",
	wield_image = "ant_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("nssm:duck_beak_shovel", {
	description = "Duck Beak Shovel",
	inventory_image = "duck_beak_shovel.png",
	wield_image = "duck_beak_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.80, [3]=0.20}, uses=5, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("nssm:mantis_axe", {
	description = "Mantis Axe",
	inventory_image = "mantis_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
		},
	})

minetest.register_tool("nssm:ant_billhook", {
	description = "Ant Billhook",
	inventory_image = "ant_billhook.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.40, [2]=1.00, [3]=0.60}, uses=30, maxlevel=3},
			snappy={times={[1]=1.40, [2]=1.00, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=6},
		},
	})

minetest.register_tool("nssm:duck_beak_pick",{
	description = "Duck Beak Pickaxe",
	inventory_image = "duck_beak_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.0, [2]=0.8, [3]=0.20}, uses=3, maxlevel=3},
		},
		damage_groups = {fleshy=5},
		},
})

minetest.register_tool("nssm:ant_pick", {
	description = "Ant Pickaxe",
	inventory_image = "ant_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=2.00, [2]=1.20, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("nssm:mantis_pick", {
	description = "Mantis Pickaxe",
	inventory_image = "mantis_pick.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.6, [2]=1.0, [3]=0.60}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("nssm:tarantula_warhammer", {
	description = "Tarantula Warhammer",
	inventory_image = "tarantula_warhammer.png",
	wield_scale= {x=2,y=2,z=1.5},
	tool_capabilities = {
		full_punch_interval =1,
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=80, maxlevel=1},
			fleshy={times={[2]=0.8, [3]=0.4}, uses=200, maxlevel=1}
		},
		damage_groups = {fleshy=13},
	},
})

minetest.register_tool("nssm:axe_of_pride", {
	description = "Axe of Pride",
	inventory_image = "axe_of_pride.png",
	wield_scale= {x=2,y=2,z=1.5},
	tool_capabilities = {
		full_punch_interval =1.3 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=100, maxlevel=1},
			fleshy={times={[2]=0.8, [3]=0.4}, uses=400, maxlevel=1}
		},
		damage_groups = {fleshy=16},
	},
	on_drop = function(itemstack, dropper, pos)
		local objects = minetest.env:get_objects_inside_radius(pos, 10)
		local flag = 0
		local part = 0
		for _,obj in ipairs(objects) do
			part = 0
			if flag == 0 then
				local pname = dropper:get_player_name()
				local player_inv = minetest.get_inventory({type='player', name = pname})

				if player_inv:is_empty('main') then
					--minetest.chat_send_all("Inventory empty")
				else
					local found = 0
					for i = 1,32 do
						local items = player_inv:get_stack('main', i)
						local n = items:get_name()
						if n == "nssm:energy_globe" then
							found = i
							break
						end
					end
					if found == 0 then
						minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
						return
					else
						if (obj:is_player()) then
							--minetest.chat_send_all("Giocatore")
							if (obj:get_player_name()~=dropper:get_player_name()) then
								obj:set_hp(obj:get_hp()-10)
								dropper:set_hp(dropper:get_hp()+10)
								--flag = 1

								local items = player_inv:get_stack('main', found)
								items:take_item()
								player_inv:set_stack('main', found, items)
								part = 1
							end
			            else
							if (obj:get_luaentity().health) then
								--minetest.chat_send_all("Entity")
								obj:get_luaentity().health = obj:get_luaentity().health -10
								check_for_death(obj:get_luaentity())

								dropper:set_hp(dropper:get_hp()+10)
								--flag = 1

								local items = player_inv:get_stack('main', found)
								items:take_item()
								player_inv:set_stack('main', found, items)
								part = 1
							end
			            end
						if part == 1 then
							local s = dropper:getpos()
							local p = obj:getpos()
							local m = 2

							minetest.add_particlespawner(
								3, --amount
								0.1, --time
								{x=p.x-0.5, y=p.y-0.5, z=p.z-0.5}, --minpos
								{x=p.x+0.5, y=p.y+0.5, z=p.z+0.5}, --maxpos
								{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --minvel
								{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --maxvel
								{x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}, --minacc
								{x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}, --maxacc
								0.5, --minexptime
								1, --maxexptime
								3, --minsize
								4, --maxsize
								false, --collisiondetection
								"heart.png" --texture
							)
						end
					end
				end
			end
        end
	end,
})

minetest.register_tool("nssm:gratuitousness_battleaxe", {
	description = "Gratuitousness Battleaxe",
	inventory_image = "gratuitousness_battleaxe.png",
	wield_scale= {x=2.2,y=2.2,z=1.5},
	tool_capabilities = {
		full_punch_interval =1.6 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=100, maxlevel=1},
			fleshy={times={[2]=0.8, [3]=0.4}, uses=400, maxlevel=1}
		},
		damage_groups = {fleshy=18},
	},
	on_drop = function(itemstack, dropper, pos)
	    local objects = minetest.env:get_objects_inside_radius(pos, 10)
	    local flag = 0
		local vec = dropper:get_look_dir()
		local pos = dropper:getpos()
		--vec.y = 0

		for i=1,10 do
			pos = vector.add(pos, vec)
		end

		local pname = dropper:get_player_name()
		local player_inv = minetest.get_inventory({type='player', name = pname})
		local found = 0
		for i = 1,32 do
			local items = player_inv:get_stack('main', i)
			local n = items:get_name()
			if n == "nssm:energy_globe" then
				found = i
				break
			end
		end
		if found == 0 then
			minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
			return
		else
			local items = player_inv:get_stack('main', found)
			items:take_item()
			player_inv:set_stack('main', found, items)
			tnt.boom(pos, {damage_radius=5,radius=4,ignore_protection=false})
		end
	end,
})

minetest.register_tool("nssm:sword_of_eagerness", {
	description = "Sword of Eagerness",
	inventory_image = "sword_of_eagerness.png",
	wield_scale= {x=2,y=2,z=1},
	tool_capabilities = {
		full_punch_interval =0.7 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=100, maxlevel=1},
			fleshy={times={[2]=0.8, [3]=0.4}, uses=400, maxlevel=1}
		},
		damage_groups = {fleshy=14},
	},
	on_drop = function(itemstack, dropper, pos)
	    local objects = minetest.env:get_objects_inside_radius(pos, 10)
	    local flag = 0
	    for _,obj in ipairs(objects) do
			local part = 0
	        if flag == 0 then
	            local pname = dropper:get_player_name()
	            local player_inv = minetest.get_inventory({type='player', name = pname})

	            if player_inv:is_empty('main') then
	                --minetest.chat_send_all("Inventory empty")
	            else
	                local found = 0
	                for i = 1,32 do
	                    local items = player_inv:get_stack('main', i)
	                    local n = items:get_name()
	                    if n == "nssm:energy_globe" then
	                        found = i
	                        break
	                    end
	                end
	                if found == 0 then
	                    minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
	                    return
	                else
						local pos = obj:getpos()
						pos.y = pos.y + 15
	                    if (obj:is_player()) then
	                        if (obj:get_player_name()~=dropper:get_player_name()) then
								part=1
								obj:setpos(pos)
	                            --flag = 1

	                            local items = player_inv:get_stack('main', found)
	                            items:take_item()
	                            player_inv:set_stack('main', found, items)
	                        end
	                    else
	                        if (obj:get_luaentity().health) then
								obj:get_luaentity().old_y = pos.y
	                            obj:setpos(pos)
								part=1
	                            --flag = 1

	                            local items = player_inv:get_stack('main', found)
	                            items:take_item()
	                            player_inv:set_stack('main', found, items)
	                        end
	                    end
						if part==1 then
							local s = pos
							s.y = s.y - 15
							minetest.add_particlespawner(
						    	25, --amount
						        0.3, --time
						        vector.subtract(s, 0.5), --minpos
						        vector.add(s, 0.5), --maxpos
						        {x=0, y=10, z=0}, --minvel
						        {x=0.1, y=11, z=0.1}, --maxvel
						        {x=0,y=1,z=0}, --minacc
						        {x=0,y=1,z=0}, --maxacc
						        0.5, --minexptime
						        1, --maxexptime
						        1, --minsize
						        2, --maxsize
						        false, --collisiondetection
						        "slothful_soul_fragment.png" --texture
						    )
						end
	                end
	            end
	        end
	    end
	end,
})

minetest.register_tool("nssm:falchion_of_eagerness", {
	description = "Falchion of Eagerness",
	inventory_image = "falchion_of_eagerness.png",
	wield_scale= {x=2,y=2,z=1},
	tool_capabilities = {
		full_punch_interval =1 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=100, maxlevel=1},
			fleshy={times={[2]=0.8, [3]=0.4}, uses=400, maxlevel=1}
		},
		damage_groups = {fleshy=16},
	},
	on_drop = function(itemstack, dropper, pos)
		local vec = dropper:get_look_dir()
		local pos = dropper:getpos()
		--vec.y = 0

		for i=1,16 do
			pos = vector.add(pos, vec)
		end

		local pname = dropper:get_player_name()
		local player_inv = minetest.get_inventory({type='player', name = pname})

		if player_inv:is_empty('main') then
			--minetest.chat_send_all("Inventory empty")
		else
			local found = 0
			for i = 1,32 do
				local items = player_inv:get_stack('main', i)
				local n = items:get_name()
				if n == "nssm:life_energy" then
					if items:get_count() >= 5 then
						found = i
						break
					end
				end
			end
			if found == 0 then
				minetest.chat_send_player(pname, "You haven't got enough life_energy!")
				return
			else
				local s = dropper:getpos()
				minetest.add_particlespawner(
					25, --amount
					0.3, --time
					vector.subtract(s, 0.5), --minpos
					vector.add(s, 0.5), --maxpos
					{x=0, y=10, z=0}, --minvel
					{x=0.1, y=11, z=0.1}, --maxvel
					{x=0,y=1,z=0}, --minacc
					{x=0,y=1,z=0}, --maxacc
					0.5, --minexptime
					1, --maxexptime
					1, --minsize
					2, --maxsize
					false, --collisiondetection
					"slothful_soul_fragment.png" --texture
				)
				minetest.remove_node(pos)
				pos.y=pos.y+1
				minetest.remove_node(pos)
				pos.y=pos.y-2
				minetest.remove_node(pos)
				dropper:setpos(pos)
				s = pos
				s.y = s.y+10
				minetest.add_particlespawner(
					25, --amount
					0.3, --time
					vector.subtract(s, 0.5), --minpos
					vector.add(s, 0.5), --maxpos
					{x=0, y=-10, z=0}, --minvel
					{x=0.1, y=-11, z=0.1}, --maxvel
					{x=0,y=-1,z=0}, --minacc
					{x=0,y=-1,z=0}, --maxacc
					0.5, --minexptime
					1, --maxexptime
					1, --minsize
					2, --maxsize
					false, --collisiondetection
					"slothful_soul_fragment.png" --texture
				)
				local items = player_inv:get_stack('main', found)
				items:set_count(items:get_count()-5)
				player_inv:set_stack('main', found, items)
			end
		end
	end,
})

minetest.register_tool("nssm:sword_of_envy", {
	description = "Sword of Envy",
	inventory_image = "sword_of_envy.png",
	wield_scale= {x=2,y=2,z=1},
	tool_capabilities = {
		full_punch_interval =0.9 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.6, [2]=0.5, [3]=0.4}, uses=100, maxlevel=1},
			fleshy={times={[2]=0.5, [3]=0.2}, uses=400, maxlevel=1}
		},
		damage_groups = {fleshy=14},
	},
	on_drop = function(itemstack, dropper, pos)
	    local objects = minetest.env:get_objects_inside_radius(pos, 10)
	    local flag = 0
	    for _,obj in ipairs(objects) do
	        if flag == 0 then
	            local pname = dropper:get_player_name()
	            local player_inv = minetest.get_inventory({type='player', name = pname})

	            if player_inv:is_empty('main') then
	                --minetest.chat_send_all("Inventory empty")
	            else
	                local found = 0
	                for i = 1,32 do
	                    local items = player_inv:get_stack('main', i)
	                    local n = items:get_name()
	                    if n == "nssm:energy_globe" then
	                        found = i
	                        break
	                    end
	                end
	                if found == 0 then
	                    minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
	                    return
	                else
	                    if (obj:is_player()) then
	                        --minetest.chat_send_all("Giocatore")
	                        if (obj:get_player_name()~=dropper:get_player_name()) then
	                            local hpp = obj:get_hp()
								obj:set_hp(dropper:get_hp())
								dropper:set_hp(hpp)
	                            flag = 1

	                            local items = player_inv:get_stack('main', found)
	                            items:take_item()
	                            player_inv:set_stack('main', found, items)
	                        end
	                    else
	                        if (obj:get_luaentity().health) then
								local hpp = obj:get_luaentity().health
								obj:get_luaentity().health = dropper:get_hp()
								if hpp > 20 then
									dropper:set_hp(20)
								else
									dropper:set_hp(hpp)
								end
	                            check_for_death(obj:get_luaentity())
	                            flag = 1

	                            local items = player_inv:get_stack('main', found)
	                            items:take_item()
	                            player_inv:set_stack('main', found, items)
	                        end
	                    end
	                end
	            end
	        end
	    end
	end,
})

minetest.register_tool("nssm:sword_of_gluttony", {
	description = "Sword of Gluttony",
	inventory_image = "sword_of_gluttony.png",
	wield_scale= {x=2,y=2,z=1},
	tool_capabilities = {
		full_punch_interval =1 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.9, [2]=0.7, [3]=0.4}, uses=100, maxlevel=1},
			fleshy={times={[2]=0.6, [3]=0.2}, uses=400, maxlevel=1}
		},
		damage_groups = {fleshy=14},
	},
	on_drop = function(itemstack, dropper, pos)
		local objects = minetest.env:get_objects_inside_radius(pos, 10)
		local flag = 0
		for _,obj in ipairs(objects) do
			if flag == 0 then
				local pname = dropper:get_player_name()
				local player_inv = minetest.get_inventory({type='player', name = pname})

				if player_inv:is_empty('main') then
					--minetest.chat_send_all("Inventory empty")
				else
					local found = 0
					for i = 1,32 do
						local items = player_inv:get_stack('main', i)
						local n = items:get_name()
						if n == "nssm:energy_globe" then
							found = i
							break
						end
					end
					if found == 0 then
						minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
						return
					else
						if (obj:is_player()) then
							if (obj:get_player_name()~=dropper:get_player_name()) then
								obj:set_hp(obj:get_hp()-10)
								--flag = 1

								--take energy globe from inventory:
								local items = player_inv:get_stack('main', found)
								items:take_item()
								player_inv:set_stack('main', found, items)
							end
			            else
							if (obj:get_luaentity().health) then
								if obj:get_luaentity().health <= 32 then
									local pos = obj:getpos()
									obj:remove()

									--check_for_death(obj:get_luaentity())
									--flag = 1
									--take energy globe from inventory:
									local items = player_inv:get_stack('main', found)
									items:take_item()
									player_inv:set_stack('main', found, items)

									for i = 1,math.random(1,4) do
										drop = minetest.add_item(pos, "nssm:roasted_duck_legs 1")
										drops(drop)
									end

									local s = obj:getpos()
									local p = dropper:getpos()
									local m = 3

									minetest.add_particlespawner(
										10, --amount
										0.1, --time
										{x=p.x-0.5, y=p.y-0.5, z=p.z-0.5}, --minpos
										{x=p.x+0.5, y=p.y+0.5, z=p.z+0.5}, --maxpos
										{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --minvel
										{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --maxvel
										{x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}, --minacc
										{x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}, --maxacc
										0.5, --minexptime
										1, --maxexptime
										1, --minsize
										2, --maxsize
										false, --collisiondetection
										"gluttonous_soul_fragment.png" --texture
									)
								end
							end
			            end
					end
				end
			end
        end
	end,
})

minetest.register_tool("nssm:death_scythe", {
	description = "Death Scythe",
	wield_scale= {x=3,y=3,z=1.3},
	inventory_image = "death_scythe.png",
	tool_capabilities = {
		full_punch_interval =0.2 ,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=28000, maxlevel=1},
			fleshy={times={[2]=0.1, [3]=0.1}, uses=28000, maxlevel=1}
		},
		damage_groups = {fleshy=28},
	},
	groups ={not_in_creative_inventory=1},
	on_drop = function(itemstack, dropper, pos)
	    local objects = minetest.env:get_objects_inside_radius(pos, 10)
	    local flag = 0
		dropper:set_hp(dropper:get_hp()-9)
	    for _,obj in ipairs(objects) do
			flag = 0
            if (obj:is_player()) then
                if (obj:get_player_name()~=dropper:get_player_name()) then
                    obj:set_hp(obj:get_hp()-40)
                    flag = 1
                end
            else
                if (obj:get_luaentity().health) then
                    obj:get_luaentity().health = obj:get_luaentity().health -40
                    check_for_death(obj:get_luaentity())
                    flag = 1
                end
            end
			if flag == 1 then
				for i = 1,math.random(1,2) do
					drop = minetest.add_item(pos, "nssm:energy_globe 1")

					if drop then
						drop:setvelocity({
							x = math.random(-10, 10) / 9,
							y = 5,
							z = math.random(-10, 10) / 9,
						})
					end
				end
			end
	    end
		local pos = dropper:getpos()
		local vec = {x=5,y=5,z=5}
		local poslist = minetest.find_nodes_in_area(vector.subtract(pos, vec), vector.add(pos,vec), "default:dirt_with_grass")
		for _,v in pairs(poslist) do
			--minetest.chat_send_all(minetest.pos_to_string(v))
			minetest.set_node(v, {name="default:dirt_with_dry_grass"})
			if math.random(1,3)==1 then
				v.y = v.y +2
				drop = minetest.add_item(v, "nssm:life_energy 1")
				drops(drop)
			end
		end

		local poslist = minetest.find_nodes_in_area_under_air(vector.subtract(pos, vec), vector.add(pos,vec), "group:flora")
		for _,v in pairs(poslist) do
			--minetest.chat_send_all(minetest.pos_to_string(v))
			minetest.set_node(v, {name="default:dry_shrub"})
			if math.random(1,3)==1 then
				v.y = v.y +2
				drop = minetest.add_item(v, "nssm:life_energy 1")
				drops(drop)
			end
		end

		local poslist = minetest.find_nodes_in_area(vector.subtract(pos, vec), vector.add(pos,vec), "group:leaves")
		for _,v in pairs(poslist) do
			--minetest.chat_send_all(minetest.pos_to_string(v))
			minetest.set_node(v, {name="nssm:dead_leaves"})
			if math.random(1,3)==1 then
				v.y = v.y +2
				drop = minetest.add_item(v, "nssm:life_energy 1")
				drops(drop)
			end
		end
	end,
})

--recipes

minetest.register_craft({
	output = 'nssm:web_string',
	recipe = {
		{'nssm:web', 'nssm:web'},
		{'nssm:web', 'nssm:web'},
	}
})

minetest.register_craft({
	output = 'nssm:dense_web_string',
	recipe = {
		{'nssm:web_string', 'nssm:web_string', 'nssm:web_string'},
		{'nssm:web_string', 'nssm:web_string', 'nssm:web_string'},
		{'nssm:web_string', 'nssm:web_string', 'nssm:web_string'},
	}
})

minetest.register_craft({
	output = 'nssm:mantis_sword',
	recipe = {
		{'nssm:mantis_claw'},
		{'nssm:mantis_claw'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:masticone_fang_sword',
	recipe = {
		{'nssm:masticone_fang', 'nssm:masticone_fang'},
		{'nssm:masticone_fang', ''},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:black_ice_tooth',
	type = "shapeless",
	recipe = {'nssm:digested_sand', 'nssm:ice_tooth'},
})

minetest.register_craft({
	output = 'nssm:web 4',
	type = "shapeless",
	recipe = {'nssm:silk_gland'},
})

minetest.register_craft({
	output = 'nssm:crab_light_mace',
	recipe = {
		{'nssm:crab_chela'},
		{'group:stick'},
		{'group:stick'},
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
	type = "shapeless",
	recipe = {'nssm:tarantula_chelicerae', 'nssm:helmet_masticone_crowned', 'nssm:eyed_tentacle','nssm:black_ice_tooth', 'nssm:superior_energy_globe', 'nssm:sky_feather','nssm:cursed_pumpkin_seed', 'nssm:ant_queen_abdomen', 'nssm:snake_scute'}
})

--[[minetest.register_craft({
	output = 'nssm:masticone_skull_crowned',
	recipe = {
		{'', 'nssm:king_duck_crown', ''},
		{'', 'nssm:masticone_skull', ''},
		{'', '', ''},
	}
})]]

minetest.register_craft({
	output = 'nssm:eyed_tentacle',
	type = "shapeless",
	recipe = {'nssm:lava_titan_eye','nssm:tentacle_curly'}
})

minetest.register_craft({
	output = 'nssm:life_energy 9',
	type = "shapeless",
	recipe = {'nssm:energy_globe'}
})

minetest.register_craft({
	output = 'nssm:energy_globe 9',
	type = "shapeless",
	recipe = {'nssm:great_energy_globe'}
})

minetest.register_craft({
	output = 'nssm:great_energy_globe 9',
	type = "shapeless",
	recipe = {'nssm:superior_energy_globe'}
})
--[[
minetest.register_craft({
	output = 'nssm:masticone_skull',
	recipe = {
		{'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments'},
		{'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments'},
		{'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments', 'nssm:masticone_skull_fragments'},
	}
})]]

minetest.register_craft({
	output = 'nssm:rope 12',
	recipe = {
		{'nssm:web_string'},
		{'nssm:web_string'},
		{'nssm:web_string'},
	}
})


minetest.register_craft({
	output = 'nssm:sky_feather',
	type = "shapeless",
	recipe = {'nssm:sun_feather','nssm:night_feather'}
})

minetest.register_craft({
	output = 'nssm:sun_sword',
	recipe = {
		{'default:diamond'},
		{'nssm:sun_feather'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:night_sword',
	recipe = {
		{'default:diamond'},
		{'nssm:night_feather'},
		{'group:stick'},
	}
})

function nssm_register_recip (ingredient, dish, tictac)

minetest.register_craft({
	type = "cooking",
	output = "nssm:"..dish,
	recipe = "nssm:"..ingredient,
	cooktime = tictac,
})

end

nssm_register_recip ('worm_flesh', 'roasted_worm_flesh', 12)
nssm_register_recip ('duck_legs', 'roasted_duck_legs', 6)
nssm_register_recip ('spider_leg', 'roasted_spider_leg', 6)
nssm_register_recip ('felucco_steak', 'roasted_felucco_steak', 10)
nssm_register_recip ('werewolf_leg', 'roasted_werewolf_leg', 10)
nssm_register_recip ('brain', 'roasted_brain', 6)
nssm_register_recip ('amphibian_heart', 'roasted_amphibian_heart', 6)
nssm_register_recip ('tentacle', 'roasted_tentacle', 6)
nssm_register_recip ('frosted_amphibian_heart', 'amphibian_heart', 8)
nssm_register_recip ('heron_leg', 'chichibios_heron_leg', 20)
nssm_register_recip ('raw_scrausics_wing', 'spicy_scrausics_wing', 12)
nssm_register_recip ('ant_leg', 'roasted_ant_leg', 6)
nssm_register_recip ('crocodile_tail', 'roasted_crocodile_tail', 16)
nssm_register_recip ('dolidrosaurus_fin', 'roasted_dolidrosaurus_fin', 8)
nssm_register_recip ('amphibian_ribs', 'roasted_amphibian_ribs', 12)
nssm_register_recip ('mantis_meat', 'roasted_mantis_meat', 6)
nssm_register_recip ('spider_meat', 'roasted_spider_meat', 6)
nssm_register_recip ('silk_gland', 'roasted_silk_gland', 4)
nssm_register_recip ('larva_juice', 'larva_soup', 20)



minetest.register_craft({
	output = 'nssm:larva_juice',
	type = "shapeless",
	recipe = {'nssm:larva_meat','bucket:bucket_empty'}
})

minetest.register_craft({
	output = 'nssm:ant_sword',
	recipe = {
		{'nssm:ant_mandible'},
		{'nssm:ant_mandible'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:ant_billhook',
	recipe = {
		{'nssm:ant_mandible', 'nssm:ant_mandible'},
		{'nssm:ant_mandible', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:ant_shovel',
	recipe = {
		{'nssm:ant_mandible'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:duck_beak_shovel',
	recipe = {
		{'nssm:duck_beak'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:duck_beak_pick',
	recipe = {
		{'nssm:duck_beak', 'nssm:duck_beak', 'nssm:duck_beak'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:sky_iron 30',
	recipe = {
		{'default:steelblock', 'default:steelblock', 'default:steelblock'},
		{'default:steelblock', 'nssm:sky_feather', 'default:steelblock'},
		{'default:steelblock', 'default:steelblock', 'default:steelblock'},
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

minetest.register_craft({
	output = 'nssm:felucco_knife',
	recipe = {
		{'nssm:felucco_horn'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:little_ice_tooth_knife',
	recipe = {
		{'nssm:little_ice_tooth'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:manticore_spine_knife',
	recipe = {
		{'nssm:manticore_spine'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:ant_pick',
	recipe = {
		{'nssm:ant_mandible', 'nssm:ant_mandible', 'nssm:ant_mandible'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:mantis_pick',
	recipe = {
		{'nssm:mantis_claw', 'nssm:mantis_claw', 'nssm:mantis_claw'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'nssm:mantis_axe',
	recipe = {
		{'nssm:mantis_claw', 'nssm:mantis_claw'},
		{'nssm:mantis_claw', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:tarantula_warhammer',
	recipe = {
		{'nssm:tarantula_chelicerae'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'nssm:mantis_battleaxe',
	recipe = {
		{'nssm:mantis_claw', 'nssm:mantis_claw', 'nssm:mantis_claw'},
		{'nssm:mantis_claw', 'group:stick', 'nssm:mantis_claw'},
		{'', 'group:stick', ''},
	}
})

if minetest.get_modpath("nssb") then
	minetest.register_craft({
		output = 'nssm:axe_of_pride',
		recipe = {
			{'nssm:proud_moranga', 'nssm:proud_moranga', 'nssm:proud_moranga'},
			{'nssm:proud_moranga', 'nssb:moranga_ingot', ''},
			{'', 'nssb:moranga_ingot', ''},
		}
	})

	minetest.register_craft({
		output = 'nssm:gratuitousness_battleaxe',
		recipe = {
			{'nssm:greedy_moranga', 'nssm:greedy_moranga', 'nssm:greedy_moranga'},
			{'nssm:greedy_moranga', 'nssb:moranga_ingot', 'nssm:greedy_moranga'},
			{'', 'nssb:moranga_ingot', ''},
		}
	})

	minetest.register_craft({
		output = 'nssm:sword_of_envy',
		recipe = {
			{'nssm:envious_moranga'},
			{'nssm:envious_moranga'},
			{'nssb:moranga_ingot'},
		}
	})

	minetest.register_craft({
		output = 'nssm:sword_of_eagerness',
		recipe = {
			{'nssm:slothful_moranga'},
			{'nssm:slothful_moranga'},
			{'nssb:moranga_ingot'},
		}
	})

	minetest.register_craft({
		output = 'nssm:falchion_of_eagerness',
		recipe = {
			{'nssm:slothful_moranga','nssm:slothful_moranga'},
			{'nssm:slothful_moranga', ''},
			{'nssb:moranga_ingot',''},
		}
	})

	minetest.register_craft({
		output = 'nssm:sword_of_gluttony',
		recipe = {
			{'nssm:gluttonous_moranga', 'nssm:gluttonous_moranga', 'nssm:gluttonous_moranga'},
			{'', 'nssm:gluttonous_moranga', ''},
			{'', 'nssb:moranga_ingot', ''},
		}
	})

	function nssm_register_moranga (viz)
	minetest.register_craft({
		output = 'nssm:'.. viz ..'_moranga',
		recipe = {
			{'nssm:'.. viz ..'_soul_fragment', 'nssb:moranga_ingot', 'nssm:'.. viz ..'_soul_fragment'},
			{'nssb:moranga_ingot', 'nssm:'.. viz ..'_soul_fragment', 'nssb:moranga_ingot'},
			{'nssm:'.. viz ..'_soul_fragment', 'nssb:moranga_ingot', 'nssm:'.. viz ..'_soul_fragment'},
		}
	})
	end
	nssm_register_moranga ("lustful")
	nssm_register_moranga ("greedy")
	nssm_register_moranga ("slothful")
	nssm_register_moranga ("wrathful")
	nssm_register_moranga ("gluttonous")
	nssm_register_moranga ("envious")
	nssm_register_moranga ("proud")
end
--Eggs

function nssm_register_egg (name, descr)
	minetest.register_craftitem("nssm:".. name, {
		description = descr .. " Egg",
		image = name.."_egg.png",
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

function nssm_register_egg2 (name, descr)				--mobs you can't catch
	minetest.register_craftitem("nssm:".. name.."_egg", {
		description = descr .. " Egg",
		image = name.."_egg.png",
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

nssm_register_egg ('flying_duck', 'Flying Duck')
nssm_register_egg ('stone_eater', 'Stoneater')
nssm_register_egg ('signosigno', 'Signosigno')
nssm_register_egg ('bloco', 'Bloco')
nssm_register_egg ('sand_bloco', 'Sand Bloco')
nssm_register_egg ('swimming_duck', 'Swimming Duck')
nssm_register_egg ('duck', 'Duck')
nssm_register_egg2 ('duckking', 'Duckking')
nssm_register_egg ('enderduck', 'Enderduck')
nssm_register_egg ('spiderduck', 'Spiderduck')
nssm_register_egg2 ('echidna', 'Echidna')
nssm_register_egg ('werewolf', 'Werewolf')
nssm_register_egg ('white_werewolf', 'White Werewolf')
nssm_register_egg ('snow_biter', 'Snow Biter')
nssm_register_egg2 ('icelamander', 'Icelamander')
nssm_register_egg ('icesnake', 'Icesnake')
nssm_register_egg2 ('lava_titan', 'Lava Titan')
nssm_register_egg ('masticone', 'Masticone')
nssm_register_egg ('mantis_beast', 'Mantis Beast')
nssm_register_egg ('mantis', 'Mantis')
nssm_register_egg ('larva', 'Larva')
nssm_register_egg2 ('phoenix', 'Phoenix')
nssm_register_egg2 ('night_master', 'Night Master')
nssm_register_egg ('scrausics', 'Scrausics')
nssm_register_egg ('moonheron', 'Moonheron')
nssm_register_egg ('sandworm', 'Sandworm')
nssm_register_egg2 ('giant_sandworm', 'Giant Sandworm')
nssm_register_egg2 ('ant_queen', 'Ant Queen')
nssm_register_egg ('ant_soldier', 'Ant Soldier')
nssm_register_egg ('ant_worker', 'Ant Worker')
nssm_register_egg ('crocodile', 'Crocodile')
nssm_register_egg ('dolidrosaurus', 'Dolidrosaurus')
nssm_register_egg ('crab', 'Crab')
nssm_register_egg ('octopus', 'Octopus')
nssm_register_egg ('xgaloctopus', 'Xgaloctopus')
nssm_register_egg ('black_widow', 'Black Widow')
nssm_register_egg ('uloboros', 'Uloboros')
nssm_register_egg2 ('tarantula', 'Tarantula')
nssm_register_egg ('daddy_long_legs', 'Daddy Long Legs')
nssm_register_egg2 ('kraken', 'Kraken')
nssm_register_egg2 ('pumpking', 'Pumpking')
nssm_register_egg ('manticore', 'Manticore')
nssm_register_egg ('felucco', 'Felucco')
nssm_register_egg ('pumpboom_large', 'Large Pumpboom')
nssm_register_egg ('pumpboom_small', 'Small Pumpboom')
nssm_register_egg ('pumpboom_medium', 'Medium Pumpboom')
nssm_register_egg2 ('mordain', 'Mordain')
nssm_register_egg2 ('morgre', 'Morgre')
nssm_register_egg2 ('morvy', 'Morvy')
nssm_register_egg2 ('morgut', 'Morgut')
nssm_register_egg2 ('morde', 'Morde')
nssm_register_egg2 ('morlu', 'Morlu')
nssm_register_egg2 ('morwa', 'Morwa')
--nssm_register_egg ('morvalar', 'Morvalar')

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


--experimental morwa statue
minetest.register_node("nssm:morwa_statue", {
   description = 'Morwa Statue',
   drawtype = 'mesh',
   mesh = 'morwa_statue.b3d',
   tiles = {'morwa_statue.png'},
   inventory_image = 'morwa_statue.png',
   groups = {not_in_creative_inventory=1},
   paramtype = 'light',
   paramtype2 = 'facedir',
   selection_box = {
      type = 'fixed',
      fixed = {-1, -0.5, -1, 1, 3, 1}, -- Right, Bottom, Back, Left, Top, Front
      },
   collision_box = {
      type = 'fixed',
      fixed = {-1, -0.5, -1, 1, 3, 1}, -- Right, Bottom, Back, Left, Top, Front
      },
})
--Abm to make the conversion between statue and the entity, caused by light

minetest.register_abm({
	nodenames = {"nssm:morwa_statue"},
	neighbors = {"air"},
	interval = 1,
	chance = 1,
	action =
	function(pos, node)
		local pos1 = {x=pos.x, y=pos.y+1, z=pos.z}
		local n = minetest.env:get_node(pos1).name
		if n ~= "air" then
			return
		end
		if (minetest.get_node_light(pos1) > 8)
		then
		minetest.add_entity(pos1, "nssm:morwa")
		minetest.remove_node(pos)
		end
	end
})
--Eggs recipes



minetest.register_craft({
	output = 'nssm:duck',
	recipe = {
		{'', 'nssm:duck_beak', ''},
		{'nssm:duck_feather', 'nssm:energy_globe', 'nssm:duck_feather'},
		{'nssm:duck_legs', 'nssm:duck_feather', 'nssm:duck_legs'},
	}
})

minetest.register_craft({
	output = 'nssm:flying_duck',
	recipe = {
		{'nssm:duck_feather', 'nssm:duck_beak', 'nssm:duck_feather'},
		{'nssm:duck_feather', 'nssm:energy_globe', 'nssm:duck_feather'},
		{'nssm:duck_legs', 'nssm:duck_feather', 'nssm:duck_legs'},
	}
})

minetest.register_craft({
	output = 'nssm:enderduck',
	recipe = {
		{'nssm:black_duck_feather', 'nssm:duck_beak', 'nssm:black_duck_feather'},
		{'nssm:duck_legs', 'nssm:energy_globe', 'nssm:duck_legs'},
		{'nssm:duck_legs', '', 'nssm:duck_legs'},
	}
})

minetest.register_craft({
	output = 'nssm:swimming_duck',
	recipe = {
		{'nssm:duck_feather', 'nssm:duck_beak', 'nssm:duck_feather'},
		{'nssm:duck_legs', 'nssm:energy_globe', 'nssm:duck_legs'},
		{'nssm:duck_feather', 'nssm:duck_feather', 'nssm:duck_feather'},
	}
})

minetest.register_craft({
	output = 'nssm:spiderduck',
	recipe = {
		{'nssm:duck_legs', 'nssm:duck_beak', 'nssm:duck_legs'},
		{'nssm:black_duck_feather', 'nssm:energy_globe', 'nssm:black_duck_feather'},
		{'nssm:duck_legs', 'nssm:black_duck_feather', 'nssm:duck_legs'},
	}
})

minetest.register_craft({
	output = 'nssm:duckking_egg',
	recipe = {
		{'', 'nssm:helmet_crown', ''},
		{'nssm:duck_feather', 'nssm:duck_beak', 'nssm:duck_feather'},
		{'nssm:duck_legs', 'nssm:superior_energy_globe', 'nssm:duck_legs'},
	}
})

minetest.register_craft({
	output = 'nssm:bloco',
	recipe = {
		{'nssm:bloco_skin', 'nssm:bloco_skin', 'nssm:bloco_skin'},
		{'nssm:bloco_skin', 'nssm:energy_globe', 'nssm:bloco_skin'},
		{'nssm:bloco_skin', 'nssm:bloco_skin', 'nssm:bloco_skin'},
	}
})
