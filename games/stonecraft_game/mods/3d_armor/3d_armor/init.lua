--[[

2017-05-10 added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

ARMOR_MOD_NAME = minetest.get_current_modname()
dofile(minetest.get_modpath(ARMOR_MOD_NAME).."/armor.lua")
dofile(minetest.get_modpath(ARMOR_MOD_NAME).."/admin.lua")

if ARMOR_MATERIALS.wood then
	minetest.register_tool("3d_armor:helmet_wood", {
		description = S("Wood Helmet"),
		inventory_image = "3d_armor_inv_helmet_wood.png",
		groups = {armor_head=5, armor_heal=0, armor_use=2000},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_wood", {
		description = S("Wood Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_wood.png",
		groups = {armor_torso=10, armor_heal=0, armor_use=2000},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_wood", {
		description = S("Wood Leggings"),
		inventory_image = "3d_armor_inv_leggings_wood.png",
		groups = {armor_legs=5, armor_heal=0, armor_use=2000},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_wood", {
		description = S("Wood Boots"),
		inventory_image = "3d_armor_inv_boots_wood.png",
		groups = {armor_feet=5, armor_heal=0, armor_use=2000},
		wear = 0,
	})
end

if ARMOR_MATERIALS.cactus then
	minetest.register_tool("3d_armor:helmet_cactus", {
		description = S("Cactus Helmet"),
		inventory_image = "3d_armor_inv_helmet_cactus.png",
		groups = {armor_head=5, armor_heal=0, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_cactus", {
		description = S("Cactus Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_cactus.png",
		groups = {armor_torso=10, armor_heal=0, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_cactus", {
		description = S("Cactus Leggings"),
		inventory_image = "3d_armor_inv_leggings_cactus.png",
		groups = {armor_legs=5, armor_heal=0, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_cactus", {
		description = S("Cactus Boots"),
		inventory_image = "3d_armor_inv_boots_cactus.png",
		groups = {armor_feet=5, armor_heal=0, armor_use=2000},
		wear = 0,
	})
end

if ARMOR_MATERIALS.steel then
	minetest.register_tool("3d_armor:helmet_steel", {
		description = S("Steel Helmet"),
		inventory_image = "3d_armor_inv_helmet_steel.png",
		groups = {armor_head=10, armor_heal=0, armor_use=500},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_steel", {
		description = S("Steel Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_steel.png",
		groups = {armor_torso=15, armor_heal=0, armor_use=500},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_steel", {
		description = S("Steel Leggings"),
		inventory_image = "3d_armor_inv_leggings_steel.png",
		groups = {armor_legs=15, armor_heal=0, armor_use=500},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_steel", {
		description = S("Steel Boots"),
		inventory_image = "3d_armor_inv_boots_steel.png",
		groups = {armor_feet=10, armor_heal=0, armor_use=500},
		wear = 0,
	})
end

if ARMOR_MATERIALS.bronze then
	minetest.register_tool("3d_armor:helmet_bronze", {
		description = S("Bronze Helmet"),
		inventory_image = "3d_armor_inv_helmet_bronze.png",
		groups = {armor_head=10, armor_heal=6, armor_use=250},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_bronze", {
		description = S("Bronze Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_bronze.png",
		groups = {armor_torso=15, armor_heal=6, armor_use=250},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_bronze", {
		description = S("Bronze Leggings"),
		inventory_image = "3d_armor_inv_leggings_bronze.png",
		groups = {armor_legs=15, armor_heal=6, armor_use=250},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_bronze", {
		description = S("Bronze Boots"),
		inventory_image = "3d_armor_inv_boots_bronze.png",
		groups = {armor_feet=10, armor_heal=6, armor_use=250},
		wear = 0,
	})
end

if ARMOR_MATERIALS.diamond then
	minetest.register_tool("3d_armor:helmet_diamond", {
		description = S("Diamond Helmet"),
		inventory_image = "3d_armor_inv_helmet_diamond.png",
		groups = {armor_head=15, armor_heal=12, armor_use=100},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_diamond", {
		description = S("Diamond Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_diamond.png",
		groups = {armor_torso=20, armor_heal=12, armor_use=100},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_diamond", {
		description = S("Diamond Leggings"),
		inventory_image = "3d_armor_inv_leggings_diamond.png",
		groups = {armor_legs=20, armor_heal=12, armor_use=100},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_diamond", {
		description = S("Diamond Boots"),
		inventory_image = "3d_armor_inv_boots_diamond.png",
		groups = {armor_feet=15, armor_heal=12, armor_use=100},
		wear = 0,
	})
end

if ARMOR_MATERIALS.gold then
	minetest.register_tool("3d_armor:helmet_gold", {
		description = S("Gold Helmet"),
		inventory_image = "3d_armor_inv_helmet_gold.png",
		groups = {armor_head=10, armor_heal=6, armor_use=250},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_gold", {
		description = S("Gold Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_gold.png",
		groups = {armor_torso=15, armor_heal=6, armor_use=250},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_gold", {
		description = S("Gold Leggings"),
		inventory_image = "3d_armor_inv_leggings_gold.png",
		groups = {armor_legs=15, armor_heal=6, armor_use=250},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_gold", {
		description = S("Gold Boots"),
		inventory_image = "3d_armor_inv_boots_gold.png",
		groups = {armor_feet=10, armor_heal=6, armor_use=250},
		wear = 0,
	})
end

if ARMOR_MATERIALS.mithril then
	minetest.register_tool("3d_armor:helmet_mithril", {
		description = S("Mithril Helmet"),
		inventory_image = "3d_armor_inv_helmet_mithril.png",
		groups = {armor_head=15, armor_heal=12, armor_use=50},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_mithril", {
		description = S("Mithril Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_mithril.png",
		groups = {armor_torso=20, armor_heal=12, armor_use=50},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_mithril", {
		description = S("Mithril Leggings"),
		inventory_image = "3d_armor_inv_leggings_mithril.png",
		groups = {armor_legs=20, armor_heal=12, armor_use=50},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_mithril", {
		description = S("Mithril Boots"),
		inventory_image = "3d_armor_inv_boots_mithril.png",
		groups = {armor_feet=15, armor_heal=12, armor_use=50},
		wear = 0,
	})
end

if ARMOR_MATERIALS.crystal then
	minetest.register_tool("3d_armor:helmet_crystal", {
		description = S("Crystal Helmet"),
		inventory_image = "3d_armor_inv_helmet_crystal.png",
		groups = {armor_head=15, armor_heal=12, armor_use=50, armor_fire=1},
		wear = 0,
	})
	minetest.register_tool("3d_armor:chestplate_crystal", {
		description = S("Crystal Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_crystal.png",
		groups = {armor_torso=20, armor_heal=12, armor_use=50, armor_fire=1},
		wear = 0,
	})
	minetest.register_tool("3d_armor:leggings_crystal", {
		description = S("Crystal Leggings"),
		inventory_image = "3d_armor_inv_leggings_crystal.png",
		groups = {armor_legs=20, armor_heal=12, armor_use=50, armor_fire=1},
		wear = 0,
	})
	minetest.register_tool("3d_armor:boots_crystal", {
		description = S("Crystal Boots"),
		inventory_image = "3d_armor_inv_boots_crystal.png",
		groups = {armor_feet=15, armor_heal=12, armor_use=50, physics_speed=1, physics_jump=0.5, armor_fire=1},
		wear = 0,
	})
end

for k, v in pairs(ARMOR_MATERIALS) do
	minetest.register_craft({
		output = "3d_armor:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "3d_armor:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end

