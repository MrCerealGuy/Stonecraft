-- 
-- CREATE ALL SPAWNERS NODES
-- 
function spawners_mobs.create(mob_table, idx)
	local mob_name = mob_table.name
	local mod_prefix = mob_table.mod_prefix
	local size = mob_table.dummy_size
	local mesh = mob_table.dummy_mesh
	local texture = mob_table.dummy_texture

	-- 
	-- DUMMY INSIDE THE SPAWNER
	-- 
	minetest.register_entity("spawners_mobs:dummy_"..mod_prefix.."_"..mob_name, {
		hp_max = 1,
		visual = "mesh",
		visual_size = size,
		collisionbox = {0,0,0,0,0,0},
		mesh = mesh,
		textures = texture,
		physical = false,
		makes_footstep_sound = false,
		automatic_rotate = math.pi * -3,
		static_save = false,

		on_activate = function(self, staticdata, dtime_s)
			self.object:setvelocity({x = 0, y = 0, z = 0})
			self.object:setacceleration({x = 0, y = 0, z = 0})
			self.object:set_armor_groups({immortal = 1})
		end
	})

	-- 
	-- DEFAULT SPAWNER
	-- 
	minetest.register_node("spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner", {
		description = mod_prefix.."_"..mob_name.." spawner",
		paramtype = "light",
		paramtype2 = "glasslikeliquidlevel",
		drawtype = "glasslike_framed_optional",
		walkable = true,
		sounds = default.node_sound_metal_defaults(),
		sunlight_propagates = true,
		tiles = {"spawners_mobs_spawner_16.png"},
		is_ground_content = false,
		groups = {cracky=1,level=2},
		stack_max = 1,
		light_source = 6,

		on_timer = spawners_mobs.on_timer,

		on_construct = function(pos)
			-- set meta
			local meta = minetest.get_meta(pos)
			meta:set_int("idx", idx)
			meta:set_int("tick", 0)
			meta:set_int("tick_short", 0)

			spawners_mobs.set_status(pos, "active")
			spawners_mobs.tick_short(pos)
		end,

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name())

			meta:set_string("infotext", mob_name.." spawner\nowner: "..placer:get_player_name().."\nspawner is active")
		end,

		on_destruct = function(pos)
			-- delete particles and remove dummy
			spawners_mobs.set_status(pos, "waiting")
		end
	})

	-- 
	-- WAITING SPAWNER
	-- 
	minetest.register_node("spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner_waiting", {
		description = mod_prefix.."_"..mob_name.." spawner waiting",
		paramtype = "light",
		paramtype2 = "glasslikeliquidlevel",
		drawtype = "glasslike_framed_optional",
		sounds = default.node_sound_metal_defaults(),
		walkable = true,
		sunlight_propagates = true,
		tiles = {
			{
				name = "spawners_mobs_spawner_waiting_animated_16.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0
				},
			}
		},
		is_ground_content = false,
		groups = {cracky=1,level=2,not_in_creative_inventory=1},
		light_source = 4,
		drop = "spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner",

		on_timer = spawners_mobs.on_timer
	})

	-- 
	-- RUSTY SPAWNER
	-- 
	minetest.register_node("spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner_rusty", {
		description = mod_prefix.."_"..mob_name.." spawner rusty",
		paramtype = "light",
		paramtype2 = "glasslikeliquidlevel",
		drawtype = "glasslike_framed_optional",
		sounds = default.node_sound_metal_defaults(),
		walkable = true,
		sunlight_propagates = true,
		tiles = {"spawners_mobs_spawner_rusty.png"},
		is_ground_content = false,
		groups = {cracky=1,level=2,not_in_creative_inventory=1},
		drop = "spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner"
	})

	-- 
	-- replacement LBM for pre-nodetimer spawners
	-- 
	minetest.register_lbm({
		name = "spawners_mobs:start_nodetimer_"..mod_prefix.."_"..mob_name.."_spawner",
		nodenames = "spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner",
		action = function(pos)
			spawners_mobs.tick_short(pos)
		end,
	})

	-- 
	-- COMPATIBILITY
	-- 
	minetest.register_alias("spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner_active", "spawners_mobs:"..mod_prefix.."_"..mob_name.."_spawner")
end

-- 
-- INIT 'CREATE' FOR ALL SPAWNERS
-- 
for i, mob_table in ipairs(spawners_mobs.mob_tables) do
	spawners_mobs.create(mob_table, i)
end
