local S = minetest.get_translator("livingcavesmobs")

mobs.moth_drops = {
	"livingcavesmobs:mothegg"
}

mobs:register_mob("livingcavesmobs:moth", {
stepheight = 3,
	type = "npc",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	owner_loyal = true,
	reach = 2,
        damage = 0,
	hp_min = 5,
	hp_max = 15,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	visual_size = {x = 2.0, y = 2.0},
	mesh = "Moth.b3d",
	textures = {
		{"texturemoth.png"},
	},
	sounds = {
	},
	makes_footstep_sound = false,
	walk_velocity = 2,
	run_velocity = 3,
        walk_chance = 15,
	fall_speed = 0,
	jump = false,
        jump_height = 6,
	stepheight = 3,
	fly = true,
	owner = "",
	order = "follow",
	drops = {
	},
	water_damage = 4,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
        stay_near = {{"livingcaves:glowshroom_top"}, 3},
	animation = {
		speed_normal = 200,
		stand_speed = 50,
		stand_start = 120,
		stand_end = 170,
		fly_start = 0,
		fly_end = 100,
		die_start = 0,
		die_end = 100,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
view_range = 5,

	on_rightclick = function(self, clicker)

		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, true, true) then return end

		-- capture npc with net or lasso
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end

		-- protect npc with mobs:protector
		if mobs:protect(self, clicker) then return end

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- right clicking with gold lump drops random item from mobs.moth_drops
		if item:get_name() == "farming:melon_slice" or item:get_name() == "farming:pineapple" or item:get_name() == "ethereal:banana" or item:get_name() == "naturalbiomes:banana" or item:get_name() == "livingdesert:date_palm_fruits" or item:get_name() == "livingdesert:figcactus_fruit" or item:get_name() == "default:apple" then

			if not mobs.is_creative(name) then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			local pos = self.object:get_pos()

			pos.y = pos.y + 0.5

			local drops = self.npc_drops or mobs.moth_drops

			minetest.add_item(pos, {
				name = drops[math.random(1, #drops)]
			})

			minetest.chat_send_player(name, ("Moth dropped you an egg for fruit!"))

			return
		end

		-- by right-clicking owner can switch npc between follow and stand
		if self.owner and self.owner == name then

			if self.order == "follow" then

				self.attack = nil
				self.order = "stand"
				self.state = "stand"
				self:set_animation("stand")
				self:set_velocity(0)

				minetest.chat_send_player(name, ("Moth stands still."))
			else
				self.order = "follow"

				minetest.chat_send_player(name, ("Moth will follow you."))
			end
		end
	end,
})


if not mobs.custom_spawn_livingcavesmobs then
mobs:spawn({
	name = "livingcavesmobs:moth",
	nodes = {"livingcaves:mushcave_bottom"},
	min_light = 0,
        interval = 60,
	chance = 800, -- 15000
	active_object_count = 4,
	min_height = -90,
	max_height = -30,
})
end

mobs:register_egg("livingcavesmobs:moth", S("Moth"), "amoth.png")