local function register_pumpboom(sizename, params)

	mobs:register_mob("nssm:pumpboom_" .. sizename, {
		type = "monster",
		hp_min = params.hp_min,
		hp_max = params.hp_max,
		collisionbox = params.collisionbox,
		visual = "mesh",
		mesh = "pumpboom.x",
		rotate = 270,
		textures = {{"pumpboom.png"}},
		visual_size = params.visual_size,
		explosion_radius = params.boom_radius,
		makes_footstep_sound = true,
		view_range = params.view_range,
		fear_height = 4,
		walk_velocity = 2,
		run_velocity = 2.5,
		sounds = {
			explode = "tnt_explode"
		},
		damage = 1.5,
		jump = true,
		drops = params.drops,
		armor = 100,
		drawtype = "front",
		water_damage = 2,
		lava_damage = 5,
		light_damage = 0,
		group_attack = true,
		attack_animals = true,
		knock_back=2,
		blood_texture = "nssm_blood.png",
		stepheight = 1.1,
		attack_type = "explode",
		animation = {
			speed_normal = 25,
			speed_run = 25,
			stand_start = 1,
			stand_end = 30,
			walk_start = 81,
			walk_end = 97,
			run_start = 81,
			run_end = 97,
			punch_start = 70,
			punch_end = 80
		}
	})
end

register_pumpboom("small",{
	hp_min = 14,
	hp_max = 15,
	visual_size = {x = 3, y = 3},
	collisionbox = {-0.45, -0.3, -0.45, 0.45, 0.45, 0.45},
	boom_radius = 4,
	view_range = 20,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2},
		{name = "nssm:black_powder", chance = 2, min = 1, max = 2}
	}
})

register_pumpboom("medium",{
	hp_min = 17,
	hp_max = 18,
	visual_size = {x = 5, y = 5},
	collisionbox = {-0.7, -0.3, -0.7, 0.7, 0.7, 0.7},
	boom_radius = 6,
	view_range = 25,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 2, max = 3},
		{name = "nssm:black_powder", chance = 2, min = 1, max = 3}
	}
})

register_pumpboom("large",{
	hp_min = 19,
	hp_max = 20,
	visual_size = {x = 8, y = 8},
	collisionbox = {-1.2, -0.3, -1.2, 1.2, 1.2, 1.2},
	boom_radius = 8,
	view_range = 30,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 3, max = 4},
		{name = "nssm:black_powder", chance = 2, min = 2, max = 4}
	}
})
