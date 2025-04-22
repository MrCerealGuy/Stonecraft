
--- Registered armors.
--
--  @topic armor


-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())

--- Mithril
--
--  Requires `armor_material_mithril`.
--
--  @section mithril

if armor.materials.mithril then
	--- Mithril Helmet
	--
	--  @helmet 3d_armor:helmet_mithril
	--  @img 3d_armor_inv_helmet_mithril.png
	--  @grp armor_head 1
	--  @grp armor_heal 12
	--  @grp armor_use 100
	--  @armorgrp fleshy 15
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:helmet_mithril", {
		description = S("Mithril Helmet"),
		inventory_image = "3d_armor_inv_helmet_mithril.png",
		groups = {armor_head=1, armor_heal=13, armor_use=66},
		armor_groups = {fleshy=16},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	--- Mithril Chestplate
	--
	--  @chestplate 3d_armor:chestplate_mithril
	--  @img 3d_armor_inv_chestplate_mithril.png
	--  @grp armor_torso 1
	--  @grp armor_heal 12
	--  @grp armor_use 100
	--  @armorgrp fleshy 20
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:chestplate_mithril", {
		description = S("Mithril Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_mithril.png",
		groups = {armor_torso=1, armor_heal=13, armor_use=66},
		armor_groups = {fleshy=21},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	--- Mithril Leggings
	--
	--  @leggings 3d_armor:leggings_mithril
	--  @img 3d_armor_inv_leggings_mithril.png
	--  @grp armor_legs 1
	--  @grp armor_heal 12
	--  @grp armor_use 100
	--  @armorgrp fleshy 20
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:leggings_mithril", {
		description = S("Mithril Leggings"),
		inventory_image = "3d_armor_inv_leggings_mithril.png",
		groups = {armor_legs=1, armor_heal=13, armor_use=66},
		armor_groups = {fleshy=21},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	--- Mithril Boots
	--
	--  @boots 3d_armor:boots_mithril
	--  @img 3d_armor_inv_boots_mithril.png
	--  @grp armor_feet 1
	--  @grp armor_heal 12
	--  @grp armor_use 100
	--  @armorgrp fleshy 15
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp level 3
	armor:register_armor(":3d_armor:boots_mithril", {
		description = S("Mithril Boots"),
		inventory_image = "3d_armor_inv_boots_mithril.png",
		groups = {armor_feet=1, armor_heal=13, armor_use=66},
		armor_groups = {fleshy=16},
		damage_groups = {cracky=2, snappy=1, level=3},
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

	local s = "mithril"
	local m = armor.materials.mithril
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
