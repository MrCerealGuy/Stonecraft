
-- non eatable craftitems

local function nssm_register_noneatcraftitems (name, descr)

	minetest.register_craftitem(":nssm:" .. name, {
		description = descr,
		inventory_image = name .. ".png",
	})
end

nssm_register_noneatcraftitems ("masticone_core", "Masticone Core")
nssm_register_noneatcraftitems ("berinhog_horn", "Berinhog Horn")
nssm_register_noneatcraftitems ("earth_heart", "Earth Heart")


minetest.register_craftitem(":nssm:cold_stars", {
	description = "Cold Stars",
	inventory_image = "cold_stars.png",

	on_place = function(itemstack, placer, pointed_thing)

		for i = 1, 33 do

			local pos1 = minetest.get_pointed_thing_position(pointed_thing, true)
			local dx = math.random(-20, 20)
			local dy = math.random(-3, 20)
			local dz = math.random(-20, 20)
			local pos1 = {x = pos1.x + dx, y = pos1.y + dy, z = pos1.z + dz}

			if not minetest.is_protected(pos1, "")
			or not minetest.get_item_group(
					minetest.get_node(pos1).name, "unbreakable") == 1 then

				minetest.set_node(pos1, {name="nssm:cold_star"})
			end
		end

		if not minetest.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end

		return itemstack
	end
})

-- nodes

minetest.register_node(":nssm:cold_star", {
	drawtype = "plantlike",
	tiles = {"cold_star.png"},
	light_source = 13,
	walkable = false,
	paramtype = "light",
	pointable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {not_in_creative_inventory = 1},
	drop = {},

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(400)
	end,

	on_timer = function(pos)
		minetest.remove_node(pos)
	end,

	on_blast = function() end,
})

minetest.register_node(":nssm:crystal_gas", {
	description = "Crystal Gas",
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	post_effect_color = {a = 1000, r = 1000, g = 1000, b = 1000},
	groups = {flammable = 2, not_in_creative_inventory = 1},
})

minetest.register_node(":nssm:slug_crystal", {
	description = "Slug Crystal",
	tiles = {"slug_crystal.png"},
	paramtype = "light",
	drawtype = "glasslike",
	drowning = 10,
	damage_per_second = 1,
	drop = "",
	post_effect_color = {a = 1000, r = 1000, g = 1000, b = 1000},
	light_source = 2,
	groups = {cracky = 1, not_in_creative_inventory = 1},
})

minetest.register_node(":nssm:coldest_ice", {
	description = "Coldest Ice",
	tiles = {"coldest_ice.png"},
	paramtype = "light",
	drowning = 2,
	damage_per_second = 1,
	drop = "",
	light_source = 3,
	groups = {cracky = 1, not_in_creative_inventory = 1},
})

minetest.register_node(":nssm:mud", {
	description = "Mud",
	inventory_image = "mude.png",
	tiles = {
		{
			name = "mud_animated.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 16.0
			}
		}
	},
	walkable = false,
	paramtype = "light",
	pointable = true,
	buildable_to = false,
	drop = "",
	drowning = 0,
	liquid_renewable = false,
	liquidtype = "source",
	liquid_range = 0,
	liquid_alternative_flowing = "nssm:mud",
	liquid_alternative_source = "nssm:mud",
	liquid_viscosity = 10,
	groups = {crumbly = 1, liquid = 1},
})

-- Abms

minetest.register_abm({
	nodenames = {"nssm:mud"},
	neighbors = {"air"},
	interval = 15,
	chance = 10,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)

		local vec={x = 1, y = 1, z = 1}
		local poslist = minetest.find_nodes_in_area(
				vector.subtract(pos, vec), vector.add(pos,vec), "group:water")

		if #poslist == 0 then
			minetest.set_node(pos, {name="default:dirt"})
		end
	end
})

minetest.register_abm({
	nodenames = {"nssm:crystal_gas"},
	interval = 1,
	chance = 4,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "nssm:slug_crystal"})
	end
})

minetest.register_abm({
	nodenames = {"nssm:slug_crystal"},
	interval = 20,
	chance = 3,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.remove_node(pos)
	end
})

-- Eggs (name, description, cannot catch)

nssm:register_egg("albino_spider", "Albino Spider")
nssm:register_egg("chog", "Chog")
nssm:register_egg("silversand_dragon", "Silversand Dragon", 1)
nssm:register_egg("tartacacia", "Tartacacia", 1)
nssm:register_egg("river_lord", "River Lord", 1)
nssm:register_egg("icelizard", "Icelizard")
nssm:register_egg("kele", "Kele")
nssm:register_egg("crystal_slug", "Crystal Slug")
nssm:register_egg("berinhog", "Berinhog")
nssm:register_egg("black_scorpion", "Black Scorpion")
nssm:register_egg("pumpkid", "Pumpkid")
nssm:register_egg("salamander", "Salamander")
nssm:register_egg("flust", "Flust")
nssm:register_egg("pelagia", "Pelagia")
