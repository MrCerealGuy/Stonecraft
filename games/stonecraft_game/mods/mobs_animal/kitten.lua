
-- translation and hairball setting

local S = minetest.get_translator("mobs_animal")
local hairball = minetest.settings:get_bool("mobs_animal.hairball") ~= false

-- custom kitty types

local kitten_types = {

	{	nodes = {"farming:jackolantern_on"},
		skins = {"mobs_kitten_black.png"}
	}
}

-- Kitten by Jordach / BFD

mobs:register_mob("mobs_animal:kitten", {
	stepheight = 0.6,
	type = "animal",
	specific_attack = {"mobs_animal:rat"},
	damage = 1,
	attack_type = "dogfight",
	attack_animals = true, -- so it can attack rat
	attack_players = false,
	reach = 1,
	stepheight = 1.1,
	passive = false,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"}
	},
	makes_footstep_sound = false,
	sounds = {random = "mobs_kitten"},
	walk_velocity = 0.6,
	walk_chance = 15,
	run_velocity = 2,
	runaway = true,
	jump = false,
	drops = {
		{name = "farming:string", chance = 1, min = 0, max = 1}
	},
	water_damage = 0.01,
	lava_damage = 5,
	fear_height = 3,
	animation = {
		speed_normal = 42,
		stand_start = 97, stand_end = 192,
		walk_start = 0, walk_end = 96,
		stoodup_start = 0, stoodup_end = 0,
	},
	follow = {
		"mobs_animal:rat", "group:food_fish_raw",
		"mobs_fish:tropical", "mobs_fish:clownfish", "xocean:fish_edible"
	},
	view_range = 8,

	-- check surrounding nodes and spawn a specific kitten
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1
		local tmp

		for n = 1, #kitten_types do

			tmp = kitten_types[n]

			if minetest.find_node_near(pos, 1, tmp.nodes) then

				self.base_texture = tmp.skins
				self.object:set_properties({textures = tmp.skins})

				return true
			end
		end

		return true -- run only once, false/nil runs every activation
	end,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 50, 50, 90, false, nil) then return end

		-- by right-clicking owner can switch between staying and walking
		if self.owner and self.owner == clicker:get_player_name() then

			if self.order ~= "stand" then
				self.order = "stand"
				self.state = "stand"
				self.object:set_velocity({x = 0, y = 0, z = 0})
				self:set_animation("stand")
			else
				self.order = ""
				self:set_animation("stoodup")
			end
		end
	end,

	do_custom = function(self, dtime)

		if not hairball then return end

		self.hairball_timer = (self.hairball_timer or 0) + dtime
		if self.hairball_timer < 10 then return end
		self.hairball_timer = 0

		if self.child or math.random(250) > 1 then return end

		local pos = self.object:get_pos()

		minetest.add_item(pos, "mobs:hairball")

		minetest.sound_play("default_dig_snappy", {
				pos = pos, gain = 1.0, max_hear_distance = 5}, true)
	end
})

-- where to spawn

if not mobs.custom_spawn_animal then

	local spawn_on = "default:dirt_with_grass"

	if minetest.get_modpath("ethereal") then
		spawn_on = "ethereal:grove_dirt"
	end

	mobs:spawn({
		name = "mobs_animal:kitten",
		nodes = {spawn_on},
		neighbors = {"group:grass"},
		min_light = 14,
		interval = 60,
		chance = 10000,
		min_height = 5,
		max_height = 50,
		day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("mobs_animal:kitten", S("Kitten"), "mobs_kitten_inv.png", 0)

-- compatibility with old mobs mod

mobs:alias_mob("mobs:kitten", "mobs_animal:kitten")

-- hairball and items

local hairball_items = {
	"default:stick", "default:coal_lump", "default:dry_shrub", "flowers:rose",
	"mobs_animal:rat", "default:grass_1", "farming:seed_wheat", "dye:green", "",
	"farming:seed_cotton", "default:flint", "default:sapling", "dye:white", "",
	"default:clay_lump", "default:paper", "default:dry_grass_1", "dye:red", "",
	"farming:string", "mobs:chicken_feather", "default:acacia_bush_sapling", "",
	"default:bush_sapling", "default:copper_lump", "default:iron_lump", "",
	"dye:black", "dye:brown", "default:obsidian_shard", "default:tin_lump",
	"ethereal:fish_tetra"
}

minetest.register_craftitem(":mobs:hairball", {
	description = S("Hairball"),
	inventory_image = "mobs_hairball.png",

	on_use = function(itemstack, user, pointed_thing)

		local pos = user:get_pos()
		local dir = user:get_look_dir()
		local newpos = {x = pos.x + dir.x, y = pos.y + dir.y + 1.5, z = pos.z + dir.z}
		local item = hairball_items[math.random(1, #hairball_items)]

		if item ~= "" and minetest.registered_items[item] then
			minetest.add_item(newpos, {name = item})
		end

		minetest.sound_play("default_place_node_hard", {
				pos = newpos, gain = 1.0, max_hear_distance = 5}, true)

		itemstack:take_item()

		return itemstack
	end
})
