-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file compatibility.lua
--! @brief contains compatibility/transition code thats to be removed
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

minetest.register_abm({
		nodenames = { "animalmaterials:wool_white" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:white"})
		end

	})

minetest.register_abm({
		nodenames = { "animalmaterials:wool_grey" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:grey"})
		end

	})

minetest.register_abm({
		nodenames = { "animalmaterials:wool_brown" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:brown"})
		end

	})

minetest.register_abm({
		nodenames = { "animalmaterials:wool_black" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:black"})
		end

	})


minetest.register_entity("mobf:compat_spawner",
	{
		collisionbox    = {0,0,0,0,0,0},
		physical        = false,
		groups          = { "immortal" },
		on_activate     =
			function(self,staticdata,dtime_s)
				local pos = self.object:getpos()
				local delta,y_offset = adv_spawning.get_spawner_density()

				local spawnerpos = {
					x = math.floor(pos.x/delta) * delta,
					y = math.floor((pos.y-y_offset)/delta) * delta + y_offset,
					z = math.floor(pos.x/delta) * delta
					}

				local objects_at = minetest.get_objects_inside_radius(spawnerpos, 0.5)

				local found = false

				for i=1,#objects_at,1 do
					local luaentity = objects_at[i]:get_luaentity()

					if luaentity ~= nil then
						if luaentity.name == "adv_spawning:spawn_seed" then
							found = true
						end
					end
				end

				if not found then
					minetest.add_entity(spawnerpos,"adv_spawning:spawn_seed")
				end

				self.object:remove()
			end,
	})


-------------------------------------------------------------------------------
-- compatibility functions to make transition to new name easier
-------------------------------------------------------------------------------

function animals_add_animal(animal)
    mobf_add_mob(animal)
end