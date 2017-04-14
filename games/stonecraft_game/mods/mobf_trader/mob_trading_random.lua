
-- fallback function that populates mobf_trader.global_trade_offers with some random offers
mobf_trader.init_global_trade_offers = function()
	local materials = {'wood','stone','steel','copper','bronze','mese','diamond'};
	local tools = {'default:pick_', 'default:axe_', 'default:shovel_', 'default:sword_'};
	for _,m in ipairs( materials ) do
		for _,t in ipairs( tools ) do
			for k=3,5 do
				mobf_trader.global_trade_offers[ #mobf_trader.global_trade_offers+1 ] = {
					offer = { t..m, 'default:steel_ingot '..math.random(1,20)},
					min = math.random(1,3),
					max = math.random(1,20)
				};
			end
		end
	end
end

-- make sure the global trade offer list contains some values to choose from
if( not( mobf_trader.global_trade_offers ) or #mobf_trader.global_trade_offers<1 ) then
	mobf_trader.init_global_trade_offers();
end


mobf_trader.trader_with_stock_add_random_offer = function( self, anz_new_offers, trader_goods )
	
	if( not( self.trader_stock )) then
		self.trader_stock = {};
	end

	if( not( trader_goods ) or #trader_goods<1) then
		trader_goods = mobf_trader.global_trade_offers;
	end

	for i=1,anz_new_offers do
		-- select a random offer
		local nr = math.random(1,#trader_goods );
		-- avoid duplicate offers 
		local found = false;
		for _,v in ipairs( self.trader_stock ) do
			if( v[1]==nr ) then
				found = true;
			end
		end
		-- give the trader a random amount of these trade goods
		if( not( found ) and trader_goods[ nr ]) then
			local stock_size = 1;
			if( trader_goods[ nr ].min and trader_goods[ nr ].max ) then
				stock_size = math.random( trader_goods[ nr ].min, trader_goods[ nr ].max );
			else
				-- TODO: make this configurable for each trader?
				stock_size = math.random(mobf_trader.RANDOM_STACK_MIN_SIZE,mobf_trader.RANDOM_STACK_MAX_SIZE);
			end
			self.trader_stock[ #self.trader_stock+1 ] = { nr, stock_size };
		end
	end
end


-- sets self.trader_stock
mobf_trader.trader_with_stock_init = function( self, trader_goods )
	mobf_trader.trader_with_stock_add_random_offer( self, math.random(1,math.min(24, trader_goods)), trader_goods );
end

-- return the list of goods represented by self.trader_stock
mobf_trader.trader_with_stock_get_goods = function( self, player, trader_goods )
	if( not( trader_goods ) or #trader_goods<1) then
		trader_goods = mobf_trader.global_trade_offers;
	end

	if( not( self.trader_stock )) then
		mobf_trader.trader_with_stock_init( self, trader_goods );
	end
	local goods = {};
	for i,v in ipairs( self.trader_stock ) do
		if( trader_goods[ v[1] ] ) then
			if( trader_goods[ v[1] ].offer ) then
				goods[#goods+1] = trader_goods[ v[1] ].offer;
			else
				goods[#goods+1] = trader_goods[ v[1] ];
			end
		end
	end
	return goods;
end

-- can be used to give the trader new stock
-- self.trader_goods are the goods the trader has on offer
-- self.trader_sold  is what he sold up until now (including the recent trade)
-- self.trader_stock is how many times the trader is willing to do a particular trade until he runs out of stock
mobf_trader.trader_with_stock_after_sale = function( self, player, menu_path, trade_details, trader_goods )
	-- traders without offers get a new random one;
	-- otherwise, getting a new offer is less likely the more offers the trader already has
	if( #self.trader_stock<1 or math.random(1,#self.trader_stock*2)==1 ) then
		mobf_trader.trader_with_stock_add_random_offer( self, math.random(1,2), trader_goods );
	end
	mob_basics.update_texture( self, "trader", nil );
end
