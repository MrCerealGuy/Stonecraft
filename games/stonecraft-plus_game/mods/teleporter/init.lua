    function generate_key_list(t)
        local keys = {}
        for k, v in pairs(t) do
            keys[#keys+1] = k
        end
        return keys
    end

local strategies = {
fs={name ="teleporters" ,form="json", place="world"},
}
storage = playerDB(strategies)


teleporter = {}
teleporter.version = 2.6
teleporter.active_light = 3;
teleporter.groups = {oddly_breakable_by_hand=2};
teleporter.groups2 = {oddly_breakable_by_hand=2,not_in_creative_inventory=1,}

-- config.lua contains configuration parameters
--dofile(minetest.get_modpath("teleporter").."/config.lua")
dofile(minetest.get_modpath("teleporter").."/functions.lua")
dofile(minetest.get_modpath("teleporter").."/nodes.lua")




	

minetest.register_abm(
	{nodenames = {"teleporter:teleporter_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.env:get_objects_inside_radius(pos, 1)
		local meta = minetest.get_meta(pos);
		local owner = meta:get_string("owner");
		if meta:get_string("public") == "true" then --if the receiver is public change the owner to public
			owner = "public";
		end
		
		local dest = meta:get_string("coords");
		for k, obj in pairs(objs) do

			if storage:get(owner,dest,false) then --if the receiver is aviable
			
					local topos = minetest.string_to_pos(dest);
					--minetest.sound_play("teleporter_teleport", {pos = pos, gain = 1.0, max_hear_distance = 2,})
					obj:setpos({x=topos.x,y=topos.y-0.5,z=topos.z})
					minetest.sound_play("teleporter_teleport", {pos = topos, gain = 1.0, max_hear_distance = 2,})

			else

				local err = "Error 404: no receiver pad at "..dest.." found. maybe its dug?\n"..
				"If you are shure there is a receiver, ask a server admin, you may found a bug!"
				meta:set_string("infotext", err);
				minetest.swap_node(pos,{name="teleporter:teleporter"});

				meta:set_string("formspec",teleporter.getform(pos,owner));
				if obj:is_player() then
					minetest.chat_send_player(obj:get_player_name(),err);
					
					minetest.sound_play("no_service", {pos = pos, gain = 0.5, max_hear_distance = 2,})
				end
			end
		end
	end	
})

