-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file graphics.lua
--! @brief graphics related parts of mob
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(not core.global_exists("graphics"))
--! @class graphics
--! @brief graphic features
graphics = {}

-------------------------------------------------------------------------------
-- @function [parent=#graphics] init_dynamic_data(entity,velocity)
--
--! @brief initialize values required by graphics
--! @memberof graphics
--
--! @param entity mob initialize
--! @param now current time
-------------------------------------------------------------------------------
function graphics.init_dynamic_data(entity,now)
	local data = {
		last_scalar_speed = nil,
	}

	entity.dynamic_data.graphics = data
end

-------------------------------------------------------------------------------
-- @function [parent=#graphics] update(entity,now,dtime)
--
--! @brief callback for updating graphics of mob
--! @memberof graphics
--
--! @param entity mob to calculate direction
--! @param now current time
--! @param dtime current dtime
-------------------------------------------------------------------------------
function graphics.update(entity,now,dtime)


	--update animation speed
	--replaced by core function (if ever merged)
	--graphics.update_animation(entity,now,dtime)

	--update attention
	if  entity.dynamic_data ~= nil and
		entity.dynamic_data.attention ~= nil and
		entity.data.attention ~= nil and
		entity.dynamic_data.attention.most_relevant_target ~= nil and
		entity.data.attention.watch_threshold ~= nil and 
			(entity.dynamic_data.attention.current_value >
			entity.data.attention.watch_threshold) then
		dbg_mobf.graphics_lvl3("MOBF: attention mode orientation update")
		local direction = mobf_get_direction(entity.object:getpos(),
								entity.dynamic_data.attention.most_relevant_target:getpos())
		if entity.mode == "3d" then
			graphics.setyaw(entity,
				mobf_calc_yaw(direction.x,direction.z))
		else
			graphics.setyaw(entity,
				mobf_calc_yaw(direction.x,direction.z)+math.pi/2)
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#graphics] update_animation(entity,now,dtime)
--
--! @brief callback for updating graphics of mob
--! @memberof graphics
--
--! @param entity mob to calculate direction
--! @param now current time
--! @param dtime current dtime
-------------------------------------------------------------------------------
function graphics.update_animation(entity,now,dtime)
	if entity.dynamic_data.animation ~= nil then

		local animdata = entity.data.animation[entity.dynamic_data.animation]
		if animdata ~= nil and
			animdata.basevelocity ~= nil then

			local current_velocity = entity.object:getvelocity()
			local scalar_velocity = mobf_calc_scalar_speed(current_velocity.x,current_velocity.z)

			if entity.dynamic_data.graphics.last_scalar_speed ~= nil then
				local speeddiff =
					DELTA(scalar_velocity,
							entity.dynamic_data.graphics.last_scalar_speed)

				if speeddiff > 0.05 then
					local current_fps = scalar_velocity/animdata.basevelocity * 15

					entity.object:set_animation_speed(current_fps)

					entity.dynamic_data.graphics.last_scalar_speed = scalar_velocity
					entity.dynamic_data.graphics.last_fps = current_fps
				end
			else
				entity.dynamic_data.graphics.last_scalar_speed = scalar_velocity
			end
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#graphics] set_animation(entity,name)
--
--! @brief set the drawmode for an mob entity
--! @memberof graphics
--
--! @param entity mob to set drawmode for
--! @param name name of animation
-------------------------------------------------------------------------------
function graphics.set_animation(entity,name)

	if name == nil then
		dbg_mobf.graphics_lvl2("MOBF: calling updating animation without name for " .. entity.data.name)
		return
	end

	if entity.mode == "2d" then

		if id == "stand" then
			entity.object:setsprite({x=0,y=0}, 1, 0, true)
		end

		if name == "burning" then
			entity.object:setsprite({x=0,y=1}, 1, 0, true)
			return
		end

		--fallback
		entity.object:setsprite({x=0,y=0}, 1, 0, true)

		return
	end

	if entity.mode == "3d" then
		--TODO change frame rate due to movement speed
		dbg_mobf.graphics_lvl2("MOBF: " .. entity.data.name .. " updating animation: " .. name)
		if entity.data.animation ~= nil and
			name ~= nil and
			entity.data.animation[name] ~= nil and
			entity.dynamic_data.animation ~= name then

			dbg_mobf.graphics_lvl2("MOBF:\tSetting animation to " .. name
				.. " start: " .. entity.data.animation[name].start_frame
				.. " end: " .. entity.data.animation[name].end_frame)
			entity.object:set_animation({
											x=entity.data.animation[name].start_frame,
											y=entity.data.animation[name].end_frame
										},
										entity.data.animation[name].anim_speed,
										nil,
										entity.data.animation[name].basevelocity)
			entity.dynamic_data.animation = name
		end

		return
	end

	mobf_bug_warning(LOGLEVEL_WARNING,"MOBF BUG!!: invalid graphics mode specified "
		.. dump(entity.mode))

end

------------------------------------------------------------------------------
-- @function [parent=#graphics] graphics_by_statename(graphics2d,graphics3d)
--
--! @brief get graphics information
--! @memberof graphics
--
--! @param mob static data
--! @param statename name of state
--
--! @return grahphic information
-------------------------------------------------------------------------------
function graphics.graphics_by_statename(mob,statename)

	local dummyentity = { data = mob }

	local default_state = mob_state.get_state_by_name(dummyentity,"default")
	local selected_state = nil

	if statename == "default" then
		selected_state = default_state
	else
		selected_state = mob_state.get_state_by_name(dummyentity,statename)
	end

	if selected_state == nil then
		selected_state = default_state
	end

	if selected_state.graphics_3d == nil then
		selected_state.graphics_3d = default_state.graphics_3d
	end

	if selected_state.graphics == nil then
		selected_state.graphics = default_state.graphics
	end


	local setgraphics = {}

	if (selected_state.graphics_3d == nil) or
		minetest.world_setting_get("mobf_disable_3d_mode") then

		if (selected_state.graphics == nil) then
			--no idea if there is any legitimate reason for this
			mobf_print("state: " .. dump(selected_state))
			mobf_print("there ain't even 2d graphics available")
			return nil
		end

		local basename = modname .. name

		if statename ~= nil and
			statename ~= "default" then
			basename = basename .. "__" .. statename
		end

		setgraphics.collisionbox    =  {-0.5,
									-0.5 * selected_state.graphics.visible_height,
									-0.5,
									0.5,
									0.5 * selected_state.graphics.visible_height,
									0.5}
		if selected_state.graphics.visual ~= nil then
			selected_state.graphics.visual          = selected_state.graphics.visual
		else
			selected_state.graphics.visual          = "sprite"
		end
		setgraphics.textures        = { basename..".png^[makealpha:128,0,0^[makealpha:128,128,0" }
		setgraphics.visual_size     = selected_state.graphics.sprite_scale
		setgraphics.spritediv       = selected_state.graphics.sprite_div
		setgraphics.mode 			= "2d"
	else
		if selected_state.graphics_3d.visual == "mesh" then
			setgraphics.mesh = selected_state.graphics_3d.mesh
		end

		setgraphics.collisionbox    = selected_state.graphics_3d.collisionbox
		setgraphics.visual          = selected_state.graphics_3d.visual
		setgraphics.visual_size     = selected_state.graphics_3d.visual_size
		setgraphics.textures        = selected_state.graphics_3d.textures
		setgraphics.texturelist     = selected_state.graphics_3d.texturelist
		setgraphics.mode            = "3d"
		setgraphics.model_orientation_fix = selected_state.graphics_3d.model_orientation_fix
	end

	return setgraphics
end

------------------------------------------------------------------------------
-- @function [parent=#graphics] prepare_graphic_info(graphics2d,graphics3d)
--
--! @brief get graphics information
--! @memberof graphics
--
--! @param graphics2d
--! @param graphics3d
--! @param modname
--! @param name
--! @param statename
--! @return grahpic information
-------------------------------------------------------------------------------
function graphics.prepare_info(graphics2d,graphics3d,modname,name,statename)

	local setgraphics = {}

	if (graphics3d == nil) or
		minetest.world_setting_get("mobf_disable_3d_mode") then
		if (graphics2d == nil) then
			--this maybe correct if there's a state model requested!
			return nil
		end

		local basename = modname .. name

		if statename ~= nil and
			statename ~= "default" then
			basename = basename .. "__" .. statename
		end

		setgraphics.collisionbox    =  {-0.5,
									-0.5 * graphics2d.visible_height,
									-0.5,
									0.5,
									0.5 * graphics2d.visible_height,
									0.5}
		if graphics2d.visual ~= nil then
			setgraphics.visual          = graphics2d.visual
		else
			setgraphics.visual          = "sprite"
		end
		setgraphics.textures        = { basename..".png^[makealpha:128,0,0^[makealpha:128,128,0" }
		setgraphics.visual_size     = graphics2d.sprite_scale
		setgraphics.spritediv       = graphics2d.sprite_div
		setgraphics.mode 			= "2d"
	else
		if graphics3d.visual == "mesh" then
			setgraphics.mesh = graphics3d.mesh
		end

		setgraphics.collisionbox    = graphics3d.collisionbox --todo is this required for mesh?
		setgraphics.visual          = graphics3d.visual
		setgraphics.visual_size     = graphics3d.visual_size
		setgraphics.textures        = graphics3d.textures
		setgraphics.mode 			= "3d"
	end

	return setgraphics
end

------------------------------------------------------------------------------
-- @function [parent=#graphics] setyaw(entity,value)
--
--! @brief update yaw for a specific entity (overlay to workaround model bugs)
--! @memberof graphics
--
--! @param entity entity to set yaw for
--! @param value yaw value to set
-------------------------------------------------------------------------------
function graphics.setyaw(entity, value)

	local current_graphics = graphics.graphics_by_statename(entity.data,
			entity.dynamic_data.state.current.name)
	
	if current_graphics.model_orientation_fix ~= nil then
		value = value + current_graphics.model_orientation_fix
	end
	entity.object:setyaw(value)
end

------------------------------------------------------------------------------
-- @function [parent=#graphics] getyaw(entity,value)
--
--! @brief read yaw for this object, fix model offset
--! @memberof graphics
--
--! @param entity entity to set yaw for
--! @param value yaw value to set
-------------------------------------------------------------------------------
function graphics.getyaw(entity)

	local retval = 0
	local current_graphics = graphics.graphics_by_statename(entity.data,
			entity.dynamic_data.state.current.name)
	
	if current_graphics.model_orientation_fix ~= nil then
		retval = retval - current_graphics.model_orientation_fix
	end
	
	retval = retval + entity.object:getyaw()
	
	return retval
end