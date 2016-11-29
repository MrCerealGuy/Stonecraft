
--[[
Modified: 20.05.14 Added diffrent trader types for medieval villages.
                   Those traders offer almost all items from default plus cottages.
                   Items from animals (mobf, https://forum.minetest.net/viewtopic.php?id=629) and bushes (Plantlife modpack, https://forum.minetest.net/viewtopic.php?id=3898) are partly included.

Features:
 * supports up to 16 different trade offers (for more, space might get too tight in the formspec)
 * up to three diffrent payments can be offered per trade offer (if more, space might get too tight in the formspec)
 * one offer (either what the trader offers or what he requests as price) may consist of up to four diffrent stacks
 * trader types can be pre-defined; each trader of that type will then sell the same goods for the same prices
 * individual traders have their own set of trade offers:
   add, edit and delete is supported for trade offers
 * traders can be spawned with the chatcommand "/trader <type>", i.e. "/trader individual";
   the trader_spawn priv is needed in order to use that chat command
 * traders can be picked up, added to your inventory, carried to another place and be placed there;
   it requires the trader_take priv or ownership of that particular trader ('.. is my employer') and is offered in the trader's formspec 
 * supports money  mod: use mobf_trader:money as item name for money and stack size for actual price
 * supports money2 mod: use mobf_trader:money2 as item name and stack size for actual price
 * no media data required other than skins for the traders; the normal player-model is used
 * traders only do something if you right-click them and call up their offer, so they do not require many ressources
 * the formspec could also be used by i.e. trade chests (mobs are more decorative!)
--]]
 

-- TODO: produce a bench occasionally and sit down on it; pick up bench when getting up
-- TODO: rename mod?
mobf_trader = {}




dofile(minetest.get_modpath("mobf_trader").."/config.lua");        -- local configuration values
dofile(minetest.get_modpath("mobf_trader").."/mob_basics.lua");    -- basic functionality: onfig, spawn, ...
dofile(minetest.get_modpath("mobf_trader").."/mob_pickup.lua");    -- pick trader up/place again
dofile(minetest.get_modpath("mobf_trader").."/mob_trading.lua");   -- the actual trading code - complete with formspecs
dofile(minetest.get_modpath("mobf_trader").."/mob_trading_random.lua");   -- traders with a more random stock
dofile(minetest.get_modpath("mobf_trader").."/large_chest.lua");   -- one large chest is easier to handle than a collectoin of chests
dofile(minetest.get_modpath("mobf_trader").."/village_traders.lua");   -- functionality for interaction with mg_villages
--TODO dofile(minetest.get_modpath("mobf_trader").."/mob_sitting.lua");   -- allows the mob to sit/lie on furniture


-- find out the right mesh; if the wrong one is used, the traders become invisible
mobf_trader.mesh = "character.b3d";
--[[
-- if we are dealing with realtest - that still uses the old model
if(    minetest.get_modpath( 'trees' )
   and minetest.get_modpath( 'anvil')
   and minetest.get_modpath( 'joiner_table')
   and minetest.get_modpath( 'scribing_table' )) then
	mobf_trader.mesh = "character.x";
end
--]]
-- 3darmor/wieldview is great
if( minetest.get_modpath( '3d_armor' )) then
	mobf_trader.mesh = "3d_armor_character.b3d";
end


mobf_trader.trader_entity_prototype = {

	-- so far, this is more or less the redefinition of the standard player model
	physical     = true,
	collisionbox = {-0.30,-1.0,-0.30, 0.30,0.8,0.30},

	visual       = "mesh";
	visual_size  = {x=1, y=1, z=1},
	mesh         = mobf_trader.mesh,
	textures     = {"character.png"},


	description  = 'Trader',

	-- this mob only has to stand around and wait for customers
        animation = {
                stand_START     =   0,
                stand_END       =  79,
                sit_START       =  81,
                sit_END         = 160,
                sleep_START     = 162,
                sleep_END       = 166,
                walk_START      = 168,
                walk_END        = 187,
                mine_START      = 189,
                mine_END        = 198,
                walkmine_START  = 200,
                walkmine_END    = 219,
        },
        animation_speed = 30,

        armor_groups = {immortal=1},
	hp_max       = 100, -- just to be sure


	-- specific data for the trader:

	-- individual name (e.g. Fritz or John)
	trader_name      = '',
	-- the goods he sells
	trader_typ       = '',
	-- who has put the trader here? (might be mapgen or a player)
	trader_owner     = '',
	-- where is the build chest or other object that caused this trader to spawn?
	trader_home_pos  = {x=0,y=0,z=0},
	-- at which position has the trader been last?
	trader_pos       = {x=0,y=0,z=0},
	-- when was the NPC first created?
	trader_birthtime = 0,
	-- additional data (perhaps statistics of how much of what has been sold)
	trader_sold      = {},
	-- some traders may have a limited (more random) stock
	trader_stock     = nil,
	-- unique ID for each trader
	trader_id        = '',
	
        decription = "Default NPC",
        inventory_image = "npcf_inv_top.png",


	-- Information that is specific to this particular trader
	get_staticdata = function(self)
		return mobf_trader.trader_entity_get_staticdata( self, nil );
	end,

	-- Called when the object is instantiated.
	on_activate = function(self, staticdata, dtime_s)
		-- set up the trader
		mobf_trader.trader_entity_on_activate(self, staticdata, dtime_s);

		-- the mob will do nothing but stand around
		self.object:set_animation({x=self.animation[ self.trader_animation..'_START'], y=self.animation[ self.trader_animation..'_END']},
				self.animation_speed-5+math.random(10));

		-- the trader has to be subject to gravity
		self.object:setvelocity(    {x=0, y=  0, z=0});
		self.object:setacceleration({x=0, y=-10, z=0});
	end,

-- this mob waits for rightclicks and does nothing else
--[[
	-- Called on every server tick (dtime is usually 0.1 seconds)
	on_step = function(self, dtime)
	end,
--]]

	-- this is a fast way to get rid of obsolete/misconfigured traders
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

		if(    not( self.trader_name )
		    or not( self.trader_id )
		    or not( self.trader_typ )
		    or not( mob_basics.mob_types[ 'trader' ][ self.trader_typ ] )) then

			self.object:remove();
			return;
		else
			self.hp_max = 100;
		end
		-- prevent accidental (or purposeful!) kills
		self.object:set_hp( self.hp_max );
		-- talk to the player
		if( puncher and puncher:get_player_name() ) then
			minetest.chat_send_player( puncher:get_player_name(),
				( self.trader_name or 'A trader' )..': '..
				'Hey! Stop doing that. I am a peaceful trader. Here, buy something:');
			-- marketing - if *that* doesn't disencourage aggressive players... :-)
			mobf_trader.trader_entity_trade( self, puncher );
		end
	end,


	-- show the trade menu
	on_rightclick = function(self, clicker)
		mobf_trader.trader_entity_trade( self, clicker );
	end,
}


mobf_trader.trader_entity_trade = function( self, clicker )
	if( not( self) or not( clicker ) or not( self.trader_typ ) or not( mob_basics.mob_types[ 'trader' ][ self.trader_typ ])) then
		return;
	end

	mob_basics.turn_towards_player(   self, clicker );
	mob_trading.show_trader_formspec( self, clicker, nil, nil,
					  mob_basics.mob_types[ 'trader' ][ self.trader_typ ].goods ); -- this is handled in mob_trading.lua
end


mobf_trader.trader_entity_get_staticdata = function( self, serialized_data )

	local data = {};
	if( serialized_data ) then
		data = minetest.deserialize( serialized_data );
	end

	-- traders of a standard type do not save their list of goods
	if( self and self.trader_typ and self.trader_typ ~= 'individual' ) then
		self.trader_goods = {};
	end

	data.mob_prefix       = 'trader';
	data.trader_name      = self.trader_name;
	data.trader_typ       = self.trader_typ;
	data.trader_owner     = self.trader_owner; 
	data.trader_home_pos  = self.trader_home_pos;
	data.trader_pos       = self.trader_pos;
	data.trader_birthtime = self.trader_birthtime;
	data.trader_sold      = self.trader_sold;
	data.trader_stock     = self.trader_stock;
	data.trader_id        = self.trader_id;
	data.trader_texture   = self.trader_texture;
	data.trader_goods     = self.trader_goods;
	data.trader_limit     = self.trader_limit;
	data.trader_animation = self.trader_animation;
	data.trader_vsize     = self.trader_vsize;

	return minetest.serialize( data );
end


mobf_trader.trader_entity_on_activate = function(self, staticdata, dtime_s)
	-- do the opposite of get_staticdata
	if( staticdata ) then
		
		local data = minetest.deserialize( staticdata );
		if( data and data.trader_id ~= '') then

			self.trader_name      = data.trader_name;
			self.trader_typ       = data.trader_typ;
	                self.trader_owner     = data.trader_owner; 
	                self.trader_home_pos  = data.trader_home_pos;
			self.trader_pos       = data.trader_pos;
	                self.trader_birthtime = data.trader_birthtime;
	                self.trader_sold      = data.trader_sold; 
	                self.trader_stock     = data.trader_stock;
			self.trader_id        = data.trader_id;
			self.trader_texture   = data.trader_texture;
			self.trader_goods     = data.trader_goods;
			self.trader_animation = data.trader_animation;
			self.trader_vsize     = data.trader_vsize;
		end

		if( not( self.trader_animation )) then
			self.trader_animation = 'stand';
		end

		if( self.trader_texture ) then
			mob_basics.update_texture( self, 'trader', nil );
		end

		if( self.trader_vsize ) then
			mob_basics.update_visual_size( self, self.trader_vsize, false, 'trader' );
		end
	end
						
	-- initialize a new trader
	if( not( self.trader_name ) or self.trader_name=='' or self.trader_id=='') then
		-- no name supplied - it will be choosen automaticly
		-- the typ of trader is unknown at this stage
		local typen = mob_basics.type_list_for_prefix('trader');
		local i     = math.random(1,#typen );
		-- if trader_id is a duplicate, this entity here (self) will be removed
		mob_basics.initialize_mob( self, nil, typen[ i ], nil, {x=0,y=0,z=0}, 'trader' );
	end
end


minetest.register_entity( "mobf_trader:trader", mobf_trader.trader_entity_prototype);


-----------------------------------------------------------------------------------------------------
-- diffrent types of traders trade diffrent goods, have diffrent name lists etc.
-----------------------------------------------------------------------------------------------------
mobf_trader.add_trader = function( prototype, description, speciality, goods, names, textures )

	-- register traders as such
	if( not( mob_basics.mob_types[ 'trader' ] )) then
		mob_basics.mob_types['trader'] = {};
	end

	-- default texture/skin for the trader; if multiple are supplied, a random one will be selected
	if( not(textures) or (textures == "" )) then
		textures = {"character.png"};
	end

--	mob_basics.log('Adding trader typ '..speciality, nil, 'trader' );


	mob_basics.mob_types[ 'trader' ][ speciality ] = {
		description = description,
		speciality  = speciality,
		goods       = goods,
		names       = names,
		textures    = textures
	}
end

-- this trader can be configured by a player or admin
mobf_trader.add_trader( nil, 'Trader who is working for someone', 'individual', {}, {'nameless'}, {} );
mobf_trader.add_trader( nil, 'Trader with limited stock',         'random',     {}, {'nameless'}, {} );



-----------------------------------------------------------------------------------------------------
-- add a chat command to spawn a trader with a "/trader <typ>" command
-----------------------------------------------------------------------------------------------------
minetest.register_chatcommand( 'trader', {
        params = "<trader type>",
        description = "Spawns a trader of the given type. Returns a list of types if called without parameter.",
        privs = {},
        func = function(name, param)
		-- this function handles the sanity checks and the actual spawning
		return mob_basics.handle_chat_command( name, param, 'trader', 'mobf_trader:trader' );
        end
});



-----------------------------------------------------------------------------------------------------
-- the mob as an item - carried in the inventory
-----------------------------------------------------------------------------------------------------
-- If you want to add mobs with diffrent names/descriptions/inventory images/entities, just add your
-- own register_craftitem and use this as an example.
minetest.register_craftitem("mobf_trader:trader_item", {
	name            = "Trader",
	description     = "Trader. Place him somewhere to activate.",
	groups          = {},
	inventory_image = "character.png",
	wield_image     = "character.png",
	wield_scale     = {x=1,y=1,z=1},
	on_place        = function( itemstack, placer, pointed_thing )
				return mob_pickup.place_mob( itemstack, placer, pointed_thing, 'trader', 'mobf_trader:trader', true );
			  end,
	-- carries individual metadata - stacking would interfere with that
	stack_max = 1,
	
})


mob_pickup.register_mob_for_pickup( 'mobf_trader:trader', 'mobf_trader:trader_item', {
	deny_pickup = function( self, player )

		if( not( self )) then
			return 'Error: Internal error. Trader not found.';
		end
		if( not( mob_basics.mob_types[ 'trader' ][ self[ 'trader_typ' ]] )) then
			return 'Error: The typ of this trader is unkown. Cannot pick him up.';
		end
		return '';
	end,

	deny_place = function( data, pos, player )

		if( data and not( mob_basics.mob_types[ 'trader' ][ data[ 'trader_typ']])) then
			return 'Error: The typ of this trader is unkown. Cannot place him.';
		end

		if( not( player )) then
			return '';
		end
		local pname = player:get_player_name();

		local mobs = mob_basics.mob_id_list_by_player( player:get_player_name(), 'trader' );
		if( #mobs >= mobf_trader.MAX_TRADER_PER_PLAYER and not( minetest.check_player_privs(pname, {mob_basics_spawn=true}))) then
			return 'Error: You are only allowed to have up to '..tostring( mobf_trader.MAX_TRADER_PER_PLAYER )..' traders '..
				' (you have '..tostring( #mobs )..' currently).';
		end

		mobs = mob_basics.mob_id_list_by_player( pname, nil );
		if( #mobs >= mobf_trader.MAX_MOBS_PER_PLAYER and not( minetest.check_player_privs(pname, {mob_basics_spawn=true}))) then
			return 'Error: You are only allowed to have up to '..tostring( mobf_trader.MAX_MOBS_PER_PLAYER   )..' mobs'..
				' (you have '..tostring( #mobs )..' currently).';
		end

		return '';
	end,
	
	pickup_success_msg = 'Mob picked up. In order to use him again, just wield him and place him somewhere.',

	place_success_msg  = 'Trader placed and waiting for trades.',
});









-- import all the traders; if you do not want any of them, comment out the line representing the unwanted traders (they are only created if their mods exists)

dofile(minetest.get_modpath("mobf_trader").."/trader_misc.lua");      -- trades a mixed assortment
dofile(minetest.get_modpath("mobf_trader").."/trader_clay.lua");      -- no more destroying beaches while digging for clay and sand!
dofile(minetest.get_modpath("mobf_trader").."/trader_moretrees.lua"); -- get wood from moretrees without chopping down trees
dofile(minetest.get_modpath("mobf_trader").."/trader_animals.lua");   -- buy animals - no need to catch them with a lasso
dofile(minetest.get_modpath("mobf_trader").."/trader_farming.lua");   -- they sell seeds and fruits - good against hunger! also contains special seeds trader
dofile(minetest.get_modpath("mobf_trader").."/trader_flowers.lua");   -- flowers and other plants from default (cactus, papyrus, ..)
dofile(minetest.get_modpath("mobf_trader").."/trader_ores.lua");      -- sells ores for tree/wood and food (both needed for further mining)
dofile(minetest.get_modpath("mobf_trader").."/trader_village.lua");   -- historic occupations that can be found in medieval villages


mobf_trader.add_as_trader_data = {}
for i,v in ipairs( mobf_trader.add_as_trader ) do
	local entity = minetest.registered_entities[ v ];
	
	if( entity ) then
		mobf_trader.add_as_trader_data[ v ] = {
			get_staticdata = entity.get_staticdata,
			on_activate    = entity.on_activate,
			on_rightclick  = entity.on_rightclick,
		}
	
		entity.get_staticdata = function(self)
			local data = mobf_trader.add_as_trader_data[ v ].get_staticdata( self );
			return mobf_trader.trader_entity_get_staticdata( self, data );
		end

		entity.on_activate = function(self, staticdata, dtime_s)
			mobf_trader.add_as_trader_data[ v ].on_activate( self, staticdata, dtime_s );
			mobf_trader.trader_entity_on_activate(self, staticdata, dtime_s);
		end

		entity.on_rightclick = function(self, clicker)
			mobf_trader.trader_entity_trade( self, clicker );
		end
	end
end
