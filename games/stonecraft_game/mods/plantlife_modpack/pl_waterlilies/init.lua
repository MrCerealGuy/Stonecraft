-- support for i18n
local S = minetest.get_translator("pl_waterlilies")

local fill_ratio = minetest.settings:get("pl_waterlilies.waterlily_rarity") or 0.03

local function get_ndef(name)
	return minetest.registered_nodes[name] or {}
end

local lilies_list = {
	{ nil	, nil			 , 1	},
	{ "225", "22.5"		, 2	},
	{ "45" , "45"			, 3	},
	{ "675", "67.5"		, 4	},
	{ "s1" , "small_1" , 5	},
	{ "s2" , "small_2" , 6	},
	{ "s3" , "small_3" , 7	},
	{ "s4" , "small_4" , 8	},
}

local lilynames_list = {}
for i in ipairs(lilies_list) do
	local deg1 = ""
	if lilies_list[i][1] ~= nil then
		deg1 = "_"..lilies_list[i][1]
	end
	table.insert(lilynames_list, "flowers:waterlily"..deg1)
end

for i in ipairs(lilies_list) do
	local deg1 = ""
	local deg2 = ""
	local lily_groups = {snappy = 3,flammable=2,flower=1}

	if lilies_list[i][1] ~= nil then
		deg1 = "_"..lilies_list[i][1]
		deg2 = "_"..lilies_list[i][2]
		lily_groups = { snappy = 3,flammable=2,flower=1, not_in_creative_inventory=1 }
	end

	minetest.register_node(":flowers:waterlily"..deg1, {
		description = S("Waterlily"),
		drawtype = "nodebox",
		tiles = {
			"flowers_waterlily"..deg2..".png",
			"flowers_waterlily"..deg2..".png^[transformFY"
		},
		use_texture_alpha = "clip",
		inventory_image = "flowers_waterlily.png",
		wield_image	= "flowers_waterlily.png",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		groups = lily_groups,
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
		node_placement_prediction = "",

		liquids_pointable = true,
		drop = "flowers:waterlily",
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

			local pname = placer:get_player_name()
			if place_pos and not minetest.is_protected(place_pos, pname) then

			local nodename = "default:cobble" -- if this block appears, something went....wrong :-)

				if not keys["sneak"] then
					local waterlily = math.random(1,8)
					if waterlily == 1 then
						nodename = "flowers:waterlily"
					elseif waterlily == 2 then
						nodename = "flowers:waterlily_225"
					elseif waterlily == 3 then
						nodename = "flowers:waterlily_45"
					elseif waterlily == 4 then
						nodename = "flowers:waterlily_675"
					elseif waterlily == 5 then
						nodename = "flowers:waterlily_s1"
					elseif waterlily == 6 then
						nodename = "flowers:waterlily_s2"
					elseif waterlily == 7 then
						nodename = "flowers:waterlily_s3"
					elseif waterlily == 8 then
						nodename = "flowers:waterlily_s4"
					end
					minetest.swap_node(place_pos, {name = nodename, param2 = math.random(0,3) })
				else
					local fdir = minetest.dir_to_facedir(placer:get_look_dir())
					minetest.swap_node(place_pos, {name = "flowers:waterlily", param2 = fdir})
				end

				if not minetest.is_creative_enabled(pname) then
					itemstack:take_item()
				end
				return itemstack
			end
		end,
	})

	minetest.register_decoration({
		name = "flowers:waterlily"..deg1,
		decoration = {"flowers:waterlily"..deg1},
		place_on = {"default:water_source"},
		deco_type = "simple",
		flags = "liquid_surface",
		spawn_by = "default:sand",
		num_spawn_by = 1,
		fill_ratio = fill_ratio,
		check_offset = -1,
		y_min = 1,
		y_max = 1,
	})

	minetest.register_decoration({
		name = "flowers:waterlily"..deg1 .."_relative",
		decoration = {"flowers:waterlily"..deg1},
		place_on = {"default:water_source"},
		deco_type = "simple",
		flags = "liquid_surface",
		spawn_by = lilynames_list,
		num_spawn_by = 1,
		fill_ratio = fill_ratio*1.25,
		check_offset = -1,
		y_min = 1,
		y_max = 1,
	})

	minetest.register_decoration({
		name = "flowers:waterlily"..deg1 .."_relative",
		decoration = {"flowers:waterlily"..deg1},
		place_on = {"default:water_source"},
		deco_type = "simple",
		flags = "liquid_surface",
		spawn_by = lilynames_list,
		num_spawn_by = 1,
		fill_ratio = fill_ratio*1.5,
		check_offset = -1,
		y_min = 1,
		y_max = 1,
	})
end

minetest.register_alias( "flowers:flower_waterlily", "flowers:waterlily")
minetest.register_alias( "flowers:flower_waterlily_225", "flowers:waterlily_225")
minetest.register_alias( "flowers:flower_waterlily_45", "flowers:waterlily_45")
minetest.register_alias( "flowers:flower_waterlily_675", "flowers:waterlily_675")
minetest.register_alias( "trunks:lilypad", "flowers:waterlily_s1")
minetest.register_alias( "along_shore:lilypads_1", "flowers:waterlily_s1")
minetest.register_alias( "along_shore:lilypads_2", "flowers:waterlily_s2")
minetest.register_alias( "along_shore:lilypads_3", "flowers:waterlily_s3")
minetest.register_alias( "along_shore:lilypads_4", "flowers:waterlily_s4")
