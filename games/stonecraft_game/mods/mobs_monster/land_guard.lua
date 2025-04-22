
-- translation and custom land guard types

local S = minetest.get_translator("mobs_monster")

local guard_types = {

	{	nodes = {
			"default:snow", "default:snowblock", "default:ice",
			"default:dirt_with_snow"
		},
		skins = {"mobs_land_guard6.png", "mobs_land_guard7.png", "mobs_land_guard8.png"},
		drops = {
			{name = "default:ice", chance = 1, min = 1, max = 4},
			{name = "mobs:leather", chance = 2, min = 0, max = 2},
			{name = "default:diamond", chance = 4, min = 0, max = 2},
		},
	},

	{	nodes = {
			"ethereal:dry_dirt", "default:sand", "default:desert_sand",
			"default:dry_dirt_with_dry_grass", "default:dry_dirt"
		},
		skins = {"mobs_land_guard4.png", "mobs_land_guard5.png"},
		drops = {
			{name = "default:sandstone", chance = 1, min = 1, max = 4},
			{name = "mobs:leather", chance = 2, min = 0, max = 2},
			{name = "default:mese_crystal", chance = 4, min = 0, max = 2},
		},
	}
}

-- Land Guard

mobs:register_mob("mobs_monster:land_guard", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	reach = 3,
	damage = 15,
	hp_min = 30,
	hp_max = 65,
	armor = 50,
	collisionbox = {-0.5, -1.01, -0.5, 0.5, 1.6, 0.5},
	visual_size = {x = 1, y = 1},
	visual = "mesh",
	mesh = "mobs_dungeon_master.b3d",
	textures = {
		{"mobs_land_guard.png"},
		{"mobs_land_guard2.png"},
		{"mobs_land_guard3.png"}
	},
	makes_footstep_sound = true,
	sounds = {random = "mobs_dungeonmaster"},
	walk_velocity = 1.5,
	run_velocity = 3.4,
	jump = true,
	jump_height = 2.0,
	floats = 0,
	view_range = 15,
	drops = {
		{name = "mobs:leather", chance = 2, min = 0, max = 2},
		{name = "default:mese_crystal", chance = 3, min = 0, max = 2},
		{name = "default:diamond", chance = 4, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 6,
	light_damage = 0,
	fear_height = 8,
	animation = {
		stand_start = 0, stand_end = 19,
		walk_start = 20, walk_end = 35,
		punch_start = 36, punch_end = 48,
		speed_normal = 15, speed_run = 20,
	},

	-- check surrounding nodes and spawn a specific guard
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1
		local tmp

		for n = 1, #guard_types do

			tmp = guard_types[n]

			if minetest.find_node_near(pos, 1, tmp.nodes) then

				self.base_texture = { tmp.skins[math.random(#tmp.skins)] }
				self.object:set_properties({textures = self.base_texture})
				self.docile_by_day = tmp.docile

				if tmp.drops then self.drops = tmp.drops end

				return true
			end
		end

		return true -- run only once, false/nil runs every activation
	end,
})

-- where to spawn

if not mobs.custom_spawn_monster then

	mobs:spawn({
		name = "mobs_monster:land_guard",
		nodes = {
			"default:snow", "default:ice", "default:stone",
			"default:dry_dirt_with_dry_grass", "ethereal:dry_dirt"
		},
		max_light = 7,
		chance = 25000,
		min_height = 0,
		active_object_count = 1,
	})
end

-- spawn egg

mobs:register_egg("mobs_monster:land_guard", S("Land Guard"), "default_ice.png", 1)
