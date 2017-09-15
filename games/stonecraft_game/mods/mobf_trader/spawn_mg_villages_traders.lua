
-- interface function for mg_villages;
-- the table "bed" contains all necessary information about the mob
mobf_trader.spawn_one_trader = function( bed )
	local prefix = 'trader';

	-- does the mob exist already?
	if( bed.mob_id ) then
		-- search for it
		local self = mob_basics.find_mob_by_id( bed.mob_id, 'trader' );
		if( self and self.object ) then
			-- make sure he sleeps on his assigned bed
			mob_sitting.sleep_on_bed( self, bed );
			-- return the id of the mob
			return bed.mob_id;
		end
	end


	local trader_typ = bed.title;
	if( not( trader_typ ) or trader_typ=="" or not( mob_basics.mob_types[ prefix ][ trader_typ ])) then
		trader_typ = 'teacher'; -- TODO: FALLBACK
	end

	-- try to spawn the mob
	local self = mob_basics.spawn_mob( bed, trader_typ, nil, nil, nil, nil, true );
	if( not( self )) then
		print("ERROR: NO TRADER GENERATED FOR "..minetest.pos_to_string( bed ));
		return nil;
	end

	bed.mob_id =  self[prefix..'_id'];

	-- select a texture depending on the mob's gender
	if( bed.gender == "f" ) then
		self[ prefix..'_texture' ] = "baeuerin.png";
	else
		self[ prefix..'_texture' ] = "wheat_farmer_by_addi.png";
	end
	self.object:set_properties( { textures = { self[ prefix..'_texture'] }});

	-- children are smaller
	if( bed.age < 19 ) then
		local factor = 0.2+bed.age/36;
		self[ prefix..'_vsize'] = {x=factor, y=factor, z=factor}; -- x,z:width; y: height
		mob_basics.update_visual_size( self, self[ prefix..'_vsize'], false, prefix );
	end
	-- position on bed and set sleeping animation
	mob_sitting.sleep_on_bed( self, bed );
	--print("SPAWNING TRADER "..trader_typ.." id: "..tostring( bed.mob_id ).." at bed "..minetest.pos_to_string( bed )); -- TODO
	return bed.mob_id;
end
