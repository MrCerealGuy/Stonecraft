local function add_group(name, group, value)
	local node = minetest.registered_nodes[name]

	if node then
		local groups = node.groups
		if not groups then
			groups = {}
		end
		groups[group] = value

		minetest.log("action", "[seacoral] Add group "..group.."="..value.." to "..name)
		minetest.override_item(name, {groups = groups})
	end
end

if minetest.get_modpath("nalc_lib") then
	add_group = nalc.add_group
end

-- NODES

-- Add magenta, aqua, skyblue seacorals
for color, cname in pairs({magenta = "Magenta", aqua = "Aqua", skyblue = "Skyblue"}) do
	minetest.register_node(
		"seacoral:coral_"..color, {
			description = cname.." Coral",
			drawtype = "plantlike_rooted",
			waving = 1,
			paramtype = "light",
			tiles = {"default_coral_skeleton.png"},
			special_tiles = {{name = "seacoral_coral"..color..".png", tileable_vertical = true}},
			inventory_image = "seacoral_coral"..color..".png",
			groups = {snappy = 3, seacoral = 1},
			selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
				},
			},
			node_dig_prediction = "default:coral_skeleton",
			node_placement_prediction = "",
			sounds = default.node_sound_stone_defaults(
				{
					dig = {name = "default_dig_snappy", gain = 0.2},
					dug = {name = "default_grass_footstep", gain = 0.25},
				}),

			on_place = function(itemstack, placer, pointed_thing)
				if pointed_thing.type ~= "node" or not placer then
					return itemstack
				end

				local player_name = placer:get_player_name()
				local pos_under = pointed_thing.under
				local pos_above = pointed_thing.above

				if minetest.get_node(pos_under).name ~= "default:coral_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
					return itemstack
				end

				if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
					minetest.chat_send_player(player_name, "Node is protected")
					minetest.record_protection_violation(pos_under, player_name)
					return itemstack
				end

				minetest.set_node(pos_under, {name = "seacoral:coral"..color})
				if not (creative and creative.is_enabled_for(player_name)) then
					itemstack:take_item()
				end

				return itemstack
			end,

			after_destruct = function(pos, oldnode)
				minetest.set_node(pos, {name = "default:coral_skeleton"})
			end,
})

	-- Replace Old seacorals with new defined ones
	minetest.register_alias("seacoral:coral"..color, "default:water_source")
	minetest.register_alias("seacoral:seacoralsand"..color, "seacoral:coral_"..color)
	minetest.register_alias("seacoral:seacoraldirt"..color, "seacoral:coral_"..color)
end

-- Replace cyan, redviolet, lime seacorals with default Minetest's ones
minetest.register_alias("seacoral:coralcyan", "default:water_source")
minetest.register_alias("seacoral:seacoralsandcyan", "default:coral_cyan")
minetest.register_alias("seacoral:seacoraldirtcyan", "default:coral_cyan")
add_group("default:coral_cyan", "seacoral", 1)

minetest.register_alias("seacoral:coralredviolet", "default:water_source")
minetest.register_alias("seacoral:seacoralsandredviolet", "default:coral_pink")
minetest.register_alias("seacoral:seacoraldirtredviolet", "default:coral_pink")
add_group("default:coral_pink", "seacoral", 1)

minetest.register_alias("seacoral:corallime", "default:water_source")
minetest.register_alias("seacoral:seacoralsandlime", "default:coral_green")
minetest.register_alias("seacoral:seacoraldirtlime", "default:coral_green")
add_group("default:coral_green", "seacoral", 1)

-- CRAFTING

if not minetest.get_modpath( "colormachine") then
	local register_seacoral_craft = function(output,recipe)
		minetest.register_craft(
			{
				type = 'shapeless',
				output = output,
				recipe = recipe,
			})
	end

	register_seacoral_craft('dye:cyan 4', {'default:coral_cyan'})
	register_seacoral_craft('dye:magenta 4', {'seacoral:coral_magenta'})
	register_seacoral_craft('dye:pink 4', {'default:coral_pink'})

	if minetest.get_modpath("unifieddyes") then
		register_seacoral_craft('dye:lime 4', {'default:coral_green'})
		register_seacoral_craft('dye:spring 4', {'seacoral:coral_aqua'})
		register_seacoral_craft('dye:azure 4', {'seacoral:coral_skyblue'})
	end
end

-- SEACORAL SAND AND DIRT GENERATION

-- Coral reef

minetest.register_decoration(
	{
		name = "seacoral:corals",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7014,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {
			"desert_ocean",
			"savanna_ocean",
			"rainforest_ocean",
		},
		y_max = -2,
		y_min = -8,
		flags = "force_placement",
		decoration = {
			"seacoral:coral_magenta", "default:coral_orange",
			"seacoral:coral_aqua", "default:coral_brown",
			"seacoral:coral_skyblue", "default:coral_skeleton",
			"default:coral_green", "default:coral_pink",
			"default:coral_cyan"
		},
	})

-- ABM'S

minetest.register_abm(
	{
		nodenames = {"group:seacoral"},
		interval = 3,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
			local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
			if ((minetest.get_node(yp).name == "default:water_source" or
					  minetest.get_node(yp).name == "noairblocks:water_sourcex") and
					 (minetest.get_node(yyp).name == "default:water_source" or
					  minetest.get_node(yyp).name == "noairblocks:water_sourcex")) then
				local objs = minetest.get_objects_inside_radius(pos, 2)
				for k, obj in pairs(objs) do
					obj:set_hp(obj:get_hp()+ 1)
				end
			else
				return
			end
		end
	})


-- OPTIONAL DEPENDENCY


if minetest.get_modpath( "colormachine") then
	colormachine.basic_dye_sources  = { "flowers:rose", "flowers:tulip", "flowers:dandelion_yellow", "default:coral_green", "default:cactus", "seacoral:coral_aqua", "default::coral_cyan", "seacoral:coral_skyblue", "flowers:geranium", "flowers:viola", "seacoral:coral_magenta", "default:coral_pink", "default:stone", "", "", "", "default:coal_lump" };
	else
	return
end


-- ALIASES


minetest.register_alias("seadye:cyan","dye:cyan")
minetest.register_alias("seadye:magenta","dye:magenta")
minetest.register_alias("seadye:lime","dye:lime")
minetest.register_alias("seadye:aqua","dye:spring")
minetest.register_alias("seadye:skyblue","dye:azure")
minetest.register_alias("seadye:redviolet","dye:pink")

minetest.log("action", "[sea - seacoral] loaded.")
