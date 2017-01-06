---------------------------------------------------------------------------------------------------
-- Extra large chest for traders
---------------------------------------------------------------------------------------------------
-- Features:
-- * traders may find all they can sell (plus storage space) in one inventory
-- * the chest does not allow placement next to another locked chest
-- * contains mobf_trader.LARGE_CHEST_SIZE inventory slots
-- * it is possible to show virtual pages containing 4x10=40 of those inventory slots each
-- * it is possible to scroll row-wise (in steps of 10 inventory slots)
---------------------------------------------------------------------------------------------------

mobf_trader.LARGE_CHEST_SIZE = 4*10*10;

mobf_trader.large_chest_formspec = function( start, player )
	if( start < 0 or start > mobf_trader.LARGE_CHEST_SIZE-10 ) then
		start = 0;
	end
	local prev_row = start-10;
	local next_row = (start+10)%mobf_trader.LARGE_CHEST_SIZE;
	if( prev_row < 0 ) then
		prev_row = mobf_trader.LARGE_CHEST_SIZE-10;
	end
	local formspec = "size[12,9]"..
		"button[0.1,1.3;0.6,1;"..tostring( prev_row )..";"..minetest.formspec_escape('^')..']'..
		"button[0.1,1.8;0.6,1;"..tostring( next_row )..";"..minetest.formspec_escape('v')..']'..
		"button[11.2,1.3;0.6,1;"..tostring( prev_row )..";"..minetest.formspec_escape('^')..']'..
		"button[11.2,1.8;0.6,1;"..tostring( next_row )..";"..minetest.formspec_escape('v')..']'..
		"label[1,4.1;Show rows:]"..
		"label[0.5,-0.3;Row:]"..
		"label[10.9,-0.3;Row:]"..
		"list[current_name;main;1,0;10,4;"..tostring( start ).."]"..
		"list[current_player;main;2,5;8,4;]"..
		"button[10.8,4.2;1.4,0.5;statistic;Statistic]"..
		"button[10.0,4.8;2.2,0.5;request_trader;Request Trader]";

	-- show the rest of the list from the beginning in order to allow continous scrolling
	local rows_missing = mobf_trader.LARGE_CHEST_SIZE-start;
	if( rows_missing < 40 ) then
		rows_missing = math.floor( rows_missing/10);
		formspec = formspec..
			"list[current_name;main;1,"..tostring( rows_missing )..";10,"..tostring( 4-rows_missing )..";0]";
	end

	-- label each row with its number
	for i=1, 4 do
		formspec = formspec..
			"label[0.7," ..tostring( i-1.0 )..";"..tostring( (math.floor(start/10)+i)%(mobf_trader.LARGE_CHEST_SIZE/10) ).."]"..
			"label[10.9,"..tostring( i-1.0 )..";"..tostring( (math.floor(start/10)+i)%(mobf_trader.LARGE_CHEST_SIZE/10) ).."]";
	end

	-- show buttons for quick access to sets of 4 rows each (kind of like a page)
	for i=1,10 do
		formspec = formspec..
			"button["..tostring( i*0.8 +1.6)..",4.2;1.0,0.5;"..tostring( (i-1)*40 )..";"..tostring( (i-1)*4+1 ).." - "..tostring((i*4)).."]";
	end
	return formspec;
end


mobf_trader.large_chest_statistic = function( pos )
	local meta = minetest.get_meta( pos );
	local self = {};
	-- we need to supply the counting function with an inventory location
	self.trader_inv = meta:get_inventory();
	-- ..so that the counting function in mob_trading can do the counting
	local counted = mob_trading.count_trader_inv( self )
	local formspec = 'size[12,11]'..
			'label[5,10.0;Content summed up]'..
			'button[3.5,10.2;1.0,0.5;1;Back]'..
			'button[7.5,10.2;1.0,0.5;1;Back]';
	local i = 0; -- offset
	-- the chest contains v pieces of item k - now display that
	for k,v in pairs( counted ) do
		if( k and k~="" and minetest.registered_items[ k ] and i<120) then
			formspec = formspec..
				'item_image['..tostring(i%12)..','..tostring( math.floor(i/12)+1)..';1.0,1.0;'..minetest.formspec_escape( k )..']'..
				'label['..(tostring(i%12)+0.5)..','..tostring( math.floor(i/12)+1+0.4)..';'..tostring( v )..'x]';
			i = i+1;
		end
	end
	-- show free inventory slot
	if( counted and counted[""] ) then
		formspec = formspec..
			'label[10,10.0;Free slots: '..tostring( counted[""] )..']';
	end
	return formspec;
end



-- players with the spawn_mob priv can own an unlimited number of mobs
mobf_trader.request_trader = function( pos, player, fields )
	local meta = minetest.get_meta( pos );
	local owner = meta:get_string( 'owner' );
	local pname = player:get_player_name();
	local formspec = 'size[12,11]'..
			'abel[5,10.0;Request Trader]'..
			'button[5.0,10.2;1.0,0.5;1;Back]'..
			'textarea[3,7;6,2.5;info;;';
	if( not( owner ) or owner ~= pname ) then
		return formspec..'Only the owner of this chest, namely '..tostring( owner )..', may request traders.]';
	end

	local mobs = mob_basics.mob_id_list_by_player( pname, 'trader' );
	if( #mobs >= mobf_trader.MAX_TRADER_PER_PLAYER and not( minetest.check_player_privs(pname, {mob_basics_spawn=true}))) then
		return formspec..'You are only allowed to have up to '..tostring( mobf_trader.MAX_TRADER_PER_PLAYER )..' traders '..
				' (you have '..tostring( #mobs )..' currently).]';
	end
	formspec = formspec..'You currently employ '..tostring( #mobs )..' traders ('..tostring( mobf_trader.MAX_TRADER_PER_PLAYER )..' allowed).\n';

	mobs = mob_basics.mob_id_list_by_player( pname, nil );
	if( #mobs >= mobf_trader.MAX_MOBS_PER_PLAYER and not( minetest.check_player_privs(pname, {mob_basics_spawn=true}))) then
		return formspec..'You are only allowed to have up to '..tostring( mobf_trader.MAX_MOBS_PER_PLAYER   )..' mobs'..
				' (you have '..tostring( #mobs )..' currently).]';
	end
	formspec = formspec..'And you do have '..tostring( #mobs )..' mobs alltogether ('..tostring( mobf_trader.MAX_MOBS_PER_PLAYER )..' allowed).\n';


	-- hire a new trader
	if( fields and fields.hire_trader ) then
		local inv = meta:get_inventory();
		if( not( inv ) or not( inv:contains_item('main', mobf_trader.TRADER_PRICE ))) then
			return formspec..'\n\nPlease place the requested price into the chest first!\n'..
				'You have to pay it once per trader.';
		end

		-- remove the price
		inv:remove_item( 'main', mobf_trader.TRADER_PRICE );
		-- place a trader on top of the chest
		mob_basics.spawn_mob( {x=pos.x, y=(pos.y+1), z=pos.z}, 'individual', pname, 'mobf_trader:trader', 'trader', true );
		return formspec..'\n\nCongratulations! You now employ a new trader.]';
	end

	-- show price information for a new trader
	local price_stack = ItemStack( mobf_trader.TRADER_PRICE );
	formspec = formspec..'\nHiring a trader will cost you the items shown above.\n'..
			'In order to actually hire one, place those items in this chest\n'..
			'and click on the price above.]'..
			'label[5.0,2.9;Price:]'..
			'item_image_button[5.0,3.5;1,1;'..tostring( price_stack:get_name() )..';hire_trader;]'..
			'label[5.5,3.9;'..tostring( price_stack:get_count() )..'x]';
	return formspec;
end


-- unfortionately, this only works with a dely
mobf_trader.give_chest_back = function( player )
	if( not( player )) then
		return;
	end
	local inv = player:get_inventory();
	local rest = inv:add_item( 'main', "mobf_trader:large_chest 1" );
	if( not( rest ) or rest:get_count()==0) then
		minetest.chat_send_player( player:get_player_name(),'Your large storage chest for traders has been returned to you.');
	else
		minetest.chat_send_player( player:get_player_name(),'Failed to return your large storage chest for traders to you.');
	end
end


-- this is basically a copy of default:chest_locked - except that it has several times the inventory size
minetest.register_node("mobf_trader:large_chest", {
	description = "Large Storage Chest for Traders",
	tiles = {"default_chest_top.png^default_book.png", "default_chest_top.png^default_book.png", "default_chest_side.png^default_book.png",
		"default_chest_side.png^default_book.png", "default_chest_side.png^default_book.png", "default_chest_lock.png^default_book.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	after_place_node = function(pos, placer)
		local other_chests = minetest.find_nodes_in_area(
				{x=pos.x-1, y=pos.y-1, z=pos.z-1},
				{x=pos.x+1, y=pos.y+1, z=pos.z+1},
				mob_trading.KNOWN_LOCKED_CHESTS );
		-- the chest itself will be found - so we have to look for "more than one"
		if( other_chests and #other_chests > 1 ) then
			if( placer ) then
				minetest.chat_send_player( placer:get_player_name(),
					'Error: The large storage chest for traders needs to keep a distance of at least 1 block to all other locked chests.');
				minetest.after( 1, mobf_trader.give_chest_back, placer );
			end
			minetest.remove_node( pos );
			return;
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Large Storage Chest for Traders (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Large Storage Chest for Traders")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", mobf_trader.LARGE_CHEST_SIZE) -- 10x the inventory space of a normal locked chest
		meta:set_string('formspec',mobf_trader.large_chest_formspec( 0, nil ));
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		meta:set_string('formspec',mobf_trader.large_chest_formspec( 0, nil ));
		if( meta:get_string('owner') and meta:get_string('owner')~='' and player:get_player_name() ~= meta:get_string("owner")) then
			return false
		end
		return inv:is_empty("main");
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if( meta:get_string('owner') and player:get_player_name() ~= meta:get_string("owner")) then
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if( meta:get_string('owner') and player:get_player_name() ~= meta:get_string("owner")) then
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if( meta:get_string('owner') and player:get_player_name() ~= meta:get_string("owner")) then
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in mobf_trader:large_chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to mobf_trader:large_chest chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from mobf_trader:large_chest at "..minetest.pos_to_string(pos))
	end,

	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.get_meta(pos)
		-- only the owner can operate the formspec
		if( not( player ) or (meta:get_string('owner') and player:get_player_name() ~= meta:get_string("owner"))) then
			return 0
		end

		if( fields and fields.statistic ) then
			meta:set_string('formspec',mobf_trader.large_chest_statistic( pos ));
			return;
		end

		if( fields and (fields.request_trader or fields.hire_trader)) then
			meta:set_string('formspec', mobf_trader.request_trader( pos, player, fields ));
			return;
		end

		for k,v in pairs( fields ) do
			local i = tonumber( k );
			if( i and i>-1 and i<mobf_trader.LARGE_CHEST_SIZE ) then
				
				meta:set_string('formspec',mobf_trader.large_chest_formspec( i, player ));
				return;
			end
		end
	end,
})


minetest.register_craft({
	output = 'mobf_trader:large_chest',
	recipe = {
		{'default:chest_locked', 'default:chest_locked', 'default:chest_locked'},
		{'default:chest_locked', 'default:bookshelf',    'default:chest_locked'},
		{'default:chest_locked', 'default:chest_locked', 'default:chest_locked'},
	}
})

