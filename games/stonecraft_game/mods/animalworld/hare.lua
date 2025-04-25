local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:hare", {
stepheight = 1,
	type = "animal",
	passive = true,
	reach = 1,
	hp_min = 15,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.268, -0.01, -0.268,  0.268, 0.5, 0.268},
	visual = "mesh",
	mesh = "Hare.b3d",
	drawtype = "front",
	textures = {
		{"texturehare.png"},
		{"texturehare.png"},
		{"texturehare.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 6,
	drops = {
		{name = "animalworld:rabbit_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:rabbit_hide", chance = 1, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 100,
		stand_start = 1,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 100,
		punch_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {"farming:carrot", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "farming_plus:carrot_item", "default:grass_1", "farming:carrot_7", "farming:carrot_8", "farming_plus:carrot", "farming:lettuce", "farming:cabbage", "ethereal:snowygrass", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"},
	view_range = 8,
	replace_rate = 10,
	replace_what = {"farming:carrot_7", "farming:carrot_8", "farming_plus:carrot", "farming:lettuce", "farming:cabbage", "ethereal:snowygrass", "flowers:geranium", "flowers:rose"},
	replace_with = "air",
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 5, 0, false, nil) then return end

		-- Monty Python tribute
		local item = clicker:get_wielded_item()

		if item:get_name() == "mobs:lava_orb" then

			if not mobs.is_creative(clicker:get_player_name()) then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			self.object:set_properties({
				textures = {"texturehare.png"},
			})

			self.type = "monster"
			self.health = 20
			self.passive = false

			return
		end
	end,
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1

		-- white snowy bunny
		if minetest.find_node_near(pos, 1,
				{"default:snow", "default:snowblock", "default:dirt_with_snow"}) then
			self.base_texture = {"texturehare.png"}
			self.object:set_properties({textures = self.base_texture})
		-- brown desert bunny
		elseif minetest.find_node_near(pos, 1,
				{"default:desert_sand", "default:desert_stone"}) then
			self.base_texture = {"texturehare.png"}
			self.object:set_properties({textures = self.base_texture})
		-- grey stone bunny
		elseif minetest.find_node_near(pos, 1,
				{"default:stone", "default:gravel"}) then
			self.base_texture = {"texturehare.png"}
			self.object:set_properties({textures = self.base_texture})
		end

		return true -- run only once, false/nil runs every activation
	end,
	attack_type = "dogfight",
	damage = 5,
})


local spawn_on = "default:dirt_with_grass"

if minetest.get_modpath("ethereal") then
	spawn_on = "ethereal:prairie_dirt", "default:dirt_with_grass"
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:hare",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "naturalbiomes:mediterran_litter", "naturalbiomes:heath_litter", "naturalbiomes:bushland_bushlandlitter"},
	neighbors = {"naturalbiomes:heath_grass", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:heatherflower", "naturalbiomes:heatherflower2", "naturalbiomes:heatherflower3", "group:grass", "group:normal_grass", "naturalbiomes:med_flower2", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:med_flower3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 100,
	day_toggle = true,
})
end


mobs:register_egg("animalworld:hare", S("Hare"), "ahare.png", 0)


mobs:alias_mob("animalworld:hare", "animalworld:hare") -- compatibility


-- raw rabbit
minetest.register_craftitem(":animalworld:rabbit_raw", {
	description = S("Raw Hare"),
	inventory_image = "animalworld_rabbit_raw.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, food_rabbit_raw = 1, flammable = 2},
})

-- cooked rabbit
minetest.register_craftitem(":animalworld:rabbit_cooked", {
	description = S("Cooked Hare"),
	inventory_image = "animalworld_rabbit_cooked.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, food_rabbit = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:rabbit_cooked",
	recipe = "animalworld:rabbit_raw",
	cooktime = 5,
})

-- rabbit hide
minetest.register_craftitem(":animalworld:rabbit_hide", {
	description = S("Hare Hide"),
	inventory_image = "animalworld_rabbit_hide.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:rabbit_hide",
	burntime = 2,
})

minetest.register_craft({
	output = "mobs:leather",
	type = "shapeless",
	recipe = {
		"animalworld:rabbit_hide", "animalworld:rabbit_hide",
		"animalworld:rabbit_hide", "animalworld:rabbit_hide"
	}
})
