
mob_village_traders = {}

mob_village_traders.names_male = { "John", "James", "Charles", "Robert", "Joseph",
	"Richard", "David", "Michael", "Christopher", "Jason", "Matthew",
	"Joshua", "Daniel","Andrew", "Tyler", "Jakob", "Nicholas", "Ethan",
	"Alexander", "Jayden", "Mason", "Liam", "Oliver", "Jack", "Harry",
	"George", "Charlie", "Jacob", "Thomas", "Noah", "Wiliam", "Oscar",
	"Clement", "August", "Peter", "Edgar", "Calvin", "Francis", "Frank",
	"Eli", "Adam", "Samuel", "Bartholomew", "Edward", "Roger", "Albert",
	"Carl", "Alfred", "Emmett", "Eric", "Henry", "Casimir", "Alan",
	"Brian", "Logan", "Stephen", "Alexander", "Gregory", "Timothy",
	"Theodore", "Marcus", "Justin", "Julius", "Felix", "Pascal", "Jim",
	"Ben", "Zach", "Tom" };

mob_village_traders.names_female = { "Amelia", "Isla", "Ella", "Poppy", "Mia", "Mary",
	"Anna", "Emma", "Elizabeth", "Minnie", "Margret", "Ruth", "Helen",
	"Dorothy", "Betty", "Barbara", "Joan", "Shirley", "Patricia", "Judith",
	"Carol", "Linda", "Sandra", "Susan", "Deborah", "Debra", "Karen", "Donna",
	"Lisa", "Kimberly", "Michelle", "Jennifer", "Melissa", "Amy", "Heather",
	"Angela", "Jessica", "Amanda", "Sarah", "Ashley", "Brittany", "Samatha",
	"Emily", "Hannah", "Alexis", "Madison", "Olivia", "Abigail", "Isabella",
	"Ava", "Sophia", "Martha", "Rosalind", "Matilda", "Birgid", "Jennifer",
	"Chloe", "Katherine", "Penelope", "Laura", "Victoria", "Cecila", "Julia",
	"Rose", "Violet", "Jasmine", "Beth", "Stephanie", "Jane", "Jacqueline",
	"Josephine", "Danielle", "Paula", "Pauline", "Patricia", "Francesca"}

-- get a middle name for the mob
mob_village_traders.get_random_letter = function()
	return string.char( string.byte( "A") + math.random( string.byte("Z") - string.byte( "A")));
end

-- this is for medieval villages
mob_village_traders.get_family_function_str = function( data )
	if(     data.generation == 2 and data.gender=="m") then
		return "worker";
	elseif( data.generation == 2 and data.gender=="f") then
		return "wife";
	elseif( data.generation == 3 and data.gender=="m") then
		return "father";
	elseif( data.generation == 3 and data.gender=="f") then
		return "mother";
	elseif( data.generation == 1 and data.gender=="m") then
		return "son";
	elseif( data.generation == 1 and data.gender=="f") then
		return "daughter";
	else
		return "unkown";
	end
end

mob_village_traders.get_full_trader_name = function( data, worker_data )
	if( not( data ) or not( data.first_name )) then
		return;
	end
	local str = data.first_name;
	if( data.mob_id ) then
	   str = "["..data.mob_id.."] "..minetest.pos_to_string( data ).." "..data.first_name;
	else
	   str = " -no mob assigned - "..minetest.pos_to_string( data ).." "..data.first_name;
	end

	if( data.middle_name ) then
		str = str.." "..data.middle_name..".";
	end
	if( data.last_name ) then
		str = str.." "..data.last_name;
	end
	if( data.age ) then
		str = str..", age "..data.age;
	end

	if( worker_data and worker_data.title and worker_data.title ~= "" ) then
		if( data.title and data.title == 'guest' ) then
			str = str..", a guest staying at "..worker_data.title.." "..worker_data.first_name.."'s house";
		elseif( data.generation==2 and data.gender=="m" and data.title and data.uniq>1) then
			str = str..", a "..data.title; --", one of "..tostring( worker_data.uniq ).." "..worker_data.title.."s";
		-- if there is a job:   , the blacksmith
		elseif( data.generation==2 and data.gender=="m" and data.title) then
			str = str..", the "..data.title;
			-- if there is a job:   , blacksmith Fred's son   etc.
		elseif( worker_data.uniq>1 ) then
			str = str..", "..worker_data.title.." "..worker_data.first_name.."'s "..mob_village_traders.get_family_function_str( data );
		else
			str = str..", the "..worker_data.title.."'s "..mob_village_traders.get_family_function_str( data );
		end
	-- else something like i.e. (son)
	elseif( data.generation and data.gender ) then
		str = str.." ("..mob_village_traders.get_family_function_str( data )..")";
	end
	return str;
end

-- TODO: shed12 and cow_shed are rather for annimals than working sheds
-- TODO: pastures are for annimals
-- TODO: show all fields the table beds may contain

-- configure a new inhabitant
-- 	gender		can be "m" or "f"
--	generation	2 for parent-generation, 1 for children, 3 for grandparents
--	name_exlcude	names the npc is not allowed to carry (=avoid duplicates)
--			(not a list but a hash table)
-- there can only be one mob with the same first name and the same profession per village
mob_village_traders.get_new_inhabitant = function( data, gender, generation, name_exclude, min_age )
	-- only create a new inhabitant if this one has not yet been configured
	if( not( data ) or data.first_name ) then
		return data;
	end

	-- the gender of children is random
	if( gender=="r" ) then
		if( math.random(2)==1 ) then
			gender = "m";
		else
			gender = "f";
		end
	end

	local name_list = {};
	if( gender=="f") then
		name_list = mob_village_traders.names_female;
		data.gender     = "f";   -- female
	else -- if( gender=="m" ) then
		name_list = mob_village_traders.names_male;
		data.gender     = "m";   -- male
	end
	local name_list_tmp = {};
	for i,v in ipairs( name_list ) do
		if( not( name_exclude[ v ])) then
			table.insert( name_list_tmp, v );
		end
	end
	data.first_name = name_list_tmp[ math.random(#name_list_tmp)];
	-- middle name as used in the english speaking world (might help to distinguish mobs with the same first name)
	data.middle_name = mob_village_traders.get_random_letter();

	data.generation = generation; -- 2: parent generation; 1: child; 3: grandparents
	if(     data.generation == 1 ) then
		data.age =      math.random( 18 ); -- a child
	elseif( data.generation == 2 ) then
		data.age = 18 + math.random( 30 ); -- a parent
	elseif( data.generation == 3 ) then
		data.age = 48 + math.random( 50 ); -- a grandparent
	end
	if( min_age ) then
		data.age = min_age + math.random( 12 );
	end
	return data;
end


-- assign inhabitants to bed positions; create families;
-- bpos needs to contain at least { beds = {list_of_bed_positions}, btype = building_type}
-- bpos is the building position data of one building each
mob_village_traders.assign_mobs_to_beds = function( bpos, house_nr, village_to_add_data_bpos )

	if( not( bpos ) or not( bpos.btype ) or not( bpos.beds)) then
		return bpos;
	end

	-- make sure no duplicates exist
	local check_duplicates = {};
	local new_table = {};
	for i,v in ipairs( bpos.beds ) do
		local str = minetest.pos_to_string( v );
		if( not(check_duplicates[ str ])) then
			table.insert( new_table, v );
		end
		check_duplicates[ str ] = 1;
	end
	bpos.beds = new_table;

	-- workplaces got assigned earlier on
	local works_at = nil;
	local title    = nil;
	local not_uniq = 0;
	-- any other plots (sheds, wagons, fields, pastures) the worker here may own
	local owns = {};
	for nr, v in ipairs( village_to_add_data_bpos ) do
		-- have we found the workplace of this mob?
		if( v and v.worker and v.worker.lives_at and v.worker.lives_at == house_nr ) then
			works_at = nr;
			title    = v.worker.title;
			if( v.worker.not_uniq ) then
				not_uniq = v.worker.not_uniq;
			end
		end
		-- ..or another plot that the mob might own?
		if( v and v.belongs_to and v.belongs_to == house_nr ) then
			table.insert( owns, nr );
		end
	end

	local worker_names_with_same_profession = {};
	-- if the profession of this mob is not uniq then at least make sure that he does not share a name with a mob with the same profession
	if( not_uniq > 1 ) then
		for nr, v in ipairs( village_to_add_data_bpos ) do
			if( v and v.worker and v.worker.lives_at
			  and village_to_add_data_bpos[ v.worker.lives_at ]
			  and village_to_add_data_bpos[ v.worker.lives_at ].beds
			  and village_to_add_data_bpos[ v.worker.lives_at ].beds[1]
			  and village_to_add_data_bpos[ v.worker.lives_at ].beds[1].first_name ) then
				table.insert( worker_names_with_same_profession, village_to_add_data_bpos[ v.worker.lives_at ].beds[1].first_name );
			end
		end
	end


	-- get data about the building
	local building_data = mg_villages.BUILDINGS[ bpos.btype ];
	-- the building type determines which kind of traders will live there
	if( not( building_data ) or not( building_data.typ )
	   -- are there beds where the mob can sleep?
	   or not( bpos.beds ) or table.getn( bpos.beds ) < 1) then
		return bpos;
	end

	-- lumberjack home
	if( building_data.typ == "lumberjack" ) then

		for i,v in ipairs( bpos.beds ) do
			-- lumberjacks do not have families and are all male
			v = mob_village_traders.get_new_inhabitant( v, "m", 2, worker_names_with_same_profession, nil );
			-- the first worker in a lumberjack hut can get work assigned and own other plots
			if( works_at and i==1) then
				v.works_at = works_at;
				v.title    = title;
				v.uniq     = not_uniq;
			else
				v.title    = 'lumberjack';
				v.uniq     = 99; -- one of many lumberjacks here
			end
			if( owns and #owns>0 ) then
				v.owns     = owns;
			end
		end

	-- normal house containing a family
	else
		-- the first inhabitant will be the male worker
		if( not( bpos.beds[1].first_name )) then
			bpos.beds[1] = mob_village_traders.get_new_inhabitant( bpos.beds[1], "m", 2, worker_names_with_same_profession, nil ); -- male of parent generation
			if( works_at ) then
				bpos.beds[1].works_at = works_at;
				bpos.beds[1].title    = title;
				bpos.beds[1].uniq     = not_uniq;
			end
			if( owns and #owns>0 ) then
				bpos.beds[1].owns     = owns;
			end
		end

		local name_exclude = {};
		-- the second inhabitant will be the wife of the male worker
		if( bpos.beds[2] and not( bpos.beds[2].first_name )) then
			bpos.beds[2] = mob_village_traders.get_new_inhabitant( bpos.beds[2], "f", 2, {}, nil ); -- female of parent generation
			-- first names ought to be uniq withhin a family
			name_exclude[ bpos.beds[2].first_name ] = 1;
		end

		-- not all houses will have grandparents
		local grandmother_bed_id = 2+math.random(5);
		local grandfather_bed_id = 2+math.random(5);
		-- some houses have guests
		local guest_id = 99;
		-- all but the given number are guests
		if( building_data.guests ) then
			guest_id = building_data.guests * -1;
		end
		-- a child of 18 with a parent of 19 would be...usually impossible unless adopted
		local oldest_child = 0;

		-- the third and subsequent inhabitants will ether be children or grandparents
		for i,v in ipairs( bpos.beds ) do
			if(     v and v.first_name and v.generation == 3 and v.gender=="f" ) then
				grandmother_bed_id = i;
			elseif( v and v.first_name and v.generation == 3 and v.gender=="m" ) then
				grandfather_bed_id = i;

			-- at max 7 npc per house (taverns may have more beds than that)
			elseif( v and not( v.first_name )) then
				if( i>guest_id ) then
					v = mob_village_traders.get_new_inhabitant( v, "r", math.random(3), name_exclude, nil ); -- get a random guest
					v.title = 'guest';
				elseif( i==grandmother_bed_id ) then
					v = mob_village_traders.get_new_inhabitant( v, "f", 3, name_exclude, bpos.beds[1].age+18 ); -- get the grandmother
				elseif( i==grandfather_bed_id ) then
					v = mob_village_traders.get_new_inhabitant( v, "m", 3, name_exclude, bpos.beds[1].age+18 ); -- get the grandfather
				else
					v = mob_village_traders.get_new_inhabitant( v, "r", 1, name_exclude, nil ); -- get a child of random gender
					-- find out how old the oldest child is
					if( v.age > oldest_child ) then
						oldest_child = v.age;
					end
				end
				-- children and grandparents need uniq names withhin a family
				name_exclude[ v.first_name ] = 1;
			end
		end
		-- the father has to be old enough for his children
		if( bpos.beds[1] and oldest_child + 18 > bpos.beds[1].age ) then
			bpos.beds[1].age = oldest_child + 18 + math.random( 10 );
		end
		-- the mother also has to be old enough as well
		if( bpos.beds[2] and oldest_child + 18 > bpos.beds[2].age ) then
			bpos.beds[2].age = oldest_child + 18 + math.random( 10 );
		end
	end

	return bpos;
end


-- print information about which mobs "live" in a house
mob_village_traders.print_house_info = function( village_to_add_data_bpos, house_nr  )

	local bpos = village_to_add_data_bpos[ house_nr ];
	local building_data = mg_villages.BUILDINGS[ bpos.btype ];

	if( not( building_data ) or not( building_data.typ )) then
		building_data = { typ = bpos.btype };
	end
	local str = "Plot Nr. "..tostring( house_nr ).." ["..tostring( building_data.typ or "-?-").."] ";
	if( bpos.btype == "road" ) then
		str = str.."is a road.\n";

	-- wagon, shed, field and pasture
	elseif( bpos.belongs_to and village_to_add_data_bpos[ bpos.belongs_to ].beds) then
		local owner = village_to_add_data_bpos[ bpos.belongs_to ].beds[1];
		if( not( owner ) or not( owner.first_name )) then
			str = str.."WARNING: NO ONE owns this plot.\n";
		else
			str = str.."belongs to: "..mob_village_traders.get_full_trader_name( owner, owner ).."\n";
		end

	elseif( not( bpos.beds ) or #bpos.beds<1 and bpos.worker and bpos.worker.title) then
		if( not( bpos.worker.lives_at)) then
			str = str.."WARNING: NO WORKER assigned to this plot.\n";
		else
			local worker = village_to_add_data_bpos[ bpos.worker.lives_at ].beds[1];
			str = str..mob_village_traders.get_full_trader_name( worker, worker ).." works here.\n";
		end

	elseif( not( bpos.beds ) or not( bpos.beds[1])) then
		str = str.."provides neither work nor housing.\n";

	else
		local mobs_need_to_respawn = false;

		str = str.."is inhabitated by:\n";
		for i,v in ipairs( bpos.beds ) do
			if( v and v.first_name ) then
				str = str.."  "..mob_village_traders.get_full_trader_name( v, bpos.beds[1] );
				if( i==1 and bpos.beds[1] and bpos.beds[1].works_at and bpos.beds[1].works_at==house_nr ) then
					str = str.." who lives and works here\n";
				elseif( i==1 ) then
					local works_at = bpos.beds[1].works_at;
					local btype2 = mg_villages.BUILDINGS[ village_to_add_data_bpos[ works_at ].btype];
					str = str.." who works at the "..tostring( btype2.typ ).." on plot "..tostring(works_at).."\n";
				else
					str = str.."\n";
				end

				if( v.mob_id ) then
					local self = mob_basics.find_mob_by_id( v.mob_id, 'trader' );
					if( not( self ) or not( self.object )) then
						-- TODO: mob missing in action
						v.mob_id = nil;
						mobs_need_to_respawn = true;
					else
						-- put the mob back on his/her bed
						mob_sitting.sleep_on_bed( self, v );
					end
				end

			end
		end
		-- other plots owned
		if( bpos.beds and bpos.beds[1] and bpos.beds[1].owns ) then
			str = str.."The family also owns the plot(s) ";
			for i,v in ipairs( bpos.beds[1].owns ) do
				if( i>1 ) then
					str = str..", ";
				end
				local building_data = mg_villages.BUILDINGS[ village_to_add_data_bpos[v].btype ];
				str = str.."Nr. "..tostring( v ).." ("..building_data.typ..")";
			end
			str = str.."\n";
		end
		if( mobs_need_to_respawn ) then
			mob_village_traders.spawn_traders_for_one_house( bpos, nil, nil );
		end
	end
	return str;
end



-- some building types will determine the name of the job
mob_village_traders.jobs_in_buildings = {};
mob_village_traders.jobs_in_buildings[ 'mill'       ] = {'miller'};
mob_village_traders.jobs_in_buildings[ 'bakery'     ] = {'baker'};
mob_village_traders.jobs_in_buildings[ 'church'     ] = {'priest'};
mob_village_traders.jobs_in_buildings[ 'tower'      ] = {'guard'};
mob_village_traders.jobs_in_buildings[ 'school'     ] = {'schoolteacher'};
mob_village_traders.jobs_in_buildings[ 'library'    ] = {'librarian'};
mob_village_traders.jobs_in_buildings[ 'tavern'     ] = {'barkeeper'};
mob_village_traders.jobs_in_buildings[ 'pub'        ] = {'barkeeper'};
mob_village_traders.jobs_in_buildings[ 'inn'        ] = {'innkeeper'};
mob_village_traders.jobs_in_buildings[ 'hotel'      ] = {'innkeeper'};
mob_village_traders.jobs_in_buildings[ 'forge'      ] = {'smith',
		-- bronzesmith, bladesmith, locksmith etc. may be of little use in our MT worlds;
		-- the blacksmith is the most common one, followed by the coppersmith
		{'blacksmith','blacksmith', 'blacksmith',  'coppersmith','coppersmith',
		 'tinsmith', 'goldsmith'}};
mob_village_traders.jobs_in_buildings[ 'shop'       ] = {'shopkeeper',
		-- the shopkeeper is the most common; however, there can be more specialized sellers
		{'shopkeeper', 'shopkeeper', 'shopkeeper', 'seed seller', 'flower seller', 'ore seller', 'fruit trader', 'wood trader'}};
mob_village_traders.jobs_in_buildings[ 'charachoal' ] = {'charachoal burner'};
mob_village_traders.jobs_in_buildings[ 'trader'     ] = {'trader'}; -- TODO: currently only used for clay traders
mob_village_traders.jobs_in_buildings[ 'chateau'    ] = {'servant'};
mob_village_traders.jobs_in_buildings[ 'sawmill'    ] = {'sawmill owner'};
mob_village_traders.jobs_in_buildings[ 'forrest'    ] = {'lumberjack'}; -- TODO: we don't have forrests yet
mob_village_traders.jobs_in_buildings['village_square']={'major'};



-- TODO pit - suitable for traders (they sell clay...)

mob_village_traders.assign_jobs_to_houses = function( village_to_add_data_bpos )

	local workers_required = {};	-- places that require a specific worker that lives elsewhere
	local found_farm_full  = {};	-- farmers (they like to work on fields and pastures)
	local found_hut        = {};	-- workers best fit for working in other buildings
	local found_house      = {};	-- workers which may either take a random job or work elsewhere
	local suggests_worker  = {};	-- sheds and wagons can support workers with a random job
	local suggests_farmer  = {};	-- fields and pastures are ideal for farmers
	-- find out which jobs need to get taken
	for house_id,bpos in ipairs(village_to_add_data_bpos) do
		-- get data about the building
		local building_data = mg_villages.BUILDINGS[ bpos.btype ];
		-- the building type determines which kind of traders will live there;

		-- nothing gets assigned if we don't have data
		if( not( building_data ) or not( building_data.typ )
		-- or if a mob is assigned already
		   or bpos.worker) then

		-- some buildings require a specific worker
		elseif( mob_village_traders.jobs_in_buildings[ building_data.typ ] ) then
			local worker_data = mob_village_traders.jobs_in_buildings[ building_data.typ ];
			bpos.worker = {};
			bpos.worker.works_as =  worker_data[1];
			-- the worker might be specialized
			if( worker_data[2] ) then
				bpos.worker.title = worker_data[2][ math.random( #worker_data[2])];
			-- otherwise his title is the same as his job name
			else
				bpos.worker.title = bpos.worker.works_as;
			end
			-- can the worker sleep there or does he require a house elsewhere?
			if( building_data.bed_count and building_data.bed_count > 0 ) then
				bpos.worker.lives_at = house_id;
			else
				table.insert( workers_required, house_id );
			end

		-- we have found a place with a bed that does not reuiqre a worker directly
		elseif( building_data.bed_count and building_data.bed_count > 0 ) then

			-- mobs having to take care of a full farm (=farm where the farmer's main income is
			-- gained from farming) are less likely to have time for other jobs
			if(     building_data.typ=='farm_full' ) then
				table.insert( found_farm_full, house_id );
			-- mobs living in a hut are the best candidates for jobs in other buildings
			elseif( building_data.typ=='hut' ) then
				table.insert( found_hut,       house_id );
			-- other mobs may either take on a random job or work in other buildings
			else
				table.insert( found_house,     house_id );
			end

		-- sheds and wagons are useful for random jobs but do not really require a worker
		elseif( building_data.typ == 'shed'
		     or building_data.typ == 'wagon' ) then

			table.insert( suggests_worker, house_id );

		-- fields and pastures are places where full farmers are best at
		elseif( building_data.typ == 'field'
		     or building_data.typ == 'pasture' ) then

			table.insert( suggests_farmer, house_id );
		end
	end

	-- TODO: these are only additional; they do not require a worker as such
	-- assign sheds and wagons randomly to suitable houses
	for i,v in ipairs( suggests_worker ) do
		-- order: found_house, found_hut, found_farm_full
		if(     #found_house>0 ) then
			local nr = math.random( #found_house );
			village_to_add_data_bpos[ v ].belongs_to = found_house[ nr ];
		elseif( #found_hut  >0 ) then
			local nr = math.random( #found_hut   );
			village_to_add_data_bpos[ v ].belongs_to = found_hut[ nr ];
		elseif( #found_farm_full>0 ) then
			local nr = math.random( #found_farm_full );
			village_to_add_data_bpos[ v ].belongs_to = found_farm_full[ nr ];
		else
		-- print("NOT ASSIGNING work PLOT Nr. "..tostring(v).." to anything (nothing suitable found)");
		end
	end

	-- assign fields and pastures randomly to suitable houses
	for i,v in ipairs( suggests_farmer ) do
		-- order: found_farm_full, found_house, found_hut
		if(     #found_farm_full>0 ) then
			local nr = math.random( #found_farm_full );
			village_to_add_data_bpos[ v ].belongs_to = found_farm_full[ nr ];
		elseif( #found_house>0 ) then
			local nr = math.random( #found_house );
			village_to_add_data_bpos[ v ].belongs_to = found_house[ nr ];
		elseif( #found_hut  >0 ) then
			local nr = math.random( #found_hut   );
			village_to_add_data_bpos[ v ].belongs_to = found_hut[ nr ];
		else
		-- print("NOT ASSIGNING farm PLOT Nr. "..tostring(v).." to anything (nothing suitable found)");
		end
	end

	-- find workers for jobs that require workes who live elsewhere
	for i,v in ipairs( workers_required ) do
		-- huts are ideal
		if(     #found_hut>0 ) then
			local nr = math.random( #found_hut );
			village_to_add_data_bpos[ v ].worker.lives_at = found_hut[ nr ];
			table.remove( found_hut, nr );
		-- but workers may also be gained from other houses where workers may live
		elseif( #found_house > 0 ) then
			local nr = math.random( #found_house );
			village_to_add_data_bpos[ v ].worker.lives_at = found_house[ nr ];
			table.remove( found_house, nr );
		-- if all else fails try to get a worker from a full farm
		elseif( #found_farm_full > 0 ) then
			local nr = math.random( #found_farm_full );
			village_to_add_data_bpos[ v ].worker.lives_at = found_farm_full[ nr ];
			table.remove( found_farm_full, nr );
		-- we ran out of potential workers...
		else
			-- TODO: no suitable worker found
			local building_data = mg_villages.BUILDINGS[ village_to_add_data_bpos[v].btype ];
			print("NO WORKER FOUND FOR Nr. "..tostring(v).." "..tostring( building_data.typ )..": "..minetest.serialize( village_to_add_data_bpos[v].worker )); -- TODO: just for debugging
		end
	end

	-- other owners of farm_full buildings become farmers
	for i,v in ipairs( found_farm_full ) do
		village_to_add_data_bpos[ v ].worker = {};
		village_to_add_data_bpos[ v ].worker.works_as = "farmer";
		village_to_add_data_bpos[ v ].worker.title    = "farmer";
		village_to_add_data_bpos[ v ].worker.lives_at = v; -- house number
	end


	-- add random jobs to the leftover houses
	local random_jobs = { 'stonemason', 'stoneminer', 'carpenter', 'toolmaker',
			'doormaker', 'furnituremaker', 'stairmaker', 'cooper', 'wheelwright',
			'saddler', 'roofer', 'iceman', 'potterer', 'bricklayer', 'dyemaker',
			'glassmaker' };
	for i,v in ipairs( found_house ) do
		local job = random_jobs[ math.random(#random_jobs)];
		village_to_add_data_bpos[ v ].worker = {};
		village_to_add_data_bpos[ v ].worker.works_as = job;
		village_to_add_data_bpos[ v ].worker.title    = job;
		village_to_add_data_bpos[ v ].worker.lives_at = v; -- house number
	end
	for i,v in ipairs( found_hut ) do
		local job = random_jobs[ math.random(#random_jobs)];
		village_to_add_data_bpos[ v ].worker = {};
		village_to_add_data_bpos[ v ].worker.works_as = job;
		village_to_add_data_bpos[ v ].worker.title    = job;
		village_to_add_data_bpos[ v ].worker.lives_at = v; -- house number
	end

	-- find out if there are any duplicate professions
	local professions = {};
	for house_nr,bpos in ipairs( village_to_add_data_bpos ) do
		if( bpos.worker and bpos.worker.title ) then
			if( not( professions[ bpos.worker.title ])) then
				professions[ bpos.worker.title ] = 1;
			else
				professions[ bpos.worker.title ] = professions[ bpos.worker.title ] + 1;
			end
		end
	end
	-- mark all those workers who share the same profession as "not_uniq"
	for house_nr,bpos in ipairs( village_to_add_data_bpos ) do
		if( bpos.worker and bpos.worker.title and professions[ bpos.worker.title ]>1) then
			bpos.worker.not_uniq = professions[ bpos.worker.title ];
		end
	end
	return village_to_add_data_bpos;
end


mob_village_traders.spawn_traders_for_one_house = function( bpos, minp, maxp )
	if( not( bpos ) or not( bpos.beds )) then
		return;
	end
	for i,bed in ipairs( bpos.beds ) do
		-- only for beds that exist, have a mob assigned and fit into minp/maxp
		if( bed
		  and bed.first_name
		  and (not( minp )
		    or (   bed.x>=minp.x and bed.x<=maxp.x
		       and bed.y>=minp.y and bed.y<=maxp.y
		       and bed.z>=minp.z and bed.z<=maxp.z))) then

			if( not( bed.mob_id )) then
				local trader_typ = bed.title;
				if( not( trader_typ ) or trader_typ=="" or not( mob_basics.mob_types[ 'trader' ][ trader_typ ])) then
					trader_typ = 'teacher'; -- TODO: FALLBACK
				end
				local self = mob_basics.spawn_mob( bed, trader_typ, nil, nil, nil, nil, true );
				if( self ) then
					local prefix = 'trader';
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
					print("SPAWNING TRADER "..trader_typ.." id: "..tostring( bed.mob_id ).." at bed "..minetest.pos_to_string( bed )); -- TODO
				else
					print("ERROR: NO TRADER GENERATED FOR "..minetest.pos_to_string( bed ));
				end

			else
				local self = mob_basics.find_mob_by_id( bed.mob_id, 'trader' );
				if( not( self ) or not( self.object )) then
					print("ERROR: TRADER "..tostring( bed.mob_id ).." got lost!");
				else
					-- put the mob back on his/her bed
					mob_sitting.sleep_on_bed( self, bed );
				end
			end
		end
	end
end


-- spawn traders in villages
mob_village_traders.part_of_village_spawned = function( village, minp, maxp, vm, data, param2_data, a, cid )
	-- if mobf_trader is not installed, we can't spawn any mobs;
	-- if mg_villages is not installed, we do not need to spawn anything
	if(   not( minetest.get_modpath( 'mobf_trader'))
	   or not( minetest.get_modpath( 'mg_villages'))
	   or not( mob_basics )
	   or not( mob_basics.spawn_mob )) then
		return;
	end

	village.to_add_data.bpos = mob_village_traders.assign_jobs_to_houses( village.to_add_data.bpos );

	-- diffrent villages may have diffrent traders
	local village_type  = village.village_type;

	-- for each building in the village
	for house_nr,bpos in ipairs(village.to_add_data.bpos) do

		bpos = mob_village_traders.assign_mobs_to_beds( bpos, house_nr, village.to_add_data.bpos );

		mob_village_traders.spawn_traders_for_one_house( bpos, minp, maxp );
	end

--[[
		   -- avoid spawning them twice
		   and not( bpos.traders )) then

print("ASSIGNING TO "..tostring(building_data.typ).." WITH beds "..minetest.serialize( bpos.beds ));
			-- choose traders; the replacements may be relevant:
			-- wood traders tend to sell the same wood type of which their house is built
			local traders = mob_village_traders.choose_traders( village_type, building_data.typ, village.to_add_data.replacements );

			-- find spawn positions for all traders in the list
			local all_pos = mob_village_traders.choose_trader_pos(bpos, minp, maxp, vm, data, param2_data, a, cid, traders);

			-- actually spawn the traders
			for _,v in ipairs( all_pos ) do
				mob_basics.spawn_mob( {x=v.x, y=v.y, z=v.z}, v.typ, nil, nil, nil, nil, true );
			end

			-- store the information about the spawned traders
			village.to_add_data.bpos[ i ].traders = all_pos;
--]]
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
		local traders = {'blacksmith', 'bronzesmith',
			'goldsmith', 'bladesmith', 'locksmith', 'coppersmith', 'silversmith', 'tinsmith' }; -- TODO: does not exist yet
		return { traders[ math.random(#traders)] };
	elseif( building_type == 'shop' ) then
		local traders = {'seeds','flowers','misc','default','ore', 'fruit trader', 'wood'};
		return { traders[ math.random(#traders)] };
	elseif( building_type == 'church' ) then
		return { 'priest' }; -- TODO: does not exist yet
	elseif( building_type == 'tower' ) then
		return { 'guard' }; -- TODO: does not exist yet  -- TODO: really only one guard per village?
	elseif( building_type == 'library' ) then
		return { 'librarian' }; -- TODO: does not exist yet
	elseif( building_type == 'tavern' ) then
		return { 'barkeeper'}; -- TODO: does not exist yet
	end

	if(     village_type == 'charachoal' ) then
		return { 'charachoal' };
	elseif( village_type == 'claytrader' ) then
		return { 'clay' };
	end

	local res = {};
	if(   building_type == 'shed' -- TODO: workers from the houses may work here
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

	-- TODO: trader, pit (in claytrader villages)
	end

	
	-- tent, chateau: places for living at; no special jobs associated
	-- TODO: chateau: may have a servant
	-- nore,taoki,medieval,lumberjack,logcabin,canadian,grasshut,tent: further village types

	return res;
end


-- chooses trader positions for multiple traders for one particular building
mob_village_traders.choose_trader_pos = function(pos, minp, maxp, vm, data, param2_data, a, cid, traders)

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
				  and (vm:get_data_from_heap(data,  a:index( pt.x, pt.y,   pt.z))~=cid.c_air
				    or vm:get_data_from_heap(data,  a:index( pt.x, pt.y+1, pt.z))~=cid.c_air )) do
					pt.y = pt.y + 1;
				end

				-- check if this position is really suitable? traders standing on the roof are a bit odd
				local node_id = vm:get_data_from_heap(data,  a:index( pt.x, pt.y-1, pt.z));
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



minetest.register_chatcommand( 'inhabitants', {
	description = "Prints (on the console!) out a list of inhabitants of a village plus their professions.",
	params = "<village number>",
	privs = {},
	func = function(name, param)


		if( not( param ) or param == "" ) then
			minetest.chat_send_player( name, "List the inhabitants of which village? Please provide the village number!");
			return;
		end

		local nr = tonumber( param );
		for id, v in pairs( mg_villages.all_villages ) do
			-- we have found the village
			if( v and v.nr == nr ) then

				minetest.chat_send_player( name, "Printing information about inhabitants of village no. "..tostring( v.nr )..", called "..( tostring( v.name or 'unknown')).." to console.");
				-- actually print it
				for house_nr = 1,#v.to_add_data.bpos do
					print( mob_village_traders.print_house_info( v.to_add_data.bpos, house_nr ));
				end
				return;
			end
		end
		-- no village found
		minetest.chat_send_player( name, "There is no village with the number "..tostring( param ).." (yet?).");
	end
});

