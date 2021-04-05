
local S = mobs.intllib

local tree_types = {

	{	nodes = {"ethereal:sakura_leaves", "ethereal:sakura_leaves2"},
		skins = {"mobs_tree_monster5.png"},
		drops = {
			{name = "default:stick", chance = 1, min = 1, max = 3},
			{name = "ethereal:sakura_leaves", chance = 1, min = 1, max = 2},
			{name = "ethereal:sakura_trunk", chance = 2, min = 1, max = 2},
			{name = "ethereal:sakura_tree_sapling", chance = 2, min = 0, max = 2},
		}
	},

	{	nodes = {"ethereal:frost_leaves"},
		skins = {"mobs_tree_monster3.png"},
		drops = {
			{name = "default:stick", chance = 1, min = 1, max = 3},
			{name = "ethereal:frost_leaves", chance = 1, min = 1, max = 2},
			{name = "ethereal:frost_tree", chance = 2, min = 1, max = 2},
			{name = "ethereal:crystal_spike", chance = 4, min = 0, max = 2},
		}
	},

	{	nodes = {"ethereal:yellowleaves"},
		skins = {"mobs_tree_monster4.png"},
		drops = {
			{name = "default:stick", chance = 1, min = 1, max = 3},
			{name = "ethereal:yellowleaves", chance = 1, min = 1, max = 2},
			{name = "ethereal:yellow_tree_sapling", chance = 2, min = 0, max = 2},
			{name = "ethereal:golden_apple", chance = 3, min = 0, max = 2},
		}
	},

	{	nodes = {"default:acacia_bush_leaves"},
		skins = {"mobs_tree_monster6.png"},
		drops = {
			{name = "tnt:gunpowder", chance = 1, min = 0, max = 2},
			{name = "default:iron_lump", chance = 5, min = 0, max = 2},
			{name = "default:coal_lump", chance = 3, min = 0, max = 3}
		},
		explode = true
	},
}


-- Tree Monster (or Tree Gollum) by PilzAdam

mobs:register_mob("mobs_monster:tree_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	attack_animals = true,
	--specific_attack = {"player", "mobs_animal:chicken"},
	reach = 2,
	damage = 2,
	hp_min = 20,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_tree_monster.b3d",
	textures = {
		{"mobs_tree_monster.png"},
		{"mobs_tree_monster2.png"},
	},
	blood_texture = "default_wood.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_treemonster",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	view_range = 15,
	drops = {
		{name = "default:stick", chance = 1, min = 0, max = 2},
		{name = "default:sapling", chance = 2, min = 0, max = 2},
		{name = "default:junglesapling", chance = 3, min = 0, max = 2},
		{name = "default:apple", chance = 4, min = 1, max = 2},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 2,
	fall_damage = 0,
	immune_to = {
		{"default:axe_wood", 0}, -- wooden axe doesnt hurt wooden monster
		{"default:axe_stone", 4}, -- axes deal more damage to tree monster
		{"default:axe_bronze", 5},
		{"default:axe_steel", 5},
		{"default:axe_mese", 7},
		{"default:axe_diamond", 9},
		{"default:sapling", -5}, -- default and jungle saplings heal
		{"default:junglesapling", -5},
--		{"all", 0}, -- only weapons on list deal damage
	},
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62,
	},

	-- check surrounding nodes and spawn a specific tree monster
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1
		local tmp

		for n = 1, #tree_types do

			tmp = tree_types[n]

			if tmp.explode and math.random(2) == 1 then return true end

			if minetest.find_node_near(pos, 1, tmp.nodes) then

				self.base_texture = tmp.skins
				self.object:set_properties({textures = tmp.skins})

				if tmp.drops then
					self.drops = tmp.drops
				end

				if tmp.explode then
					self.attack_type = "explode"
					self.explosion_radius = 3
					self.explosion_timer = 3
					self.damage = 21
					self.reach = 3
					self.fear_height = 4
					self.water_damage = 2
					self.lava_damage = 15
					self.light_damage = 0
					self.makes_footstep_sound = false
					self.runaway_from = {"mobs_animal:kitten"}
					self.sounds = {
						attack = "tnt_ignite",
						explode = "tnt_explode",
						fuse = "tnt_ignite"
					}
				end

				return true
			end
		end

		return true -- run only once, false/nil runs every activation
	end
})


if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "mobs_monster:tree_monster",
	nodes = {"group:leaves"}, --{"default:leaves", "default:jungleleaves"},
	max_light = 7,
	chance = 7000,
	min_height = 0,
	day_toggle = false,
})
end


mobs:register_egg("mobs_monster:tree_monster", S("Tree Monster"), "default_tree_top.png", 1)


mobs:alias_mob("mobs:tree_monster", "mobs_monster:tree_monster") -- compatibility
