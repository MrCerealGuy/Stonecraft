--[[

2017-06-30 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("homedecor") then return end

local S = homedecor_i18n.gettext

screwdriver = screwdriver or {}

local function start_smoke(pos, node, clicker, chimney)
	local this_spawner_meta = minetest.get_meta(pos)
	local id = this_spawner_meta:get_int("smoky")
	local s_handle = this_spawner_meta:get_int("sound")
	local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name

	if id ~= 0 then
		if s_handle then
			minetest.after(0, function(handle)
				minetest.sound_stop(handle)
			end, s_handle)
		end
		minetest.delete_particlespawner(id)
		this_spawner_meta:set_int("smoky", nil)
		this_spawner_meta:set_int("sound", nil)
		return
	end

	if above == "air" and (not id or id == 0) then
		id = minetest.add_particlespawner({
			amount = 4, time = 0, collisiondetection = true,
			minpos = {x=pos.x-0.25, y=pos.y+0.4, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+5, z=pos.z+0.25},
			minvel = {x=-0.2, y=0.3, z=-0.2}, maxvel = {x=0.2, y=1, z=0.2},
			minacc = {x=0,y=0,z=0}, maxacc = {x=0,y=0.5,z=0},
			minexptime = 1, maxexptime = 3,
			minsize = 4, maxsize = 8,
			texture = "smoke_particle.png",
		})
		if chimney == 1 then
			this_spawner_meta:set_int("smoky", id)
			this_spawner_meta:set_int("sound", nil)
		else
			s_handle = minetest.sound_play("fire_small", {
				pos = pos,
				max_hear_distance = 5,
				loop = true
			})
			this_spawner_meta:set_int("smoky", id)
			this_spawner_meta:set_int("sound", s_handle)
		end
	end
end

local function stop_smoke(pos)
	local this_spawner_meta = minetest.get_meta(pos)
	local id = this_spawner_meta:get_int("smoky")
	local s_handle = this_spawner_meta:get_int("sound")

	if id ~= 0 then
		minetest.delete_particlespawner(id)
	end

	if s_handle then
		minetest.after(0, function(handle)
			minetest.sound_stop(handle)
		end, s_handle)
	end

	this_spawner_meta:set_int("smoky", nil)
	this_spawner_meta:set_int("sound", nil)
end

minetest.register_node("fake_fire:ice_fire", {
	inventory_image = "ice_fire_inv.png",
	description = S("Ice fire"),
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	sunlight_propagates = true,
	buildable_to = true,
	walkable = false,
	light_source = 14,
	waving = 1,
	tiles = {
		{name="ice_fire_animated.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=1.5}},
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		start_smoke(pos, node, clicker)
		return itemstack
	end,
	on_destruct = function (pos)
		stop_smoke(pos)
		minetest.sound_play("fire_extinguish", {
			pos = pos, max_hear_distance = 5
		})
	end,
	drop = ""
})

minetest.register_alias("fake_fire:fake_fire", "fire:permanent_flame")

minetest.register_node("fake_fire:fancy_fire", {
		inventory_image = "fancy_fire_inv.png",
		description = S("Fancy Fire"),
		drawtype = "mesh",
		mesh = "fancy_fire.obj",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {dig_immediate=3},
		sunlight_propagates = true,
		light_source = 14,
		walkable = false,
		damage_per_second = 4,
		on_rotate = screwdriver.rotate_simple,
		tiles = {
		{name="fake_fire_animated.png",
		animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}, {name='fake_fire_logs.png'}},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			start_smoke(pos, node, clicker)
			return itemstack
		end,
		on_destruct = function (pos)
			stop_smoke(pos)
			minetest.sound_play("fire_extinguish", {
				pos = pos, max_hear_distance = 5
			})
		end,
		drop = {
			max_items = 3,
			items = {
				{
					items = { "default:torch", "default:torch", "building_blocks:sticks" },
					rarity = 1,
				}
			}
		}
	})

-- EMBERS
minetest.register_node("fake_fire:embers", {
    description = S("Glowing Embers"),
	tiles = {
		{name="embers_animated.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
	},
	light_source = 9,
	groups = {crumbly=3},
	paramtype = "light",
	sounds = default.node_sound_dirt_defaults(),
})

-- CHIMNEYS
local materials = {
	{ "stone",     S("Stone chimney top") },
	{ "sandstone", S("Sandstone chimney top") },
}

for _, mat in ipairs(materials) do
	local name, desc = unpack(mat)
	minetest.register_node("fake_fire:chimney_top_"..name, {
		description = desc,
		tiles = {"default_"..name..".png^chimney_top.png", "default_"..name..".png"},
		groups = {snappy=3},
		paramtype = "light",
		sounds = default.node_sound_stone_defaults(),
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local chimney = 1
			start_smoke(pos, node, clicker, chimney)
			return itemstack
		end,
		on_destruct = function (pos)
			stop_smoke(pos)
		end
	})

	minetest.register_craft({
		type = "shapeless",
		output = 'fake_fire:chimney_top_'..name,
		recipe = {"default:torch", "stairs:slab_"..name}
	})
end

minetest.register_alias("fake_fire:flint_and_steel", "fire:flint_and_steel")

minetest.override_item("default:ice", {
	on_ignite = function(pos, igniter)
		local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(flame_pos).name == "air" then
			minetest.set_node(flame_pos, {name = "fake_fire:ice_fire"})
		end
	end
})

-- CRAFTS

minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:embers',
	recipe = {"default:torch", "group:wood", "default:torch"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:fancy_fire',
	recipe = {"default:torch", "building_blocks:sticks", "default:torch" }
})

-- ALIASES
minetest.register_alias("fake_fire:smokeless_fire", "fake_fire:fake_fire")
minetest.register_alias("fake_fire:smokeless_ice_fire", "fake_fire:ice_fire")
minetest.register_alias("fake_fire:smokeless_chimney_top_stone", "fake_fire:chimney_top_stone")
minetest.register_alias("fake_fire:smokeless_chimney_top_sandstone", "fake_fire:chimney_top_sandstone")
minetest.register_alias("fake_fire:flint", "fake_fire:flint_and_steel")
