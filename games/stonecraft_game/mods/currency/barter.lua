currency.barter = {}
barter = currency.barter -- Kept as a global variable for compatibility

local S = minetest.get_translator("currency")

barter.chest = {}
barter.chest.expire_after = tonumber(minetest.settings:get('barter.chest.expireafter')) or 15 * 60
barter.chest.formspec = {
	main = "size[8,9]"..
		"list[current_name;pl1;0,0;3,4;]"..
		"list[current_name;pl2;5,0;3,4;]"..
		"list[current_player;main;0,5;8,4;]",
	pl1 = {
		start = "button[0,4;3,1;pl1_start;" .. S("Start") .. "]",
		player = function(name) return "label[0,4;"..name.."]" end,
		accept1 = "button[2.9,1;1.2,1;pl1_accept1;" .. S("Confirm") .. "]"..
				"button[2.9,2;1.2,1;pl1_cancel;" .. S("Cancel") .. "]",
		accept2 = "button[2.9,1;1.2,1;pl1_accept2;" .. S("Exchange") .. "]"..
				"button[2.9,2;1.2,1;pl1_cancel;" .. S("Cancel") .. "]",
	},
	pl2 = {
		start = "button[5,4;3,1;pl2_start;" .. S("Start") .. "]",
		player = function(name) return "label[5,4;"..name.."]" end,
		accept1 = "button[3.9,1;1.2,1;pl2_accept1;" .. S("Confirm") .. "]"..
				"button[3.9,2;1.2,1;pl2_cancel;" .. S("Cancel") .. "]",
		accept2 = "button[3.9,1;1.2,1;pl2_accept2;" .. S("Exchange") .. "]"..
				"button[3.9,2;1.2,1;pl2_cancel;" .. S("Cancel") .. "]",
	},
}

barter.chest.check_privilege = function(listname,playername,meta)
	if listname == "pl1" then
		if playername ~= meta:get_string("pl1") then
			return false
		elseif meta:get_int("pl1step") ~= 1 then
			return false
		end
	end
	if listname == "pl2" then
		if playername ~= meta:get_string("pl2") then
			return false
		elseif meta:get_int("pl2step") ~= 1 then
			return false
		end
	end
	return true
end

barter.chest.update_formspec = function(meta)
	local formspec = barter.chest.formspec.main
	local pl_formspec = function (n)
		if meta:get_int(n.."step")==0 then
			formspec = formspec .. barter.chest.formspec[n].start
		else
			formspec = formspec .. barter.chest.formspec[n].player(meta:get_string(n))
			if meta:get_int(n.."step") == 1 then
				formspec = formspec .. barter.chest.formspec[n].accept1
			elseif meta:get_int(n.."step") == 2 then
				formspec = formspec .. barter.chest.formspec[n].accept2
			end
		end
	end
	pl_formspec("pl1") pl_formspec("pl2")
	meta:set_string("formspec",formspec)
end

barter.chest.give_inventory = function(inv,list,playername)
	local player = minetest.get_player_by_name(playername)
	if player then
		for _,v in ipairs(inv:get_list(list)) do
			if player:get_inventory():room_for_item("main",v) then
				player:get_inventory():add_item("main",v)
			else
				minetest.add_item(player:get_pos(),v)
			end
			inv:remove_item(list,v)
		end
	end
end

barter.chest.cancel = function(meta)
	barter.chest.give_inventory(meta:get_inventory(),"pl1",meta:get_string("pl1"))
	barter.chest.give_inventory(meta:get_inventory(),"pl2",meta:get_string("pl2"))
	meta:set_string("pl1","")
	meta:set_string("pl2","")
	meta:set_int("pl1step",0)
	meta:set_int("pl2step",0)
	meta:set_int("clean",1)
	meta:set_int("timer",0)
end

barter.chest.exchange = function(meta)
	barter.chest.give_inventory(meta:get_inventory(),"pl1",meta:get_string("pl2"))
	barter.chest.give_inventory(meta:get_inventory(),"pl2",meta:get_string("pl1"))
	meta:set_string("pl1","")
	meta:set_string("pl2","")
	meta:set_int("pl1step",0)
	meta:set_int("pl2step",0)
	meta:set_int("clean",1)
	meta:set_int("timer",0)
end

barter.chest.start_timer = function(pos, meta)
	meta:set_int("clean",0)
	meta:set_int("timer",0)
	local node_timer = minetest.get_node_timer(pos)
	if node_timer:is_started() then return end
	node_timer:start(22)
end

minetest.register_node("currency:barter", {
	drawtype = "nodebox",
	description = S("Barter Table"),
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"barter_top.png",
		"barter_base.png",
		"barter_side.png"
	},
	inventory_image = "barter_top.png",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000},
			{-0.437500,-0.500000,-0.437500,-0.250000,0.500000,-0.250000},
			{-0.437500,-0.500000,0.250000,-0.250000,0.500000,0.437500},
			{0.250000,-0.500000,-0.437500,0.437500,0.500000,-0.250000},
			{0.250000,-0.500000,0.250000,0.437500,0.500000,0.447500},
		},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2},
	is_ground_content = false,
	sounds = currency.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Barter Table"))
		meta:set_string("pl1","")
		meta:set_string("pl2","")
		meta:set_int("clean",1)
		meta:set_int("timer",0)
		barter.chest.update_formspec(meta)
		local inv = meta:get_inventory()
		inv:set_size("pl1", 12) -- 3*4
		inv:set_size("pl2", 12) -- 3*4
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		barter.chest.start_timer(pos, meta)
		local pl_receive_fields = function(n)
			if fields[n.."_start"] and meta:get_string(n) == "" then
				meta:set_string(n,sender:get_player_name())
			end
			if meta:get_string(n) == "" then
				meta:set_int(n.."step",0)
			elseif meta:get_int(n.."step")==0 then
				meta:set_int(n.."step",1)
			end
			if sender:get_player_name() == meta:get_string(n) then
				if meta:get_int(n.."step")==1 and fields[n.."_accept1"] then
					meta:set_int(n.."step",2)
				end
				if meta:get_int(n.."step")==2 and fields[n.."_accept2"] then
					meta:set_int(n.."step",3)
					if n == "pl1" and meta:get_int("pl2step") == 3 then barter.chest.exchange(meta) end
					if n == "pl2" and meta:get_int("pl1step") == 3 then barter.chest.exchange(meta) end
				end
				if fields[n.."_cancel"] then barter.chest.cancel(meta) end
			end
		end
		pl_receive_fields("pl1") pl_receive_fields("pl2")
		-- End
		barter.chest.update_formspec(meta)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		barter.chest.start_timer(pos, meta)
		if not barter.chest.check_privilege(from_list,player:get_player_name(),meta) then return 0 end
		if not barter.chest.check_privilege(to_list,player:get_player_name(),meta) then return 0 end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		barter.chest.start_timer(pos, meta)
		if not barter.chest.check_privilege(listname,player:get_player_name(),meta) then return 0 end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		barter.chest.start_timer(pos, meta)
		if not barter.chest.check_privilege(listname,player:get_player_name(),meta) then return 0 end
		return stack:get_count()
	end,
	on_timer = function(pos, dtime)
		local meta = minetest.get_meta(pos)
		if 1 == meta:get_int("clean") then return false end

		local timer = meta:get_int("timer")
		timer = timer + dtime
		if timer > barter.chest.expire_after then
			-- attempt to return items to owners
			barter.chest.cancel(meta)
			-- also clear out items of offline users
			local inv = meta:get_inventory()
			inv:set_list("pl1", {})
			inv:set_list("pl2", {})
			return false
		end
		meta:set_int("timer",timer)
		return true
	end
})
