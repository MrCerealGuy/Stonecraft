local materials = xcompat.materials
local S = minetest.get_translator("pipeworks")

local straight = function(pos, node, velocity, stack) return {velocity} end
local steel_tex = "[combine:16x16^[noalpha^[colorize:#D3D3D3"
if minetest.get_modpath("default") then steel_tex = "default_steel_block.png" end

-- register an embedded tube
function pipeworks.register_embedded_tube(nodename, opts)
	minetest.register_node(nodename, {
		description = opts.description,
		tiles = {
			opts.base_texture,
			opts.base_texture,
			opts.base_texture,
			opts.base_texture,
			opts.base_texture .. "^pipeworks_tube_connection_metallic.png",
			opts.base_texture .. "^pipeworks_tube_connection_metallic.png",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {
			cracky = 1,
			oddly_breakable_by_hand = 1,
			tubedevice = 1,
			dig_glass = 2,
			pickaxey=1,
			handy=1
		},
		is_ground_content = false,
		_mcl_hardness = 0.8,
		legacy_facedir_simple = true,
		_sound_def = {
			key = "node_sound_stone_defaults",
		},
		tube = {
			connect_sides = {
				front = 1,
				back = 1
			},
			priority = 50,
			can_go = straight,
			can_insert = function(pos, node, stack, direction)
				local dir = minetest.facedir_to_dir(node.param2)
				return vector.equals(dir, direction) or vector.equals(vector.multiply(dir, -1), direction)
			end
		},
		after_place_node = pipeworks.after_place,
		after_dig_node = pipeworks.after_dig,
		on_rotate = pipeworks.on_rotate,
	})

	minetest.register_craft( {
		output = nodename .. " 1",
		recipe = {
			{ opts.base_ingredient, opts.base_ingredient, opts.base_ingredient },
			{ opts.base_ingredient, "pipeworks:tube_1", opts.base_ingredient },
			{ opts.base_ingredient, opts.base_ingredient, opts.base_ingredient }
		},
	})
	pipeworks.ui_cat_tube_list[#pipeworks.ui_cat_tube_list+1] = nodename
end

-- steelblock embedded tube
pipeworks.register_embedded_tube("pipeworks:steel_block_embedded_tube", {
	description = S("Airtight steelblock embedded tube"),
	base_texture = steel_tex,
	base_ingredient = materials.steel_ingot
})
