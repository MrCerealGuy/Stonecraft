
--- 3D Armor Shields
--
--  @topic shields


-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())

local disable_sounds = minetest.settings:get_bool("shields_disable_sounds")
local function play_sound_effect(player, name)
	if not disable_sounds and player then
		local pos = player:get_pos()
		if pos then
			minetest.sound_play(name, {
				pos = pos,
				max_hear_distance = 10,
				gain = 0.5,
			})
		end
	end
end

if minetest.global_exists("armor") and armor.elements then
	table.insert(armor.elements, "shield")
end

-- Regisiter Shields

--- Admin Shield
--
--  @shield shields:shield_admin
--  @img shields_inv_shield_admin.png
--  @grp armor_shield 1000
--  @grp armor_heal 100
--  @grp armor_use 0
--  @grp not_int_creative_inventory 1
armor:register_armor("shields:shield_admin", {
	description = S("Admin Shield"),
	inventory_image = "shields_inv_shield_admin.png",
	groups = {armor_shield=1000, armor_heal=100, armor_use=0, not_in_creative_inventory=1},
})

minetest.register_alias("adminshield", "shields:shield_admin")


if armor.materials.wood then
	--- Wood Shield
	--
	--  @shield shields:shield_wood
	--  @img shields_inv_shield_wood.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 2000
	--  @grp flammable 1
	--  @armorgrp fleshy 5
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp choppy 3
	--  @damagegrp crumbly 2
	--  @damagegrp level 1
	armor:register_armor("shields:shield_wood", {
		description = S("Wooden Shield"),
		inventory_image = "shields_inv_shield_wood.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_wood_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_wood_footstep")
		end,
	})
	--- Enhanced Wood Shield
	--
	--  @shield shields:shield_enhanced_wood
	--  @img shields_inv_shield_enhanced_wood.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 2000
	--  @armorgrp fleshy 8
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp choppy 3
	--  @damagegrp crumbly 2
	--  @damagegrp level 2
	armor:register_armor("shields:shield_enhanced_wood", {
		description = S("Enhanced Wood Shield"),
		inventory_image = "shields_inv_shield_enhanced_wood.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=2000},
		armor_groups = {fleshy=8},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})
	minetest.register_craft({
		output = "shields:shield_enhanced_wood",
		recipe = {
			{"default:steel_ingot"},
			{"shields:shield_wood"},
			{"default:steel_ingot"},
		},
	})
	minetest.register_craft({
		type = "fuel",
		recipe = "shields:shield_wood",
		burntime = 8,
	})
end

if armor.materials.cactus then
	--- Cactus Shield
	--
	--  @shield shields:shield_cactus
	--  @img shields_inv_shield_cactus.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 1000
	--  @armorgrp fleshy 5
	--  @damagegrp cracky 3
	--  @damagegrp snappy 3
	--  @damagegrp choppy 2
	--  @damagegrp crumbly 2
	--  @damagegrp level 1
	armor:register_armor("shields:shield_cactus", {
		description = S("Cactus Shield"),
		inventory_image = "shields_inv_shield_cactus.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=1},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_wood_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_wood_footstep")
		end,
	})
	--- Enhanced Cactus Shield
	--
	--  @shield shields:shield_enhanced_cactus
	--  @img shields_inv_shield_enhanced_cactus.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 1000
	--  @armorgrp fleshy 8
	--  @damagegrp cracky 3
	--  @damagegrp snappy 3
	--  @damagegrp choppy 2
	--  @damagegrp crumbly 2
	--  @damagegrp level 2
	armor:register_armor("shields:shield_enhanced_cactus", {
		description = S("Enhanced Cactus Shield"),
		inventory_image = "shields_inv_shield_enhanced_cactus.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=8},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})
	minetest.register_craft({
		output = "shields:shield_enhanced_cactus",
		recipe = {
			{"default:steel_ingot"},
			{"shields:shield_cactus"},
			{"default:steel_ingot"},
		},
	})
	minetest.register_craft({
		type = "fuel",
		recipe = "shields:shield_cactus",
		burntime = 16,
	})
end

if armor.materials.steel then
	--- Steel Shield
	--
	--  @shield shields:shield_steel
	--  @img shields_inv_shield_steel.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 800
	--  @grp physics_speed -0.03
	--  @grp physics_gravity 0.03
	--  @armorgrp fleshy 10
	--  @damagegrp cracky 2
	--  @damagegrp snappy 3
	--  @damagegrp choppy 2
	--  @damagegrp crumbly 1
	--  @damagegrp level 2
	armor:register_armor("shields:shield_steel", {
		description = S("Steel Shield"),
		inventory_image = "shields_inv_shield_steel.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=800,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})
end

if armor.materials.bronze then
	--- Bronze Shield
	--
	--  @shield shields:shield_bronze
	--  @img shields_inv_shield_bronze.png
	--  @grp armor_shield 1
	--  @grp armor_heal 6
	--  @grp armor_use 400
	--  @grp physics_speed -0.03
	--  @grp physics_gravity 0.03
	--  @armorgrp fleshy 10
	--  @damagegrp cracky 2
	--  @damagegrp snappy 3
	--  @damagegrp choppy 2
	--  @damagegrp crumbly 1
	--  @damagegrp level 2
	armor:register_armor("shields:shield_bronze", {
		description = S("Bronze Shield"),
		inventory_image = "shields_inv_shield_bronze.png",
		groups = {armor_shield=1, armor_heal=6, armor_use=400,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})
end

if armor.materials.diamond then
	--- Diamond Shield
	--
	--  @shield shields:shield_diamond
	--  @img shields_inv_shield_diamond.png
	--  @grp armor_shield 1
	--  @grp armor_heal 12
	--  @grp armor_use 200
	--  @armorgrp fleshy 15
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp choppy 1
	--  @damagegrp level 3
	armor:register_armor("shields:shield_diamond", {
		description = S("Diamond Shield"),
		inventory_image = "shields_inv_shield_diamond.png",
		groups = {armor_shield=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_glass_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_break_glass")
		end,
	})
end

if armor.materials.gold then
	--- Gold Shield
	--
	--  @shield shields:shield_gold
	--  @img shields_inv_shield_gold.png
	--  @grp armor_shield 1
	--  @grp armor_heal 6
	--  @grp armor_use 300
	--  @grp physics_speed -0.04
	--  @grp physics_gravity 0.04
	--  @armorgrp fleshy 10
	--  @damagegrp cracky 1
	--  @damagegrp snappy 2
	--  @damagegrp choppy 2
	--  @damagegrp crumbly 3
	--  @damagegrp level 2
	armor:register_armor("shields:shield_gold", {
		description = S("Gold Shield"),
		inventory_image = "shields_inv_shield_gold.png",
		groups = {armor_shield=1, armor_heal=6, armor_use=300,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})
end

if armor.materials.mithril then
	--- Mithril Shield
	--
	--  @shield shields:shield_mithril
	--  @img shields_inv_shield_mithril.png
	--  @grp armor_shield 1
	--  @grp armor_heal 12
	--  @grp armor_use 100
	--  @armorgrp fleshy 15
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp level 3
	armor:register_armor("shields:shield_mithril", {
		description = S("Mithril Shield"),
		inventory_image = "shields_inv_shield_mithril.png",
		groups = {armor_shield=1, armor_heal=13, armor_use=66},
		armor_groups = {fleshy=16},
		damage_groups = {cracky=2, snappy=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_glass_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_break_glass")
		end,
	})
end

if armor.materials.crystal then
	--- Crystal Shield
	--
	--  @shield shields:shield_crystal
	--  @img shields_inv_shield_crystal.png
	--  @grp armor_shield 1
	--  @grp armor_heal 12
	--  @grp armor_use 100
	--  @grp armor_fire 1
	--  @armorgrp fleshy 15
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp level 3
	armor:register_armor("shields:shield_crystal", {
		description = S("Crystal Shield"),
		inventory_image = "shields_inv_shield_crystal.png",
		groups = {armor_shield=1, armor_heal=12, armor_use=100, armor_fire=1},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_glass_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_break_glass")
		end,
	})
end

if armor.materials.nether then
	--- Nether Shield
	--
	--  @shield shields:shield_nether
	--  @img shields_inv_shield_nether.png
	--  @grp armor_shield 1
	--  @grp armor_heal 17
	--  @grp armor_use 200
	--  @grp armor_fire 1
	--  @armorgrp fleshy 20
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp level 3
	armor:register_armor("shields:shield_nether", {
		description = S("Nether Shield"),
		inventory_image = "shields_inv_shield_nether.png",
		groups = {armor_shield=1, armor_heal=17, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=3, snappy=2, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_glass_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_break_glass")
		end,
	})
end

for k, v in pairs(armor.materials) do
	minetest.register_craft({
		output = "shields:shield_"..k,
		recipe = {
			{v, v, v},
			{v, v, v},
			{"", v, ""},
		},
	})
end
