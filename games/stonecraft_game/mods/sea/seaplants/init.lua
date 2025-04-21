-- NODES

for color, cname in pairs({green = "Green", brown = "Brown"}) do
	minetest.register_node(
		"seaplants:sand_with_kelp_"..color, {
			description = cname.." Kelp",
			drawtype = "plantlike_rooted",
			waving = 1,
			tiles = {"default_sand.png"},
			special_tiles = {{name = "seaplants_kelp"..color.."middle.png", tileable_vertical = true}},
			inventory_image = "seaplants_kelp"..color..".png",
			paramtype = "light",
			paramtype2 = "leveled",
			groups = {snappy = 3},
			selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
				},
			},
			node_dig_prediction = "default:sand",
			node_placement_prediction = "",
			sounds = default.node_sound_sand_defaults(
				{
					dig = {name = "default_dig_snappy", gain = 0.2},
					dug = {name = "default_grass_footstep", gain = 0.25},
				}),
			
			on_use = minetest.item_eat(1),
			
			on_place = function(itemstack, placer, pointed_thing)
				-- Call on_rightclick if the pointed node defines it
				if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
					local node_ptu = minetest.get_node(pointed_thing.under)
					local def_ptu = minetest.registered_nodes[node_ptu.name]
					if def_ptu and def_ptu.on_rightclick then
						return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
															  itemstack, pointed_thing)
					end
				end

				local pos = pointed_thing.under
				if minetest.get_node(pos).name ~= "default:sand" then
					return itemstack
				end

				local height = math.random(4, 6)
				local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
				local node_top = minetest.get_node(pos_top)
				local def_top = minetest.registered_nodes[node_top.name]
				local player_name = placer:get_player_name()

				if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
					if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
						minetest.set_node(pos, {name = "seaplants:sand_with_kelp_"..color,
														param2 = height * 16})
						if not (creative and creative.is_enabled_for
								  and creative.is_enabled_for(player_name)) then
							itemstack:take_item()
						end
					else
						minetest.chat_send_player(player_name, "Node is protected")
						minetest.record_protection_violation(pos, player_name)
					end
				end

				return itemstack
			end,

			after_destruct  = function(pos, oldnode)
				minetest.set_node(pos, {name = "default:sand"})
			end
	})

	-- Replace Old Kelps by new ones
	minetest.register_alias("seaplants:kelp"..color, "default:water_source")
	minetest.register_alias("seaplants:kelp"..color.."middle", "default:water_source")
	minetest.register_alias("seaplants:seaplantssandkelp"..color, "seaplants:sand_with_kelp_"..color)
	minetest.register_alias("seaplants:seaplantsdirtkelp"..color, "seaplants:sand_with_kelp_"..color)
end

for color, cname in pairs({green = "Green", red = "Red"}) do
	minetest.register_node(
		"seaplants:seagrass_"..color, {
			description = cname.." Seagrass",
			drawtype = "plantlike_rooted",
			waving = 1,
			paramtype = "light",
			tiles = {"default_sand.png"},
			special_tiles = {{name = "seaplants_seagrass"..color..".png", tileable_vertical = true}},
			inventory_image = "seaplants_seagrass"..color..".png",
			groups = {snappy = 3},
			selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
				},
			},
			node_dig_prediction = "default:sand",
			node_placement_prediction = "",
			sounds = default.node_sound_sand_defaults(
				{
					dig = {name = "default_dig_snappy", gain = 0.2},
					dug = {name = "default_grass_footstep", gain = 0.25},
				}),

			on_use = minetest.item_eat(1),

			on_place = function(itemstack, placer, pointed_thing)
				if pointed_thing.type ~= "node" or not placer then
					return itemstack
				end

				local player_name = placer:get_player_name()
				local pos_under = pointed_thing.under
				local pos_above = pointed_thing.above

				if minetest.get_node(pos_under).name ~= "default:sand" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
					return itemstack
				end

				if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
					minetest.chat_send_player(player_name, "Node is protected")
					minetest.record_protection_violation(pos_under, player_name)
					return itemstack
				end

				minetest.set_node(pos_under, {name = "seaplants:seagrass_"..color})
				if not (creative and creative.is_enabled_for(player_name)) then
					itemstack:take_item()
				end

				return itemstack
			end,

			after_destruct = function(pos, oldnode)
				minetest.set_node(pos, {name = "default:sand"})
			end,
	})

	-- Replace Old seagrasses by new ones
	minetest.register_alias("seaplants:seagrass"..color, "default:water_source")
	minetest.register_alias("seaplants:seaplantssandseagrass"..color, "seaplants:seagrass_"..color)
	minetest.register_alias("seaplants:seaplantsdirtseagrass"..color, "seaplants:seagrass_"..color)
end


-- CRAFT ITEMS


minetest.register_craftitem("seaplants:seasaladmix", {
	description = "Sea salad mix",
	inventory_image = "seaplants_seasaladmix.png",
	on_use = minetest.item_eat(6)
})


-- CRAFTING

minetest.register_craft({
	type = "shapeless",
	output = "seaplants:seasaladmix",
	recipe = {"seaplants:sand_with_kelp_green", "seaplants:sand_with_kelp_brown", "seaplants:seagrass_green", "seaplants:seagrass_red"}
})


-- SEAPLANTS GENERATION

-- Kelp

minetest.register_decoration(
	{
		name = "seaplants:seaplants",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87113,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {
			"default:sand_with_kelp", "seaplants:sand_with_kelp_green",
			"seaplants:sand_with_kelp_brown", "seaplants:seagrass_green",
			"seaplants:seagrass_red"
		},
		param2 = 48,
		param2_max = 96,
	})


-- ALIASES

minetest.register_alias("seaplants:stemsgreen","default:sand")
minetest.register_alias("seaplants:stemsbrown","default:dirt")
minetest.register_alias("seaplants:leafyblue","default:sand")
minetest.register_alias("seaplants:leafygreen","default:dirt")

minetest.register_alias("seaplants:chewstickgreen","seaplants:sand_with_kelp_green")
minetest.register_alias("seaplants:chewstickbrown","seaplants:sand_with_kelp_brown")
minetest.register_alias("seaplants:leavysnackgreen","seaplants:seagrass_green")
minetest.register_alias("seaplants:leavysnackblue","seaplants:seagrass_red")
minetest.register_alias("seaplants:seasalad","seaplants:seasaladmix")

minetest.log("action", "[sea - seaplants] loaded.")
