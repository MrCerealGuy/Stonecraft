
-- TODO: play sound while working
-- TODO: play sound when emptying a bucket
-- TODO: store correct bucket texture when loading the world anew
-- TODO: show particles when running? distinguish between running/idle state? (with punch?)

-- well for getting water
--   * has some storage space for buckets (filled with water, river water or empty)
--   * only the owner can use the bucket store and the well
--   * the bucket will be added as an entity and slowly rotate;
--     once filled, the texture of the bucket is changed
--   * full (water or river water) buckets can be emptied
--   * by default public; but can also be made private


-- how many seconds does it take to fill a bucket?
cottages.water_fill_time = 10

local S = cottages.S

-- code taken from the itemframes mod in homedecor
-- (the relevant functions are sadly private there and thus cannot be reused)
local tmp = {}
minetest.register_entity("cottages:bucket_entity",{
	hp_max = 1,
	visual="wielditem",
	visual_size={x = 0.33, y = 0.33},
	collisionbox = {0, 0, 0, 0, 0, 0},
	physical = false,
	textures = {"air"},
	on_activate = function(self, staticdata)
		if tmp.nodename ~= nil and tmp.texture ~= nil then
			self.nodename = tmp.nodename
			tmp.nodename = nil
			self.texture = tmp.texture
			tmp.texture = nil
		else
			if staticdata ~= nil and staticdata ~= "" then
				local data = staticdata:split(';')
				if data and data[1] and data[2] then
					self.nodename = data[1]
					self.texture = data[2]
				end
			end
		end
		if self.texture ~= nil then
			self.object:set_properties({textures = {self.texture}})
		end
		self.object:set_properties({automatic_rotate = 1})
		if self.texture ~= nil and self.nodename ~= nil then
			local entity_pos = vector.round(self.object:get_pos())
			local objs = minetest.get_objects_inside_radius(entity_pos, 0.5)
			for _, obj in ipairs(objs) do
				if obj ~= self.object and
				   obj:get_luaentity() and
				   obj:get_luaentity().name == "cottages:bucket_entity" and
				   obj:get_luaentity().nodename == self.nodename and
				   obj:get_properties() and
				   obj:get_properties().textures and
				   obj:get_properties().textures[1] == self.texture then
					minetest.log("action","[cottages] Removing extra " ..
						self.texture .. " found in " .. self.nodename .. " at " ..
						minetest.pos_to_string(entity_pos))
					self.object:remove()
					break
				end
			end
		end
	end,
	get_staticdata = function(self)
		if self.nodename ~= nil and self.texture ~= nil then
			return self.nodename .. ';' .. self.texture
		end
		return ""
	end,
})

cottages.water_gen_fill_bucket = function(pos)
	if( not(pos)) then
		return
	end
	local meta = minetest.get_meta(pos)
	local bucket = meta:get_string("bucket")
	-- nothing to do
	if( not(bucket) or bucket ~= "bucket:bucket_empty") then
		return
	end
	-- abort if the water has not been running long enough
	-- (the player may have removed a bucket before it was full)
	start = meta:get_string("fillstarttime")
	if( (minetest.get_us_time()/1000000) - tonumber(start) < cottages.water_fill_time -2) then
		return
	end

	-- the bucket has been filled
	meta:set_string("bucket", "bucket:bucket_river_water")

	-- change the texture of the bucket to that of one filled with river water
	local objs = nil
	objs = minetest.get_objects_inside_radius(pos, .5)
	if objs then
		for _, obj in ipairs(objs) do
			if obj and obj:get_luaentity() and obj:get_luaentity().name == "cottages:bucket_entity" then
				obj:set_properties( { textures = { "bucket:bucket_river_water" }})
				obj:get_luaentity().nodename = "bucket:bucket_river_water"
				obj:get_luaentity().texture = "bucket:bucket_river_water"
			end
		end
	end
end


minetest.register_node("cottages:water_gen", {
	description = "Tree Trunk Well",
	tiles = {"default_tree_top.png", "default_tree.png^[transformR90", "default_tree.png^[transformR90"},
	drawtype = "nodebox",
	paramtype  = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = cottages.sounds.wood,
	node_box = {
		type = "fixed",
		fixed = {
			-- floor of water bassin
			{-0.5, -0.5+(3/16), -0.5,  0.5,   -0.5+(4/16),  0.5},
			-- walls
			{-0.5, -0.5+(3/16), -0.5,  0.5,        (4/16), -0.5+(2/16)},
			{-0.5, -0.5+(3/16), -0.5, -0.5+(2/16), (4/16),  0.5},
			{ 0.5, -0.5+(3/16),  0.5,  0.5-(2/16), (4/16), -0.5},
			{ 0.5, -0.5+(3/16),  0.5, -0.5+(2/16), (4/16),  0.5-(2/16)},
			-- feet
			{-0.5+(3/16), -0.5, -0.5+(3/16), -0.5+(6/16), -0.5+(3/16),  0.5-(3/16)},
			{ 0.5-(3/16), -0.5, -0.5+(3/16),  0.5-(6/16), -0.5+(3/16),  0.5-(3/16)},
			-- real pump
			{ 0.5-(4/16), -0.5,        -(2/16),  0.5, 0.5+(4/16),  (2/16)},
			-- water pipe inside wooden stem
			{ 0.5-(8/16), 0.5+(1/16),  -(1/16),  0.5, 0.5+(3/16),  (1/16)},
			-- where the water comes out
			{ 0.5-(15/32), 0.5,        -(1/32),  0.5-(12/32), 0.5+(1/16),  (1/32)},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5+(4/16), 0.5 }
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local spos = pos.x .. "," .. pos.y .. "," .. pos.z
		meta:set_string("formspec",
			"size[8,9]" ..
			"label[3.0,0.0;Tree trunk well]"..
			"label[1.5,0.7;Punch the well while wielding an empty bucket.]"..
			"label[1.5,1.0;Your bucket will slowly be filled with river water.]"..
			"label[1.5,1.3;Punch again to get the bucket back when it is full.]"..
			"label[1.0,2.9;Internal bucket storage (passive storage only):]"..
			"item_image[0.2,0.7;1.0,1.0;bucket:bucket_empty]"..
			"item_image[0.2,1.7;1.0,1.0;bucket:bucket_river_water]"..
			"label[1.5,1.9;Punch well with full water bucket in order to empty bucket.]"..
			"button_exit[6.0,0.0;2,0.5;public;"..S("Public?").."]"..
			"list[nodemeta:" .. spos .. ";main;1,3.3;8,1;]" ..
			"list[current_player;main;0,4.85;8,1;]" ..
			"list[current_player;main;0,6.08;8,3;8]" ..
			"listring[nodemeta:" .. spos .. ";main]" ..
			"listring[current_player;main]")
		local inv = meta:get_inventory()
		inv:set_size('main', 6)
		meta:set_string("infotext", S("Public tree trunk well")) -- (punch with empty bucket to fill bucket)")
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", S("Public tree trunk well (owned by %s)"):format(meta:get_string("owner")))
		-- no bucket loaded
		meta:set_string("bucket", "")
		meta:set_string("public", "public")
		end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and
				default.can_interact_with_node(player, pos)
	end,
	-- no inventory move allowed
	allow_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		return 0
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not(stack) or not cottages.player_can_use(meta, player) then
			return 0
		end
		local inv = meta:get_inventory()
		-- only for buckets
		local sname = stack:get_name()
		if(   sname ~= "bucket:bucket_empty"
		  and sname ~= "bucket:bucket_water"
		  and sname ~= "bucket:bucket_river_water") then
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not(cottages.player_can_use(meta, player)) then
			return 0
		end
		return stack:get_count()
	end,
	on_blast = function() end,
	on_receive_fields = function(pos, formname, fields, sender)
		cottages.switch_public(pos, formname, fields, sender, 'tree trunk well')
	end,
	-- punch to place and retrieve bucket
	on_punch = function(pos, node, puncher)
		if( not( pos ) or not( node ) or not( puncher )) then
			return
		end
		-- only the owner can use the well
		local name = puncher:get_player_name()
               	local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local public = meta:get_string("public")
		if( name ~= owner and public~="public") then
			minetest.chat_send_player( name, S("This tree trunk well is owned by %s. You can't use it."):format(name))
			return
		end

		-- we will either add or take from the players inventory
		local pinv = puncher:get_inventory()

		-- is the well working on something? (either empty or full bucket)
		local bucket = meta:get_string("bucket")
		-- there is a bucket loaded - either empty or full
		if( bucket and bucket~="") then
			if( not(pinv:room_for_item("main", bucket))) then
				minetest.chat_send_player( puncher:get_player_name(),
					S("Sorry. You have no room for the bucket. Please free some "..
					"space in your inventory first!"))
				return
			end
		end

		-- remove the old entity (either a bucket will be placed now or a bucket taken)
		local objs = nil
		objs = minetest.get_objects_inside_radius(pos, .5)
		if objs then
			for _, obj in ipairs(objs) do
				if obj and obj:get_luaentity() and obj:get_luaentity().name == "cottages:bucket_entity" then
					obj:remove()
				end
			end
		end

		-- the player gets the bucket (either empty or full) into his inventory
		if( bucket and bucket ~= "") then
			pinv:add_item("main", bucket )
			meta:set_string("bucket", "")
			-- we are done
			return
		end

		-- punching with empty bucket will put that bucket into the well (as an entity)
		-- and will slowly fill it
		local wielded = puncher:get_wielded_item()
		if(    wielded
		    and wielded:get_name()
		    and wielded:get_name() == "bucket:bucket_empty") then
			-- remove the bucket from the players inventory
			pinv:remove_item( "main", "bucket:bucket_empty")
			-- remember that we got a bucket loaded
			meta:set_string("bucket", "bucket:bucket_empty")
			-- create the entity
			tmp.nodename = "bucket:bucket_empty"
			-- TODO: add a special texture with a handle for the bucket here
			tmp.texture = "bucket:bucket_empty"
			local e = minetest.add_entity({x=pos.x,y=pos.y+(4/16),z=pos.z},"cottages:bucket_entity")
			-- fill the bucket with water
			minetest.after(cottages.water_fill_time, cottages.water_gen_fill_bucket, pos)
			-- the bucket will only be filled if the water ran long enough
			meta:set_string("fillstarttime", tostring(minetest.get_us_time()/1000000)) 
 			return;
		end
		-- buckets can also be emptied here
		if(    wielded
		    and wielded:get_name()
		    and (wielded:get_name() == "bucket:bucket_water"
		      or wielded:get_name() == "bucket:bucket_river_water")
		    and (pinv:room_for_item("main", "bucket:bucket_empty"))) then
			-- remove the full bucket from the players inventory
			pinv:remove_item( "main", wielded:get_name())
			-- add empty bucket
			pinv:add_item("main", "bucket:bucket_empty")
			-- TODO: play diffrent sound when pouring a bucket
 			return;
		end
		    
		-- else check if there is a bucket that can be retrieved
		meta:set_string("bucket","")
	end,
})


-- a well (will fill water buckets) crafted from wooden materials
minetest.register_craft({
	output = 'cottages:water_gen',
	recipe = {
		{'default:stick', '', ''},
		{'default:tree', 'bucket:bucket_empty',  'bucket:bucket_empty'},
		{'default:tree', 'default:tree', 'default:tree'},
	}
})

