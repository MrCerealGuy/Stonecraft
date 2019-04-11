players_income = {}

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer >= 720 then --720 for one day
		timer = 0
		for _,player in ipairs(minetest.get_connected_players()) do
				local name = player:get_player_name()
				if players_income[name] == nil then
					players_income[name] = 0
				end
				players_income[name] = 1
				minetest.log("info", "[Currency] "..S("basic income for @1", name))
		end
	end
end)

earn_income = function(player)
	if not player or player.is_fake_player then return end
	local name = player:get_player_name()
	if players_income[name] == nil then
		players_income[name] = 0
	end
	if players_income[name] > 0 then
		count = players_income[name]
		local inv = player:get_inventory()
		inv:add_item("main", {name="currency:minegeld_10", count=count})
		players_income[name] = 0
		minetest.log("info", "[Currency] "..S("added basic income for @1 to inventory", name))
	end
end

minetest.register_on_dignode(function(pos, oldnode, digger)
	earn_income(digger)
end)

minetest.register_on_placenode(function(pos, node, placer)
	earn_income(placer)
end)
