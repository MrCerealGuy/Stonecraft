
-- translation and mod check

local S = minetest.get_translator("ethereal")
local door_mod = minetest.get_modpath("doors")

-- fence registration helper (fence, rail, gate, mese post)

local function add_fence(name, node, desc, texture)

	if default.register_fence then

		default.register_fence("ethereal:fence_" .. name, {
			description = S(desc .. " Fence"),
			texture = texture .. ".png",
			material = "ethereal:" .. node,
			groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			sounds = default.node_sound_wood_defaults(),
			check_for_pole = true
		})
	end

	if default.register_fence_rail then

		default.register_fence_rail("ethereal:fence_rail_" .. name, {
			description = S(desc .. " Fence Rail"),
			texture = texture .. ".png",
			material = "ethereal:" .. node,
			groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			sounds = default.node_sound_wood_defaults()
		})
	end

	if door_mod and doors.register_fencegate then

		doors.register_fencegate("ethereal:fencegate_" .. name, {
			description = S(desc .. " Fence Gate"),
			texture = texture .. ".png",
			material = "ethereal:" .. node,
			groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
		})
	end

	if default.register_mesepost then

		default.register_mesepost("ethereal:mese_post_" .. name, {
			description = S(desc .. " Mese Post Light"),
			texture = texture .. ".png",
			material = "ethereal:" .. node
		})
	end
end

-- add wooden fences, gates and mese posts

add_fence("scorched", "scorched_tree", "Scorched", "ethereal_scorched_tree")
add_fence("frostwood", "frost_wood", "Frost", "ethereal_frost_wood")
add_fence("redwood", "redwood_wood", "Redwood", "ethereal_redwood_wood")
add_fence("willow", "willow_wood", "Willow", "ethereal_willow_wood")
add_fence("yellowwood", "yellow_wood", "Healing Wood", "ethereal_yellow_wood")
add_fence("palm", "palm_wood", "Palm", "moretrees_palm_wood")
add_fence("banana", "banana_wood", "Banana Wood", "ethereal_banana_wood")
add_fence("mushroom", "mushroom_trunk", "Mushroom", "ethereal_mushroom_trunk")
add_fence("birch", "birch_wood", "Birch", "moretrees_birch_wood")
add_fence("sakura", "sakura_wood", "Sakura", "ethereal_sakura_wood")
add_fence("olive", "olive_wood", "Olive", "ethereal_olive_wood")
add_fence("basandra", "basandra_wood", "Basandra", "ethereal_basandra_bush_wood")


-- add compatibility for previous ethereal gates

minetest.register_alias("ethereal:fencegate_wood_open", "doors:gate_wood_open")
minetest.register_alias("ethereal:fencegate_wood_closed", "doors:gate_wood_closed")
minetest.register_alias("ethereal:fencegate_acacia_open", "doors:gate_acacia_wood_open")
minetest.register_alias("ethereal:fencegate_acacia_closed", "doors:gate_acacia_wood_closed")
minetest.register_alias("ethereal:fencegate_junglewood_open", "doors:gate_junglewood_open")
minetest.register_alias("ethereal:fencegate_junglewood_closed", "doors:gate_junglewood_closed")
minetest.register_alias("ethereal:fencegate_pine_open", "doors:gate_pine_wood_open")
minetest.register_alias("ethereal:fencegate_pine_closed", "doors:gate_pine_wood_closed")

-- sakura door

if door_mod then

	doors.register("ethereal:door_sakura", {
		tiles = {
			{name = "ethereal_sakura_door.png", backface_culling = true}
		},
		description = S("Sakura Wood Door"),
		inventory_image = "ethereal_sakura_door_inv.png",
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		recipe = {
			{"group:stick", "default:paper"},
			{"default:paper", "group:stick"},
			{"ethereal:sakura_wood", "ethereal:sakura_wood"}
		}
	})

	minetest.register_alias("ethereal:sakura_door", "ethereal:door_sakura")
	minetest.register_alias("ethereal:sakura_door_a", "ethereal:door_sakura_a")
	minetest.register_alias("ethereal:sakura_door_b", "ethereal:door_sakura_b")
end
