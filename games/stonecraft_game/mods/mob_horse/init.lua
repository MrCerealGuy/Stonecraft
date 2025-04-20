
-- translation and get mod path

local S = minetest.get_translator("mob_horse")
local MP = minetest.get_modpath(minetest.get_current_modname()) .. "/"

-- horse shoes (speed, jump, brake/reverse speed, overlay texture)

local shoes = {
	["mobs:horseshoe_steel"] = {7, 4, 2, "mobs_horseshoe_steelo.png"},
	["mobs:horseshoe_bronze"] = {7, 4, 4, "mobs_horseshoe_bronzeo.png"},
	["mobs:horseshoe_mese"] = {9, 5, 8, "mobs_horseshoe_meseo.png"},
	["mobs:horseshoe_diamond"] = {10, 6, 6, "mobs_horseshoe_diamondo.png"},
	["mobs:horseshoe_crystal"] = {11, 6, 9, "mobs_horseshoe_crystalo.png"}
}

-- rideable horse

mobs:register_mob("mob_horse:horse", {
	type = "animal",
	visual = "mesh",
	visual_size = {x = 1.20, y = 1.20},
	mesh = "mobs_horse.x",
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.25, 0.4},
	animation = {
		speed_normal = 15, speed_run = 30,
		stand_start = 25, stand_end = 50, -- 75
		stand2_start = 25, stand2_end = 25,
		stand3_start = 55, stand3_end = 75, stand3_loop = false,
		walk_start = 75, walk_end = 100,
		run_start = 75, run_end = 100,
		punch_start = 55, punch_end = 75, punch_speed = 35,
	},
	textures = {
		{"mobs_horse.png"}, -- textures by Mjollna
		{"mobs_horsepeg.png"},
		{"mobs_horseara.png"}
	},
	fear_height = 3,
	--runaway = true,
	fly = false,
	walk_chance = 60,
	view_range = 7,
	follow = {
		"farming:wheat", "default:apple", "farming:oat",
		"farming:barley", "farming:corn"
	},
	passive = false, attack_type = "dogfight", reach = 2.5, damage = 3,
	attack_monsters = true,
	hp_min = 15,
	hp_max = 23,
	armor = 100,
	lava_damage = 5,
	fire_damage = 4,
	fall_damage = 1,
	water_damage = 0,
	makes_footstep_sound = true,
	drops = {
		{name = "mobs:leather", chance = 1, min = 0, max = 2},
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2}
	},

	do_custom = function(self, dtime)

		-- set needed values if not already present
		if not self.v2 then
			self.v2 = 0
			self.max_speed_forward = 6
			self.max_speed_reverse = 2
			self.accel = 6
			self.terrain_type = 3
			self.driver_attach_at = {x = 0, y = 10, z = -2}
			self.driver_eye_offset = {x = 0, y = 10 + 3, z = 0}
			self.driver_scale = {x = 0.8, y = 0.8} -- shrink driver to fit model
		end

		-- if driver present allow control of horse
		if self.driver then

			mobs.drive(self, "walk", "stand", false, dtime)

			return false -- skip rest of mob functions
		end

		return true
	end,

	on_die = function(self, pos)

		-- detach player from horse properly
		if self.driver then
			mobs.detach(self.driver, {x = 1, y = 0, z = 1})
		end

		-- drop saddle if found
		if self.saddle then
			minetest.add_item(pos, "mobs:saddle")
		end

		-- drop any horseshoes added
		if self.shoed then
			minetest.add_item(pos, self.shoed)
		end
	end,

	do_punch = function(self, hitter)

		-- don't cut the branch you're... ah, that's not about that
		if hitter ~= self.driver then
			return true
		end
	end,

	on_rightclick = function(self, clicker)

		-- make sure player is clicking
		if not clicker or not clicker:is_player() then return end

		-- feed, tame or heal horse
		if mobs:feed_tame(self, clicker, 10, true, true) then return end

		-- applying protection rune
		if mobs:protect(self, clicker) then return end

		local player_name = clicker:get_player_name()

		-- make sure tamed horse is being clicked by owner only
		if self.tamed and self.owner == player_name then

			local inv = clicker:get_inventory()
			local tool = clicker:get_wielded_item()
			local item = tool:get_name()

			-- detatch player already riding horse
			if self.driver and clicker == self.driver then

				mobs.detach(clicker, {x = 1, y = 0, z = 1})

				return
			end

			-- attach saddle to horse
			if not self.driver and not self.child
			and clicker:get_wielded_item():get_name() == "mobs:saddle"
			and not self.saddle then

				self.saddle = true
				self.order = "stand"
				self.object:set_properties({stepheight = 1.2})

				-- take saddle from inventory
				inv:remove_item("main", "mobs:saddle")

				self.texture_mods = self.texture_mods .. "^mobs_saddle_overlay.png"

				self.object:set_texture_mod(self.texture_mods)

				return
			end

			-- apply horseshoes
			if item:find("mobs:horseshoe") then

				-- drop any existing shoes
				if self.shoed then
					minetest.add_item(self.object:get_pos(), self.shoed)
				end

				local speed = shoes[item][1]
				local jump = shoes[item][2]
				local reverse = shoes[item][3]
				local overlay = shoes[item][4]

				self.max_speed_forward = speed
				self.jump_height = jump
				self.max_speed_reverse = reverse
				self.accel = speed
				self.shoed = item

				-- apply horseshoe overlay to current horse texture
				if overlay then

					self.texture_mods = "^" .. overlay

					if self.saddle then
						self.texture_mods = self.texture_mods
							.. "^mobs_saddle_overlay.png"
					end

					self.object:set_texture_mod(self.texture_mods)
				end

				-- show horse speed and jump stats with shoes fitted
				minetest.chat_send_player(player_name,
						S("Horse shoes fitted -")
						.. S(" speed: ") .. speed
						.. S(" , jump height: ") .. jump
						.. S(" , stop speed: ") .. reverse)

				tool:take_item()

				clicker:set_wielded_item(tool)

				return
			end
		end

		-- used to capture horse with magic lasso
		if mobs:capture_mob(self, clicker, nil, nil, 100, false, nil) then return end

		-- ride horse if saddled
		if self.saddle and self.owner == player_name then
			mobs.attach(self, clicker)
		end
	end,
--[[
	on_sound = function(self, def)
		if def.loudness > 0.8 then -- if loud enough startle horse into jumping
			self.object:set_velocity({x = 0, y = 5, z = 0})
		end
	end
]]
})

-- check for custom spawn.lua
local input = io.open(MP .. "spawn.lua", "r")

if input then
	input:close()
	input = nil
	dofile(MP .. "spawn.lua")
else

	mobs:spawn({
		name = "mob_horse:horse",
		nodes = {"default:dirt_with_grass", "ethereal:dry_dirt"},
		min_light = 14,
		interval = 60,
		chance = 16000,
		min_height = 10,
		max_height = 31000,
		day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("mob_horse:horse", S("Horse"), "wool_brown.png", 1)

-- steel horseshoes

minetest.register_craftitem(":mobs:horseshoe_steel", {
	description = S("Steel HorseShoes (use on horse to apply)"),
	inventory_image = "mobs_horseshoe_steel.png",
})

minetest.register_craft({
	output = "mobs:horseshoe_steel",
	recipe = {
		{"", "default:steelblock", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

-- bronze horseshoes

minetest.register_craftitem(":mobs:horseshoe_bronze", {
	description = S("Bronze HorseShoes (use on horse to apply)"),
	inventory_image = "mobs_horseshoe_bronze.png"
})

minetest.register_craft({
	output = "mobs:horseshoe_bronze",
	recipe = {
		{"", "default:bronzeblock", ""},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"}
	}
})

-- mese horseshoes

minetest.register_craftitem(":mobs:horseshoe_mese", {
	description = S("Mese HorseShoes (use on horse to apply)"),
	inventory_image = "mobs_horseshoe_mese.png"
})

minetest.register_craft({
	output = "mobs:horseshoe_mese",
	recipe = {
		{"", "default:mese", ""},
		{"default:mese_crystal_fragment", "", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "", "default:mese_crystal_fragment"}
	}
})

-- diamond horseshoes

minetest.register_craftitem(":mobs:horseshoe_diamond", {
	description = S("Diamond HorseShoes (use on horse to apply)"),
	inventory_image = "mobs_horseshoe_diamond.png"
})

minetest.register_craft({
	output = "mobs:horseshoe_diamond",
	recipe = {
		{"", "default:diamondblock", ""},
		{"default:diamond", "", "default:diamond"},
		{"default:diamond", "", "default:diamond"}
	}
})

-- crystal horseshoes

if minetest.get_modpath("ethereal") then

	minetest.register_craftitem(":mobs:horseshoe_crystal", {
		description = S("Crystal HorseShoes (use on horse to apply)"),
		inventory_image = "mobs_horseshoe_crystal.png"
	})

	minetest.register_craft({
		output = "mobs:horseshoe_crystal",
		recipe = {
			{"", "ethereal:crystal_block", ""},
			{"ethereal:crystal_ingot", "", "ethereal:crystal_ingot"},
			{"ethereal:crystal_ingot", "", "ethereal:crystal_ingot"}
		}
	})
end

-- lucky blocks

if minetest.get_modpath("lucky_block") then

	lucky_block:add_blocks({
		{"dro", {"mobs:horseshoe_steel"}},
		{"dro", {"mobs:horseshoe_bronze"}},
		{"dro", {"mobs:horseshoe_mese"}},
		{"dro", {"mobs:horseshoe_diamond"}},
		{"dro", {"mobs:horseshoe_crystal"}}
	})
end

print("[MOD] Mobs Redo Horse loaded")
