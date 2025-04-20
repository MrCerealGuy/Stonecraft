
-- translation and mod check

local S = minetest.get_translator("mobs_npc")
local mcl = minetest.get_modpath("mcl_core") ~= nil

-- right-click drops

mobs_npc.npc_drops = {
	{mcl and "mcl_tools:pick_iron" or "default:pick_steel", 2},
	mcl and "mcl_mobitems:cooked_beef" or "mobs:meat",
	{mcl and "mcl_tools:sword_iron" or "default:sword_steel", 2},
	{mcl and "mcl_tools:shovel_iron" or "default:shovel_steel", 2},
	mcl and "mcl_farming:bread" or "farming:bread",
	mcl and "mcl_buckets:bucket_water" or "bucket:bucket_water",
	mcl and "mcl_core:sapling" or "default:sapling",
	mcl and "mcl_core:tree" or "default:tree",
	mcl and "mcl_mobitems:leather" or "mobs:leather",
	mcl and "mcl_ocean:brain_coral" or "default:coral_orange",
	{mcl and "mcl_core:diamond" or "default:mese_crystal_fragment", 3},
	mcl and "mcl_core:clay" or "default:clay",
	{mcl and "mcl_signs:wall_sign" or "default:sign_wall", 2},
	mcl and "mcl_core:ladder" or "default:ladder",
	mcl and "mcl_copper:raw_copper" or "default:copper_lump",
	mcl and "mcl_farming:carrot" or "default:blueberries",
	mcl and "mcl_core:birchsapling" or "default:aspen_sapling",
	mcl and "mcl_core:frosted_ice" or "default:permafrost_with_moss"
}

-- Npc by TenPlus1

mobs:register_mob("mobs_npc:npc", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attack_monsters = true,
	attack_npcs = false,
	owner_loyal = true,
	pathfinding = true,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	drawtype = "front",
	textures = {
		{"mobs_npc.png"},
		{"mobs_npc2.png"}, -- female by nuttmeg20
		{"mobs_npc3.png"}, -- male by swagman181818
		{"mobs_npc4.png"}, -- female by Sapphire16
		{"mobs_npc5.png"}, -- male by Astrobe
		{"mobs_npc6.png"} -- female by Astrobe
	},
	child_texture = {
		{"mobs_npc_baby.png"} -- derpy baby by AmirDerAssassine
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = mcl and "mcl_core:wood" or "default:wood", chance = 1, min = 1, max = 3},
		{name = mcl and "mcl_core:apple" or "default:apple", chance = 2, min = 1, max = 2},
		{name = mcl and "mcl_tools:axe_stone" or "default:axe_stone", chance = 5, min = 1, max = 1}
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {
		mcl and "mcl_farming:bread" or "farming:bread",
		mcl and "mcl_mobitems:cooked_beef"or "group:food_meat", --"mobs:meat",
		mcl and "mcl_core:diamond" or "default:diamond"
	},
	view_range = 15,
	owner = "",
	order = "wander",
	fear_height = 3,
	animation = {
		speed_normal = 30, speed_run = 30,
		stand_start = 0, stand_end = 79,
		walk_start = 168, walk_end = 187,
		run_start = 168, run_end = 187,
		punch_start = 189, punch_end = 198 -- was 200 and 219
	},

	on_rightclick = function(self, clicker)

		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, true, true) then return end

		-- capture npc with net or lasso
		if mobs:capture_mob(self, clicker, nil, 5, 80, false, nil) then return end

		-- protect npc with mobs:protector
		if mobs:protect(self, clicker) then return end

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- right clicking with gold lump drops random item from list
		if 	mobs_npc.drop_trade(self, clicker, mcl and "mcl_raw_ores:raw_gold"
				or "default:gold_lump", self.npc_drops or mobs_npc.npc_drops) then

			return
		end

		-- owner can right-click with stick to show control formspec
		if item:get_name() == (mcl and "mcl_core:stick" or "default:stick")
		and (self.owner == name or
		minetest.check_player_privs(clicker, {protection_bypass = true}) )then

			minetest.show_formspec(name, "mobs_npc:controls",
					mobs_npc.get_controls_formspec(name, self))

			return
		end

		-- show simple dialog if enabled or idle chatter
		if mobs_npc.useDialogs == "Y" then
			simple_dialogs.show_dialog_formspec(name, self)
		else
			if self.state == "attack" then
				mobs_npc.npc_talk(self, clicker, {"Grr!", "I'm kinda busy!"})
			else
				mobs_npc.npc_talk(self, clicker, {
					"Hello", "Hi there", "What a lovely day"})
			end
		end
	end
})

-- spawn egg

mobs:register_egg("mobs_npc:npc", S("Npc"),
		mcl and "default_stone_brick.png" or "default_brick.png", 1)

-- compatibility with older mobs mod

mobs:alias_mob("mobs:npc", "mobs_npc:npc")

-- spawn NPC in world

if not mobs.custom_spawn_npc then

	mobs:spawn({
		name = "mobs_npc:npc",
		nodes = {mcl and "mcl_core:stonebrick" or "default:brick"},
		neighbors = {mcl and "mcl_flowers:tallgrass" or "group:grass"},
		min_light = 10,
		chance = 10000,
		active_object_count = 1,
		min_height = 0,
		day_toggle = true
	})
end
