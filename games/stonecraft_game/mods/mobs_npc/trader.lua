
-- translation and mod check
local S = minetest.get_translator("mobs_npc")
local mcl = minetest.get_modpath("mcl_core") ~= nil

-- define table containing names for use and shop items for sale

mobs.human = {

	names = {
		"Bob", "Duncan", "Bill", "Tom", "James", "Ian", "Lenny",
		"Dylan", "Ethan", "Sam", "Aubrey"
	},

	items = {
		--{item for sale, price, chance of appearing in trader's inventory}
		{mcl and "mcl_core:apple 10" or "default:apple 10",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 10},
		{mcl and "mcl_farming:bread 10" or "farming:bread 10",
				mcl and "mcl_core:gold_ingot 4" or "default:gold_ingot 4", 5},
		{mcl and "mcl_core:clay 10" or "default:clay 10",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 12},
		{mcl and "mcl_core:stonebrick 10" or "default:brick 10",
				mcl and "mcl_core:gold_ingot 4" or "default:gold_ingot 4", 17},
		{mcl and "mcl_core:glass 10" or "default:glass 10",
				mcl and "mcl_core:gold_ingot 4" or "default:gold_ingot 4", 17},
		{mcl and "mcl_core:obsidian 10" or "default:obsidian 10",
				mcl and "mcl_core:gold_ingot 15" or "default:gold_ingot 15", 50},
		{mcl and "mcl_core:diamond 1" or "default:diamond 1",
				mcl and "mcl_core:gold_ingot 5" or "default:gold_ingot 5", 40},
		{mcl and "mcl_farming:wheat_item 10" or "farming:wheat 10",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 17},
		{mcl and "mcl_core:tree 5" or "default:tree 5",
				mcl and "mcl_core:gold_ingot 4" or "default:gold_ingot 4", 20},
		{mcl and "mcl_core:stone 10" or "default:stone 10",
				mcl and "mcl_core:gold_ingot 8" or "default:gold_ingot 8", 17},
		{mcl and "mcl_core:stonebrick 10" or "default:desert_stone 10",
				mcl and "mcl_core:gold_ingot 8" or "default:gold_ingot 8", 27},
		{mcl and "mcl_core:sapling 1" or "default:sapling 1",
				mcl and "mcl_core:gold_ingot 1" or "default:gold_ingot 1", 7},
		{mcl and "mcl_tools:pick_iron 1" or "default:pick_steel 1",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 7},
		{mcl and "mcl_tools:sword_iron 1" or "default:sword_steel 1",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 17},
		{mcl and "mcl_tools:shovel_iron 1" or "default:shovel_steel 1",
				mcl and "mcl_core:gold_ingot 1" or "default:gold_ingot 1", 17},
		{mcl and "mcl_core:cactus 2" or "default:cactus 2",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 40},
		{mcl and "mcl_core:paper 2" or "default:papyrus 2",
				mcl and "mcl_core:gold_ingot 2" or "default:gold_ingot 2", 40},
		{mcl and "mcl_core:iron_nugget 1" or "default:mese_crystal_fragment 1",
				mcl and "mcl_core:dirt_with_grass 10" or "default:dirt_with_grass 10", 90},
		{mcl and "mcl_copper:raw_copper 1" or "default:mese_crystal_fragment 1",
				mcl and "mcl_core:gold_ingot 5" or "default:gold_ingot 5", 90}
	}
}

-- Trader (same as NPC but with right-click shop)

mobs:register_mob("mobs_npc:trader", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attack_monsters = true,
	attack_animals = false,
	attack_npcs = false,
	pathfinding = false,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	textures = {
		{"mobs_trader.png"}, -- by Frerin
		{"mobs_trader2.png"},
		{"mobs_trader3.png"},
		{"mobs_trader4.png"} -- female by Astrobe
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = false,
	drops = {},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	follow = {
		mcl and "mcl_farming:bread" or "farming:bread",
		mcl and "mcl_mobitems:cooked_beef"or "group:food_meat", --"mobs:meat",
		mcl and "mcl_core:diamond" or "default:diamond"
	},
	view_range = 7,
	owner = "",
	order = "stand",
	fear_height = 3,
	animation = {
		speed_normal = 30, speed_run = 30,
		stand_start = 0, stand_end = 79,
		walk_start = 168, walk_end = 187,
		run_start = 168, run_end = 187,
		punch_start = 189, punch_end = 198 -- was 200 and 219
	},

	-- stop attacking on right-click and open shop
	on_rightclick = function(self, clicker)

		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, false, false) then return end

		-- protect npc with mobs:protector
		if mobs:protect(self, clicker) then return end

		-- stop trader from moving or attacking
		self.attack = nil
		self:set_velocity(0)
		self:set_animation("stand")

		-- owner can right-click with stick to show control formspec
		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		if item:get_name() == (mcl and "mcl_core:stick" or "default:stick")
		and (self.owner == name or
		minetest.check_player_privs(clicker, {protection_bypass = true}) )then

			minetest.show_formspec(name, "mobs_npc:controls",
					mobs_npc.get_controls_formspec(name, self))

			return
		end

		-- open shop
		mobs_npc.shop_trade(self, clicker, mobs.human)
	end,

	-- show that npc is a trader once spawned
	on_spawn = function(self)

		self.nametag = S("Trader")

		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#FFFFFF"
		})

		return true -- return true so on_spawn is run once only
	end
})

-- spawn egg

mobs:register_egg("mobs_npc:trader", S("Trader"),
		mcl and "mcl_core_sandstone_top.png" or "default_sandstone.png", 1)

-- compatibility with older mobs mod
mobs:alias_mob("mobs:trader", "mobs_npc:trader")

-- make global and add functions and list

local trader_lists = {}

mobs_npc.add_trader_list = function(def)
	table.insert(trader_lists, def)
end

mobs_npc.add_trader_list({
	block = mcl and "mcl_core:ironblock" or "default:tinblock",
	nametag = "Castro",
	textures = {"mobs_trader2.png"},
	item_list = {
		{mcl and "mcl_raw_ores:raw_gold 2" or "default:gold_lump 2",
				mcl and "mcl_core:gold_ingot 3" or "default:gold_ingot 3"},
		{mcl and "mcl_raw_ores:raw_iron 2" or "default:iron_lump 2",
				mcl and "mcl_core:iron_ingot 2" or "default:steel_ingot 2"},
		{mcl and "mcl_copper:raw_copper 2" or "default:copper_lump 2",
				mcl and "mcl_copper:copper_ingot 3" or "default:copper_ingot 3"},
		{mcl and "mcl_core:iron_nugget 2" or "default:tin_lump 2",
				mcl and "mcl_core:iron_ingot 3" or "default:tin_ingot 3"}
	}
})

-- helper function

local function place_trader(pos, node)

	local face = node.param2
	local pos2, def

	-- find which way block is facing
	if face == 0 then
		pos2 = {x = pos.x, y = pos.y, z = pos.z - 1}
	elseif face == 1 then
		pos2 = {x = pos.x - 1, y = pos.y, z = pos.z}
	elseif face == 2 then
		pos2 = {x = pos.x, y = pos.y, z = pos.z + 1}
	elseif face == 3 then
		pos2 = {x = pos.x + 1, y = pos.y, z = pos.z}
	else
		return
	end

	-- do we already have a trader spawned?
	local objs = minetest.get_objects_inside_radius(pos2, 1)

	if objs and #objs > 0 then
		return
	end

	-- get block below
	local bnode = minetest.get_node({x = pos2.x, y = pos2.y - 1, z = pos2.z})

	pos2.y = pos2.y + 0.5

	-- add new trader
	local obj = minetest.add_entity(pos2, "mobs_npc:trader")
	local ent = obj and obj:get_luaentity()

	if not ent then return end -- nil check

	for n = 1, #trader_lists do

		def = trader_lists[n]

		if bnode.name == def.block then

			ent.trades = def.item_list
			ent.nametag = def.nametag
			ent.game_name = def.nametag
			ent.base_texture = def.textures
			ent.textures = def.textures

			obj:set_properties({
				textures = ent.textures
			})

			break
		end
	end

	-- pop sound
	minetest.sound_play("default_place_node_hard", {
			pos = pos, gain = 1.0, max_hear_distance = 5, pitch = 2.0}, true)
end

-- trader block (punch to spawn trader)

minetest.register_node(":mobs:trader_block", {
	description = S("Place this and punch to spawn Trader"),
	groups = {cracky = 3},
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"default_stone.png", "default_stone.png", "default_stone.png",
		"default_stone.png", "default_stone.png", "default_stone.png^mobs_npc_shop_icon.png"
	},

	-- punch block to spawn trader
	on_punch = function(pos, node, puncher, pointed_thing)
		place_trader(pos, node)
	end,

	on_rotate = screwdriver and screwdriver.rotate_simple,
	on_blast = function() end
})

-- trader block recipe

local db = mcl and "mcl_core:diamondblock" or "default:diamondblock"
local tb = mcl and "mcl_core:ironblock" or "default:tinblock"

minetest.register_craft({
	output = "mobs:trader_block",
	recipe = {
		{"group:stone", "group:stone", "group:stone"},
		{"group:stone", db, "group:stone"},
		{"group:stone", tb, "group:stone"}
	}
})
