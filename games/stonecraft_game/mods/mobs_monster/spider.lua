
local S = mobs.intllib

local get_velocity = function(self)

	local v = self.object:get_velocity()

	-- sanity check
	if not v then return 0 end

	return (v.x * v.x + v.z * v.z) ^ 0.5
end


local spider_types = {

	{	nodes = {"default:snow", "default:snowblock", "default:dirt_with_snow"},
		skins = {"mobs_spider_snowy.png"},
		docile = true,
		drops = nil
	},

	{	nodes = {"default:dirt_with_rainforest_litter", "default:jungletree"},
		skins = {"mobs_spider_orange.png"},
		docile = true,
		drops = nil,
		shoot = true
	},

	{	nodes = {"default:stone", "default:gravel"},
		skins = {"mobs_spider_grey.png"},
		docile = nil,
		drops = nil,
		small = true
	},

	{	nodes = {"default:mese", "default:stone_with_mese"},
		skins = {"mobs_spider_mese.png"},
		docile = nil,
		drops = {
			{name = "farming:string", chance = 1, min = 0, max = 2},
			{name = "default:mese_crystal_fragment", chance = 2, min = 1, max = 4}}
	},

	{	nodes = {"ethereal:crystal_dirt", "ethereal:crystal_spike"},
		skins = {"mobs_spider_crystal.png"},
		docile = true,
		drops = {
			{name = "farming:string", chance = 1, min = 0, max = 2},
			{name = "ethereal:crystal_spike", chance = 15, min = 1, max = 2}}
	}
}


-- Spider by AspireMint (CC-BY-SA 3.0 license)

mobs:register_mob("mobs_monster:spider", {
	--docile_by_day = true,
	group_attack = true,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 30,
	armor = 200,
	collisionbox = {-0.8, -0.5, -0.8, 0.8, 0, 0.8},
	visual_size = {x = 1, y = 1},
	visual = "mesh",
	mesh = "mobs_spider.b3d",
	textures = {
		{"mobs_spider_mese.png"},
		{"mobs_spider_orange.png"},
		{"mobs_spider_snowy.png"},
		{"mobs_spider_grey.png"},
		{"mobs_spider_crystal.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_spider",
		attack = "mobs_spider",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	view_range = 15,
	floats = 0,
	drops = {
		{name = "farming:string", chance = 1, min = 0, max = 2},
	},
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 0,
		stand_end = 0,
		walk_start = 1,
		walk_end = 21,
		run_start = 1,
		run_end = 21,
		punch_start = 25,
		punch_end = 45,
	},

	-- check surrounding nodes and spawn a specific spider
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1
		local tmp

		for n = 1, #spider_types do

			tmp = spider_types[n]

			if minetest.find_node_near(pos, 1, tmp.nodes) then

				self.base_texture = tmp.skins
				self.object:set_properties({textures = tmp.skins})
				self.docile_by_day = tmp.docile

				if tmp.drops then
					self.drops = tmp.drops
				end

				if tmp.shoot then
					self.attack_type = "dogshoot"
					self.arrow = "mobs_monster:cobweb"
					self.dogshoot_switch = 1
					self.dogshoot_count_max = 60
					self.dogshoot_count2_max = 20
					self.shoot_interval = 2
					self.shoot_offset = 2
				end

				if tmp.small then
					self.object:set_properties({
						collisionbox = {-0.2, -0.2, -0.2, 0.2, 0, 0.2},
						visual_size = {x = 0.25, y = 0.25}
					})
				end

				return true
			end
		end

		return true -- run only once, false/nil runs every activation
	end,

	-- custom function to make spiders climb vertical facings
	do_custom = function(self, dtime)

		-- quarter second timer
		self.spider_timer = (self.spider_timer or 0) + dtime
		if self.spider_timer < 0.25 then
			return
		end
		self.spider_timer = 0

		-- need to be stopped to go onwards
		if get_velocity(self) > 0.5 then
			self.disable_falling = nil
			return
		end

		local pos = self.object:get_pos()
		local yaw = self.object:get_yaw()

		-- sanity check
		if not yaw then return end

		pos.y = pos.y + self.collisionbox[2] - 0.2

		local dir_x = -math.sin(yaw) * (self.collisionbox[4] + 0.5)
		local dir_z = math.cos(yaw) * (self.collisionbox[4] + 0.5)
		local nod = minetest.get_node_or_nil({
			x = pos.x + dir_x,
			y = pos.y + 0.5,
			z = pos.z + dir_z
		})

		-- get current velocity
		local v = self.object:get_velocity()

		-- can only climb solid facings
		if not nod or not minetest.registered_nodes[nod.name]
		or not minetest.registered_nodes[nod.name].walkable then
			self.disable_falling = nil
			v.y = 0
			self.object:set_velocity(v)
			return
		end

--print ("----", nod.name, self.disable_falling, dtime)

		-- turn off falling if attached to facing
		self.disable_falling = true

		-- move up facing
		v.x = 0 ; v.y = 0
		v.y = self.jump_height
		mobs:set_animation(self, "jump")
		self.object:set_velocity(v)
	end,

	-- make spiders jump at you on attack
	custom_attack = function(self, pos)

		local vel = self.object:get_velocity()

		self.object:set_velocity({
			x = vel.x * self.run_velocity,
			y = self.jump_height * 1.5,
			z = vel.z * self.run_velocity
		})

		self.pausetimer = 0.5

		return true -- continue rest of attack function
	end
})


if not mobs.custom_spawn_monster then
-- above ground spawn
mobs:spawn({
	name = "mobs_monster:spider",
	nodes = {
		"default:dirt_with_rainforest_litter", "default:snowblock",
		"default:snow", "ethereal:crystal_dirt", "ethereal:cold_dirt"
	},
	min_light = 0,
	max_light = 8,
	chance = 7000,
	active_object_count = 1,
	min_height = 25,
	max_height = 31000,
})

-- below ground spawn
mobs:spawn({
	name = "mobs_monster:spider",
	nodes = {"default:stone_with_mese", "default:mese", "default:stone"},
	min_light = 0,
	max_light = 7,
	chance = 7000,
	active_object_count = 1,
	min_height = -31000,
	max_height = -40,
})
end


mobs:register_egg("mobs_monster:spider", S("Spider"), "mobs_cobweb.png", 1)


mobs:alias_mob("mobs_monster:spider2", "mobs_monster:spider") -- compatibility
mobs:alias_mob("mobs:spider", "mobs_monster:spider")


-- cobweb
minetest.register_node(":mobs:cobweb", {
	description = S("Cobweb"),
	drawtype = "plantlike",
	visual_scale = 1.2,
	tiles = {"mobs_cobweb.png"},
	inventory_image = "mobs_cobweb.png",
	paramtype = "light",
	sunlight_propagates = true,
	liquid_viscosity = 11,
	liquidtype = "source",
	liquid_alternative_flowing = "mobs:cobweb",
	liquid_alternative_source = "mobs:cobweb",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	groups = {snappy = 1, disable_jump = 1},
	drop = "farming:string",
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_craft({
	output = "mobs:cobweb",
	recipe = {
		{"farming:string", "", "farming:string"},
		{"", "farming:string", ""},
		{"farming:string", "", "farming:string"},
	}
})


local web_place = function(pos)

	local pos2 = minetest.find_node_near(pos, 1, {"air", "group:leaves"}, true)

	if pos2 then
		minetest.swap_node(pos2, {name = "mobs:cobweb"})
	end
end

mobs:register_arrow("mobs_monster:cobweb", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"mobs_cobweb.png"},
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	velocity = 15,
	tail = 1,
	tail_texture = "mobs_cobweb.png",
	tail_size = 5,
	glow = 2,
	expire = 0.1,

	hit_player = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 2.0,
			damage_groups = {fleshy = 3},
		}, nil)

		web_place(self.object:get_pos())
	end,

	hit_node = function(self, pos, node)
		web_place(pos)
	end,

	hit_mob = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 2.0,
			damage_groups = {fleshy = 3},
		}, nil)
	end
})
