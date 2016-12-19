
-- register a preassure plate; the code was taken from Jeijas mesecon mod
-- and modified as needed
local mc_add_pressure_plate = function( typ, texture )
    minetest.register_node("mccompat:"..typ.."_pressure_plate", {
	drawtype = "nodebox",
	tiles = {texture},
	paramtype = "light",
	is_ground_content = false,
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = { -7/16, -8/16, -7/16, 7/16, -7/16, 7/16 },
	},
	node_box = {
		type = "fixed",
		fixed = { -7/16, -8/16, -7/16, 7/16, -7/16, 7/16 },
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
    	description = typ.." Pressure Plate",
   })

   minetest.register_node("mccompat:"..typ.."_pressure_plate_active", {
    	description = typ.." Pressure Plate (activated)",
	drawtype = "nodebox",
	tiles = {texture},
	paramtype = "light",
	is_ground_content = false,
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = { -7/16, -8/16, -7/16, 7/16, -7/16, 7/16 },
	},
	node_box = {
		type = "fixed",
		fixed = { -7/16, -8/16, -7/16, 7/16, -31/64, 7/16 },
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = "mccompat:"..typ.."_pressure_plate",
   })


   -- TODO: actually open/close nearby doors etc.
   minetest.register_abm(
	{nodenames = {"mccompat:"..typ.."_pressure_plate"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.get_objects_inside_radius(pos, 1)
		for k, obj in pairs(objs) do
			local objpos=obj:getpos()
			if objpos.y>pos.y-1 and objpos.y<pos.y then
				minetest.swap_node(pos, {name="mccompat:"..typ.."_pressure_plate_active"})
			end
		end	
	end,
   })

   -- TODO: close the door again
   minetest.register_abm(
	{nodenames = {"mccompat:"..typ.."_pressure_plate_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.get_objects_inside_radius(pos, 1)
		if objs[1]==nil then
			minetest.swap_node(pos, {name="mccompat:"..typ.."_pressure_plate"})
		end
	end,
   })

end


mc_add_pressure_plate( "stone",          "stone.png" );
mc_add_pressure_plate( "wooden",         "planks_oak.png" );
mc_add_pressure_plate( "light_weighted", "gold_block.png" );
mc_add_pressure_plate( "heavy_weighted", "iron_block.png" );
