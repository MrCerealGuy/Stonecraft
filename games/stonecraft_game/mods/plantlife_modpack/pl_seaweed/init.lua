-- support for i18n
local S = minetest.get_translator("pl_seaweed")

local seaweed_rarity = minetest.settings:get("pl_seaweed.seaweed_rarity") or 0.06

local function get_ndef(name)
	return minetest.registered_nodes[name] or {}
end

local algae_list = { {nil}, {2}, {3}, {4} }

for i in ipairs(algae_list) do
	local num = ""
	local algae_groups = {snappy = 3,flammable=2,flower=1}

	if algae_list[i][1] ~= nil then
		num = "_"..algae_list[i][1]
		algae_groups = { snappy = 3,flammable=2,flower=1, not_in_creative_inventory=1 }
	end

	minetest.register_node(":flowers:seaweed"..num, {
		description = S("Seaweed"),
		drawtype = "nodebox",
		tiles = {
			"flowers_seaweed"..num..".png",
			"flowers_seaweed"..num..".png^[transformFY"
		},
		use_texture_alpha = "clip",
		inventory_image = "flowers_seaweed_2.png",
		wield_image	= "flowers_seaweed_2.png",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		groups = algae_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.4, -0.5, -0.4, 0.4, -0.45, 0.4 },
		},
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.49, -0.5, 0.5, -0.49, 0.5 },
		},
		buildable_to = true,

		liquids_pointable = true,
		drop = "flowers:seaweed",
		on_place = function(itemstack, placer, pointed_thing)
			if not itemstack or not placer or not pointed_thing then
				return
			end

			local keys = placer:get_player_control()
			local pt = pointed_thing

			local place_pos = nil
			local top_pos = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
			local under_node = minetest.get_node(pt.under)
			local above_node = minetest.get_node(pt.above)
			local top_node	 = minetest.get_node(top_pos)
			if get_ndef(under_node.name)["buildable_to"] then
				if under_node.name ~= "default:water_source" then
					place_pos = pt.under
				elseif top_node.name ~= "default:water_source" and get_ndef(top_node.name)["buildable_to"] then
					place_pos = top_pos
				else
					return
				end
			elseif get_ndef(above_node.name)["buildable_to"] then
				place_pos = pt.above
			end
			if not place_pos then return end -- something went wrong :P

			local pname = placer:get_player_name()
			if not minetest.is_protected(place_pos, pname) then

			local nodename = "default:cobble" -- :D

				if not keys["sneak"] then
					--local node = minetest.get_node(pt.under)
					local seaweed = math.random(1,4)
					if seaweed == 1 then
						nodename = "flowers:seaweed"
					elseif seaweed == 2 then
						nodename = "flowers:seaweed_2"
					elseif seaweed == 3 then
						nodename = "flowers:seaweed_3"
					elseif seaweed == 4 then
						nodename = "flowers:seaweed_4"
					end
					minetest.swap_node(place_pos, {name = nodename, param2 = math.random(0,3) })
				else
					local fdir = minetest.dir_to_facedir(placer:get_look_dir())
					minetest.swap_node(place_pos, {name = "flowers:seaweed", param2 = fdir})
				end

				if not minetest.is_creative_enabled(pname) then
					itemstack:take_item()
				end
				return itemstack
			end
		end,
	})

	minetest.register_decoration({
		name = "flowers:seaweed"..num,
		decoration = {"flowers:seaweed"..num},
		place_on = {"default:water_source"},
		deco_type = "simple",
		flags = "liquid_surface",
		spawn_by = {"default:dirt_with_grass", "default:sand"},
		num_spawn_by = 1,
		fill_ratio = seaweed_rarity,
		check_offset = -1,
		y_min = 1,
		y_max = 1,
	})

	minetest.register_decoration({
		name = "flowers:seaweed"..num .."_sand",
		decoration = {"flowers:seaweed"..num},
		place_on = {"default:sand"},
		deco_type = "simple",
		flags = "all_floors",
		spawn_by = "default:water_source",
		num_spawn_by = 1,
		fill_ratio = seaweed_rarity*1.2,
		check_offset = -1,
		y_min = 1,
		y_max = 1,
	})
end

minetest.register_alias("flowers:flower_seaweed", "flowers:seaweed")
minetest.register_alias("along_shore:pondscum_1", "flowers:seaweed")
minetest.register_alias("along_shore:seaweed_1", "flowers:seaweed")
minetest.register_alias("along_shore:seaweed_2", "flowers:seaweed_2")
minetest.register_alias("along_shore:seaweed_3", "flowers:seaweed_3")
minetest.register_alias("along_shore:seaweed_4", "flowers:seaweed_4")
