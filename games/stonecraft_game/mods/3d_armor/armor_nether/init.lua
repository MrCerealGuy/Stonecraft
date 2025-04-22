
--- Registered armors.
--
--  @topic armor


-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())


--- Nether
--
--  Requires `armor_material_nether`.
--
--  @section nether

if armor.materials.nether then
	--- Nether Helmet
	--
	--  @helmet 3d_armor:helmet_nether
	--  @img 3d_armor_inv_helmet_nether.png
	--  @grp armor_head 1
	--  @grp armor_heal 14
	--  @grp armor_use 200
	--  @grp armor_fire 1
	--  @armorgrp fleshy 18
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:helmet_nether", {
		description = S("Nether Helmet"),
		inventory_image = "3d_armor_inv_helmet_nether.png",
		groups = {armor_head=1, armor_heal=14, armor_use=100, armor_fire=1},
		armor_groups = {fleshy=18},
		damage_groups = {cracky=3, snappy=2, level=3},
	})
	--- Nether Chestplate
	--
	--  @chestplate 3d_armor:chestplate_nether
	--  @img 3d_armor_inv_chestplate_nether.png
	--  @grp armor_torso 1
	--  @grp armor_heal 14
	--  @grp armor_use 200
	--  @grp armor_fire 1
	--  @armorgrp fleshy 25
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:chestplate_nether", {
		description = S("Nether Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_nether.png",
		groups = {armor_torso=1, armor_heal=14, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=25},
		damage_groups = {cracky=3, snappy=2, level=3},
	})
	--- Nether Leggings
	--
	--  @leggings 3d_armor:leggings_nether
	--  @img 3d_armor_inv_leggings_nether.png
	--  @grp armor_legs 1
	--  @grp armor_heal 14
	--  @grp armor_use 200
	--  @grp armor_fire 1
	--  @armorgrp fleshy 25
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:leggings_nether", {
		description = S("Nether Leggings"),
		inventory_image = "3d_armor_inv_leggings_nether.png",
		groups = {armor_legs=1, armor_heal=14, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=25},
		damage_groups = {cracky=3, snappy=2, level=3},
	})
	--- Nether Boots
	--
	--  @boots 3d_armor:boots_nether
	--  @img 3d_armor_inv_boots_nether.png
	--  @grp armor_feet 1
	--  @grp armor_heal 14
	--  @grp armor_use 200
	--  @grp armor_fire 1
	--  @armorgrp fleshy 18
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:boots_nether", {
		description = S("Nether Boots"),
		inventory_image = "3d_armor_inv_boots_nether.png",
		groups = {armor_feet=1, armor_heal=14, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=18},
		damage_groups = {cracky=3, snappy=2, level=3},
	})


	--- Crafting
	--
	--  @section craft

	--- Craft recipes for helmets, chestplates, leggings, boots, & shields.
	--
	--  @craft armor
	--  @usage
	--  Key:
	--  - m: material
	--    - wood:    group:wood
	--    - cactus:  default:cactus
	--    - steel:   default:steel_ingot
	--    - bronze:  default:bronze_ingot
	--    - diamond: default:diamond
	--    - gold:    default:gold_ingot
	--    - mithril: moreores:mithril_ingot
	--    - crystal: ethereal:crystal_ingot
	--    - nether:  nether:nether_ingot
	--
	--  helmet:        chestplate:    leggings:
	--  ┌───┬───┬───┐  ┌───┬───┬───┐  ┌───┬───┬───┐
	--  │ m │ m │ m │  │ m │   │ m │  │ m │ m │ m │
	--  ├───┼───┼───┤  ├───┼───┼───┤  ├───┼───┼───┤
	--  │ m │   │ m │  │ m │ m │ m │  │ m │   │ m │
	--  ├───┼───┼───┤  ├───┼───┼───┤  ├───┼───┼───┤
	--  │   │   │   │  │ m │ m │ m │  │ m │   │ m │
	--  └───┴───┴───┘  └───┴───┴───┘  └───┴───┴───┘
	--
	--  boots:         shield:
	--  ┌───┬───┬───┐  ┌───┬───┬───┐
	--  │   │   │   │  │ m │ m │ m │
	--  ├───┼───┼───┤  ├───┼───┼───┤
	--  │ m │   │ m │  │ m │ m │ m │
	--  ├───┼───┼───┤  ├───┼───┼───┤
	--  │ m │   │ m │  │   │ m │   │
	--  └───┴───┴───┘  └───┴───┴───┘

	local s = "nether"
	local m = armor.materials.nether
	minetest.register_craft({
		output = "3d_armor:helmet_"..s,
		recipe = {
			{m, m, m},
			{m, "", m},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..s,
		recipe = {
			{m, "", m},
			{m, m, m},
			{m, m, m},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..s,
		recipe = {
			{m, m, m},
			{m, "", m},
			{m, "", m},
		},
	})
	minetest.register_craft({
		output = "3d_armor:boots_"..s,
		recipe = {
			{m, "", m},
			{m, "", m},
		},
	})

end
