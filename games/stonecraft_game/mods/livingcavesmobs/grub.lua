local S = minetest.get_translator("livingcavesmobs")

mobs.grub_drops = {
	"farming:string"
}

mobs:register_mob("livingcavesmobs:grub", {
	stepheight = 1,
	type = "npc",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	owner = "",
	order = "follow",
	reach = 2,
	damage = 0,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.3, 0.2},
	visual = "mesh",
	mesh = "Grub.b3d",
	textures = {
		{"texturegrub.png"},
	},
	makes_footstep_sound = false,
	sounds = {
	},
	walk_velocity = 0.5,
	run_velocity = 0.7,
	runaway = true,
        stay_near = {{"livingcaves:glowshroom_top", "default:bush_leaves", "default:blueberry_bush_leaves", "naturalbiomes:cowberrybush_leaves", "naturalbiomes:beach_bush_leaves", "naturalbiomes:outback_bush_leaves"}, 4},
	jump = false,
	jump_height = 3,
	pushable = true,
	view_range = 3,
	drops = {
		{name = "livingcavesmobs:grub", chance = 3, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 70,
		stand_start = 0,
		stand_end = 100,
		stand_start = 100,
		stand_end = 200,
		walk_start = 200,
		walk_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
		on_rightclick = function(self, clicker)

		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, true, true) then return end

		-- capture npc with net or lasso
		if mobs:capture_mob(self, clicker, 25, 0, 0, false, nil) then return end

		-- protect npc with mobs:protector
		if mobs:protect(self, clicker) then return end

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- right clicking with gold lump drops random item from mobs.grub_drops
		if item:get_name() == "default:bush_leaves" or item:get_name() == "default:blueberry_bush_leaves" or item:get_name() == "naturalbiomes:beach_bush_leaves" or item:get_name() == "naturalbiomes:outback_bush_leaves" then

			if not mobs.is_creative(name) then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			local pos = self.object:get_pos()

			pos.y = pos.y + 0.5

			local drops = self.npc_drops or mobs.grub_drops

			minetest.add_item(pos, {
				name = drops[math.random(1, #drops)]
			})

			minetest.chat_send_player(name, S("Grub dropped you a string for bush leaves!"))

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

				minetest.chat_send_player(name, S("Grub stands still."))
			else
				self.order = "follow"

				minetest.chat_send_player(name, S("Grub will follow you."))
			end
		end
	end,
})



mobs:register_egg("livingcavesmobs:grub", S("Grub"), "agrub.png")


mobs:alias_mob("livingcavesmobs:grub", "livingcavesmobs:grub") -- compatibility

minetest.register_craftitem(":livingcavesmobs:cocoon", {
	description = S("Moth Cocoon"),
	inventory_image = "livingcavesmobs_cocoon.png",
	drawtype = "plantlike",
	tiles = {"livingcavesmobs_cocoon.png"},
	inventory_image = "livingcavesmobs_cocoon.png",
	wield_image = "livingcavesmobs_cocoon.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	groups = {food = 1, flammable = 2, fleshy = 3, dig_immediate = 3},
        drop = "livingcavesmobs:cocoon",
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingcavesmobs:cocoon", param2 = 1})
		end
	end
})

minetest.register_craftitem(":livingcavesmobs:mothegg", {
	description = S("Moth Egg"),
	inventory_image = "livingcavesmobs_mothegg.png",
	drawtype = "plantlike",
	tiles = {"livingcavesmobs_mothegg.png"},
	inventory_image = "livingcavesmobs_mothegg.png",
	wield_image = "livingcavesmobs_mothegg.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	on_use = minetest.item_eat(2),
	groups = {food = 1, flammable = 2, fleshy = 3, dig_immediate = 3},
        drop = "livingcavesmobs:mothegg",
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "livingcavesmobs:mothegg", param2 = 1})
		end
	end
})


minetest.register_craft({
	output = "livingcavesmobs:cocoon",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:grub", "default:bush_leaves", "default:bush_leaves", "default:bush_leaves"}
})

minetest.register_craft({
	output = "livingcavesmobs:cocoon",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:grub", "default:blueberry_bush_leaves", "default:blueberry_bush_leaves", "default:blueberry_bush_leaves"}
})

minetest.register_craft({
	output = "livingcavesmobs:cocoon",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:grub", "naturalbiomes:beach_bush_leaves", "naturalbiomes:beach_bush_leaves", "naturalbiomes:beach_bush_leaves"}
})

minetest.register_craft({
	output = "livingcavesmobs:cocoon",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:grub", "naturalbiomes:outback_bush_leaves", "naturalbiomes:outback_bush_leaves", "naturalbiomes:outback_bush_leaves"}
})

minetest.register_craft({
	output = "wool:white",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:cocoon", "livingcavesmobs:cocoon", "livingcavesmobs:cocoon", "livingcavesmobs:cocoon"}
})

minetest.register_craft({
	output = "livingcavesmobs:moth",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:cocoon", "default:stick"}
})

minetest.register_craft({
	output = "livingcavesmobs:grub",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:mothegg", "naturalbiomes:outback_bush_leaves", "naturalbiomes:outback_bush_leaves", "naturalbiomes:outback_bush_leaves"}
})

minetest.register_craft({
	output = "livingcavesmobs:grub",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:mothegg", "naturalbiomes:beach_bush_leaves", "naturalbiomes:beach_bush_leaves", "naturalbiomes:beach_bush_leaves"}
})

minetest.register_craft({
	output = "livingcavesmobs:grub",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:mothegg", "default:blueberry_bush_leaves", "default:blueberry_bush_leaves", "default:blueberry_bush_leaves"}
})

minetest.register_craft({
	output = "livingcavesmobs:grub",
	type = "shapeless",
	recipe = 
		{"livingcavesmobs:mothegg", "default:bush_leaves", "default:bush_leaves", "default:bush_leaves"}
})
