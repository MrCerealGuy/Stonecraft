
-----------------------------------------------------------------------------------------------------
-- Allows to pick up a mob, carry him around in the player's inventory, and place the mob back
-----------------------------------------------------------------------------------------------------
-- uses mob_basics.find_mob_by_id and mob_basics.update_visual_size when available

-- TODO: add after_place, after_pickup?

-- the privilege allows admins/moderators to pick up and remove mobs which are undesired for whatever reason
minetest.register_privilege("mob_pickup",  { description = "allows to pick up mobs (which use mob_pickup) that are not your own", give_to_singleplayer = false});


-- namespace used for functions and variables of this part of the mod
mob_pickup = {}

-- find the right object for an entity so that a mob can be stored in the player's inventory after pickup
mob_pickup.entity_to_object_name = {}

mob_pickup.pickup_success_msg = {}

mob_pickup.place_success_msg = {}

-- this can hold functions (in a table) which deny the pickup of a mob; structure:
--    key:   entity name
--    value: function( self, player ) that gets an entity as parameter, returns '' on success; returns error message on failure
mob_pickup.deny_pickup = {}
-- if you want to deny placement - i.e. if there are already too many around or something like that; structure:
--    key:   entity name
--    value: function( data, pos, player ) that gets an entity name as parameter, returns '' on success; returns error message on failure
--                     data is minetest.deserialize( item[ "metadata" ]); pos is the position where the mob is to be placed
mob_pickup.deny_place  = {}


-----------------------------------------------------------------------------------------------------
-- We need to know something about the mobs and their corresponding items
-----------------------------------------------------------------------------------------------------
-- the "functions" parameter may contain the deny_* functions
mob_pickup.register_mob_for_pickup = function( entity_name, item_name, data )
	if( not( entity_name ) or not( item_name )) then
		return false;
	end
	-- has the mob been registered already?
	if( mob_pickup.entity_to_object_name[ entity_name ] ) then
		return false;
	end
	-- store which item the player will get when picking up the mob
	mob_pickup.entity_to_object_name[ entity_name ] = item_name;

	-- for animals, pickup might be denied if the player does not wield the appropriate lasso/cage/watever
	if( data and data.deny_pickup ) then
		mob_pickup.deny_pickup[ entity_name ] = data.deny_pickup;
	end

	if( data and data.deny_place ) then
		mob_pickup.deny_place[  entity_name ] = data.deny_place;
	end

	if( data and data.pickup_success_msg ) then
		mob_pickup.pickup_success_msg[ entity_name ] = data.pickup_success_msg;
	else
		mob_pickup.pickup_success_msg[ entity_name ] = 
			'Mob picked up. In order to use him again, just wield him and place him somewhere.';
	end

	if( data and data.place_success_msg ) then
		mob_pickup.place_success_msg[ entity_name  ] = data.place_success_msg;
	else
		mob_pickup.place_success_msg[ entity_name  ] = 
			'Mob placed.';
	end
end

-----------------------------------------------------------------------------------------------------
-- Log when someone picks up a mob or places one (in case there's debate of who removed or placed a mob)
-----------------------------------------------------------------------------------------------------
-- The position of the mob is important here; also who picked him up (might not always be the owner)
-- This is more or less a copy from mob_basics.log
mob_pickup.log = function( msg, self, prefix )
        if( self==nil ) then
                minetest.log("action", '[mob_pickup] '..tostring( msg ) );
        else
                minetest.log("action", '[mob_pickup] '..tostring( msg )..
                        ' id:'..tostring(               self[ prefix..'_id'] )..
                        ' typ:'..tostring(              self[ prefix..'_typ'] or '?' )..
                        ' prefix:'..tostring(           prefix or '?' )..
                        ' at:'..minetest.pos_to_string( self.object:get_pos() )..
                        ' by:'..tostring(               self[ prefix..'_owner'] )..'.');
        end
end
-----------------------------------------------------------------------------------------------------
-- pick the mob up and store in the players inventory;
-----------------------------------------------------------------------------------------------------
-- the mob's data will be saved and he can be placed at another location
-- NOTE: only mobs which are owned by the player can be picked up (unless the player has the mob_pickup priv)
mob_pickup.pick_mob_up = function( self, player, menu_path, prefix, is_personalized, stored_data )

	if( not( self ) or not( player ) or not(self.name)) then
		return;
	end

	local pname = player:get_player_name();

	-- check the privs again to be sure that there's no maliscious client input
	if( not( (self[ prefix..'_owner'] and self[ prefix..'_owner'] == pname)
	       or minetest.check_player_privs( pname, {mob_pickup=true}))) then

		minetest.chat_send_player( pname,
			'Error: You do not own this mob and do not have the mob_pickup priv. Taking failed.');
		return;
	end


	local staticdata = {};
	if( not( stored_data )) then
		staticdata = self:get_staticdata();
	else
		staticdata = stored_data;
	end

	-- deserialize to do some tests
	local staticdata_table = minetest.deserialize( staticdata );
	if(    not( staticdata_table[ prefix..'_name'] )
	    or not( staticdata_table[ prefix..'_id'  ] )
	    or not( staticdata_table[ prefix..'_typ' ] )) then

		minetest.chat_send_player( pname,
			'Error: This mob is misconfigured. Name, id or typ are missing. Please punch him in order to remove him.');
		return;
	end

	-- is picking this mob up allowed?
	local deny = mob_pickup.deny_pickup[ self.name ];
	if( not( stored_data ) and deny ) then
		local deny_msg = deny( self, player );
		if( deny_msg ~= '') then
			minetest.chat_send_player( pname,
				deny_msg );
			return;
		end
	end

	local mob_object_name = mob_pickup.entity_to_object_name[ self.name ];
	if( not( mob_object_name )) then
		minetest.chat_send_player( pname,
			'Error: This mob is unknown by mob_pickup. Taking failed.');
		return;
	end

	local player_inv = player:get_inventory();
	-- no point in doing more if the player can't take the mob due to too few space
	if( not( player_inv:room_for_item("main", mob_object_name ))) then 
		minetest.chat_send_player( pname,
			'Error: You do not have a free inventory slot for the mob. Taking failed.');
		return;
	end


	-- create a stack with a general mob item
	local mob_as_item = ItemStack( mob_object_name );

	-- turn that stack data into a form we can manipulate
	local item           = mob_as_item:to_table();
	-- the metadata field became available - it now stores the real data
	item[ "metadata" ]   = staticdata;
	-- save the changed table
	mob_as_item:replace( item );

	if( stored_data ) then
		minetest.chat_send_player( pname,
			'A copy of the mob has been dropped into your inventory.');
		-- put the copy of the mob into the players inventory
		player_inv:add_item( "main", mob_as_item );
		-- do not remove the mob
		return;
	end
	minetest.chat_send_player( pname,
		mob_pickup.pickup_success_msg[ self.name ] ); 

	mob_pickup.log( pname..' picked up', self, prefix ); 

	-- put the mob into the players inventory
	player_inv:add_item( "main", mob_as_item );
	-- remove the now obsolete mob
	self.object:remove();
	-- remove the mob from the stored list
	mob_basics.forget_mob( staticdata_table[ prefix..'_id'  ] );
end


-----------------------------------------------------------------------------------------------------
-- place the mob back into the world
-----------------------------------------------------------------------------------------------------
-- called from on_place: on_place = function( itemstack, placer, pointed_thing )
-- is_personalized has to be true for all mobs that carry metadata
mob_pickup.place_mob = function( itemstack, placer, pointed_thing, prefix, entity_name, is_personalized )
	if( not( placer )) then
		return itemstack;
	end
	local pname = placer:get_player_name();
	if( not( pointed_thing ) or pointed_thing.type ~= "node" ) then
		minetest.chat_send_player( pname,
			'Error: No node selected for mob to spawn on. Cannot spawn him.');
		return itemstack; 
	end

	local data = {};

	-- some mobs carry individual data (i.e. traders owned by players), wile others (i.e. animals) do not
	if( is_personalized ) then
		local item = itemstack:to_table();
		if( not( item[ "metadata"] ) or item["metadata"]=="" ) then
			minetest.chat_send_player( pname,
				'Error: Mob is not properly configured. Cannot spawn him.');
			return itemstack; 
		end

		data = minetest.deserialize( item[ "metadata" ]);
		if( not( data ) or data[ prefix..'_id'] == '') then
			minetest.chat_send_player( pname,
				'Error: Mob is misconfigured. Cannot spawn him.');
			return itemstack;
		end

		-- if there is already a mob with the same id, do not create a new one
		if( mob_basics and mob_basics.find_mob_by_id( data[ prefix..'_id'], prefix )) then

			minetest.chat_send_player( pname,
				'Error: A mob with that ID exists already. Please destroy this duplicate!');
			return itemstack;
		end
	end


	local pos  = minetest.get_pointed_thing_position( pointed_thing, false );

	-- does this particular mob want to be placed there?
	local deny = mob_pickup.deny_place[ entity_name ];
	if( deny ) then
		local deny_msg = deny( data, pos, placer );
		if( deny_msg ~= '' ) then
			minetest.chat_send_player( pname,
				deny_msg );
			return itemstack;
		end
	end

	-- spawn a mob
	local object = minetest.add_entity( {x=pos.x, y=(pos.y+1.5), z=pos.z}, entity_name );
	if( not( object )) then
		minetest.chat_send_player( pname,
			'Error: Spawning of mob failed.');
		return itemstack;
	end
			
	object:set_yaw( -1.14 );


	local self = object:get_luaentity();
	local tmp_id = self[ prefix..'_id'];

	-- transfer the data to the mob object
	for k,v in pairs( data ) do
		if( type( k )=='string' ) then
			local help = k:split( '_');
			if( help and #help>1 and help[1]==prefix ) then
				self[ k ] = v;
			end
		end
	end

	self[ prefix..'_animation' ] = 'stand';

	self.object:set_properties( { textures = { data[ prefix..'_texture'] }});
	if( mob_basics and mob_basics.update_visual_size ) then
		mob_basics.update_visual_size( self, data[ prefix..'_vsize'], false, prefix );
	end

	-- the mob was placed at a new location
	self[ prefix..'_pos']  = pos;

	minetest.chat_send_player( pname, mob_pickup.place_success_msg[ entity_name  ]);

	mob_pickup.log( pname..' placed', self, prefix ); 

	mob_basics.forget_mob( tmp_id );
	mob_basics.update( self, prefix ); -- store data about this placed mob
	return '';
end
