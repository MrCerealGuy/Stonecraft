
moresnow.throw_snowball = function( pos, dir, player )
	local snowball_GRAVITY=9
	local snowball_VELOCITY=19

	if( player ) then
		pos = player:getpos();
		dir = player:get_look_dir();
		pos.y = pos.y + 1.5;
	elseif( not( dir )) then
		dir = {};
		dir.x = math.random( 1, 20000 )*0.0001 - 1.0001;
		dir.z = math.random( 1, 20000 )*0.0001 - 1.0001;
		dir.y = math.random( 2, 10000 )*0.0001 - 0.0001; -- always upwards
		pos.y = pos.y + 1.0;
		snowball_VELOCITY = 31;
	end

	local obj = core.add_entity( pos, "__builtin:falling_node")
	obj:get_luaentity():set_node( { name = 'default:snow'});

	obj:setvelocity({x=dir.x*snowball_VELOCITY, y=dir.y*snowball_VELOCITY, z=dir.z*snowball_VELOCITY})
	obj:setacceleration({x=dir.x*-3, y=-snowball_GRAVITY, z=dir.z*-3})
end


-- let a row of snow fall
moresnow.snow_at_one_place = function( pos )

	local n = minetest.get_node( pos );
	if( not(n) or not( n.name ) or n.name=='air' ) then
		spawn_falling_node( pos, {name="default:snow"})
	end
end



moresnow.snow_cannon_stop = function( pos )
	local node = minetest.get_node( pos );
	minetest.swap_node( pos, { name = 'moresnow:snow_cannon', param2 = node.param2 });
	moresnow.snow_cannon_update_formspec( minetest.get_meta( pos ), false );
	local meta = minetest.get_meta( pos );
	meta:set_string("infotext", "Snow cannon (inactive)");
end


moresnow.snow_cannon_fire = function( pos )

	local meta = minetest.get_meta( pos );

	-- if there is a node above the machine, abort (no way of firing)
	local node = minetest.get_node( {x=pos.x, y=pos.y+1, z=pos.z} );
	if( not( node) or not( node.name ) or (node.name ~= 'air' and node.name ~= 'moresnow:snow_top')) then
		-- deactivate the machine by turning back to the inactive state
		meta:set_int( 'mode', -1 );
		moresnow.snow_cannon_stop( pos );
		return;
	end

	local water = meta:get_int( 'water' );
	if( not( water ) or water<1 ) then
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory();
		if(     inv:contains_item( 'buckets', 'bucket:bucket_water')) then
			inv:remove_item(   'buckets', 'bucket:bucket_water' );
			-- return an empty button
			inv:add_item(      'buckets', 'bucket:bucket_empty' );

		elseif( inv:contains_item( 'buckets', 'default:ice' )) then
			inv:remove_item(   'buckets', 'default:ice' );

		else
			meta:set_int( 'mode', -2 );
			moresnow.snow_cannon_stop( pos );
			return;
		end
		water = 9;
	end
	-- consume one water
	meta:set_int( 'water', water-1 );
	
	local mode = meta:get_int( 'mode' );
	if( not( mode )) then
		mode = 1;
	end

	-- ordered mode - make sure every node in the vicinity gets one snow (9x9 area)
	if(     mode==1 ) then
		local i = meta:get_int( 'pcount' );
		-- each node in the vicinity has been covered with snow
		if( not( i ) or i >= 81 or i<0) then
			meta:set_int( 'pcount', 0 );
			moresnow.snow_cannon_stop( pos );
			return;
		end

		local p = {x = pos.x-4+( i%9 ), y=pos.y+20, z=pos.z-4+(math.floor(i/9))};
		moresnow.snow_at_one_place( p );
		meta:set_int( 'pcount', i+1 );

	-- randomly drop snow on nodes in the vicnity (9x9 area)
	elseif( mode==2 ) then
		local k = math.random( 1, 9 );
		local j = math.random( 1, 9 );
		local p = {x = pos.x-5+k, y=pos.y+20, z=pos.z-5+j};
		moresnow.snow_at_one_place( p );

	-- really shoot the snowballs; drawback: this may cover a HUGE area
	elseif( mode==3 ) then
		moresnow.throw_snowball( pos, nil, nil );

	end
end


moresnow.snow_cannon_update_formspec = function( meta, is_active )
	local mode = meta:get_string( 'mode' );
	local program = 'none';
	mode = meta:get_int( 'mode' );
	if( not( mode ) or mode<-2 or mode>3) then
		mode = 0;
		meta:set_int( 'mode', mode );
	end
	if(     mode==0 ) then
		program = 'paused';
	elseif( mode==-1 ) then
		program = 'Error: Top covered.';
	elseif( mode==-2 ) then
		program = 'Error: Out of water!';
	elseif( mode==1 ) then
		program = 'ordered mode';
	elseif( mode==2 ) then
		program = 'random mode';
	elseif( mode==3 ) then
		program = 'crazy shooting';
	else
		program = 'unknown';
	end

	local hotbar_bg = '';
	if( default.get_hotbar_bg ) then
		hotbar_bg = default.get_hotbar_bg(0,4.25)
	end
	local start = 'start';
	if( is_active ) then
		start = 'stop';
	elseif( mode<0 ) then
		start = 'resume';
	else
		start = 'start';
	end
	local button_crazy = '';
	if( moresnow.crazy_mode ) then
		button_crazy = "button_exit[6.5,1.5;2,0.5;crazy;crazy]";
	end
	meta:set_string( 'formspec',
		"size[10.5,8]"..
		( default.gui_bg or '')..
		( default.gui_bg_img or '')..
		( default.gui_slots or '')..
		"label[0,0;Current program:]"..
		"label[2,0;"..program.."]"..
		"label[4,0;Start/resume Program:]"..
		"button_exit[6.5,0;2,0.5;"..start..";"..start.."]"..
		"button_exit[6.5,0.5;2,0.5;ordered;ordered]"..
		"button_exit[6.5,1.0;2,0.5;random;random]"..
		button_crazy..
		"label[0,2;Water reservoir:]"..
		"label[2,2;Fill up with water buckets or ice blocks.]"..
		"list[current_name;buckets;0,2.5;10,1;]"..
		"list[current_player;main;1,4.25;8,1;]"..
		"list[current_player;main;1,5.5;8,3;8]"..
		hotbar_bg );
end


moresnow.snow_cannon_on_receive_fields = function(pos, formname, fields, sender)
	local node = minetest.get_node( pos );
	local meta = minetest.get_meta( pos );

	if( not( fields )) then
		return;
	end

	local mode = meta:get_int( 'mode' );
	if(     fields.ordered ) then
		mode = 1;
		meta:set_int('pcount', 0 );
	elseif( fields.random ) then
		mode = 2;
	elseif( fields.crazy ) then
		mode = 3;
	elseif( fields.stop ) then
		moresnow.snow_cannon_stop( pos );
		return;
	elseif( not(fields.start) and not(fields.resume )) then
		return;
	end

	meta:set_int('mode', mode);
	if( node.name == 'moresnow:snow_cannon' ) then
		minetest.swap_node( pos, { name = 'moresnow:snow_cannon_active', param2 = node.param2 });
		meta:set_string("infotext", "Snow cannon (active)");
	end
	moresnow.snow_cannon_update_formspec( meta, true );
end


moresnow.snow_cannon_on_construct = function( pos )
	local meta = minetest.get_meta(pos);
	meta:set_string("infotext", "Snow cannon (inactive)");
	meta:set_int(   "mode",     0 );
	local inv = meta:get_inventory();
	inv:set_size("buckets", 10);
	moresnow.snow_cannon_update_formspec( meta );
end


moresnow.snow_cannon_can_dig = function( pos, player )
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory();
	if not( inv:is_empty("buckets")) then
		return false;
	end
	return true;
end


moresnow.snow_cannon_allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0;
	end
	if( stack:get_name() ~= 'bucket:bucket_water' and stack:get_name() ~= 'default:ice' ) then
		return 0;
	end
	return stack:get_count();
end

moresnow.snow_cannon_allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	return 0;
end

moresnow.snow_cannon_allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0;
	end
	return stack:get_count();
end



local moresnow_snow_cannon_nodebox_inactive = {
			{ -0.3,   0.5,  -0.2,   0.3,   0.6,  0.2},
			{ -0.3,   0.1,  -0.2,  -0.2,   0.5,  0.2},
			{  0.2,   0.1,  -0.2,   0.3,   0.5,  0.2},
			{ -0.3,   0,    -0.2,   0.3,   0.1,  0.2},

			{ -0.35,-0.05,  -0.4,   0.35,  0.65,-0.2 }};

local moresnow_snow_cannon_nodebox_active  = {
			-- walls of the actual cannon (which is pointing upward)
			{ -0.3,   0.1,  -0.3,  -0.2,   0.5,  0.3},
			{  0.2,   0.1,  -0.3,   0.3,   0.5,  0.3},

			{ -0.2,   0.1,  -0.3,   0.2,   0.5, -0.2},
			{ -0.2,   0.1,   0.2,   0.2,   0.5,  0.3},

			-- fan case
			{ -0.35, -0.1,  -0.35,  0.35,  0.1,  0.35}, };


local moresnow_snow_cannon_nodebox_common = {
			-- horizontal supporting (allowing the cannon to rotate)
			{ -0.4,  0.26,  -0.01, -0.3,  0.28,  0.01},
			{  0.3,  0.26,  -0.01,  0.4,  0.28,  0.01},

			-- vertical supporting
			{ -0.45, -0.5,  -0.05, -0.4,  0.3,   0.05},
			{  0.4,  -0.5,  -0.05,  0.45, 0.3,   0.05},

			-- connection vertical supporting - case
			{ -0.4,  -0.4,  -0.05, -0.15,-0.3,   0.05},
			{ 0.15,  -0.4,  -0.05,  0.4, -0.3,   0.05},

			-- horizontal supporting - connection to the legs
			{ -0.45, -0.25, 0.05,  -0.4, -0.15,   0.4},
			{  0.4,  -0.25, 0.05,   0.45,-0.15,   0.4},

			-- front legs
			{ -0.45, -0.5,   0.4,  -0.4, -0.15,  0.5},
			{  0.4,  -0.5,   0.4,   0.45,-0.15,  0.5},


			--case
			{ -0.15, -0.5,  -0.5,   0.15, -0.3,  0.15},
			-- motor
			{ -0.20, -0.4,  -0.4,   0.20, -0.14, -0.1},

			-- connection between cannon and case
			{ -0.1,  -0.3,  -0.1,   0.1,   0.1,   0.1},
		};


for _,v in ipairs( moresnow_snow_cannon_nodebox_common ) do
	table.insert( moresnow_snow_cannon_nodebox_inactive, v );
end
minetest.register_node("moresnow:snow_cannon", {
	description = "snow cannon (inactive)",

	drawtype = "nodebox",
	node_box = {
		type  = "fixed",
		fixed = moresnow_snow_cannon_nodebox_inactive,
	},
	selection_box = {
		type = "regular",
	},
	tiles = {"default_mese_block.png"},

	paramtype  = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,

	on_construct = moresnow.snow_cannon_on_construct,
	can_dig      = moresnow.snow_cannon_can_dig,

	allow_metadata_inventory_put  = moresnow.snow_cannon_allow_metadata_inventory_put,
	allow_metadata_inventory_move = moresnow.snow_cannon_allow_metadata_inventory_move,
	allow_metadata_inventory_take = moresnow.snow_cannon_allow_metadata_inventory_take,

	on_receive_fields = moresnow.snow_cannon_on_receive_fields,
})


for _,v in ipairs( moresnow_snow_cannon_nodebox_common ) do
	table.insert( moresnow_snow_cannon_nodebox_active, v );
end
minetest.register_node("moresnow:snow_cannon_active", {
	description = "snow cannon (active)",

	drawtype = "nodebox",
	node_box = {
		type  = "fixed",
		fixed = moresnow_snow_cannon_nodebox_active,
	},
	selection_box = {
		type = "regular",
	},
	tiles = {"default_mese_block.png"},

	paramtype  = "light",
	paramtype2 = "facedir",
	groups = {cracky=2,not_in_creative_inventory=1},
	legacy_facedir_simple = true,

	on_construct = moresnow.snow_cannon_on_construct,
	can_dig      = moresnow.snow_cannon_can_dig,

	allow_metadata_inventory_put  = moresnow.snow_cannon_allow_metadata_inventory_put,
	allow_metadata_inventory_move = moresnow.snow_cannon_allow_metadata_inventory_move,
	allow_metadata_inventory_take = moresnow.snow_cannon_allow_metadata_inventory_take,

	on_receive_fields = moresnow.snow_cannon_on_receive_fields,
})


minetest.register_abm({
	nodenames = {"moresnow:snow_cannon_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		moresnow.snow_cannon_fire( pos );
	end
})


minetest.register_craft({
        output = 'moresnow:snow_cannon',
        recipe = {
                { 'default:steel_ingot', '',                   'default:steel_ingot' },
                { 'default:steel_ingot', 'default:mese',       'default:steel_ingot' },
                { 'default:copper_ingot','default:steelblock', 'default:copper_ingot' },
        }
})


-- the snow mod does this already
if( not( minetest.get_modpath( 'snow' ))) then
	minetest.override_item("default:snow", {
		on_use = function(itemstack, user, pointed_thing)
				moresnow.throw_snowball( nil, nil, user );
				itemstack:take_item();
				return itemstack;
			end
	})
end

