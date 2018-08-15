-------------------------------------------------------------------------------
-- allows mobs to use furniture for sitting/lying on them
-------------------------------------------------------------------------------
-- * recognizes bences, chairs, armchairs and toilets as things to sit on (from cottages, 3dforniture and homedecor)
-- * acceptable beds come from cottages, papyrus_bed, beds and colouredbeds



mob_sitting = {}

-- let the entity entity sleep on the bed at position t_pos (rotated according to pos.p2 or node.param2)
mob_sitting.sleep_on_bed = function( self, pos )
	if( not( self ) or not( self.object ) or not( pos )) then
		return;
	end
	-- copy target position because we will slightly adjust it
	local t_pos = {x=pos.x, y=pos.y, z=pos.z, p2 = pos.p2};
	local param2 = pos.p2;
	if( not( pos.p2 )) then
		local node = minetest.get_node( pos );
		param2 = node.param2;
	end

	-- store in the mob data that the mob is sleeping here (else he would be standing
	-- after next initialization)
	self.trader_uses = {x=t_pos.x, y=t_pos.y, z=t_pos.z, p2 = param2};
	self.trader_does = 'sleep';

	local yaw = 0;
	if( param2==0 ) then
		yaw = 180; --270; 
		t_pos.z = t_pos.z - 0.5; 
	elseif( param2==1 ) then
		yaw = 90; --180; 
		t_pos.x = t_pos.x - 0.5; 
	elseif( param2==2 ) then
		yaw = 0; --90; 
		t_pos.z = t_pos.z + 0.5; 
	elseif( param2==3 ) then
		yaw = 270; --0; 
		t_pos.x = t_pos.x + 0.5; 
	end
	-- rotate the npc in the right direction
	self.object:set_yaw( math.rad( yaw ));
	-- move the entity on the furniture; the entity has already been rotated accordingly
	self.object:set_pos( {x=t_pos.x, y=t_pos.y+1.1,z=t_pos.z} );

	-- wield nothing
	mob_basics.update_texture( self, 'trader', {} );

	-- set sleep animation
	mob_sitting.set_animation( self, 'sleep' );
	return t_pos;
end



-- TODO: better place that in a more general mod...
mob_sitting.set_animation = function( entity, anim )
	local a = 0;   -- startframe of animation
	local b = 79;  -- endframe of animation
	local speed = 30; 
	if( anim=='stand' ) then
		a = 0;
		b = 79;
	elseif( anim=='sit' ) then
		a = 81;
		b = 148;
	elseif( anim=='sleep' ) then
		a = 164;
		b = 164;
	end
	entity.object:set_animation({x=a, y=b}, speed)
end
