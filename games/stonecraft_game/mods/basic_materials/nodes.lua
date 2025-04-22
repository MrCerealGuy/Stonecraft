local S = minetest.get_translator("basic_materials")
local sound_api = xcompat.sounds
local chains_sbox = {type = "fixed",fixed = { -0.1, -0.5, -0.1, 0.1, 0.5, 0.1 }}

minetest.register_node("basic_materials:cement_block", {
	description = S("Cement"),
	tiles = {"basic_materials_cement_block.png"},
	is_ground_content = false,
	groups = {cracky=2, dig_stone = 1, pickaxey=5},
	_mcl_hardness=1.6,
	sounds = sound_api.node_sound_stone_defaults(),
})

minetest.register_node("basic_materials:concrete_block", {
	description = S("Concrete Block"),
	tiles = {"basic_materials_concrete_block.png",},
	is_ground_content = false,
	groups = {cracky=1, concrete=1, dig_stone = 1, pickaxey=5},
	_mcl_hardness=1.6,
	sounds = sound_api.node_sound_stone_defaults(),
})

minetest.register_node("basic_materials:chain_steel", {
	description = S("Chain (steel, hanging)"),
	drawtype = "mesh",
	mesh = "basic_materials_chains.obj",
	tiles = {"basic_materials_chain_steel.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "basic_materials_chain_steel_inv.png",
	is_ground_content = false,
	groups = {cracky=3, dig_stone = 1, pickaxey=5},
	_mcl_hardness=1.6,
	selection_box = chains_sbox,
})

minetest.register_node("basic_materials:chain_brass", {
	description = S("Chain (brass, hanging)"),
	drawtype = "mesh",
	mesh = "basic_materials_chains.obj",
	tiles = {"basic_materials_chain_brass.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "basic_materials_chain_brass_inv.png",
	is_ground_content = false,
	groups = {cracky=3, dig_stone = 1, pickaxey=5},
	_mcl_hardness=1.6,
	selection_box = chains_sbox,
})

minetest.register_node("basic_materials:brass_block", {
	description = S("Brass Block"),
	tiles = { "basic_materials_brass_block.png" },
	is_ground_content = false,
	groups = {cracky=1, dig_stone = 1, pickaxey=5},
	_mcl_hardness=1.6,
	sounds = sound_api.node_sound_metal_defaults()
})
