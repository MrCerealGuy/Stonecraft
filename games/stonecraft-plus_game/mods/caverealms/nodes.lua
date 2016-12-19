-- CaveRealms nodes.lua

--NODES--

local FALLING_ICICLES = caverealms.config.falling_icicles --true --toggle to turn on or off falling icicles in glaciated biome
local FALLCHA = caverealms.config.fallcha --0.33 --chance of causing the structure to fall
local DM_TOP = caverealms.config.dm_top -- -4000 --level at which Dungeon Master Realms start to appear


--glowing crystal
minetest.register_node("caverealms:glow_crystal", {
	description = "Glow Crystal",
	tiles = {"caverealms_glow_crystal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

--glowing emerald
minetest.register_node("caverealms:glow_emerald", {
	description = "Glow Emerald",
	tiles = {"caverealms_glow_emerald.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

--glowing mese crystal blocks
minetest.register_node("caverealms:glow_mese", {
	description = "Mese Crystal Block",
	tiles = {"caverealms_glow_mese.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

--glowing ruby
minetest.register_node("caverealms:glow_ruby", {
	description = "Glow Ruby",
	tiles = {"caverealms_glow_ruby.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

--glowing amethyst
minetest.register_node("caverealms:glow_amethyst", {
	description = "Glow Amethyst",
	tiles = {"caverealms_glow_amethyst.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

--embedded crystal
minetest.register_node("caverealms:glow_ore", {
	description = "Glow Crystal Ore",
	tiles = {"caverealms_glow_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 10,
	paramtype = "light",
})

--embedded emerald
minetest.register_node("caverealms:glow_emerald_ore", {
	description = "Glow Emerald Ore",
	tiles = {"caverealms_glow_emerald_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 10,
	paramtype = "light",
})

--embedded ruby
minetest.register_node("caverealms:glow_ruby_ore", {
	description = "Glow Ruby Ore",
	tiles = {"caverealms_glow_ruby_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 10,
	paramtype = "light",
})

--embedded amethyst
minetest.register_node("caverealms:glow_amethyst_ore", {
	description = "Glow Amethyst Ore",
	tiles = {"caverealms_glow_amethyst_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 10,
	paramtype = "light",
})

--thin (transparent) ice
minetest.register_node("caverealms:thin_ice", {
	description = "Thin Ice",
	tiles = {"caverealms_thin_ice.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
	freezemelt = "default:water_source",
	paramtype = "light",
})

--salt crystal
minetest.register_node("caverealms:salt_crystal", {
	description = "Salt Crystal",
	tiles = {"caverealms_salt_crystal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 11,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

--alternate version for stalactites
minetest.register_node("caverealms:hanging_thin_ice", {
	description = "Thin Ice",
	tiles = {"caverealms_thin_ice.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
	drop = "caverealms:thin_ice",
	freezemelt = "default:water_flowing",
	paramtype = "light",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if FALLING_ICICLES then
			if math.random() <= FALLCHA then
				obj = minetest.add_entity(pos, "caverealms:falling_ice")
				obj:get_luaentity():set_node(oldnode)
				for y = -13, 13 do
					for x = -3, 3 do
					for z = -3, 3 do
						local npos = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
						if minetest.get_node(npos).name == "caverealms:hanging_thin_ice" then
							nobj = minetest.add_entity(npos, "caverealms:falling_ice")
							nobj:get_luaentity():set_node(oldnode)
							minetest.remove_node(npos)
						end
					end
					end
				end
				minetest.remove_node(pos)
			else
				return 1
			end
		else
			return 1
		end
	end,
})

--glowing crystal gem
local glow_gem_size = { 1.0, 1.2, 1.4, 1.6, 1.7 }

for i in ipairs(glow_gem_size) do
	if i == 1 then
		nodename = "caverealms:glow_gem"
	else
		nodename = "caverealms:glow_gem_"..i
	end

	vs = glow_gem_size[i]

	minetest.register_node(nodename, {
		description = "Glow Gem",
		tiles = {"caverealms_glow_gem.png"},
		inventory_image = "caverealms_glow_gem.png",
		wield_image = "caverealms_glow_gem.png",
		is_ground_content = true,
		groups = {cracky=3, oddly_breakable_by_hand=1},
		sounds = default.node_sound_glass_defaults(),
		light_source = 11,
		paramtype = "light",
		drawtype = "plantlike",
		walkable = false,
		buildable_to = true,
		visual_scale = vs,
		selection_box = {
			type = "fixed",
			fixed = {-0.5*vs, -0.5*vs, -0.5*vs, 0.5*vs, -5/16*vs, 0.5*vs},
		}
	})
end

--glowing salt gem
local salt_gem_size = { 1.0, 1.2, 1.4, 1.6, 1.7 }

for i in ipairs(salt_gem_size) do
	if i == 1 then
		nodename = "caverealms:salt_gem"
	else
		nodename = "caverealms:salt_gem_"..i
	end

	vs = salt_gem_size[i]

	minetest.register_node(nodename, {
		description = "Salt Gem",
		tiles = {"caverealms_salt_gem.png"},
		inventory_image = "caverealms_salt_gem.png",
		wield_image = "caverealms_salt_gem.png",
		is_ground_content = true,
		groups = {cracky=3, oddly_breakable_by_hand=1},
		sounds = default.node_sound_glass_defaults(),
		light_source = 11,
		paramtype = "light",
		drawtype = "plantlike",
		walkable = false,
		buildable_to = true,
		visual_scale = vs,
		selection_box = {
			type = "fixed",
			fixed = {-0.5*vs, -0.5*vs, -0.5*vs, 0.5*vs, -5/16*vs, 0.5*vs},
		}
	})
end

--stone spike
local spike_size = { 1.0, 1.2, 1.4, 1.6, 1.7 }

for i in ipairs(spike_size) do
	if i == 1 then
		nodename = "caverealms:spike"
	else
		nodename = "caverealms:spike_"..i
	end

	vs = spike_size[i]

	minetest.register_node(nodename, {
		description = "Stone Spike",
		tiles = {"caverealms_spike.png"},
		inventory_image = "caverealms_spike.png",
		wield_image = "caverealms_spike.png",
		is_ground_content = true,
		groups = {cracky=3, oddly_breakable_by_hand=1},
		sounds = default.node_sound_stone_defaults(),
		light_source = 3,
		paramtype = "light",
		drawtype = "plantlike",
		walkable = false,
		buildable_to = true,
		visual_scale = vs,
		selection_box = {
			type = "fixed",
			fixed = {-0.5*vs, -0.5*vs, -0.5*vs, 0.5*vs, -5/16*vs, 0.5*vs},
		}
	})
end

--upward pointing icicle
minetest.register_node("caverealms:icicle_up", {
	description = "Icicle",
	tiles = {"caverealms_icicle_up.png"},
	inventory_image = "caverealms_icicle_up.png",
	wield_image = "caverealms_icicle_up.png",
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	light_source = 8,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

--downward pointing icicle
minetest.register_node("caverealms:icicle_down", {
	description = "Icicle",
	tiles = {"caverealms_icicle_down.png"},
	inventory_image = "caverealms_icicle_down.png",
	wield_image = "caverealms_icicle_down.png",
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	light_source = 8,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

--cave mossy cobble - bluish?
minetest.register_node("caverealms:stone_with_moss", {
	description = "Cave Stone with Moss",
	tiles = {"default_cobble.png^caverealms_moss.png", "default_cobble.png", "default_cobble.png^caverealms_moss_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

--cave lichen-covered cobble - purple-ish
minetest.register_node("caverealms:stone_with_lichen", {
	description = "Cave Stone with Lichen",
	tiles = {"default_cobble.png^caverealms_lichen.png", "default_cobble.png", "default_cobble.png^caverealms_lichen_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

--cave algae-covered cobble - yellow-ish
minetest.register_node("caverealms:stone_with_algae", {
	description = "Cave Stone with Algae",
	tiles = {"default_cobble.png^caverealms_algae.png", "default_cobble.png", "default_cobble.png^caverealms_algae_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

--tiny-salt-crystal-covered cobble - pink-ish
minetest.register_node("caverealms:stone_with_salt", {
	description = "Cave Stone with Salt",
	tiles = {"caverealms_salty2.png"},--{"caverealms_salty2.png^caverealms_salty.png", "caverealms_salty2.png", "caverealms_salty2.png^caverealms_salty_side.png"},
	light_source = 9,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_glass_defaults(),
})

--Hot Cobble - cobble with lava instead of mortar XD
minetest.register_node("caverealms:hot_cobble", {
	description = "Hot Cobble",
	tiles = {"caverealms_hot_cobble.png"},
	is_ground_content = true,
	groups = {crumbly=2, hot=1},
	damage_per_second = 1,
	light_source = 3,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})

--Glow Obsidian
minetest.register_node("caverealms:glow_obsidian", {
	description = "Glowing Obsidian",
	tiles = {"caverealms_glow_obsidian.png"},
	is_ground_content = true,
	groups = {crumbly=1},
	light_source = 7,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})

--Glow Obsidian 2 - has traces of lava
minetest.register_node("caverealms:glow_obsidian_2", {
	description = "Hot Glow Obsidian",
	tiles = {"caverealms_glow_obsidian2.png"},
	is_ground_content = true,
	groups = {crumbly=1, hot=1},
	damage_per_second = 1,
	light_source = 9,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})

--Coal Dust
minetest.register_node("caverealms:coal_dust", {
	description = "Coal Dust",
	tiles = {"caverealms_coal_dust.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

--glow worms
minetest.register_node("caverealms:glow_worm", {
	description = "Glow Worms",
	tiles = {"caverealms_glow_worm.png"},
	inventory_image = "caverealms_glow_worm.png",
	wield_image = "caverealms_glow_worm.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 9,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
})

--cave plants go here

--glowing fungi
minetest.register_node("caverealms:fungus", {
	description = "Glowing Fungus",
	tiles = {"caverealms_fungi.png"},
	inventory_image = "caverealms_fungi.png",
	wield_image = "caverealms_fungi.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 5,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

--mycena mushroom
minetest.register_node("caverealms:mycena", {
	description = "Mycena Mushroom",
	tiles = {"caverealms_mycena.png"},
	inventory_image = "caverealms_mycena.png",
	wield_image = "caverealms_mycena.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 6,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

--giant mushroom
--stem
minetest.register_node("caverealms:mushroom_stem", {
	description = "Giant Mushroom Stem",
	tiles = {"caverealms_mushroom_stem.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=1},
})

--cap
minetest.register_node("caverealms:mushroom_cap", {
	description = "Giant Mushroom Cap",
	tiles = {"caverealms_mushroom_cap.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=1},
})

--gills
minetest.register_node("caverealms:mushroom_gills", {
	description = "Giant Mushroom Gills",
	tiles = {"caverealms_mushroom_gills.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=1},
	drawtype = "plantlike",
	paramtype = "light",
})

--define special flame so that it does not expire
minetest.register_node("caverealms:constant_flame", {
	description = "Fire",
	drawtype = "plantlike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {igniter=2,dig_immediate=3,hot=3, not_in_creative_inventory=1},
	drop = '',
	walkable = false,
	buildable_to = true,
	damage_per_second = 4,
	
	after_place_node = function(pos, placer)
		if pos.y > DM_TOP then
			minetest.remove_node(pos)
		end
		if not (minetest.get_modpath("moontest")) then
			fire.on_flame_add_at(pos)
		end
	end,
	
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if not (minetest.get_modpath("moontest")) then
			fire.on_flame_remove_at(pos)
		end
	end,
})

--node to create a treasure chest in DM Forts.
minetest.register_node("caverealms:s_chest", {
	description = "Trying to rob the bank before it's opened, eh?",
	tiles = {"default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=3,oddly_breakable_by_hand=2,cavechest=1, not_in_creative_inventory=1},
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if pos.y > DM_TOP then
			minetest.remove_node(pos)
		end
	end,
})

--hacky schematic placers

minetest.register_node("caverealms:s_fountain", {
	description = "A Hack like you should know what this does...",
	tiles = {"caverealms_stone_eyes.png"},
	groups = {crumbly=3, schema=1, not_in_creative_inventory=1},
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if pos.y > DM_TOP then
			minetest.remove_node(pos)
		end
	end,
})

minetest.register_node("caverealms:s_fortress", {
	description = "A Hack like you should know what this does...",
	tiles = {"caverealms_stone_eyes.png"},
	groups = {crumbly=3, schema=1, not_in_creative_inventory=1},
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if pos.y > DM_TOP then
			minetest.remove_node(pos)
		end
	end,
})

--dungeon master statue (nodebox)
minetest.register_node("caverealms:dm_statue", {
	tiles = {
		"caverealms_dm_stone.png",
		"caverealms_dm_stone.png",
		"caverealms_dm_stone.png",
		"caverealms_dm_stone.png",
		"caverealms_dm_stone.png",
		"caverealms_stone_eyes.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.3125, 0.4375}, -- NodeBox1
			{-0.25, -0.125, -0.1875, 0.25, 0.5, 0.1875}, -- NodeBox2
			{-0.375, 0, -0.125, -0.25, 0.4375, 0.125}, -- NodeBox3
			{0.25, 0.125, -0.4375, 0.375, 0.375, 0.1875}, -- NodeBox4
			{-0.25, -0.5, -0.125, -0.125, -0.125, 0.125}, -- NodeBox5
			{0.125, -0.3125, -0.125, 0.25, 0, 0.125}, -- NodeBox6
		}
	},
	selection_box = {
		type = "regular"
	}
})
