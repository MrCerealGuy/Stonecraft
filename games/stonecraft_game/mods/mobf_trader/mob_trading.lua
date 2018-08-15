
----------------------------------------------------------------------------
--  The only relevant function for other mods to call here is:
--      mob_trading.show_trader_formspec( self, player, menu_path, fields )
--  All other functions are more or less internal.
----------------------------------------------------------------------------
-- Note: group:bla would be handy for prices, but implementing that costs too much
--       while not gaining much (there are alternate prices after all).
-- Note: A limit of x items/hour would be handy as well; except that it can be doe
--       with less effort if the trader uses a trade chest that handles the
--       refilling after some time.


-- contains mostly defines and functions
mob_trading = {};

mob_trading.MAX_OFFERS                = 24; -- up to that many diffrent offers are supported by the trader of the type 'individual'
mob_trading.MAX_ALTERNATE_PAYMENTS    = 6; -- up to 6 diffrent payments are possible for each good offered

-- how many nodes does the trader of the type individual search for locked chests?
mob_trading.LOCKED_CHEST_SEARCH_RANGE = 3;

mob_trading.KNOWN_LOCKED_CHESTS = {'default:chest_locked',        'locks:shared_locked_chest', 
				 'mobf_trader:large_chest',
				 'technic:iron_locked_chest',   'technic:copper_locked_chest',
				 'technic:silver_locked_chest', 'technic:gold_locked_chest'};

-- pseudo-item so that something can be entered when money from the money mod (which does not exist as an item) is requested
mob_trading.MONEY_ITEM   = 'money';
-- same for the money2 mod
mob_trading.MONEY2_ITEM  = 'money2';


-- store temporal lists, especially for limits (sell if more than/buy if less than)
mob_trading.tmp_lists = {};



mob_trading.get_trader_goods = function( self, trader_goods, player )
	if( not( self )) then
		return {};
	end

	if(not( trader_goods )
	   and self
	   and self.trader_typ
	   and mob_basics.mob_types[ 'trader' ][ self.trader_typ ] ) then
		trader_goods = mob_basics.mob_types[ 'trader' ][ self.trader_typ ].goods;
	end

	-- which goods does this trader trade?
	if(     self.trader_typ == 'random'
	     or self.trader_stock
	    or (mobf_trader.ALL_TRADERS_RANDOM and self.trader_typ ~= 'individual' and trader_goods and #trader_goods>0)) then
		-- give each trader at least one item for trade
		if( not( self.trader_stock ) or #self.trader_stock < 1 ) then
			mobf_trader.trader_with_stock_add_random_offer( self, 2, trader_goods );
		end
		trader_goods = mobf_trader.trader_with_stock_get_goods( self, player, trader_goods );
		if( self.trader_stock and #self.trader_stock > 0 and trader_goods and #trader_goods < 1 ) then
			self.trader_stock = {};
			mobf_trader.trader_with_stock_add_random_offer( self, 2, trader_goods );
		end
	elseif( self.trader_typ == 'individual' or not( trader_goods ) or #trader_goods < 1 ) then
		trader_goods = self.trader_goods;
	end
	return trader_goods;
end
-------------------------------------------------------------------------------
-- main formspec of the trader
-------------------------------------------------------------------------------
-- the trader entity turns towards the player
-- usually shows the goods the trader has to offer plus trade details once an offer has been selected
--
-- self HAS to contain:
--      self.trader_id        unique id of the trader (unique for the entire map)
--      self.trader_name      i.e. 'Fritz'; used only for the greeting
--      self.object           traders of the type individual need to find locked chests in their environment
--      self.trader_typ       traders with the type 'individual' are handled specially (they trade for players);
--      self.trader_goods     required for traders of the typ individual; else determined through self.trader_typ
--      self.trader_owner     required for traders of the typ individual
--      self.trader_sold      used for collecting statistics
--	self.trader_stock     array of {id,amount] values representing the trader's stock
-- Optional:
--      self.trader_inv       helper variable that will contain a reference to the trader chest's inventory; will be set automaticly
--      self.trader_limit     will be used if set; may contain self.trader_limit.sell_if_more[ item name ] and self.trader_limit.buy_if_less[ item name ]
mob_trading.show_trader_formspec = function( self, player, menu_path, fields, trader_goods )

	if( not( self ) or not( player )) then
		return;
	end

	local pname = player:get_player_name();

	local npc_id = self.trader_id;
	if( not( npc_id )) then
		return;
	end

	trader_goods = mob_trading.get_trader_goods( self, trader_goods, player );
	-- update what the trader wields/shows
	if( mobf_trader.mesh == "3d_armor_character.b3d" and trader_goods[1]) then
		mob_basics.update_texture( self, "trader", trader_goods );
	end

	local formspec = 'size[10,11]'..
			 'list[current_player;main;1,7;8,4;]'..
			 'button_exit[7.5,6.3;2,0.5;quit;End trade]';


	-- indicate to the owner of the trader which fields of the owner's inventory are taken as input fields
	-- for new trade offers; for this purpose, colored boxes are drawn around the relevant inventory slots
	if( (self.trader_owner and self.trader_owner == pname ) and self.trader_typ=='individual') then
		formspec = formspec..
			'label[-0.25,6.90;When adding]'..
			'label[-0.25,7.10;a new offer,]'..
			'label[-0.25,7.30;suggest this:]'..
			'label[1.1,6.5;Sell:]'..
					'box[0.95,6.7;0.95,4.35;#00AA00]'..
			'label[2.1,6.5;for:]'..
					'box[1.95,6.7;0.95,4.35;#0000CC]'..
			-- the Add button is also shown next to the player's inventory that provides the names
			'button[9,7.1;1,0.5;'..npc_id..'_add;Add]'..
			'button[1.1,10.9;3.9,0.5;'..npc_id..'_addm;Add offer based on these colored slots]';
		for i = 3, mob_trading.MAX_ALTERNATE_PAYMENTS do
			local boxcolor = '#0000CC';
			formspec = formspec..'label['..(tostring(i)+0.1)..',6.5;or:]';
			-- complex offers of up to 4 items allow only 3 alternate payments
			if( i<=4 ) then
				boxcolor = '#0000CC';
				if(( i%2 )==1 ) then
					boxcolor = '#AAAAAA';
				end
				formspec = formspec..'box['..( i-0.05 )..',6.7;0.95,4.35;'..boxcolor..']';
			else
				boxcolor = '#000077';
				if(( i%2 )==1 ) then
					boxcolor = '#777777';
				end
				formspec = formspec..'box['..( i-0.05 )..',6.7;0.95,1.25;'..boxcolor..']';
			end
		end
	end


	-- back to main menu (player clicked 'Abort' in the add/edit new offer menu)
	if( menu_path and #menu_path > 1 and menu_path[2]=='main') then
		menu_path[2] = nil;
	end

	-- configure the trade limits for a trader
	if( menu_path and #menu_path > 1 and (menu_path[2]=='limits' or menu_path[2]=='limitlist' or menu_path[2]=='limitstore')) then 

		-- find out how many of each item is availabe
		local counted_inv = nil;
		if( self.trader_typ == 'individual' and self.trader_owner) then
			mob_trading.find_trader_inv( self );
			counted_inv = mob_trading.count_trader_inv( self );
		end
	
		mob_trading.show_trader_formspec_limits( self, player, menu_path, fields, trader_goods, npc_id, pname, counted_inv );
		-- the function above already displayed a formspec; nothing more to do here
		return;
	end


	-- the player wants to delete a trade offer
	if( menu_path and #menu_path > 1 and menu_path[2]=='delete') then
		if( not(trader_goods )) then
			trader_goods = {};
		end
		local edit_nr = tonumber( menu_path[3] );
		-- store the modified offer
		if( edit_nr and edit_nr > 0 and edit_nr <= #trader_goods ) then
			table.remove( trader_goods, edit_nr );
			self.trader_goods       = trader_goods;
			minetest.chat_send_player( pname, self.trader_name..': Deleted. This trade is no longer offered.');
			mob_basics.update( self, 'trader' ); -- save the new goods list
		end
		-- display all offers (minus the deleted one)
		menu_path[2] = nil;
	end


	-- the player wants to store a new trade offer or change an existing one
	if( menu_path and #menu_path > 1 and (menu_path[2]=='storenew' or menu_path[2]=='storenewm' or menu_path[2]=='storechange')) then

		local error_msg = mob_trading.store_trade_offer_changes( self, pname,  menu_path, fields, trader_goods );

		-- in case of error: display the input again so that the player can edit it
		if( error_msg ~= '' ) then
			if(     menu_path[2]=='storenewm') then 
				menu_path[2] = 'addm';
			elseif( menu_path[2]=='storenew' ) then
				menu_path[2] = 'add';
			elseif( menu_path[2]=='storechange' ) then
				menu_path[2] = 'edit';
			end
			-- show the error
			formspec = formspec..
				'textarea[1.0,1.6;9,0.5;info;;'..minetest.formspec_escape( error_msg  )..']';
			-- send the player a chat message as well
			minetest.chat_send_player( pname, self.trader_name..': '..error_msg );
		end
	end


	-- add a new trade offer for the individual trader
	if( menu_path and #menu_path > 1 and (menu_path[2]=='add' or menu_path[2]=='edit' or menu_path[2]=='addm')) then

		mob_trading.show_trader_formspec_edit( self, player,  menu_path, fields, trader_goods, formspec, npc_id, pname );
		-- the function above already displayed a formspec; nothing more to do here
		return;
	end



	-- it is possible to display up to 4 items which may together form one offer; this needs a diffrent sort of visualization
	local offer_packages = false;
	for j,k in ipairs( trader_goods ) do
		for i,v in ipairs( k ) do
			if( not( offer_packages ) and type( v )=='table' ) then
				offer_packages = true;
			end
		end
	end

	-- move some entries up in order to have enough space
	local m_up = 0;
	local p_up = 0;
	if( not( menu_path ) or #menu_path == 1 ) then
		m_up =  1.0;
	elseif(  menu_path  and #menu_path == 2 ) then
		-- displaying a package with up to 4 items takes more space
		if( offer_packages ) then
			m_up =  0.0;
			p_up =  0.5; 
		else
			m_up =  0.5;
			p_up =  1.0; 
		end
	elseif(  menu_path  and #menu_path > 2 ) then
		if( offer_packages ) then
			m_up =  -1.0;
			p_up =  -1.0; 
		else
			m_up =   0.0; 
			p_up =   0.0; 
		end
	end

	-- intorduce the trader
	if( not( self.trader_name )) then
		self.trader_name = 'Nameless trader';
	end
	local greeting1 = 'My name is '..tostring( self.trader_name or 'uniportant')..'.';
	local greeting2 = 'I sell the following:';

	local greeting3 = '';
	if( self.trader_owner and self.trader_owner ~= '' ) then
		if( self.trader_owner == pname ) then
			greeting3 = 'You are my employer.';
		else
			greeting3 = tostring( self.trader_owner )..' is my employer.';
		end
	else
		greeting3 = 'I work for myself.';
	end

	if( menu_path and menu_path[1] ) then
	      formspec = formspec..'button[4.5,6.3;2,0.5;'..npc_id..'_main;Show goods]';
	end

	formspec = formspec..'label[0.5,'..(0.5+m_up)..';'..minetest.formspec_escape( greeting1 )..']'..
		             'label[3.5,'..(0.5+m_up)..';'..minetest.formspec_escape( greeting2 )..']'..
		             'label[6.5,'..(0.5+m_up)..';'..minetest.formspec_escape( greeting3 )..']'..
		             'label[0.2,'..(1.5+m_up)..';Goods:]';

	-- the owner and people with the mob_pickup priv can pick the trader up
	-- (he will end up in the inventory and can then be placed elsewhere)
	if( (self.trader_owner and self.trader_owner == pname)
	  or minetest.check_player_privs( pname, {mob_pickup=true})) then

		formspec = formspec..'button_exit[9,0.5;1,0.5;'..npc_id..'_take;Take]';
	end
	-- only the owner can edit the limits
	if(  self.trader_owner and self.trader_owner == pname ) then
		if( self.trader_typ=='individual') then
			formspec = formspec..'button_exit[9,1.5;1,0.5;'..npc_id..'_limits;Limits]';
		end
		-- admin traders can now be configured as well
		formspec = formspec..'button_exit[9,1.0;1,0.5;'..npc_id..'_config;Config]';
	end

	-- find out how many of each item is availabe
	local counted_inv = nil;
	if( self.trader_typ == 'individual' and self.trader_owner) then
		mob_trading.find_trader_inv( self );
		counted_inv = mob_trading.count_trader_inv( self );
	end
	
	-- give information about a specific good
	if( menu_path and #menu_path >= 2 ) then

		local choice1 = tonumber( menu_path[2] );

		-- in case the client sends invalid input
		if( not( choice1 ) or choice1 > #trader_goods ) then
			choice1 = 1;
		end

		local trade_details = trader_goods[ choice1 ];

		-- when offering 6 diffrent methods of payment, we can't display 4 items per payment - there's simply not enough space
		if( offer_packages and #trade_details > 4 ) then
			offer_packages = false;
		end

		if( #menu_path >= 3 ) then

			local res = mob_trading.do_trade( self, player, menu_path, trade_details, counted_inv );

			if( res.msg ) then
				formspec = formspec..
					'textarea[1.0,5.1;8,1.0;info;;'..( minetest.formspec_escape( res.msg ))..']';
				minetest.chat_send_player( pname, self.trader_name..': '..res.msg );
			end
			local allow_repeat = true;
			if( res.success ) then
				-- if the trader is one that has no inv but a limited stock, then substract that stock
				if( self.trader_stock and self.trader_stock[ choice1 ]) then
					self.trader_stock[ choice1 ][2] = self.trader_stock[ choice1 ][2] - 1;
					-- callback function used to get new stock
					mobf_trader.trader_with_stock_after_sale( self, player, menu_path, trade_details, trader_goods );
					if( self.trader_stock[ choice1 ][2] < 1 ) then
						table.remove( self.trader_stock, choice1 );
						-- the trader has no more of that; choice1 points to a diffrent trade offer now
						allow_repeat = false;
						-- the old selected trade is no longer availabel
						menu_path = {menu_path[1]};
						-- update the goods the trader has on offer
						trader_goods = mobf_trader.trader_with_stock_get_goods( self, player, trader_goods );
					end
				-- update the inventory of traders of the type individual as well
				elseif( self.trader_typ == 'individual' and self.trader_owner) then
					counted_inv = mob_trading.count_trader_inv( self );
				end
				if( allow_repeat ) then
					formspec = formspec..
						'button[1.0,5.8;2.5,0.5;'..menu_path[1]..'_'..menu_path[2]..'_'..menu_path[3]..';Repeat the trade]';
				end
			end
			if( allow_repeat ) then
				formspec = formspec..'button[1.5,6.3;2,0.5;'..menu_path[1]..'_'..menu_path[2]..';Show prices]';
			end
		end	


		if( #menu_path >= 2 ) then

			-- if that button is clicked, show the same formspec again
			if( offer_packages ) then 
				formspec = formspec..
					'label[0.3,'..(5.1+p_up)..';Get all of this]'..
					'label[2.0,'..(4.1+p_up)..';for]'..
					'label[3.0,'..(3.00+p_up)..';Select what you want to give:]'..

					mob_trading.show_trader_formspec_item_list(
						0, 4.0+p_up-0.6, trade_details[1], menu_path[2], npc_id, 1.0, 1.0, 1, counted_inv, true, self )..
						'box[-0.15,'..(4.0+p_up-0.70)..';2.1,2.4;#00AA00]';
			else
				formspec = formspec..
					'label[0.3,'..(4.0+p_up)..';Get]'..
					'box[0.25,'..(3.8+p_up)..';1.75,1.10;#00AA00]'..

					mob_trading.show_trader_formspec_item_list(
						0.5, 4.0+p_up-0.6, trade_details[1], menu_path[2], npc_id, 1.0, 1.0, 1, counted_inv, true, self );
			end


			if( (self.trader_owner and self.trader_owner == pname ) and self.trader_typ=='individual') then
				formspec = formspec..'button[9,'..(3.7+p_up)..';1,0.5;'..npc_id..'_delete_'..menu_path[2]..';Delete]'..
				                     'button[9,'..(4.7+p_up)..';1,0.5;'..npc_id..'_edit_'..  menu_path[2]..';Edit]'; 
			end

			-- the real options here are the prices
			local npc_id_det   = npc_id..'_'..menu_path[2];

			local or_or_for = 'for';
			for i,v in ipairs( trade_details ) do
	
				local boxcolor = '#0000CC';
				-- the first entry is the good that is offered; all subsequent ones are prices
				if( i > 1 ) then
					if( i > 2 ) then
						or_or_for = 'or';
					end
					if( i%2==1 ) then
						boxcolor = '#AAAAAA';
					end
					if( offer_packages ) then 
						formspec = formspec..
							'label['..((i-1)*2.40+0.0)..','..(5.1+p_up)..';'..or_or_for..']'..
							'button['..((i-1)*2.40+0.3)..','..(5.3+p_up)..';1.5,0.5;'..
							 npc_id_det..'_'..tostring( i )..';Payment '..tostring(i-1)..']'..

							mob_trading.show_trader_formspec_item_list(
								((i-1)*2.40), 4.0+p_up-0.6, trade_details[i], i, npc_id_det, 1.0, 1.0, 1, counted_inv, false, self )..
								'box['..(-0.15+((i-1)*2.40))..','..(4.0+p_up-0.70)..';2.1,2.4;'..boxcolor..']';
					else
						formspec = formspec..
							'label['..((i)*1.2-0.3)..','..(4.0+p_up)..';'..or_or_for..']'..
							'box['..((i*1.2)-0.34)..','..(3.8+p_up)..';1.15,1.10;'..boxcolor..']'..
							mob_trading.show_trader_formspec_item_list(
								((i*1.2)-0.5), 4.0+p_up-0.6, trade_details[i], i, npc_id_det, 1.0, 1.0, 1, counted_inv, false, self );
					end
				end
			end
		end

		
		-- show the amount of sold items after the purchase
		if( menu_path and #menu_path >= 2 ) then
			-- show how much of these items/packages have been sold already
			if(    self.trader_sold
			   and self.trader_sold[ trade_details[ 1 ]]) then
				formspec = formspec..'label[9.0,'..(3.9+p_up)..';Sold: '..
					tostring( self.trader_sold[ trade_details[ 1 ]] )..']';
			else
				formspec = formspec..'label[9.0,'..(3.9+p_up)..';Sold: -]';
			end

			if(    self.trader_stock
			   and self.trader_stock[ choice1 ]
			   and self.trader_stock[ choice1 ][2] ) then
				formspec = formspec..'label[9.0,'..(3.7+p_up)..';Stock: '..
					tostring( math.max( 0, self.trader_stock[ choice1 ][2] ))..']';
			end
		end
	end

	-- show the goods the trader has to offer
	for i,v in ipairs( trader_goods ) do

		formspec = formspec..mob_trading.show_trader_formspec_item_list(
				((i-1)%8)+1, math.floor((i-1)/8)*1.2+(1.0+m_up), v[1], i, npc_id, 0.4, 0.4, 0.6, counted_inv, true, self);
	end



	minetest.show_formspec( pname, "mob_trading:trader", formspec );
end




-- TODO: use can_trade instead of duplicating checks here?
--------------------------------------------------------------------------
-- show an image button for *one* item stack that is part of a trade offer
--------------------------------------------------------------------------
-- helper function;
-- if there is enough space (only one stack offered or one offer selected), the amount of items in that stack will be shown as a label;
-- additional information such as "SOLD OUT" is added so that it becomes immmediately obvious if the trade is not possible;
-- self.trader.trader_limit is used
mob_trading.show_trader_formspec_item = function( offset_x, offset_y, text_offset_x, text_offset_y, stack_desc, nr, prefix, size, counted_inv, is_offer, self )

	local stack = ItemStack( stack_desc );
	local anz   = stack:get_count();
	local name  = stack:get_name();
	local label = '';
	local label_amount = '';

	-- show the label with the amount of item showed only if more than one is sold and the button is large enough
	if( anz > 1 and size>0.7) then
		label_amount = '\n\n\t\t'..tostring( anz )..'x';
	else
		label = '';
	end
	
	-- TODO: in case of money, there is no check yet weather the side concerned can afford the trade
	if( name==mob_trading.MONEY_ITEM or name==mob_trading.MONEY2_ITEM) then
		return { text='image_button['..offset_x..','..offset_y..';'..size..','..size..';'..
			      'mobf_trader_money.png;'..
			      prefix..'_'..tostring( nr )..';;;]'..
			      label,
			 anz_avail = 0 };
	end

	-- do not show unknown blocks
	if( not( minetest.registered_items[ name ] )) then
		return { text='', anz_avail=0};
	end

	local anz_avail = 0;

	if( counted_inv and self and self.trader_inv) then
		if(     is_offer
		   -- no more in stock
		   and (   (not(counted_inv[name]) or counted_inv[name]<anz )
		        or (     self.trader_limit 
                             and self.trader_limit.sell_if_more
			     and self.trader_limit.sell_if_more[ name ] 
		             -- ...or less than what the trader is supposed to keep as a reserve
			     and self.trader_limit.sell_if_more[ name ] > (counted_inv[name]-anz) ))) then 
			label_amount = "SOLD\nOUT";
			anz_avail = 0;

		elseif( is_offer ) then
			-- how many more of these items are on sale?
		        if (     self.trader_limit 
                             and self.trader_limit.sell_if_more
			     and self.trader_limit.sell_if_more[ name ] ) then
				anz_avail = math.floor( (counted_inv[name]-self.trader_limit.sell_if_more[ name ]) / anz );
			else
				anz_avail = math.floor( (counted_inv[name]) / anz );
			end

		-- is there enough free space?
		elseif( not(is_offer) and not( self.trader_inv:room_for_item( 'main', stack ))) then
			label_amount = "NO\nSPACE\nLEFT";

		-- upper storage limit reached
		elseif( not(is_offer)
		        and self.trader_limit 
                        and self.trader_limit.buy_if_less
			and self.trader_limit.buy_if_less[ name ] 
		        -- only buy up to buy_if_less items of this kind
			and self.trader_limit.buy_if_less[ name ] < (counted_inv[name]+anz)) then 

			label_amount = "NO MORE\nWANTED";
		end
	end

	return { text='item_image_button['..offset_x..','..offset_y..';'..size..','..size..';'..
		      ( name or '?')..';'..
		      prefix..'_'..tostring( nr )..';'..label_amount..']'..
		      -- SOLD OUT etc. have to be seperate labels instead of labels of the item_image_buttons because
		      -- the item_image_buttons can't handle multiple lines of text
		      label,
		 anz_avail = anz_avail };
end


--------------------------------------------------------------------------
-- shows the complete offer (consisting of up to 4 seperate stacks)
--------------------------------------------------------------------------
-- set stretch_x and stretch_y to 0.4 each plus quarter_botton_size to 0.6 in order to make everything fit into one formspec
mob_trading.show_trader_formspec_item_list = function( offset_x, offset_y, stack_desc, nr, prefix, stretch_x, stretch_y, quarter_button_size, counted_inv, is_offer, self )

	-- show multiple items
	if( type( stack_desc )=='table') then

		local formspec = '';
		-- display first image at the lower left corner
		local a = 0;
		local b = 1;

--		formspec = formspec..'label['..(offset_x)..','..(offset_y+0.6)..';Package]';
		-- we can display no more than 4 items
		local k = math.min( 4, #stack_desc );
		-- if there are only 2 items, display them centralized
		if( k==2 ) then
			offset_x = offset_x + 0.5*stretch_x;
		end
			
		local error_msg = '';
		local error_msg_offset = 0;
		local anz_avail = 1000;
		if( stretch_x > 0.7 ) then
			error_msg_offset = 0.65;
		end
		for i = 1,k do

			local res = mob_trading.show_trader_formspec_item(offset_x+(a*stretch_x), offset_y+(b*stretch_y),
					offset_x+error_msg_offset, offset_y+error_msg_offset,
					stack_desc[i], nr, prefix, quarter_button_size, counted_inv, is_offer, self );
			formspec = formspec..res.text;
			-- the item of which the least amount is available determines how many packages can be sold
			if( res.anz_avail < anz_avail ) then
				anz_avail = res.anz_avail;
			end

			if(    i==1) then a = 1; b = 0; -- 2nd: upper right corner
			elseif(i==2) then a = 1; b = 1; -- 3rd: lower right corner
			elseif(i==3) then a = 0; b = 0; -- 4rd: upper left corner
			end

			-- 2 items: always display centralized
			if( k==2 ) then
				a = 0;
			end
		end
		if( stretch_x > 0.7 and is_offer and anz_avail>0) then
			formspec = formspec..'label[9.0,'..(offset_y+0.75)..';Left: '..tostring(anz_avail)..']';
		end
		return formspec;
	else

		-- put the only image we have to display in a central position
		if( quarter_button_size==1 ) then
			offset_x = offset_x + quarter_button_size/2;
			offset_y = offset_y + quarter_button_size/2;
		end

		local res = mob_trading.show_trader_formspec_item( offset_x, offset_y, offset_x, offset_y, stack_desc, nr, prefix, 1, counted_inv, is_offer, self );
		if( stretch_x > 0.7 and is_offer and res.anz_avail>0) then
			res.text = res.text..'label[9.0,'..(offset_y+0.25)..';Left: '..tostring(res.anz_avail)..']';
		end
		return res.text;
	end
end




--------------------------------------------------
-- Store new trade offer or change existing one
--------------------------------------------------
-- changes trader_goods if the add or edit succeeded
-- changes menu_path so that the newly added/edited offer is displayed
-- sends a chat message to the player in case of success and returns ''; else returns error message
mob_trading.store_trade_offer_changes = function( self, pname,  menu_path, fields, trader_goods )

	local offer = {};
	local i = 1;
	local j = 1;

	-- t1 has to be filled in - it has to contain the stack the player wants to offer
	if(   (not( fields[ 't1' ] ) or fields[ 't1'] == '' )
	  and (not( fields[ 't2' ] ) or fields[ 't2'] == '' )
	  and (not( fields[ 't3' ] ) or fields[ 't3'] == '' )
	  and (not( fields[ 't4' ] ) or fields[ 't4'] == '' )) then
		return 'Error: What do you want to offer? Please enter something after \'Sell:\'!';
	end

	for i=1,mob_trading.MAX_ALTERNATE_PAYMENTS do
		local offer_one_side = {};
		for j=1,4 do
			local text = fields[ 't'..tostring(((i-1)*4)+j) ];
			if( text and text ~= '' ) then
				local help = text:split( ' ' );
				-- if no amount is given, assume 1
				if( #help < 2 ) then
					help[2] = 1;
				end
				-- the amount of items can only be positive
				help[2] = tonumber( help[2] );
				if( not( help[2] ) or help[2]<1 ) then
					return 'Error: Negative amounts are not supported: \''..( text )..'\'.';
				end
				-- money and money2 are acceptable as well
				if( not( minetest.registered_items[ help[1] ] ) and help[1]~=mob_trading.MONEY_ITEM and help[1]~=mob_trading.MONEY2_ITEM) then
					return 'Error: \''..tostring( help[1] )..'\' is not a valid item. Please check your spelling.';
				end
				-- do not allow stacks that are larger than max stack size (this is not relevant for money)
				if( minetest.registered_items[ help[1] ] ) then
					local stack = ItemStack( text );
					if( stack:get_count() > stack:get_stack_max() ) then
						return 'Error: \''..tostring( help[1] )..'\' can only be traded in stacks of up to '..
							tostring( stack:get_stack_max() )..' pieces at a time.';
					end
				end
				table.insert( offer_one_side, text );
			end
		end
		-- use a string to store
		if( #offer_one_side==1) then
			table.insert( offer, offer_one_side[1] );
		-- use a table to store (necessary when up to four items are bundled)
		elseif( #offer_one_side>1) then
			table.insert( offer, offer_one_side );
		end
	end
	if( #offer < 2 ) then
		return 'Please provide at least one form of payment.';
	end
	if( #trader_goods >= mob_trading.MAX_OFFERS and (menu_path[2]=='storenew' or menu_path[2]=='storenewm')) then
		return 'Sorry. Each trader can only make up to '..tostring( mob_trading.MAX_OFFERS )..' diffrent offers.';
	end


	if( not(trader_goods )) then
		trader_goods = {};
	end
	if( menu_path[2]=='storenew' or menu_path[2]=='storenewm') then
		-- TODO: check if a similar offer exists already
		table.insert( trader_goods, offer ); 
		-- inform the trader about his new offer
		self.trader_goods = trader_goods;
			
		-- display the newly stored offer
		minetest.chat_send_player( pname, self.trader_name..': Your new offer has been added.');
		mob_basics.update( self, 'trader'); -- store new offer

		-- make sure the new offer is selected and displayed when this function here continues
		menu_path[2] = #trader_goods;
		return '';

	elseif( menu_path[2]=='storechange') then
		local edit_nr = tonumber( menu_path[3] );
		-- store the modified offer
		if( edit_nr and edit_nr > 0 and edit_nr <= #trader_goods ) then
			trader_goods[ edit_nr ] = offer;
			self.trader_goods       = trader_goods;
			minetest.chat_send_player( pname, self.trader_name..': The offer has been changed.');
		end
		mob_basics.update( self, 'trader'); -- store changed offer
		-- display the modified offer
		menu_path[2] = edit_nr;
		menu_path[3] = nil;
		return '';
	end
	return 'Error: Unknown command.';
end



-------------------------------------------------------------------------------
-- helper function for mob_trading.show_trader_limits;
-- changes the table items
mob_trading.insert_item_limitation = function( items, k, i, v )
	if( i<1 or i>4) then
		return;
	end
	if( not( items[ k ] )) then
		-- 0 in stock; sell if more than 0; buy if less than 10000; item is part of a trade offer
		items[ k ] = { 0, 0, 10000, false };
	end
	items[ k ][ i ] = v;
end


-------------------------------------------------------------------------------
-- display and allow configuration of self.trader_limit
-------------------------------------------------------------------------------
mob_trading.show_trader_formspec_limits = function( self, player, menu_path, fields, trader_goods, npc_id, pname, counted_inv )

	local items = {};

	if( not( self.trader_limit )) then
		self.trader_limit = {};
	end
	if( not( self.trader_limit.sell_if_more )) then
		self.trader_limit.sell_if_more = {};
	end
	if( not( self.trader_limit.buy_if_less )) then
		self.trader_limit.buy_if_less = {};
	end


	local selected = 2;
	-- store the new limits
	if( #menu_path > 2 and menu_path[2]=='limitstore' and fields['SellIfMoreThan'] and fields['BuyIfLessThan']
		and mob_trading.tmp_lists[ pname ] and #mob_trading.tmp_lists[ pname ] >= tonumber( menu_path[3] )
		and tonumber( menu_path[3] )>0) then
		
			local selected = mob_trading.tmp_lists[ pname ][ tonumber(menu_path[3]) ];

			local anz = tonumber(fields['SellIfMoreThan']);
			if( anz > 0 and anz < 10000 ) then
				self.trader_limit.sell_if_more[ selected ] = anz;
			end

			anz = tonumber(fields['BuyIfLessThan']);
			if( anz > 0 and anz < 10000 ) then
				self.trader_limit.buy_if_less[ selected ] = anz;
			end
	end


	-- everything the trader has in his chest is a candidate for trading
	if( not( counted_inv )) then
		counted_inv = {};
	end
	for k,v in pairs( counted_inv ) do
		mob_trading.insert_item_limitation( items, k, 1, v );
	end

	if( self.trader_goods ) then
		-- everything that's in one of the offers the trader makes
		for j,w in ipairs( self.trader_goods ) do -- for all trade offer
			for i,v in ipairs( w ) do -- for one particular trade offer and all possible payments
				if( type( v )=='table' ) then 
					for _,s in ipairs( v ) do -- for all items that are part of a trade
						mob_trading.insert_item_limitation( items, ItemStack(s):get_name(), 4, true );
					end
				else -- only one item is offered
					mob_trading.insert_item_limitation(         items, ItemStack(v):get_name(), 4, true);
				end
			end
		end
	end

	-- everything for which there's already a self.trader_limit.sell_if_more limit
	for k,v in pairs( self.trader_limit.sell_if_more ) do
		mob_trading.insert_item_limitation( items, k, 2, v );
	end

	-- everything for which there's already a self.trader_limit.buy_if_less limit
	for k,v in pairs( self.trader_limit.buy_if_less ) do
		mob_trading.insert_item_limitation( items, k, 3, v );
	end
	


	-- show the input form for new limits
	if( fields[ npc_id..'_limitlist' ] ) then
		local selection =  minetest.explode_table_event( fields[ npc_id..'_limitlist' ] );
		if( selection and selection['row']) then
			selected = selection['row'];
		end

		if( (selection['type'] == 'DCL' or selection['type'] == 'CHG')
		   and mob_trading.tmp_lists[ pname ] and #mob_trading.tmp_lists[ pname ] >= selected 
		   and mob_trading.tmp_lists[ pname ][ selected ] ~= "" ) then

			local selected_item = mob_trading.tmp_lists[ pname ][ selected ];

			local formspec = 'size[6,4]'..
				'item_image[0.0,1.0;1.0,1.0;'..selected_item..']'..
				'label[1.0,0.0;Set limits for buy and sell]'..
				'label[1.5,0.5;Description:]'..
					'label[3.5,0.5;'..( minetest.registered_items[ selected_item ].description or '?' )..']'..
				'label[1.5,1.0;Item name:]'..
					'label[3.5,1.0;'..tostring( selected_item )..']'..
				'label[1.5,1.5;In stock:]'..
					'label[3.5,1.5;'..tostring( items[ selected_item ][1] )..']'..
				'label[1.5,2.0;Sell if more than]'..
					'field[3.5,2.5;1.2,0.5;SellIfMoreThan;;'..tostring( items[ selected_item ][2] )..']'..
						'label[4.5,2.0;are in stock.]'..
				'label[1.5,2.5;Buy if less than]'..
					'field[3.5,3.0;1.2,0.5;BuyIfLessThan;;'..tostring( items[ selected_item ][3] )..']'..
						'label[4.5,2.5;are in stock.]'..
				'button[0.5,3.5;2,0.5;'..npc_id..'_limitstore_'..tostring(selected)..';Store]'..
				'button[3.0,3.5;2,0.5;'..npc_id..'_limitlist;Abort]';

			minetest.show_formspec( pname, "mob_trading:trader", formspec );
			mob_basics.update( self, 'trader'); -- store current limitations
			return;
		end
	end

	-- all items for which limitations might possibly be needed have been collected;
	-- now display them
	local formspec = 'size[12,12]'..
			'button[4.0,2.0;2,0.5;'..npc_id..'_main;Back]'..
			'tablecolumns[' ..
--			'image;'..
			      'text,align=left;'..
			'color;text,align=right;'..
			'color;text,align=center;'..
			      'text,align=right;'..
			'color;text,align=center;'..
			      'text,align=right;'..
			'color;text,align=left]'..
                        'table[0.1,2.7;11.4,8.8;'..npc_id..'_limitlist;';

	if( not( mob_trading.tmp_lists[ pname ])) then
		mob_trading.tmp_lists[ pname ] = {};
	end
	local col = 0;
	local row = 2;
	for k,v in pairs( items ) do
	
		table.insert( mob_trading.tmp_lists[ pname ], k );
		local c1 = '#FF0000';
		if( v[1] > 0 ) then
			c1 = '#BBBBBB';
		end
		local t1 = 'sell always';
		local c2 = '#006600';
		if( v[2] > 0 ) then
			c2 = '#00FF00';
			t1 = 'sell if more than:';
		end
		local t2 = 'buy always';
		local c3 = '#666600';
		if( v[3] ~= 10000 ) then
			c3 = '#FFFF00';
			t2 = 'buy if less than:';
		end

		local desc = '';
		if( k =="" ) then
			desc = '<empty inventory slot>';
			k    = '<nothing>';
		elseif( minetest.registered_items[ k ] 
		    and minetest.registered_items[ k ].description ) then
			desc = minetest.registered_items[ k ].description;
		end

		formspec = formspec..
			desc..','..
			c1..','..         tostring( v[1] )..','..
			c2..','..t1..','..tostring( v[2] )..','..
			c3..','..t2..','..tostring( v[3] )..',#AAAAAA,'..k..',';
	end
	if( selected > #items ) then
		selected = 1;
	end

	mob_basics.update( self, 'trader'); -- store current limitations

	formspec = formspec..';'..selected..']';

	-- display the formspec
	minetest.show_formspec( pname, "mob_trading:trader", formspec );
end


-------------------------------------------------------------------------------
-- show a formspec that allows to add a new trade offer or edit an existing one
-------------------------------------------------------------------------------
mob_trading.show_trader_formspec_edit = function( self, player,  menu_path, fields, trader_goods, formspec, npc_id, pname )


	local player_inv = player:get_inventory();
	local edit_nr    = 0;

	if(     menu_path[2]=='add') then
		formspec = formspec..
			'button[0.5,6.3;2,0.5;'..npc_id..'_storenew;Store]'..
			'button[3.0,6.3;2,0.5;'..npc_id..'_main;Abort]'..
			'label[3.0,-0.2;Add a new simple trade offer]'..
			'textarea[1.0,0.5;9,1.5;info;;'..( minetest.formspec_escape( 
				'Plese enter what you want to trade in exchange for what.\n'..
				'The items in the top row of your inventory serve as sample entries to the fields here.\n'..
				'Please edit the input fields to suit your needs or abort and re-arrange your inventory so\n'..
				'that what you want to offer is leftmost, while trade goods you ask for extend to the right.'))..']';
	elseif( menu_path[2]=='addm' ) then
		formspec = formspec..
			'button[0.5,6.3;2,0.5;'..npc_id..'_storenewm;Store]'..
			'button[3.0,6.3;2,0.5;'..npc_id..'_main;Abort]'..
			'label[3.0,-0.2;Add a new complex trade offer]'..
			'textarea[1.0,0.5;9,1.5;info;;'..( minetest.formspec_escape( 
				'Plese enter which item(s) you want to trade in exchange for which item(s).\n'..
				'The items in the colored columns of your inventory serve as sample entries to the fields here.\n'..
				'Please edit the input fields to suit your needs or abort and re-arrange your inventory.\n'..
				'The green, blue and gray fields form bundles of up to four items.'))..']';
	elseif( menu_path[2]=='edit' ) then
		formspec = formspec..
			'button_exit[0.5,6.3;2,0.5;'..npc_id..'_storechange_'..menu_path[3]..';Store]'..
			'button_exit[3.0,6.3;2,0.5;'..npc_id..'_main;Abort]'..
			'label[3.0,-0.2;Edit trade offer]'..
			'textarea[1.0,1.5;9,0.5;info;;'..minetest.formspec_escape( 
				'Plese edit this trade offer according to your needs.')..']';
		edit_nr = tonumber( menu_path[3] );
		if( not( edit_nr ) or edit_nr < 1 or edit_nr>#trader_goods ) then
			edit_nr = 0;
		end
	end

	local texts = {};
	-- add a complex trade with multiple (up to four) items for each side? or is a 1:1 trade sufficient?
	local extended = false;
	if( menu_path[2]=='addm' ) then
		extended = true;
	end
	for i=1,mob_trading.MAX_ALTERNATE_PAYMENTS do
		for j=1,4 do
			local text  = '';

			-- edit input from previous attempt
			if( fields and fields[ 't'..tostring(((i-1)*4)+j) ] ) then
				text = fields[ 't'..tostring(((i-1)*4)+j) ];
			-- edit an existing offer
			elseif( edit_nr and edit_nr > 0 and edit_nr <= #trader_goods ) then
				if( type( trader_goods[ edit_nr ][i] )=='table' ) then
					text = ( trader_goods[ edit_nr ][i][j] or '');
					extended = true;
				elseif( j==1 ) then
					text = ( trader_goods[ edit_nr ][i]    or '');
				else
					text = '';
				end
			-- take what's in the player's inventory as a base
			else
				local stack = player_inv:get_stack( 'main', ((j-1)*8)+i );

				if( not( stack:is_empty() )) then
					text = stack:get_name()..' '..stack:get_count();
				else
					text = '';
				end
			end
			table.insert( texts, text );
		end
	end

	for i=1,mob_trading.MAX_ALTERNATE_PAYMENTS do
		local o     = 0;
		local ltext = 'or';
		local boxcolor = '#0000CC';
		-- the 'Sell' is not as far to the right as the rest
		if(     i==1 ) then
			o     = -1;
			ltext = 'Sell';
			boxcolor = '#00AA00';
		elseif( i==2 ) then
			ltext = 'for';
		elseif( i>1 and (i%2==1)) then
			boxcolor = '#AAAAAA';
		end
		if( extended ) then -- distinguish between simple (one item offered, 1 wanted) and complex (up to 4 offered; up to 4 wanted) trades
			if( i<5 ) then
			    formspec = formspec..
				'label['..(1.0+o)..','..( 1.0+(i*1.1))..';'..ltext..']'..
				'box['..(  0.8+o)..','..( 0.86+(i*1.1))..';9.1,1.04;'..boxcolor..']'..
				'field['..(2.1+o)..','..( 1.0+(i*1.1))..';3.9,1.0;t'..tostring((i*4)-3)..';;'..
					minetest.formspec_escape( texts[ (i*4)-3] )..']'..
				'field['..(2.1+o)..','..( 1.5+(i*1.1))..';3.9,1.0;t'..tostring((i*4)-2)..';;'..
					minetest.formspec_escape( texts[ (i*4)-2] )..']'..
				'field['..(6.2+o)..','..( 1.0+(i*1.1))..';3.9,1.0;t'..tostring((i*4)-1)..';;'..
					minetest.formspec_escape( texts[ (i*4)-1] )..']'..
				'field['..(6.2+o)..','..( 1.5+(i*1.1))..';3.9,1.0;t'..tostring((i*4)  )..';;'..
					minetest.formspec_escape( texts[ (i*4)  ] )..']'..
				'label['..(5.5+o)..','..( 1.0+(i*1.1))..';and]';
			end
		else
			-- the colors are a bit darker when offering a simple trade
			if( boxcolor=='#AAAAAA' ) then
				boxcolor = '#777777';
			elseif( boxcolor=='#0000CC' ) then
				boxcolor = '#000077';
			end
			formspec = formspec..
				'label['..(2.0+o)..','..( 2.5+(i*0.5))..';'..ltext..']'..
				'box['..(  1.8+o)..','..( 2.55+(i*0.5))..';8.1,0.51;'..boxcolor..']'..
				'field['..(3.1+o)..','..( 2.7+(i*0.5))..';7,1.0;t'..tostring((i*4)-3)..';;'..
					minetest.formspec_escape( texts[ (i*4)-3 ] )..']';
		end
	end
	minetest.show_formspec( pname, "mob_trading:trader", formspec );
end






-----------------------------------------------------------------------------------------------------
-- checks if the deptor can pay the price to the receiver (and if the receiver has enough free space)
-----------------------------------------------------------------------------------------------------
-- If the other side is an admin shop/trader with unlimited supply:
--          receiver_name has to be nil or '' and  receiver_inv has to be empty for unlmiited trade
-- The function uses recursion in case of table value for price_stack_str and calls itshelf for each price part.
mob_trading.can_trade = function( price_stack_str, debtor_name, debtor_inv, receiver_name, receiver_inv, player_is_debtor, counted_inv, self )

	-- we've got multiple items to care for
	if( type( price_stack_str )=='table' ) then
		
		-- sum up requests like 2x99 of one type or multiple requests for money
		local items = {};
		local anz_diffrent_items = 0;
		for _,v in ipairs( price_stack_str ) do
			local price_stack = ItemStack( v );
			-- get information about the price
			local price_stack_name  = price_stack:get_name();
			local price_stack_count = price_stack:get_count();
			if( not( items[ price_stack_name ])) then
				items[ price_stack_name ] = price_stack_count;
				-- lua can't count....
				anz_diffrent_items = anz_diffrent_items + 1;
			else
				items[ price_stack_name ] = items[ price_stack_name ] + price_stack_count;
			end
		end
		-- check for each part if it can be paid
		local price_desc   = '';
		local price_stacks = {};
		local price_types  = {};
		local free_slots_wanted = #price_stack_str; -- for each price stack, we need a free inventory slot
		for k,v in pairs( items ) do
			-- recursively check if payment is possible
			local res = mob_trading.can_trade( k..' '..tostring( v ), debtor_name, debtor_inv, receiver_name, receiver_inv, player_is_debtor, counted_inv, self );
			-- if a part cannot be paid, the whole trade cannot be made
			if( res.error_msg ) then
				return res;
			end
			-- store the information about this part of the payment
			table.insert( price_stacks, res.price_stacks[1]);
			table.insert( price_types,  res.price_types[1] );
			-- description of first item 
			if(     price_desc == '' ) then
				price_desc = res.price_desc;
			-- cheat: this is the last price description
			elseif( #price_stacks == anz_diffrent_items ) then
				price_desc = price_desc..' and '..res.price_desc;
			else
				price_desc = price_desc..', '..res.price_desc;
			end
			-- if money/money2 is part of the price, then that will not need a free inventory slot in the trader's chest
			if( (res.price_types and res.price_types[1] ~= 'direct' ) or (player_is_debtor and not(counted_inv)) ) then
				free_slots_wanted = free_slots_wanted - 1;
			end
		end
		-- with several items as payment, we want a free slot for each payment - else we cannot be sure that the trader can store all of the payment
		if( free_slots_wanted > 0 and (not(counted_inv) or not(counted_inv[""]) or counted_inv[""]<free_slots_wanted )) then
			return { error_msg = 'Sorry, I do not have enough free inventory slots to ensure that the trade can take place.',
				 price_desc = price_desc, price_stacks = price_stacks, price_types = price_types };
		end
		-- if all parts can be paid, the whole payment will be possible
		return { error_msg = nil, price_desc = price_desc, price_stacks = price_stacks, price_types = price_types };
	end
	
	local price_stack = ItemStack( price_stack_str );
	-- get information about the price
	local price_desc        = '';
	local price_stack_name  = price_stack:get_name();
	local price_stack_count = price_stack:get_count();
	-- this is set to a text message in case something can't be paid
	local error_msg         = '';
	-- the trade may contain money (from two diffrent mods) or items; this indicates which tpye was choosen by price_stack_str
	local price_type        = '?';
	-- empty price stacks are pointless for a trader
	if(     price_stack:is_empty() or price_stack_count < 0) then
		error_msg  = 'Sorry. This is no exchange of presents. Both sides have to contribute to the trade. The following is not acceptable: '..
				tostring( price_stack_str );
		price_desc = price_stack_str;

	-- in case the money mod is used
	elseif( price_stack_name == mob_trading.MONEY_ITEM) then
		price_type = 'money';
		price_desc = CURRENCY_PREFIX..price_stack_count..CURRENCY_POSTFIX;

		if( not( money ) or not( money.exist )) then
			error_msg = 'Sorry. There seems to be something wrong with the money mod.';

		elseif( debtor_name   and debtor_name   ~= '' and not( money.exist( debtor_name ))) then
			error_msg = 'no_account_debtor';

		-- the other party needs an account as well (except for admin shops)
		elseif( receiver_name and receiver_name ~= '' and not( money.exist( receiver_name ))) then
			error_msg = 'no_account_receiver';

		elseif( debtor_name and money.get_money( debtor_name ) < price_stack_count ) then
			error_msg = 'no_money';
		end

	-- in case the money2 mod is used
	elseif( price_stack_name == mob_trading.MONEY2_ITEM) then
		price_type = 'money2';
		price_desc = price_stack_count..' '..( money.currency_name or 'cr' );

		if( not( money ) or not( money.has_credit ) or not( money.get )) then
			error_msg = 'Sorry. There seems to be something wrong with the money2 mod.';

		elseif( debtor_name   and debtor_name   ~= '' and not( money.has_credit( debtor_name ))) then
			error_msg = 'no_account_debtor';

		elseif( receiver_name and receiver_name ~= '' and not( money.has_credit( receiver_name ))) then
			error_msg = 'no_account_receiver';

		elseif( debtor_name and money.get( debtor_name ) < price_stack_count ) then
			error_msg = 'no_money';
		end


	-- item-based trade 
	else
		price_type = 'direct';
		if( not( minetest.registered_items[ price_stack_name ] )) then

			error_msg  = 'There is something wrong with my offer. Seems \''..tostring( price_stack_name )..'\' does not exist anymore.';
			price_desc = price_stack_name;

		else
			price_desc = price_stack_count..'x '..
				( minetest.registered_items[ price_stack_name ].description or price_stack_name);
		end	

		-- does the debtor have the item? 
		if(       debtor_inv and not( debtor_inv:contains_item("main", price_stack ))) then
			error_msg = 'no_item';

		-- does the trader have more than sell_if_more of the item requested?
		elseif(   debtor_inv
		      and counted_inv
 		      and not( player_is_debtor )
		      and self.trader_limit 
                      and self.trader_limit.sell_if_more
		      and self.trader_limit.sell_if_more[ price_stack_name ] 
		      -- less than what the trader is supposed to keep as a reserve
		      and self.trader_limit.sell_if_more[ price_stack_name ] > (counted_inv[ price_stack_name ]-price_stack_count) ) then 
			error_msg = 'no_intrest';
		     
		-- does the trader want any more of this kind of payment?
		elseif(   debtor_inv
		      and counted_inv
 		      and player_is_debtor
		      and self.trader_limit 
                      and self.trader_limit.buy_if_less
		      and self.trader_limit.buy_if_less[ price_stack_name ] 
		      -- less than what the trader is supposed to keep as a reserve
		      and self.trader_limit.buy_if_less[ price_stack_name ] < (counted_inv[ price_stack_name ]+price_stack_count) ) then 
			error_msg = 'no_intrest';

		-- does the receiver have enough free room to take the item?
		elseif( receiver_inv and not( receiver_inv:room_for_item("main", price_stack ))) then
			error_msg = 'no_space';
		end

	end


	if( error_msg == '' ) then
		return { error_msg = nil, price_desc = price_desc, price_stacks = {price_stack}, price_types = {price_type} };
	end

	-- create extensive error messages, depending on who does lack what in order to finish the trade
	if(     error_msg == 'no_account_debtor' ) then
		if( player_is_debtor ) then
			error_msg = 'You do not have a bank account. Please get one so that we can trade.';
		else
			error_msg = 'Sorry. I lost my bank account data. Please contact my owner!';
		end

	elseif( error_msg == 'no_account_receiver') then
		if( not(player_is_debtor)) then
			error_msg = 'You do not have a bank account. Please get one so that we can trade.';
		else
			error_msg = 'Sorry. I lost my bank account data. Please contact my owner!';
		end

	elseif( error_msg == 'no_money' ) then
		if( player_is_debtor) then
			error_msg = 'You do not have enough money. The price is '..tostring( price_desc )..'.';
		else
			error_msg = 'Sorry, my shop ran out of money. I cannot afford to buy. Please come back later!';
		end

	elseif( error_msg == 'no_item' ) then
		if( player_is_debtor) then
			error_msg = 'You do not have '..tostring( price_desc )..'.';
		else
			error_msg = 'Oh. I just noticed that I ran out of '..tostring( price_desc )..'. Please come back later!';
		end

	
	elseif( error_msg == 'no_space' ) then
		if( player_is_debtor) then
			error_msg = 'Sorry. I do not have any storage space left for '..tostring( price_desc )..'. Please come back later!';
		else
			error_msg = 'You do not have enough free space in your inventory for '..tostring( price_desc )..'.';
		end

	-- in case the self.trader_limit.* values prevent the trader from trading
	elseif( error_msg == 'no_intrest') then
		if( player_is_debtor) then
			error_msg = 'Sorry, I am not intrested in any more '..tostring( price_desc )..' right now. Please come back later!';
		else
			error_msg = 'Sorry, but I do not have any '..tostring( price_desc )..' left I\'m willing to sell. Please come back later!';
		end
	end


	-- price_desc is important for printing out the price to the player
	return { error_msg = error_msg, price_desc = price_desc, price_stacks = {price_stack}, price_types = {price_type} };
end



-----------------------------------------------------------------------------------------------------
-- moves stack from source_inv to target_inv;
--     if either does not exist, the stack is removed (i.e. with traders that are not of type individual)
-----------------------------------------------------------------------------------------------------
mob_trading.move_trade_goods = function( source_inv, target_inv, stack, player, self )

	local stacks_removed = {};

	-- in case of non-individual traders selling something, there might be no source inv
	if( source_inv ) then
		local anz = stack:get_count();
		-- large stacks may have to be split up
		while( anz > 0 ) do
			-- do not create stacks which are larger than get_stack_max
			if( stack:get_stack_max() < anz) then
				stack:set_count( stack:get_stack_max() );
			end
			local removed = source_inv:remove_item( "main", stack );
			if( not(removed) or removed:get_count() < 1 ) then
				-- this error is not supposed to happen - we DID check if everything could get removed; if this error occourse nonetheless,
				-- it requires further invesitation
				minetest.chat_send_player( player:get_player_name(),'Error: Could not transfer all the promised items. Failed to remove '..
					tostring( stack:get_name() )..' '..tostring( stack:get_count() )..'. Please contact an admin!');
				print( '[mob_trading] ERROR: Could not transfer all items; player: '..tostring( player:get_player_name() )..
					', trading with '..tostring( self.trader_name or '?' )..'; '..tostring( stack:get_name() )..
					' '..tostring( stack:get_count()..'.'));

				return false;
			end
			anz = anz - removed:get_count();
			stack:set_count( anz );
			table.insert( stacks_removed, removed );
		end
	else
		stacks_removed = { stack };
	end

	-- non-individual traders do not store what they receive; they have no target inv
	if( not( target_inv )) then
		return true;
	end

	for i,v in pairs( stacks_removed ) do
		-- the stack may be larger than max stack size and thus require more than one add_item-call
		local remaining_stack = v;	
		while( not( remaining_stack:is_empty() )) do

			-- add as many as possible in one go
			local leftover = target_inv:add_item( 'main', remaining_stack );

			-- in case nothing was added to target_inv: an error occoured (i.e. target_inv full)
			if( not( leftover:is_empty())
			    and (leftover:get_count() >= remaining_stack:get_count())) then

				-- find a place between player and trader so that the player can see the items falling down; slightly elevated
				local p1 = player:get_pos();
				local p2 = self.object:get_pos();
				local p3 = {x=p1.x-((p1.x-p2.x)/2), y=p1.y-((p1.y-p2.y)/2)+1.0, z=p1.z-((p1.z-p2.z)/2)};

				-- tell the player to take a look
				minetest.chat_send_player( player:get_player_name(), self.trader_name..': '..
					'You do not have enough free space in your inventory. '..
					'Therefore, '..leftover:get_count()..'x '..leftover:get_name()..' have been dropped at where you stand.');
				-- place the item stack at the position where the player is standing
				minetest.add_item( p3, remaining_stack );
				-- the stack was dropped completely
				leftover:set_count(0);
				if( not( leftover:is_empty())) then
					minetest.chat_send_player( player:get_player_name(), self.trader_name..': ERROR: Failed to drop the items at your feet!');
					return;
				end
			end
			remaining_stack = leftover;
		end
	end
	-- everything has been moved
	return true;
end


-----------------------------------------------------------------------------------------------------
-- locates a locked chest owned by the given trader and returns the inventory;
--    sets self.trader_inv to the inventory
-----------------------------------------------------------------------------------------------------
mob_trading.find_trader_inv = function( self )
	if( not( self ) or not( self.object )) then
		return nil;
	end
	local RANGE = mob_trading.LOCKED_CHEST_SEARCH_RANGE;
	local tpos = self.object:get_pos(); -- current position of the trader
	-- search for locked chest from default, locks mod and technic mod chests
	-- ignore technic mithril chests as those are not locked
	local chest_list = minetest.find_nodes_in_area(
		{ x=(tpos.x-RANGE), y=(tpos.y-RANGE), z=(tpos.z-RANGE )},
		{ x=(tpos.x+RANGE), y=(tpos.y+RANGE), z=(tpos.z+RANGE )},
		mob_trading.KNOWN_LOCKED_CHESTS );
	for _, p in ipairs( chest_list ) do
		local meta = minetest.get_meta( p );
		if( meta and meta:get_string('owner') and meta:get_string('owner')==self.trader_owner ) then
			self.trader_inv = meta:get_inventory();
			return self.trader_inv;
		end
	end
	return nil;
end


-----------------------------------------------------------------------------------------------------
-- count how many items of each type the trader has in his chest
-----------------------------------------------------------------------------------------------------
--      empty stacks are counted under the key ""; for other items, the amount of items of each type is counted
mob_trading.count_trader_inv = function( self )
	if( not( self.trader_inv )) then
		return {};
	end
	local anz = self.trader_inv:get_size('main');
	local stored = {};
	for i=1, anz do
		local stack = self.trader_inv:get_stack('main', i );
		local name = stack:get_name();
		local count = stack:get_count();
		-- count empty stacks 
		if( name=="" ) then
			count = 1;
		end
		-- count how much of each item is there
		if( not( stored[ name ])) then
			stored[ name ] = count;
		else
			stored[ name ] = stored[ name ] + count;
		end
	end
	return stored;
end


-----------------------------------------------------------------------------------------------------
-- check if payment and trade are possible; do the actual trade
-----------------------------------------------------------------------------------------------------
-- self ought to contain: trader_id, trader_typ, trader_owner, trader_home_pos, trader_sold (optional - for statistics)
-- traders of the type 'individual' who do have owners will search their environment for chests owned by their owner;
--      said chests contain the stock of the trader
mob_trading.do_trade = function( self, player, menu_path, trade_details, counted_inv )

	if( not( self ) or not( player ) or not( menu_path ) or #menu_path < 3) then
		return {msg='', success=false};
	end

	local player_inv = player:get_inventory();
	local pname      = player:get_player_name();
	local choice2    = tonumber( menu_path[3] );
	local formspec   = '';

	-- the first entry is what is sold
	if( not( choice2 ) or choice2 > #trade_details or choice2 < 2) then
		choice2 = 2;
	end

	local trader_inv   = nil; 
	-- traders who do have an owner need to have an inventory somewhere
	if( self.trader_owner and self.trader_owner ~= '' and self.trader_typ=='individual') then

		if( not( self.trader_inv )) then
			self.trader_inv = mob_trading.find_trader_inv( self );
		end
		if( not( self.trader_inv )) then
			return {msg='Sorry. I was unable to find my storage chest. Please contact my owner!', success=false};
		end
	end

	-- can the player pay the selected payment to the trader?
	local player_can_trade = mob_trading.can_trade( trade_details[ choice2 ], pname, player_inv, self.trader_owner, self.trader_inv, true, counted_inv, self );
	if( player_can_trade.error_msg ) then
		return {msg=player_can_trade.error_msg, success=false};
	end

	-- can the trader in turn give the player what the player paid for?
	local trader_can_trade = mob_trading.can_trade( trade_details[ 1       ], self.trader_owner, self.trader_inv, pname, player_inv, false, counted_inv, self );
	if( trader_can_trade.error_msg ) then
		return {msg=trader_can_trade.error_msg, success=false};
	end
		

	-- both sides are able to give what they agreed on - the trade may progress;
	-- traders that use money/money2 need to have an owner for their account

	-- each trade may require the exchange of multiple items
	for i,v in pairs( player_can_trade.price_types ) do
		-- the player pays first
		if(     player_can_trade.price_types[i] == 'money' ) then
			local amount = player_can_trade.price_stacks[i]:get_count();
			money.set_money( self.trader_owner, get_money( self.trader_owner ) + amount );
			money.set_money( pname,             get_money( pname )             - amount );
					
		elseif( player_can_trade.price_types[i] == 'money2' ) then
			local res = money.transfer( pname, self.trader_owner, player_can_trade.price_stacks[i]:get_count() );
			if( res ) then
				return {msg='Internal error: Payment failed: '..tostring( res )..'.', success=false};
			end
	
		elseif( player_can_trade.price_types[i] == 'direct' ) then
			local res = mob_trading.move_trade_goods( player_inv, self.trader_inv, player_can_trade.price_stacks[i], player, self );
		end
	end


	for i,v in pairs( trader_can_trade.price_types ) do
		-- the trader replies
		if(     trader_can_trade.price_types[i] == 'money' ) then
			local amount = trader_can_trade.price_stacks[i]:get_count();
			money.set_money( pname,             get_money( pname )             + amount );
			money.set_money( self.trader_owner, get_money( self.trader_owner ) - amount );
					
		elseif( trader_can_trade.price_types[i] == 'money2' ) then
			local res = money.transfer( self.trader_owner, pname, trader_can_trade.price_stacks[i]:get_count() );
			if( not( res )) then
				return {msg='Internal error: Payment failed.', success=false};
			end
	
		elseif( trader_can_trade.price_types[i] == 'direct' ) then
			local res = mob_trading.move_trade_goods( self.trader_inv, player_inv, trader_can_trade.price_stacks[i], player, self );
		end
	end


	-- let the trader do some statistics
	if( not( self.trader_sold )) then
		self.trader_sold = {};
	end
	if( not( self.trader_sold[ trade_details[ 1 ]] )) then
		self.trader_sold[  trade_details[ 1 ]] = 1;
	else
		self.trader_sold[  trade_details[ 1 ]] = self.trader_sold[ trade_details[ 1 ]] +1;
	end

	-- log the action
	minetest.log("action", '[mob_trading] '..
				player:get_player_name()..
				' gets '..minetest.serialize(   trade_details[ 1 ])..
				' for ' ..minetest.serialize(   trade_details[ choice2 ])..
				' from '..tostring(             self.trader_id )..
				' at '..minetest.pos_to_string( self.object:get_pos() )..
				' (owned by '..tostring(        self.trader_owner )..')'..
				' typ:'..tostring(              self.trader_typ or '?' )..'.');

	mob_basics.update( self, 'trader'); -- store updated statistic of sold items

	return {msg='You got '..trader_can_trade.price_desc..' for your '..player_can_trade.price_desc..
			'. Thank you! Would you like to trade more?', success=true};
end

