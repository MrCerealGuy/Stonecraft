---------------------------------------------------------------------------------------
-- simple anvil that can be used to repair tools
---------------------------------------------------------------------------------------
-- * can be used to repair tools
-- * the hammer gets dammaged a bit at each repair step
---------------------------------------------------------------------------------------
-- License of the hammer picture: CC-by-SA; done by GloopMaster; source:
--   https://github.com/GloopMaster/glooptest/blob/master/glooptest/textures/glooptest_tool_steelhammer.png

local S = cottages.S

-- the hammer for the anvil
minetest.register_tool("cottages:hammer", {
        description = S("Steel hammer for repairing tools on the anvil"),
        image           = "glooptest_tool_steelhammer.png",
        inventory_image = "glooptest_tool_steelhammer.png",

        tool_capabilities = {
                full_punch_interval = 0.8,
                max_drop_level=1,
                groupcaps={
			-- about equal to a stone pick (it's not intended as a tool)
                        cracky={times={[2]=2.00, [3]=1.20}, uses=30, maxlevel=1},
                },
                damage_groups = {fleshy=6},
        }
})


local cottages_anvil_formspec =
                               "size[8,8]"..
				"image[7,3;1,1;glooptest_tool_steelhammer.png]"..
--                                "list[current_name;sample;0,0.5;1,1;]"..
                                "list[current_name;input;2.5,1.5;1,1;]"..
--                                "list[current_name;material;5,0;3,3;]"..
                                "list[current_name;hammer;5,3;1,1;]"..
--					"label[0.0,0.0;Sample:]"..
--					"label[0.0,1.0;(Receipe)]"..
					"label[2.5,1.0;"..S("Workpiece:").."]"..
--					"label[6.0,-0.5;Materials:]"..
					"label[6.0,2.7;"..S("Optional").."]"..
					"label[6.0,3.0;"..S("storage for").."]"..
					"label[6.0,3.3;"..S("your hammer").."]"..

					"label[0,-0.5;"..S("Anvil").."]"..
					"label[0,3.0;"..S("Punch anvil with hammer to").."]"..
					"label[0,3.3;"..S("repair tool in workpiece-slot.").."]"..
                                "list[current_player;main;0,4;8,4;]";


minetest.register_node("cottages:anvil", {
	drawtype = "nodebox",
	description = S("anvil"),
	tiles = {"cottages_stone.png"}, -- TODO default_steel_block.png,  default_obsidian.png are also nice
	paramtype  = "light",
        paramtype2 = "facedir",
	groups = {cracky=2},
	-- the nodebox model comes from realtest
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.3,0.5,-0.4,0.3},
				{-0.35,-0.4,-0.25,0.35,-0.3,0.25},
				{-0.3,-0.3,-0.15,0.3,-0.1,0.15},
				{-0.35,-0.1,-0.2,0.35,0.1,0.2},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.3,0.5,-0.4,0.3},
				{-0.35,-0.4,-0.25,0.35,-0.3,0.25},
				{-0.3,-0.3,-0.15,0.3,-0.1,0.15},
				{-0.35,-0.1,-0.2,0.35,0.1,0.2},
			}
	},
	on_construct = function(pos)

		local meta = minetest.get_meta(pos);
               	meta:set_string("infotext", S("Anvil"));
               	local inv = meta:get_inventory();
               	inv:set_size("input",    1);
--               	inv:set_size("material", 9);
--               	inv:set_size("sample",   1);
               	inv:set_size("hammer",   1);
                meta:set_string("formspec", cottages_anvil_formspec );
       	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos);
		meta:set_string("owner", placer:get_player_name() or "");
		meta:set_string("infotext", S("Anvil (owned by %s)"):format((meta:get_string("owner") or "")));
                meta:set_string("formspec",
					cottages_anvil_formspec,
					"label[2.5,-0.5;"..S("Owner: %s"):format(meta:get_string('owner') or "").."]");
        end,

        can_dig = function(pos,player)

		local meta  = minetest.get_meta(pos);
                local inv   = meta:get_inventory();
		local owner = meta:get_string('owner');

                if(  not( inv:is_empty("input"))
--		  or not( inv:is_empty("material"))
--		  or not( inv:is_empty("sample"))
		  or not( inv:is_empty("hammer"))
		  or not( player )
		  or ( owner and owner ~= ''  and player:get_player_name() ~= owner )) then

		   return false;
		end
                return true;
        end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
                if( player and player:get_player_name() ~= meta:get_string('owner' ) and from_list~="input") then
                        return 0
		end
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
                if( player and player:get_player_name() ~= meta:get_string('owner' ) and listname~="input") then
                        return 0;
		end
		if( listname=='hammer' and stack and stack:get_name() ~= 'cottages:hammer') then
			return 0;
		end
		if(   listname=='input'
		 and( stack:get_wear() == 0
                   or stack:get_name() == "technic:water_can" 
                   or stack:get_name() == "technic:lava_can" )) then

			minetest.chat_send_player( player:get_player_name(),
				S('The workpiece slot is for damaged tools only.'));
			return 0;
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
                if( player and player:get_player_name() ~= meta:get_string('owner' ) and listname~="input") then
                        return 0
		end
		return stack:get_count()
	end,


	on_punch = function(pos, node, puncher)
		if( not( pos ) or not( node ) or not( puncher )) then
			return;
		end
		-- only punching with the hammer is supposed to work
		local wielded = puncher:get_wielded_item();
		if( not( wielded ) or not( wielded:get_name() ) or wielded:get_name() ~= 'cottages:hammer') then
 			return;
		end
		local name = puncher:get_player_name();

		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory();

		local input = inv:get_stack('input',1);

		-- only tools can be repaired
		if( not( input ) 
		   or input:is_empty()
                   or input:get_name() == "technic:water_can" 
                   or input:get_name() == "technic:lava_can" ) then

			meta:set_string("formspec",
					cottages_anvil_formspec,
					"label[2.5,-0.5;"..S("Owner: %s"):format(meta:get_string('owner') or "").."]");
			return;
		end

		-- 65535 is max damage
		local damage_state = 40-math.floor(input:get_wear()/1638);

		local tool_name = input:get_name();
		local hud_image = "";
		if( tool_name
		   and minetest.registered_items[ tool_name ] ) then
			if(     minetest.registered_items[ tool_name ].inventory_image ) then
				hud_image = minetest.registered_items[ tool_name ].inventory_image;
			elseif( minetest.registered_items[ tool_name ].textures 
			    and type(minetest.registered_items[ tool_name ].textures)=='table') then
				hud_image = minetest.registered_items[ tool_name ].textures[1];
			elseif( minetest.registered_items[ tool_name ].textures 
			    and type(minetest.registered_items[ tool_name ].textures)=='string') then
				hud_image = minetest.registered_items[ tool_name ].textures;
			end
		end
			
		local hud1 = puncher:hud_add({
			hud_elem_type = "image",
			scale = {x = 15, y = 15},
			text = hud_image,
			position = {x = 0.5, y = 0.5},
			alignment = {x = 0, y = 0}
		});
		local hud2 = nil;
		local hud3 = nil;
		if( input:get_wear()>0 ) then
			hud2 = puncher:hud_add({
				hud_elem_type = "statbar",
				text = "default_cloud.png^[colorize:#ff0000:256",
				number = 40,
				direction = 0, -- left to right
				position = {x=0.5, y=0.65},
				alignment = {x = 0, y = 0},
				offset = {x = -320, y = 0},
				size = {x=32, y=32},
			})
			hud3 = puncher:hud_add({
				hud_elem_type = "statbar",
				text = "default_cloud.png^[colorize:#00ff00:256",
				number = damage_state,
				direction = 0, -- left to right
				position = {x=0.5, y=0.65},
				alignment = {x = 0, y = 0},
				offset = {x = -320, y = 0},
				size = {x=32, y=32},
			});
		end
		minetest.after(2, function()
			if( puncher ) then
				puncher:hud_remove(hud1);
				puncher:hud_remove(hud2);
				puncher:hud_remove(hud3);
			end
		end)

		-- tell the player when the job is done
		if(   input:get_wear() == 0 ) then
--			minetest.chat_send_player( puncher:get_player_name(),
--				S('Your tool has been repaired successfully.'));
			return;
		end

		-- do the actual repair
		input:add_wear( -5000 ); -- equals to what technic toolshop does in 5 seconds
		inv:set_stack("input", 1, input)

		-- damage the hammer slightly
		wielded:add_wear( 100 );
		puncher:set_wielded_item( wielded );

		-- do not spam too much
--		if( math.random( 1,5 )==1 ) then
--			minetest.chat_send_player( puncher:get_player_name(),
--				S('Your workpiece improves.'));
--		end
	end,
	is_ground_content = false,
})



---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
minetest.register_craft({
	output = "cottages:anvil",
	recipe = {
                {cottages.craftitem_steel,cottages.craftitem_steel,cottages.craftitem_steel},
                {'',                   cottages.craftitem_steel,''                   },
                {cottages.craftitem_steel,cottages.craftitem_steel,cottages.craftitem_steel} },
})


-- the castle-mod has an anvil as well - with the same receipe. convert the two into each other
if ( minetest.get_modpath("castle") ~= nil ) then

  minetest.register_craft({
	output = "cottages:anvil",
	recipe = {
		 {'castle:anvil'},
		},
  }) 

  minetest.register_craft({
	output = "castle:anvil",
	recipe = {
		 {'cottages:anvil'},
		},
  }) 
end



minetest.register_craft({
	output = "cottages:hammer",
	recipe = {
                {cottages.craftitem_steel,cottages.craftitem_steel,cottages.craftitem_steel},
                {cottages.craftitem_steel,cottages.craftitem_steel,cottages.craftitem_steel},
                {'',                   cottages.craftitem_stick,      ''                   } }
})

