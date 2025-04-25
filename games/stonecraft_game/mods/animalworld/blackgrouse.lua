local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:blackgrouse", {
stepheight = 2,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = false,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 1,
	hp_min = 10,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.3, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "Blackgrouse.b3d",
	textures = {
		{"textureblackgrouse.png"}, 
		{"textureblackgrouse2.png"}, 

	},
	child_texture = {
		{"textureblackgrousechick.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_blackgrouse3",
		damage = "animalworld_blackgrouse2",
		death = "animalworld_blackgrouse",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jumps = true,
	jump_height = 3,
	fall_speed = -1,
	fall_damage = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
        stay_near = {{"naturalbiomes:heath_grass", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:heatherflower", "naturalbiomes:heatherflower2", "naturalbiomes:heatherflower3"}, 5},
	animation = {
		speed_normal = 75,
		stand_speed = 40,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		stand2_start = 200,
		stand2_end = 300,
		jump_start = 400,
		jump_end = 500,
		walk_start = 300,
		walk_end = 400,
		die_start = 400,
		die_end = 500,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {
		"naturalbiomes:bamboo_sapling", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "livingfloatlands:coldsteppe_pine3_sapling", "livingfloatlands:coldsteppe_pine2_sapling", "livingfloatlands:coldsteppe_pine_sapling", "naturalbiomes:alppine1_sapling", "naturalbiomes:alpine_cowberrybush_sapling", "naturalbiomes:alppine2_sapling", "livingfloatlands:giantforest_paleoredwood_sapling", "naturalbiomes:juniper_sapling", "default:pine_sapling", "livingdesert:pine_sapling3", "livingdesert:pine_sapling2", "livingdesert:pine_sapling"
	},
	view_range = 10,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,

	do_custom = function(self, dtime)

		self.egg_timer = (self.egg_timer or 0) + dtime
		if self.egg_timer < 10 then
			return
		end
		self.egg_timer = 0

		if self.child
		or math.random(1, 100) > 1 then
			return
		end

		local pos = self.object:get_pos()

		minetest.add_item(pos, "mobs:egg")

		minetest.sound_play("default_place_node_hard", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:blackgrouse",
	nodes = {"naturalbiomes:heath_litter", "mcl_core:dirt_with_grass", "mcl_core:podzol"}, 
	neighbors = {"mcl_flowers:double:fern", "mcl_flowers:fern", "naturalbiomes:heath_grass", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:heatherflower", "naturalbiomes:heatherflower2", "naturalbiomes:heatherflower3"}, 
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 60,
	day_toggle = true,
})
end


mobs:register_egg("animalworld:blackgrouse", S("Black Grouse"), "ablackgrouse.png")