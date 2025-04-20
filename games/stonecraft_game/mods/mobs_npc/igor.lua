
-- translation and mod check

local S = minetest.get_translator("mobs_npc")
local mcl = minetest.get_modpath("mcl_core") ~= nil

-- right-click drops

mobs_npc.igor_drops = {
	mcl and "mcl_potions:glass_bottle" or "vessels:glass_bottle",
	mcl and "mcl_mobitems:beef" or "mobs:meat_raw",
	{mcl and "mcl_tools:sword_iron" or "default:sword_steel", 2},
	mcl and "mcl_farming:bread" or "farming:bread",
	{mcl and "mcl_buckets:bucket_water" or "bucket:bucket_water", 2},
	mcl and "mcl_mushrooms:mushroom_red" or "flowers:mushroom_red",
	mcl and "mcl_core:jungletree" or "default:jungletree",
	{mcl and "mcl_fire:flint_and_steel" or "fire:flint_and_steel", 3},
	mcl and "mcl_mobitems:leather" or "mobs:leather",
	mcl and "mcl_core:acaciasapling" or "default:acacia_sapling",
	{mcl and "mcl_beds:bed_red" or "fireflies:bug_net", 3},
	mcl and "mcl_core:clay_lump" or "default:clay_lump",
	mcl and "mcl_core:ice" or "default:ice",
	mcl and "mcl_ocean:bubble_coral" or "default:coral_brown",
	mcl and "mcl_raw_ores:raw_iron" or "default:iron_lump",
	mcl and "mcl_amethyst:amethyst_block" or "default:obsidian_shard",
	mcl and "mcl_core:mossycobble" or "default:mossycobble",
	mcl and "mcl_core:obsidian" or {"default:obsidian", 2}
}

-- Igor by TenPlus1

mobs:register_mob("mobs_npc:igor", {
	type = "npc",
	passive = false,
	damage = 5,
	attack_type = "dogfight",
	owner_loyal = true,
	pathfinding = true,
	reach = 2,
	attack_monsters = true,
--	attack_ignore = {"mobs_npc:npc"},
	hp_min = 20,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	textures = {
		{"mobs_igor.png"}, -- skin by ruby32199
		{"mobs_igor2.png"},
		{"mobs_igor3.png"},
		{"mobs_igor4.png"},
		{"mobs_igor5.png"},
		{"mobs_igor6.png"},
		{"mobs_igor7.png"},
		{"mobs_igor8.png"}
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 1,
	run_velocity = 2,
	stepheight = 1.1,
	fear_height = 2,
	jump = true,
	drops = {
		{name = mcl and "mcl_mobitems:beef" or "mobs:meat_raw",
				chance = 1, min = 1, max = 2},
		{name = mcl and "mcl_raw_ores:raw_gold" or "default:gold_lump",
				chance = 3, min = 1, max = 1}
	},
	water_damage = 1,
	lava_damage = 3,
	light_damage = 0,
	follow = {
		mcl and "mcl_mobitems:beef" or "group:food_meat_raw",--"mobs:meat_raw",
		mcl and "mcl_core:diamond" or "default:diamond"
	},
	view_range = 15,
	owner = "",
	order = "wander",
	animation = {
		speed_normal = 30, speed_run = 30,
		stand_start = 0, stand_end = 79,
		walk_start = 168, walk_end = 187,
		run_start = 168, run_end = 187,
		punch_start = 189, punch_end = 198 -- was 200 and 219
	},

	on_rightclick = function(self, clicker)

		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, nil, 5, 80, false, nil) then return end

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- right clicking with gold lump drops random item from list
		if 	mobs_npc.drop_trade(self, clicker,  mcl and "mcl_raw_ores:raw_gold"
				or "default:gold_lump", self.npc_drops or mobs_npc.igor_drops) then

			return
		end

		-- owner can right-click with stick to show control formspec
		if item:get_name() == (mcl and "mcl_core:stick" or "default:stick")
		and self.owner == name then

			minetest.show_formspec(name, "mobs_npc:controls",
					mobs_npc.get_controls_formspec(name, self))

			return
		end

		-- show simple dialog if enabled or idle chatter
		if mobs_npc.useDialogs == "Y" then
			simple_dialogs.show_dialog_formspec(name, self)
		else
			if self.state == "attack" then
				mobs_npc.npc_talk(self, clicker, {"Grr!", "Must Kill!"})
			else
				mobs_npc.npc_talk(self, clicker, {
					"Hey!", "What do you want?", "Go away!", "Go bother someone else!"})
			end
		end
	end
})

-- spawn egg

mobs:register_egg("mobs_npc:igor", S("Igor"),
		mcl and "mcl_mobitems_beef_raw.png" or "mobs_meat_raw.png", 1)

-- compatibility with older mobs mod

mobs:alias_mob("mobs:igor", "mobs_npc:igor")

-- spawn Igor in world

if not mobs.custom_spawn_npc then

	mobs:spawn({
		name = "mobs_npc:igor",
		nodes = {mcl and "mcl_farming:pumpkin" or "mobs:meatblock"},
		neighbors = {mcl and "mcl_core:stonebrick" or "default:brick"},
		min_light = 10,
		chance = 10000,
		active_object_count = 1,
		min_height = 0,
		day_toggle = true
	})
end
