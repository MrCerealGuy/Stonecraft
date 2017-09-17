-------------------------------------------------------------------------------
-- allows mobs to use beds
-------------------------------------------------------------------------------


-- let the entity sleep on the bed at position pos (rotated according to pos.p2 or node.param2)
mob_world_interaction.sleep_on_bed = function( entity, pos )
	if( not( entity ) or not( entity.object ) or not( pos )) then
		return;
	end
	-- copy target position because we will slightly adjust it
	local t_pos = {x=pos.x, y=pos.y, z=pos.z, p2 = pos.p2};
	local param2 = pos.p2;
	if( not( pos.p2 )) then
		local node = minetest.get_node( pos );
		param2 = node.param2;
	end

	-- adjust position so that the mob will fit into the bed
	local yaw = 0;
	if( param2==0 ) then
		yaw = 180;
		t_pos.z = t_pos.z - 0.5; 
	elseif( param2==1 ) then
		yaw = 90;
		t_pos.x = t_pos.x - 0.5; 
	elseif( param2==2 ) then
		yaw = 0;
		t_pos.z = t_pos.z + 0.5; 
	elseif( param2==3 ) then
		yaw = 270;
		t_pos.x = t_pos.x + 0.5; 
	end
	-- rotate the npc in the right direction
	entity.object:setyaw( math.rad( yaw ));
	-- move the entity on the furniture; the entity has already been rotated accordingly
	entity.object:setpos( {x=t_pos.x, y=t_pos.y+1.1,z=t_pos.z} );

	-- wield nothing
-- TODO: that is too specific...add more general function here
	mob_basics.update_texture( entity, 'trader', {} );

	-- set sleep animation
	mob_world_interaction.set_animation( entity, 'sleep' );

	-- store in the mob data that the mob is sleeping here (else he would be standing
	-- after next initialization)
-- TODO: this is highly mob-specific and needs to be saved
	entity.trader_uses = {x=pos.x, y=pos.y, z=pos.z, p2 = param2};
	entity.trader_does = 'sleep';

	return t_pos;
end
