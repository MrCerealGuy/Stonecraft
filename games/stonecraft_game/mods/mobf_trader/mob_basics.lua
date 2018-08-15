
------------------------------------------------------------------------------------------------------
-- Provides basic mob functionality:
------------------------------------------------------------------------------------------------------
-- * handles formspec input of a mob 
-- * allows configuration of the mob
-- * adds spawn command
-- * initializes a mob
-- * helper functions (i.e. turn towards player)
-- * data of *active* traders (those that stand around somewhere in the world; excluding those in 
--   inventories in players or chests) is stored
------------------------------------------------------------------------------------------------------

minetest.register_privilege("mob_basics_spawn", { description = "allows to spawn mob_basic based mobs with a chat command (i.e. /trader)", give_to_singleplayer = false});

-- reserve namespace for basic mob operations
mob_basics = {}

-- store information about the diffrent mobs
mob_basics.mob_types = {}

-- if you want to add a new texture, do it here
mob_basics.TEXTURES = {'kuhhaendler.png', 'bauer_in_sonntagskleidung.png', 'baeuerin.png', 'character.png', 'wheat_farmer_by_addi.png', 'tomatenhaendler.png', 'blacksmith.png',
			'holzfaeller.png' };
-- further good looking skins:
--mob_basics.TEXTURES = {'kuhhaendler.png', 'bauer_in_sonntagskleidung.png', 'baeuerin.png', 'character.png', 'wheat_farmer_by_addi.png',
--			"pawel04z.png", "character.png", "skin_2014012302322877138.png",
--			"6265356020613120.png","4535914155999232.png","6046371190669312.png","1280435.png"};

-- TODO: gather textures from installed skin mods?


-- keep a list of all mobs that are handled by this mod
mob_basics.known_mobs = {}

-- this is a list of the indices of mob_basics.known_mobs needed for the /moblist command
mob_basics.mob_list = {};

-----------------------------------------------------------------------------------------------------
-- Logging is important for debugging
-----------------------------------------------------------------------------------------------------
mob_basics.log = function( msg, self, prefix )
	if( self==nil ) then
		minetest.log("action", '[mob_basics] '..tostring( msg ) );
	else
		minetest.log("action", '[mob_basics] '..tostring( msg )..
			' id:'..tostring(               self[ prefix..'_id'] )..
			' typ:'..tostring(              self[ prefix..'_typ'] or '?' )..
			' prefix:'..tostring(           prefix or '?' )..
			' at:'..minetest.pos_to_string( self.object:get_pos() )..
			' by:'..tostring(               self[ prefix..'_owner'] )..'.');
	end
end


-----------------------------------------------------------------------------------------------------
-- Save mob data to a file
-----------------------------------------------------------------------------------------------------
-- TODO: save and restore ought to be library functions and not implemented in each individual mod!
mob_basics.save_data = function()

	local data = minetest.serialize( mob_basics.known_mobs );
	local path = minetest.get_worldpath().."/mod_mob_basics.data";

	local file = io.open( path, "w" );
	if( file ) then
		file:write( data );
		file:close();
	else
		print("[Mod mob_basics] Error: Savefile '"..tostring( path ).."' could not be written.");
	end
end


-----------------------------------------------------------------------------------------------------
-- restore data
-- Note: At first start, there will be a complaint about missing savefile. That message can be ignored.
-----------------------------------------------------------------------------------------------------
mob_basics.restore_data = function()

	local path = minetest.get_worldpath().."/mod_mob_basics.data";

	local file = io.open( path, "r" );
	if( file ) then
		local data = file:read("*all");
		mob_basics.known_mobs = minetest.deserialize( data );
		file:close();

		-- this is also a good time to create a list of all mobs which is used for /moblist
		mob_basics.mob_list = {};
		for k,v in pairs( mob_basics.known_mobs ) do
			table.insert( mob_basics.mob_list, k );
		end
	else
		print("[Mod mob_basics] Error: Savefile '"..tostring( path ).."' not found.");
	end
end

-- read information about known mob entities from a savefile
-- (do this once at each startup)
mob_basics.restore_data();


-----------------------------------------------------------------------------------------------------
-- A new mob has been added or a mob has been changed (i.e. new trade goods added)
-----------------------------------------------------------------------------------------------------
mob_basics.update = function( self, prefix )
	if( not( self )) then
		return;
	end
	-- make sure we save the current position
	self[ prefix..'_pos' ] = self.object:get_pos();

	local staticdata = self:get_staticdata();

	-- deserialize to do some tests
	local staticdata_table = minetest.deserialize( staticdata );
	if(    not( staticdata_table[ prefix..'_name'] )
	    or not( staticdata_table[ prefix..'_id'  ] )
	    or not( staticdata_table[ prefix..'_typ' ] )) then
                return;
        end

	-- if it is a new mob, register it in the list
	if( not( mob_basics.known_mobs[ staticdata_table[ prefix..'_id'  ] ] )) then
		table.insert( mob_basics.mob_list, staticdata_table[ prefix..'_id'  ] );
	end
	mob_basics.known_mobs[ staticdata_table[ prefix..'_id'  ] ] = staticdata_table;

	-- actually store the changed data
	mob_basics.save_data();
--minetest.chat_send_player('singleplayer','UPDATING MOB '..tostring( self[ prefix..'_id'] )); 
end


-----------------------------------------------------------------------------------------------------
-- Data about mobs that where picked up and are stored in the player's inventory is not saved here;
-- Those mobs need to be forgotten.
-----------------------------------------------------------------------------------------------------
mob_basics.forget_mob = function( id )
	mob_basics.known_mobs[ id ] = nil;
	mob_basics.save_data();
--minetest.chat_send_player('singleplayer','FORGETTING MOB '..tostring( id )); 
	-- the mob does *not* get deleted out of mob_basics.known_mobs because that would screw up the list
end
	

-----------------------------------------------------------------------------------------------------
-- return a list of all known mob types which use prefix 
-----------------------------------------------------------------------------------------------------
mob_basics.type_list_for_prefix = function( prefix )
	local list = {};
	if( not( prefix ) or not( mob_basics.mob_types[ prefix ] )) then
		return list;
	end
	for k,v in pairs( mob_basics.mob_types[ prefix ] ) do
		table.insert( list, k );
	end
	return list;
end



-----------------------------------------------------------------------------------------------------
-- return the mobs owned by pname
-----------------------------------------------------------------------------------------------------
-- if prefix is nil, then all mobs owned by the player will be returned
mob_basics.mob_id_list_by_player = function( pname, search_prefix )
	local res = {};
		
	if( not( pname )) then
		return res;
	end
	for k,v in ipairs( mob_basics.mob_list ) do

		local data = mob_basics.known_mobs[ v ];
		if( data ) then

			local prefix = data['mob_prefix'];
			if( (not( search_prefix ) or search_prefix == prefix)
				and data[ prefix..'_owner']
				and data[ prefix..'_owner']==pname ) then
				table.insert( res, v );
			end
		end
	end
	return res;
end



-----------------------------------------------------------------------------------------------------
-- idea taken from npcf
-----------------------------------------------------------------------------------------------------
mob_basics.find_mob_by_id = function( id, prefix )

	if( not( id )) then
		return;
	end

	for i, v in pairs( minetest.luaentities ) do
		if( v.object and v[ prefix..'_typ'] and v[ prefix..'_id'] and v[ prefix..'_id'] == id ) then
			return v;
		end
	end
end


-----------------------------------------------------------------------------------------------------
-- helper function that lets the mob turn towards a target; taken from npcf
-----------------------------------------------------------------------------------------------------
mob_basics.get_face_direction = function(v1, v2)
        if v1 and v2 then
                if v1.x and v2.x and v1.z and v2.z then
                        local dx = v1.x - v2.x
                        local dz = v2.z - v1.z
                        return math.atan2(dx, dz)
                end
        end
end
-----------------------------------------------------------------------------------------------------
-- turn towards the player
-----------------------------------------------------------------------------------------------------
mob_basics.turn_towards_player = function( self, player )
	if( self.object and self.object.set_yaw ) then
		self.object:set_yaw( mob_basics.get_face_direction( self.object:get_pos(), player:get_pos() ));
	end
end



-----------------------------------------------------------------------------------------------------
-- the mobs can vary in height and width
-----------------------------------------------------------------------------------------------------
-- create pseudoradom gaussian distributed numbers
mob_basics.random_number_generator_polar = function()
	local u = 0;
	local v = 0;
	local q = 0;
	repeat
		u = 2 * math.random() - 1;
		v = 2 * math.random() - 1;
		q = u * u + v * v
	until( (0 < q) and (q < 1));

	local p = math.sqrt(-2 * math.log(q) / q) -- math.log returns ln(q)
	return {x1 = u * p, x2 = v * p };
end

-----------------------------------------------------------------------------------------------------
-- visual_size needs to be updated whenever changed or the mob is activated
-----------------------------------------------------------------------------------------------------
-- called whenever changed/configured;
-- called from the entity itself in on_activate;
-- standard size is assumed to be 180 cm
mob_basics.update_visual_size = function( self, new_size, generate, prefix )
	if( not( new_size ) or not( new_size.x )) then
		if( generate ) then
			local res = mob_basics.random_number_generator_polar();
			local width  = 1.0+(res.x1/20.0);
			local height = 1.0+(res.x2/10.0);
			width  = math.floor( width  * 100 + 0.5 );
			height = math.floor( height * 100 + 0.5 );
			new_size = {x=(width/100.0), y=(height/100.0), z=(width/100.0)};
		else
			new_size = {x=1, y=1, z=1};
		end
	end
	if( not( self[ prefix..'_vsize'] ) or not(self[ prefix..'_vsize'].x)) then
		self[ prefix..'_vsize'] = {x=1, y=1, z=1};
	end
	self[ prefix..'_vsize'].x = new_size.x;
	self[ prefix..'_vsize'].y = new_size.y;
	self[ prefix..'_vsize'].z = new_size.z;
	self.object:set_properties( { visual_size  = {x=self[ prefix..'_vsize'].x, y=self[ prefix..'_vsize'].y, z=self[ prefix..'_vsize'].z}});
end


-----------------------------------------------------------------------------------------------------
-- configure a mob using a formspec menu
-----------------------------------------------------------------------------------------------------
mob_basics.config_mob = function( self, player, menu_path, prefix, formname, fields )

	local mob_changed = false; -- do we need to store the changes? There might be multiple changes in one go

	-- change texture
	if( menu_path and #menu_path>3 and menu_path[2]=='config' and menu_path[3]=='texture' ) then
		local nr = tonumber( menu_path[4] );
		-- actually set the new texture
		if( nr and nr > 0 and nr <= #mob_basics.TEXTURES ) then
			self[ prefix..'_texture'] = mob_basics.TEXTURES[ nr ];
			mob_basics.update_texture( self, prefix, nil );
		end
		mob_changed = true;

	-- change animation (i.e. sit, walk, ...)
	elseif( menu_path and #menu_path>3 and menu_path[2]=='config' and menu_path[3]=='anim' ) then
		self[ prefix..'_animation'] = menu_path[4];
		self.object:set_animation({x=self.animation[ self[ prefix..'_animation']..'_START'], y=self.animation[ self[ prefix..'_animation']..'_END']},
				self.animation_speed-5+math.random(10));
		mob_changed = true;
	end

	
	-- texture and animation are changed via buttons; the other options use input fields
	-- prepare variables needed for the size of the mob and the actual formspec
	local formspec = 'size[10,8]'; 
	fields['MOBheight'] = tonumber( fields['MOBheight']);
	fields['MOBwidth']  = tonumber( fields['MOBwidth']);

	if( not( self[ prefix..'_vsize'] ) or not( self[ prefix..'_vsize'].x )) then
		self[ prefix..'_vsize'] = {x=1,y=1,z=1};
	end
	-- rename a mob
	if( fields['MOBname'] and fields['MOBname'] ~= "" and fields['MOBname'] ~= self[ prefix..'_name'] ) then

		if( string.len(fields['MOBname']) < 2 or string.len(fields['MOBname']) > 40 ) then
			minetest.chat_send_player( player:get_player_name(),
				"Sorry. This name is not allowed. The name has to be between 2 and 40 letters long.");
		elseif( not( fields['MOBname']:match("^[A-Za-z0-9%_%-% ]+$"))) then
			minetest.chat_send_player( player:get_player_name(),
				"Sorry. The name may only contain letters, numbers, _, - and blanks.");
		elseif( minetest.check_player_privs( fields['MOBname'], {shout=true})) then
			minetest.chat_send_player( player:get_player_name(),
				"Sorry. The name may not be the same as that one of a player.");
		else
			minetest.chat_send_player( player:get_player_name(),
				'Your mob has been renamed from \"'..tostring( self[ prefix..'_name'] )..'\" to \"'..
				fields['MOBname']..'\".');
			self[ prefix..'_name'] = fields['MOBname'];
			formspec = formspec..'label[3.0,1.5;Renamed successfully.]';
			mob_changed = true;
		end

	-- height has to be at least halfway reasonable
	elseif( fields['MOBheight'] and fields['MOBheight']>20 and fields['MOBheight']<300 
		and (fields['MOBheight']/180.0)~=self[ prefix..'_vsize'].y ) then

		local new_height = math.floor((fields['MOBheight']/1.8) +0.5)/100.0;
		mob_basics.update_visual_size( self, {x=self[ prefix..'_vsize'].x, y=new_height, z=self[ prefix..'_vsize'].z}, false, prefix );
		formspec = formspec..'label[3.0,1.5;Height changed to '..tostring( self[ prefix..'_vsize'].y*180)..' cm.]';
		mob_changed = true;

	-- width (x and z direction) has to be at least halfway reasonable
	elseif( fields['MOBwidth'] and fields['MOBwidth']>50 and fields['MOBwidth']<150 
		and (fields['MOBwidth']/100.0)~=self[ prefix..'_vsize'].x ) then

		local new_width  = math.floor(fields['MOBwidth'] +0.5)/100.0;
		mob_basics.update_visual_size( self, {x=new_width, y=self[ prefix..'_vsize'].y, z=new_width}, false, prefix );
		formspec = formspec..'label[3.0,1.5;Width changed to '..tostring( self[ prefix..'_vsize'].x*100)..'%.]';
		mob_changed = true;
	end

	-- save only if there where any actual changes
	if( mob_changed ) then
		mob_basics.update( self, prefix );
	end

	local npc_id = self[ prefix..'_id'];
	formspec = formspec..
		'label[3.0,0.0;Configure your mob]'..
		'label[0.0,0.5;Activity:]'..
		'button[1.5,0.6;1,0.5;'..npc_id..'_config_anim_stand;*stand*]'..
		'button[2.5,0.6;1,0.5;'..npc_id..'_config_anim_sit;*sit*]'..
		'button[3.5,0.6;1,0.5;'..npc_id..'_config_anim_sleep;*sleep*]'..
		'button[4.5,0.6;1,0.5;'..npc_id..'_config_anim_walk;*walk*]'..
		'button[5.5,0.6;1,0.5;'..npc_id..'_config_anim_mine;*mine*]'..
		'button[6.5,0.6;1,0.5;'..npc_id..'_config_anim_walkmine;*w&m*]'..
		'label[0.0,1.0;Name of the mob:]'..
		'field[3.0,1.5;3.0,0.5;MOBname;;'..( self[ prefix..'_name'] or '?' )..']'..
		'label[5.8,1.0;Height:]'..
		'field[6.8,1.5;0.9,0.5;MOBheight;;'..( self[ prefix..'_vsize'].y*180)..']'..
		'label[7.2,1.0;cm]'..
		'label[5.8,1.5;Width:]'..
		'field[6.8,2.0;0.9,0.5;MOBwidth;;'..( (self[ prefix..'_vsize'].x*100) or '100' )..']'..
		'label[7.2,1.5;%]'..
		'label[0.0,1.6;Select a texture:]'..
		'button_exit[7.5,0.2;2,0.5;'..npc_id..'_take;Take]'..
		'button[7.5,0.7;2,0.5;'..npc_id..'_main;Back]'..
		'button[7.5,1.2;2,0.5;'..npc_id..'_config_store;Store]';

	-- list available textures and mark the currently selected one
	for i,v in ipairs( mob_basics.TEXTURES ) do
		local label = '';
		if( v==self[ prefix..'_texture'] ) then
			label = 'current';
		end
		formspec = formspec..
			'image_button['..tostring(((i-1)%8)*1.1-1.0)..','..tostring(math.ceil((i-1)/8)*1.1+1.2)..
					';1.0,1.0;'..v..';'..npc_id..'_config_texture_'..tostring(i)..';'..label..']';
	end

	-- show the resulting formspec to the player
	minetest.show_formspec( player:get_player_name(), formname, formspec );
end





-----------------------------------------------------------------------------------------------------
-- formspec input received
-----------------------------------------------------------------------------------------------------
mob_basics.form_input_handler = function( player, formname, fields)

	if( formname and formname == "mob_basics:mob_list" ) then
		mob_basics.mob_list_formspec( player, formname, fields );
		return;
	end
	-- are we responsible to handle this input?
	if( not( formname ) or formname ~= "mob_trading:trader" ) then -- TODO
		return false;
	end

-- TODO: determine prefix from formname
	local prefix = 'trader';

	-- all the relevant information is contained in the name of the button that has
	-- been clicked on: npc-id, selections
	for k,v in pairs( fields ) do

		if( k == 'quit' and #fields==1) then
			return true;
		end

		-- all values are seperated by _
		local menu_path = k:split( '_');
		if( menu_path and #menu_path > 0 ) then
			-- find the mob object
			local self = mob_basics.find_mob_by_id( menu_path[1], prefix );
			if( self ) then
				if( #menu_path == 1 ) then
					menu_path = nil;
				end

				-- pick the mob up
				if( v=='Take' ) then 
					if( mob_pickup and mob_pickup.pick_mob_up ) then
						-- all these mobs do have a unique id and are personalized, so the parameter before the last one is true
						-- we really want to pick up the mob - so the very last parameter is nil (not only a copy)
						mob_pickup.pick_mob_up(   self, player, menu_path, prefix, true, nil);
					end
					return true;

				-- configure mob (the mob turns towards the player and shows a formspec)
				elseif( v=='Config' or (#menu_path>1 and menu_path[2]=='config')) then
					mob_basics.turn_towards_player(   self, player );
					mob_basics.config_mob(            self, player, menu_path, prefix, formname, fields ); 
					return true;

				-- trade with the mob (who turns towards the player and shows a formspec)
				else
					mob_basics.turn_towards_player(   self, player );
					mob_trading.show_trader_formspec( self, player, menu_path, fields,
									  mob_basics.mob_types[ prefix ][ self.trader_typ ].goods ); -- this is handled in mob_trading.lua
					return true;
				end
				return true;
			end
		end
	end
	return true;
end


-- make sure we receive the input
minetest.register_on_player_receive_fields( mob_basics.form_input_handler );




-----------------------------------------------------------------------------------------------------
-- initialize a newly created mob
-----------------------------------------------------------------------------------------------------
mob_basics.initialize_mob = function( self, mob_name, mob_typ, mob_owner, mob_home_pos, prefix)

	local typ_data = mob_basics.mob_types[ prefix ];

	-- does this typ of mob actually exist?
	if( not( mob_typ ) or not( typ_data ) or not( typ_data[ mob_typ ] )) then
		mob_typ = 'default'; -- a default mob
	end

	-- each mob may have an individual name
	if( not( mob_name )) then
		local i = math.random( 1, #typ_data[ mob_typ ].names ); 
		self[ prefix..'_name'] = typ_data[   mob_typ ].names[ i ];
	else
		self[ prefix..'_name'] = mob_name;
	end

	if( typ_data[ mob_typ ].description ) then
		self.description = typ_data[ mob_typ ].description; 
	else
		self.description = prefix..' '..self[ prefix..'_name'];
	end


	self[ prefix..'_typ']       = mob_typ;      -- the type of the mob
	self[ prefix..'_owner']     = mob_owner;    -- who spawned this guy?
	self[ prefix..'_home_pos']  = mob_home_pos; -- position of a control object (build chest, sign?)
	self[ prefix..'_pos']       = self.object:get_pos(); -- the place where the mob was "born"
	self[ prefix..'_birthtime'] = os.time();       -- when was the npc first called into existence?
	self[ prefix..'_sold']      = {};              -- the trader is new and had no time to sell anything yet (only makes sense for traders)

	-- select a random texture for the mob depending on the mob type
	if( typ_data[ mob_typ ].textures ) then
		local texture = typ_data[ mob_typ ].textures[ math.random( 1, #typ_data[ mob_typ ].textures )];
		self[ prefix..'_texture'] = texture;
		mob_basics.update_texture( self, prefix, nil );
	end
	mob_basics.update_visual_size( self, nil, true, prefix ); -- generate random visual size

	-- create unique ID for the mob
	-- uniq_id: time in seconds, _, adress of entitty data, _, prefix
	local uniq_id = os.time()..'.'..string.sub( tostring(self), 8 )..'.'..prefix;

	-- does a mob with that id exist already?
	if( mob_basics.known_mobs[ uniq_id ] ) then
		return false;
	end

	-- mobs flying in the air would be odd
	self.object:set_velocity(    {x=0, y=  0, z=0});
	self.object:set_acceleration({x=0, y=-10, z=0});


	-- if there is already a mob with the same id, remove this one here in order to avoid duplicates
	if( mob_basics.find_mob_by_id( uniq_id, prefix )) then

		self.object:remove();
		return false;
	else
		-- if the mob was already known under a temporary id
		if( self[ prefix..'_id'] ) then
			mob_basics.forget_mob( self[ prefix..'_id'] )
		end
		self[ prefix..'_id'] = uniq_id;
		mob_basics.update( self, prefix ); -- store the newly created mob
		return true;
	end
end


-----------------------------------------------------------------------------------------------------
-- spawn a mob
-----------------------------------------------------------------------------------------------------
mob_basics.spawn_mob = function( pos, mob_typ, player_name, mob_entity_name, prefix, initialize, no_messages )

	if( not( no_messages )) then
		mob_basics.log('Trying to spawn '..tostring( mob_entity_name )..' of type '..tostring( mob_typ )..' at '..minetest.pos_to_string( pos ));
	end
	-- spawning from random_buildings
	if( not( mob_entity_name ) and not( prefix )) then
		mob_entity_name = 'mobf_trader:trader';
		prefix          = 'trader';
		initialize      = true;
	end
	-- slightly above the position of the player so that it does not end up in a solid block
	local object = minetest.add_entity( {x=pos.x, y=(pos.y+1.5), z=pos.z}, mob_entity_name );
	if( not( initialize )) then
		if( object ~= nil ) then
			local self = object:get_luaentity();
			mob_basics.update( self, prefix ); -- a mob has been added
		end
		return self;
	end
	if object ~= nil then
		object:set_yaw( -1.14 );
		local self = object:get_luaentity();
		-- initialize_mob does a mob_basics.update() already
		if( mob_basics.initialize_mob( self, nil, mob_typ, player_name, pos, prefix )) then

			if( not( no_messages )) then
				mob_basics.log( 'Spawned mob', self, prefix );
			end
			self[ prefix..'_texture'] = mob_basics.TEXTURES[ math.random( 1, #mob_basics.TEXTURES )];
			self.object:set_properties( { textures = { self[ prefix..'_texture'] }});
		elseif( not( no_messages )) then
			mob_basics.log( 'Error: ID already taken. Can not spawn mob.', nil, prefix );
		end
		return self;
	end
end

-- compatibility function for random_buildings
mobf_trader_spawn_trader = mob_basics.spawn_mob;

if( minetest.get_modpath( "mobf_trader" ) and mobf_trader ) then
	mobf_trader.spawn_trader = mob_basics.spawn_mob;
end


-----------------------------------------------------------------------------------------------------
-- handle input from a chat command to spawn a mob
-----------------------------------------------------------------------------------------------------
mob_basics.handle_chat_command = function( name, param, prefix, mob_entity_name )

	if( param == "" or param==nil) then
		minetest.chat_send_player(name,
			"Please supply the type of "..prefix.."! Supported: "..
			table.concat( mob_basics.type_list_for_prefix( prefix ), ', ')..'.' ); 
		return;
	end
                
	if( not( mob_basics.mob_types[ prefix ] ) or not( mob_basics.mob_types[ prefix ][ param ] )) then 
		minetest.chat_send_player(name,
			"A mob "..prefix.." of type \""..tostring( param )..
			"\" does not exist. Supported: "..
			table.concat( mob_basics.type_list_for_prefix( prefix ), ', ')..'.' );
		return;
	end

	-- the actual spawning requires a priv; the type list as such may be seen by anyone
	if( not( minetest.check_player_privs(name, {mob_basics_spawn=true}))) then 
		minetest.chat_send_player(name,
			"You need the mob_basics_spawn priv in order to spawn "..prefix.."."); 
		return;
	end

	local player = minetest.get_player_by_name(name);
	local pos    = player:get_pos();

	minetest.chat_send_player(name,
		"Placing "..prefix.." \'"..tostring( param )..
		"\' at your position: "..minetest.pos_to_string( pos )..".");
	mob_basics.spawn_mob( pos, param, name, mob_entity_name, prefix, true );
end



-----------------------------------------------------------------------------------------------------
-- It is sometimes helpful to be able to figure out where the traders and other mobs actually are
-- and where the nearest one can be found.
-- This is also useful for restoring mobs after a /clearallobjects.
-----------------------------------------------------------------------------------------------------
minetest.register_chatcommand( 'moblist', {
        params = "<trader type>",
        description = "Shows a list of all mobs known to mob_basics.",
        privs = {},
        func = function(name, param)
                -- this function handles the sanity checks and the actual spawning
                return mob_basics.mob_list_formspec( minetest.get_player_by_name( name ), "mob_basics:mob_list", {});
        end
});

-----------------------------------------------------------------------------------------------------
-- show a list of existing mobs and their positions
-----------------------------------------------------------------------------------------------------
mob_basics.mob_list_formspec = function( player, formname, fields )

	if( not( player ) or fields.quit) then
		return
	end
	local pname = player:get_player_name();
	local ppos  = player:get_pos();

	local search_for  = nil;
	local id_found    = nil;
	local col         = 0;
	local text        = '';
	if( fields and fields.mob_list and not( fields.back )) then

		local row = 1;
		local selection =  minetest.explode_table_event( fields.mob_list );
                if( selection ) then
			row = selection.row;
			col = selection.column;
		end
		if( not( row ) or row > #mob_basics.mob_list or row < 1 or not( mob_basics.known_mobs[ mob_basics.mob_list[ row ]])) then
			row = 1;	-- default to first row
		end
		if( not( col ) or col < 1 or col > 10 ) then
			col = 0; 	-- default to no limitation
		end

		local data = mob_basics.known_mobs[ mob_basics.mob_list[ row ]];
		if( not( data )) then
			data = {};
		end
		local prefix = data['mob_prefix'];
		if( not( prefix )) then
			prefix = 'trader';
		end
		local mpos   = data[ prefix..'_pos'];
		if( not( prefix )) then
			prefix = 'trader';
		end
		if(     col == 1 ) then
			search_for = math.ceil( math.sqrt(((ppos.x-mpos.x)*(ppos.x-mpos.x))
					 	 	+ ((ppos.y-mpos.y)*(ppos.y-mpos.y))
						 	+ ((ppos.z-mpos.z)*(ppos.z-mpos.z))));
			text       = 'Mobs that are less than '..tostring( search_for )..' m away from you'; 
		elseif( col == 2 ) then -- same prefix
			search_for = prefix;
			text       = 'Mobs of typ \''..tostring( search_for )..'\'';
		elseif( col == 3 ) then 
			search_for = data[ prefix..'_typ'];
			text       = 'Mobs of the subtyp \''..tostring( search_for )..'\'';
		-- 4, 5 and 6 store the mobs position
		elseif( col == 7 ) then 
			search_for = data[ prefix..'_name'];
			text       = 'Mobs with the name \''..tostring( search_for )..'\'';
		elseif( col == 8 ) then 
			search_for = data[ prefix..'_owner'];
			text       = 'Mobs belonging to player '..tostring(search_for);
		-- create a copy of the mob data and store that as a placeable item in the player's inventory
		elseif( col == 9 ) then

			-- actually create a copy of the mob
			if( mob_pickup and mob_pickup.pick_mob_up ) then

				local mobself = {};
				mobself.name = 'mobf_trader:trader'; -- TODO: there may be further types in the future
				mobself[ prefix..'_owner' ] = data[ prefix..'_owner'];
				-- all these mobs do have a unique id and are personalized, so the parameter before the last one is true
				-- the mob as such is not affected - we only want a copy (thus, last parameter is data)
				mob_pickup.pick_mob_up(mobself, player, menu_path, prefix, true, minetest.serialize( data ));
			end

			id_found   = data[ prefix..'_id']; -- show details about this particular mob
			search_for = nil;
			col        = 0;
		-- visit the mob
		elseif( col == 10 ) then
			if( not( minetest.check_player_privs(pname, {teleport=true}))) then 
				search_for = nil;
				col        = 0;
				minetest.chat_send_player( pname, 'You do not have the teleport priv. Please walk there manually.');
			elseif( mpos and mpos.x and mpos.y and mpos.z ) then
				player:moveto( mpos, false ); -- teleport the player to the mob
				-- TODO: check if the mob is there; if not: restore it
				return;
			end
		-- else no search
		else
			search_for = nil;
			col        = 0;
		end

	end

	-- selections in that list lead back to the main list
	local input_form_name = 'mob_list';
	if( search_for ) then
		input_form_name = 'mob_list_searched';
	end
	local formspec = 'size[12,12]'..
			'button_exit[4.0,0.5;2,0.5;quit;Quit]'..
			'tablecolumns[' ..
--			'text,align=left;'..
			'text,align=right;'..
			'text,align=center;'..
			'text,align=center;'..
			'text,align=right;'..
			'text,align=right;'..
			'text,align=right;'..
			'text,align=left;'..
			'text,align=left;'..
			'text,align=center;'..
			'text,align=center]'..
                        'table[0.1,2.7;11.4,8.8;'..input_form_name..';';

	-- the list mob_basic.mob_list contains the ids of all known mobs; they act as indices for mob_basics.known_mobs;
	-- important part: mob_basics.mob_list only gets extended but not shortened during the runtime of a server
	for k,v in ipairs( mob_basics.mob_list ) do

		local data = mob_basics.known_mobs[ v ];
		if( data ) then

			local prefix = data['mob_prefix'];
			if( not( prefix )) then
				prefix = 'trader';
			end
	
			local mpos     = data[ prefix..'_pos'];
			local distance = math.sqrt(((ppos.x-mpos.x)*(ppos.x-mpos.x))
						 + ((ppos.y-mpos.y)*(ppos.y-mpos.y))
						 + ((ppos.z-mpos.z)*(ppos.z-mpos.z)));

			if( not( search_for )  -- list all mobs
				or( col==1 and search_for and search_for >= distance )               -- list all mobs less than this many m away
				or( col==2 and search_for and search_for==data['mob_prefix'] )       -- list all mobs with the same prefix
				or( col==3 and search_for and search_for==data[ prefix..'_typ'   ] ) --   "        "        "       typ (i.e. fruit traders)
				or( col==7 and search_for and search_for==data[ prefix..'_name'  ] ) --   "        "        "       name
				or( col==8 and search_for and search_for==data[ prefix..'_owner' ] ) --   "        "        "       owner
			) then

				formspec = formspec..
--					tostring( data[ prefix..'_id'    ])..','.. -- left aligned
					tostring( math.floor( distance )  )..','.. -- right-aligned
					tostring( data[ 'mob_prefix'     ] or '')..','.. -- centered
					tostring( data[ prefix..'_typ'   ] or '')..','.. 
					tostring( math.floor(data[ prefix..'_pos'].x ))..','.. -- right-aligned
					tostring( math.floor(data[ prefix..'_pos'].y ))..','..
					tostring( math.floor(data[ prefix..'_pos'].z ))..','..
					tostring( data[ prefix..'_name'  ] or '')..','..
					tostring( data[ prefix..'_owner' ] or '')..','; -- left aligned
				if( data[ prefix..'_owner' ] and data[ prefix..'_owner'] == pname ) then
					formspec = formspec..'Copy';
				elseif( minetest.check_player_privs( pname, {mob_pickup=true})) then
					formspec = formspec..'Admin-Copy';
				end
				formspec = formspec..',Visit MOB,';
			-- Note: The fields _sold, _goods and _limit are specific to the trader; they cannot be displayed here.
			-- The values animation and vsize are of no intrest here (only when watching the trader).
			-- The values home_pos, birthtime, and id could be of intrest to a limited degree (at least for admins).
			-- texture is of intrest.
			end
		end
	end

 	formspec = formspec..';]'..
			'tabheader[0.1,2.2;spalte;Dist,Type,Subtype,X,Y,Z,Name of Mob,Owner;;true;true]';
	if( search_for and text ) then
		formspec = formspec..
			'label[1.0,1.0;'..minetest.formspec_escape( text )..':]'..
			'button[7.0,1.5;2,0.5;back;Back]';
	end

        -- display the formspec
        minetest.show_formspec( pname, "mob_basics:mob_list", formspec );
end

-----------------------------------------------------------------------------------------------------
-- traders may have diffrent textures; if 3d_armor is installed, they show what they sell
-----------------------------------------------------------------------------------------------------
-- TODO: add an option for mobs to statically wield something
mob_basics.update_texture = function( self, prefix, trader_goods )

	-- set a default fallback texture
	if( not( self[ prefix..'_texture'] )) then
		self[ prefix..'_texture'] = "character.png";
	end
	-- normal model
	if( mobf_trader.mesh ~= "3d_armor_character.b3d" ) then
		self.object:set_properties( { textures = { self[ prefix..'_texture'] }});
		-- we are done; no way to show the player what the mob is trying to sell
		return;
	end

	-- we are dealing with wieldview now

	-- fallback in case we find no image for the trade good
	local wield_texture = "3d_armor_trans.png";

	-- get the goods the trader has to offer
	if( not( trader_goods )) then
	 	trader_goods = mob_trading.get_trader_goods( self, nil, nil);
	end
	if( not( trader_goods )) then
		trader_goods = {};
	end

	local wield_offer = trader_goods[1];
	if( type(trader_goods[1])== 'table' ) then
		wield_offer = trader_goods[1][1];
	end
	-- update what the trader wields
	if(    wield_offer
	   and trader_goods
	   and type(wield_offer)=='string' ) then
		
		local stack = ItemStack( wield_offer );
		local stack_name = stack:get_name();
		if( stack_name and minetest.registered_items[ stack_name ] ) then
			wield_texture = minetest.registered_items[ stack_name ].wield_image;
			if( not( wield_texture ) or wield_texture=="") then
				wield_texture = minetest.registered_items[ stack_name ].inventory_image;
			end
			if( not( wield_texture ) or wield_texture=="") then
				wield_texture = minetest.registered_items[ stack_name ].tiles;
				if( type(wield_texture)=='table' ) then
					wield_texture = wield_texture[1];
				end
			end
		end
	end

	-- actually update the textures
	self.object:set_properties( { textures = { 
		self[ prefix..'_texture'],
		"3d_armor_trans.png",
		wield_texture
	}});
end


-- TODO: show additional data
--                                trader_home_pos  = self.trader_home_pos,
--                                trader_birthtime = self.trader_birthtime,
--                                trader_id        = self.trader_id,
--                                trader_texture   = self.trader_texture,
