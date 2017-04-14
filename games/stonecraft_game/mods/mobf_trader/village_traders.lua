
mob_village_traders = {}

-- spawn traders in villages
mob_village_traders.part_of_village_spawned = function( village, minp, maxp, data, param2_data, a, cid )
	-- if mobf_trader is not installed, we can't spawn any mobs;
	-- if mg_villages is not installed, we do not need to spawn anything
	if(   not( minetest.get_modpath( 'mobf_trader'))
	   or not( minetest.get_modpath( 'mg_villages'))
	   or not( mob_basics )
	   or not( mob_basics.spawn_mob )) then
		return;
	end

	-- diffrent villages may have diffrent traders
	local village_type  = village.village_type;

	-- for each building in the village
	for i,bpos in pairs(village.to_add_data.bpos) do
		-- get data about the building
		local building_data = mg_villages.BUILDINGS[ bpos.btype ];

		-- only handle buildings that are at least partly contained in that part of the
		-- village that got spawned in this mapchunk
		if( not(  bpos.x > maxp.x or bpos.x + bpos.bsizex < minp.x
		       or bpos.z > maxp.z or bpos.z + bpos.bsizez < minp.z ) 
		   -- the building type determines which kind of traders will live there
		   and building_data
		   and building_data.typ 
		   -- avoid spawning them twice
		   and not( bpos.traders )) then

			-- choose traders; the replacements may be relevant:
			-- wood traders tend to sell the same wood type of which their house is built
			local traders = mob_village_traders.choose_traders( village_type, building_data.typ, village.to_add_data.replacements );

			-- find spawn positions for all traders in the list
			local all_pos = mob_village_traders.choose_trader_pos(bpos, minp, maxp, data, param2_data, a, cid, traders);

			-- actually spawn the traders
			for _,v in ipairs( all_pos ) do
				mob_basics.spawn_mob( {x=v.x, y=v.y, z=v.z}, v.typ, nil, nil, nil, nil, true );
			end

			-- store the information about the spawned traders
			village.to_add_data.bpos[ i ].traders = all_pos;
		end
	end
end


mob_village_traders.choose_traders = function( village_type, building_type, replacements )

	if( not( building_type ) or not( village_type )) then
		return {};
	end
	
	-- some jobs are obvious
	if(     building_type == 'mill' ) then
		return { 'miller' };
	elseif( building_type == 'bakery' ) then
		return { 'baker' };
	elseif( building_type == 'school' ) then
		return { 'teacher' };
	elseif( building_type == 'forge' ) then
		local traders = {'blacksmith', 'bronzesmith' };
		return { traders[ math.random(#traders)] };
	elseif( building_type == 'shop' ) then
		local traders = {'seeds','flowers','misc','default','ore', 'fruit trader', 'wood'};
		return { traders[ math.random(#traders)] };
	-- there are no traders for these jobs - they'd require specialized mobs
	elseif( building_type == 'tower'
	     or building_type == 'church'
	     or building_type == 'secular'
	     or building_type == 'tavern' ) then
		return {};
	end

	if(     village_type == 'charachoal' ) then
		return { 'charachoal' };
	elseif( village_type == 'claytrader' ) then
		return { 'clay' };
	end

	local res = {};
	if(   building_type == 'shed'
	   or building_type == 'farm_tiny' 
	   or building_type == 'house'
	   or building_type == 'house_large'
	   or building_type=='hut') then
		local traders = { 'stonemason', 'stoneminer', 'carpenter', 'toolmaker',
			'doormaker', 'furnituremaker', 'stairmaker', 'cooper', 'wheelwright',
			'saddler', 'roofer', 'iceman', 'potterer', 'bricklayer', 'dyemaker',
			'dyemakerl', 'glassmaker' }
		-- sheds and farms both contain craftmen
		res = { traders[ math.random( #traders )] };
		if(    building_type == 'shed'
		    or building_type == 'house'
		    or building_type == 'house_large'
		    or building_type == 'hut' ) then
			return res;
		end
	end

	if(   building_type == 'field'
	   or building_type == 'farm_full'
	   or building_type == 'farm_tiny' ) then

		local fruit = 'farming:cotton';
		if( 'farm_full' ) then
			-- RealTest
			fruit = 'farming:wheat';
			if( replacements_group['farming'].traders[ 'farming:soy']) then
				fruit = 'farming:soy';
			end
			if( minetest.get_modpath("mobf") ) then
				local animal_trader = {'animal_cow', 'animal_sheep', 'animal_chicken', 'animal_exotic'};
				res[1] = animal_trader[ math.random( #animal_trader )];	
			end
			return { res[1], replacements_group['farming'].traders[ fruit ]};
		elseif( #replacements_group['farming'].found > 0 ) then
			-- get a random fruit to grow
			fruit = replacements_group['farming'].found[ math.random( #replacements_group['farming'].found) ];
			return { res[1], replacements_group['farming'].traders[ fruit ]};
		else
			return res;
		end
	end

	if( building_type == 'pasture' and minetest.get_modpath("mobf")) then
		local animal_trader = {'animal_cow', 'animal_sheep', 'animal_chicken', 'animal_exotic'};
		return { animal_trader[ math.random( #animal_trader )] };
	end	


	-- TODO: banana,cocoa,rubber from farming_plus?
	-- TODO: sawmill
	if( building_type == 'lumberjack' or village_type == 'lumberjack' ) then
		-- find the wood replacement
		local wood_replacement = 'default:wood';
		for _,v in ipairs( replacements ) do
			if( v and v[1]=='default:wood' ) then
				wood_replacement = v[2];
			end
		end
		-- lumberjacks are more likely to sell the wood of the type of house they are living in
		if( wood_replacement and math.random(1,3)==1) then
			return { replacements_group['wood'].traders[ wood_replacement ]};
		-- ...but not exclusively
		elseif( replacements_group['wood'].traders ) then
			-- construct a list containing all available wood trader types
			local list = {};
			for k,v in pairs( replacements_group['wood'].traders ) do
				list[#list+1] = k;
			end
			return { replacements_group['wood'].traders[ list[ math.random( 1,#list )]]};
		-- fallback
		else
			return { 'common_wood'};
		end
	end

	
	-- tent, chateau: places for living at; no special jobs associated
	-- nore,taoki,medieval,lumberjack,logcabin,canadian,grasshut,tent: further village types

	return res;
end


-- chooses trader positions for multiple traders for one particular building
mob_village_traders.choose_trader_pos = function(pos, minp, maxp, data, param2_data, a, cid, traders)

	local trader_pos = {};
	-- determine spawn positions for the mobs
	for i,tr in ipairs( traders ) do
		local tries = 0;
		local found = false;
		local pt = {x=pos.x, y=pos.y-1, z=pos.z};
		while( tries < 20 and not(found)) do
			-- get a random position for the trader
			pt.x = (pos.x-1)+math.random(0,pos.bsizex+1);
			pt.z = (pos.z-1)+math.random(0,pos.bsizez+1);
			-- check if it is inside the area contained in data
			if (pt.x >= minp.x and pt.x <= maxp.x) and (pt.y >= minp.y and pt.y <= maxp.y) and (pt.z >= minp.z and pt.z <= maxp.z) then

				while( pt.y < maxp.y 
				  and (data[ a:index( pt.x, pt.y,   pt.z)]~=cid.c_air
				    or data[ a:index( pt.x, pt.y+1, pt.z)]~=cid.c_air )) do
					pt.y = pt.y + 1;
				end

				-- check if this position is really suitable? traders standing on the roof are a bit odd
				local node_id = data[ a:index( pt.x, pt.y-1, pt.z)];
				local def = {};
				if( node_id and minetest.get_name_from_content_id( node_id )) then
					def = minetest.registered_nodes[ minetest.get_name_from_content_id( node_id)];
				end
				if( not(def) or not(def.drawtype) or def.drawtype=="nodebox" or def.drawtype=="mesh" or def.name=='air') then
					found = false;
				elseif( def and def.name ) then
					found = true;
				end
			end
			tries = tries+1;

			-- check if this position has already been assigned to another trader
			for j,t in ipairs( trader_pos ) do
				if( t.x==pt.x and t.y==pt.y and t.z==pt.z ) then
					found = false;
				end
			end
		end

		-- there is usually free space around the building; use that for spawning
		if( found==false ) then
			if( pt.x < minp.x ) then
				pt.x = pos.x + pos.bsizex+1;
			else
				pt.x = pos.x-1;
			end
			pt.z = pos.z-1 + math.random( pos.bsizez+1 );
			-- let the trader drop down until he finds ground
			pt.y = pos.y + 20;
			found = true;
		end

		table.insert( trader_pos, {x=pt.x, y=pt.y, z=pt.z, typ=tr} );
	end
	return trader_pos;
end
