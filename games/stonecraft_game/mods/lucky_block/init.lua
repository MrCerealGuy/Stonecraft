
lucky_block = {}
lucky_schems = {}


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- a wee bit of colour
local green = minetest.get_color_escape_sequence("#1eff00")

-- example custom function (punches player with 5 damage)
local function punchy(pos, player)

	player:punch(player, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = 5}
	}, nil)

	minetest.sound_play("player_damage", {pos = pos, gain = 1.0})

	minetest.chat_send_player(player:get_player_name(),
		green .. S("Stop hitting yourself!"))
end


-- pint sized player
local function pint(pos, player)

	player:set_properties({visual_size = {x = 0.5, y = 0.5}})

	minetest.chat_send_player(player:get_player_name(),
		green .. S("Pint Sized Player!"))

	minetest.sound_play("default_place_node", {pos = pos, gain = 1.0})

	minetest.after (180, function(player, pos) -- 3 minutes

		if player and player:is_player() then

			player:set_properties({visual_size = {x = 1.0, y = 1.0}})

			minetest.sound_play("default_place_node", {pos = pos, gain = 1.0})
		end
	end, player)
end


local function drop(pos, itemstack)

	local obj = minetest.add_item(pos, itemstack:take_item(itemstack:get_count()))

	if obj then

		obj:setvelocity({
			x = math.random(-10, 10) / 9,
			y = 5,
			z = math.random(-10, 10) / 9,
		})
	end
end


-- custom function to drop player inventory and replace with dry shrubs
local function bushy(pos, player)

	local player_inv = player:get_inventory() ; pos = player:get_pos() or pos

	for i = 1, player_inv:get_size("main") do
		drop(pos, player_inv:get_stack("main", i))
		player_inv:set_stack("main", i, "default:dry_shrub")
	end

	minetest.chat_send_player(player:get_player_name(),
		green .. S("Dry shrub takeover!"))
end


-- default blocks
local lucky_list = {
	{"cus", pint},
	{"sch", "wishingwell", 0, true},
	{"cus", bushy},
	{"cus", punchy},
	{"fal", {"default:wood", "default:gravel", "default:sand", "default:desert_sand", "default:stone", "default:dirt", "default:goldblock"}, 0},
	{"lig"},
	{"nod", "lucky_block:super_lucky_block", 0},
	{"exp", 2},
}


-- ability to add new blocks to list
function lucky_block:add_blocks(list)

	for s = 1, #list do
		table.insert(lucky_list, list[s])
	end
end


-- call to purge the block list
function lucky_block:purge_block_list()
	lucky_list = {
		{"nod", "lucky_block:super_lucky_block", 0}
	}
end


-- add schematics to global list
function lucky_block:add_schematics(list)

	for s = 1, #list do
		table.insert(lucky_schems, list[s])
	end
end


-- import schematics and default blocks
dofile(minetest.get_modpath("lucky_block") .. "/schems.lua")
dofile(minetest.get_modpath("lucky_block") .. "/blocks.lua")


-- for random colour selection
local all_colours = {
	"grey", "black", "red", "yellow", "green", "cyan", "blue", "magenta",
	"orange", "violet", "brown", "pink", "dark_grey", "dark_green", "white"
}

-- default items in chests
local chest_stuff = {
	{name = "default:apple", max = 3},
	{name = "default:steel_ingot", max = 2},
	{name = "default:gold_ingot", max = 2},
	{name = "default:diamond", max = 1},
	{name = "default:pick_steel", max = 1}
}


-- call to purge the chest items list
function lucky_block:purge_chest_items()
	chest_stuff = {}
end


-- ability to add to chest items list
function lucky_block:add_chest_items(list)

	for s = 1, #list do
		table.insert(chest_stuff, list[s])
	end
end


-- particle effects
local effect = function(pos, amount, texture, min_size, max_size, radius, gravity, glow)

	radius = radius or 2
	min_size = min_size or 0.5
	max_size = max_size or 1
	gravity = gravity or -10
	glow = glow or 0

	minetest.add_particlespawner({
		amount = amount,
		time = 0.25,
		minpos = pos,
		maxpos = pos,
		minvel = {x = -radius, y = -radius, z = -radius},
		maxvel = {x = radius, y = radius, z = radius},
		minacc = {x = 0, y = gravity, z = 0},
		maxacc = {x = 0, y = gravity, z = 0},
		minexptime = 0.1,
		maxexptime = 1,
		minsize = min_size,
		maxsize = max_size,
		texture = texture,
		glow = glow,
	})
end


-- temp entity for mob damage
minetest.register_entity("lucky_block:temp", {
	physical = true,
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual_size = {x = 0, y = 0},
	visual = "sprite",
	textures = {"tnt_smoke.png"},

	on_step = function(self, dtime)

		self.timer = (self.timer or 0) + dtime

		if self.timer > 0.5 then
			self.object:remove()
		end
	end
})


-- modified from TNT mod to deal entity damage only
local function entity_physics(pos, radius)

	radius = radius * 2

	local objs = minetest.get_objects_inside_radius(pos, radius)
	local obj_pos, dist

	-- add temp entity to cause damage
	local tmp_ent = minetest.add_entity(pos, "lucky_block:temp")

	for n = 1, #objs do

		obj_pos = objs[n]:get_pos()

		dist = vector.distance(pos, obj_pos)
		if dist < 1 then dist = 1 end

		local damage = math.floor((4 / dist) * radius)
		local ent = objs[n]:get_luaentity()

		if objs[n]:is_player() then
			objs[n]:set_hp(objs[n]:get_hp() - damage)

		else --if ent.health then

			--objs[n]:punch(objs[n], 1.0, {
			objs[n]:punch(tmp_ent, 1.0, {
				full_punch_interval = 1.0,
				damage_groups = {fleshy = damage},
			}, pos)
		end
	end
end


-- fill chest with random items from list
local function fill_chest(pos, items)

	local stacks = items or {}
	local inv = minetest.get_meta(pos):get_inventory()

	inv:set_size("main", 8 * 4)

	for i = 0, 2, 1 do
		local stuff = chest_stuff[math.random(1, #chest_stuff)]
		table.insert(stacks, {name = stuff.name, count = math.random(1, stuff.max)})
	end

	for s = 1, #stacks do
		if not inv:contains_item("main", stacks[s]) then
			inv:set_stack("main", math.random(1, 32), stacks[s])
		end
	end
end


-- explosion with protection check
local function explode(pos, radius, sound)

	sound = sound or "tnt_explode"

	if minetest.get_modpath("tnt") and tnt and tnt.boom
	and not minetest.is_protected(pos, "") then

		tnt.boom(pos, {
			radius = radius,
			damage_radius = radius,
			sound = sound,
		})
	else
		minetest.sound_play(sound, {pos = pos, gain = 1.0,
				max_hear_distance = 32})

		entity_physics(pos, radius)

		effect(pos, 32, "tnt_smoke.png", radius * 3, radius * 5, radius, 1, 0)
	end
end


-- this is what happens when you dig a lucky block
local lucky_block = function(pos, digger)

	-- make sure it's really random
	math.randomseed(os.time() + minetest.get_timeofday())

	local luck = math.random(1, #lucky_list) ; -- luck = 1
	local action = lucky_list[luck][1]
	local schem

--	print ("luck ["..luck.." of "..#lucky_list.."]", action)

	-- place schematic
	if action == "sch" then

		if #lucky_schems == 0 then
			print ("[lucky block] No schematics")
			return
		end

		local schem = lucky_list[luck][2]
		local switch = lucky_list[luck][3] or 0
		local force = lucky_list[luck][4]

		if switch == 1 then
			pos = vector.round(digger:get_pos())
		end

		for i = 1, #lucky_schems do

			if schem == lucky_schems[i][1] then

				local p1 = vector.subtract(pos, lucky_schems[i][3])

				minetest.place_schematic(p1, lucky_schems[i][2], "", {}, force)

				break
			end
		end

		if switch == 1 then
			digger:set_pos(pos, false)
		end

	-- place node (if chest then fill chest)
	elseif action == "nod" then

		local nod = lucky_list[luck][2]
		local switch = lucky_list[luck][3]
		local items = lucky_list[luck][4]

		if switch == 1 then
			pos = digger:get_pos()
		end

		if not minetest.registered_nodes[nod] then
			print (nod)
			nod = "default:goldblock"
		end

		effect(pos, 25, "tnt_smoke.png", 8, 8, 2, 1, 0)

		minetest.set_node(pos, {name = nod})

		if nod == "default:chest" then
			fill_chest(pos, items)
		end

	-- place entity
	elseif action == "spw" then

		local pos2 = {}
		local num = lucky_list[luck][3] or 1
		local tame = lucky_list[luck][4]
		local own = lucky_list[luck][5]
		local range = lucky_list[luck][6] or 5
		local name = lucky_list[luck][7]

		for i = 1, num do

			pos2.x = pos.x + math.random(-range, range)
			pos2.y = pos.y + 1
			pos2.z = pos.z + math.random(-range, range)

			local nod = minetest.get_node(pos2)
			local def = minetest.registered_nodes[nod.name]

			if def and def.walkable == false then

				local entity = lucky_list[luck][2]

				-- coloured sheep
				if entity == "mobs:sheep" then
					local colour = "_" .. all_colours[math.random(#all_colours)]
					entity = "mobs:sheep" .. colour
				end

				-- has entity been registered?
				if minetest.registered_entities[entity] then

					local ent = minetest.add_entity(pos2, entity):get_luaentity()

					if tame then
						ent.tamed = true
					end

					if own then
						ent.owner = digger:get_player_name()
					end

					if name then
						ent.nametag = name
						ent.object:set_properties({
							nametag = name,
							nametag_color = "#FFFF00"
						})
					end
				else
					print ("[lucky_block] " .. entity .. " could not be spawned")
				end
			end
		end

	-- explosion
	elseif action == "exp" then

		local rad = lucky_list[luck][2] or 2
		local snd = lucky_list[luck][3] or "tnt_explode"

		explode(pos, rad, snd)

	-- teleport
	elseif action == "tel" then

		local xz_range = lucky_list[luck][2] or 10
		local y_range = lucky_list[luck][3] or 5

		pos.x = pos.x + math.random(-xz_range, xz_range)
		pos.x = pos.y + math.random(-y_range, y_range)
		pos.x = pos.z + math.random(-xz_range, xz_range)

		effect(pos, 25, "tnt_smoke.png", 8, 8, 1, -10, 0)

		digger:set_pos(pos, false)

		effect(pos, 25, "tnt_smoke.png", 8, 8, 1, -10, 0)

		minetest.chat_send_player(digger:get_player_name(),
			green .. S("Random Teleport!"))

	-- drop items
	elseif action == "dro" then

		local num = lucky_list[luck][3] or 1
		local colours = lucky_list[luck][4]
		local items = #lucky_list[luck][2]

		for i = 1, num do

			local item = lucky_list[luck][2][math.random(1, items)]

			if colours then
				item = item .. all_colours[math.random(#all_colours)]
			end

			if not minetest.registered_nodes[item]
			and not minetest.registered_craftitems[item]
			and not minetest.registered_tools[item] then
				item = "default:coal_lump"
			end

			local obj = minetest.add_item(pos, item)

			if obj then

				obj:set_velocity({
					x = math.random(-10, 10) / 9,
					y = 5,
					z = math.random(-10, 10) / 9,
				})
			end
		end

	-- lightning strike
	elseif action == "lig" then

		local nod = lucky_list[luck][2]

		if nod and not minetest.registered_nodes[nod] then
			print (nod)
			nod = "fire:basic_flame"
		end

		pos = digger:get_pos()

		if nod then
			minetest.set_node(pos, {name = nod})
		end

		minetest.add_particle({
			pos = pos,
			velocity = {x = 0, y = 0, z = 0},
			acceleration = {x = 0, y = 0, z = 0},
			expirationtime = 1.0,
			collisiondetection = false,
			texture = "lucky_lightning.png",
			size = math.random(100, 150),
			glow = 15,
		})

		entity_physics(pos, 2)

		minetest.sound_play("lightning", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 25
		})

		minetest.set_node(pos, {name = "fire:permanent_flame"})

	-- falling nodes
	elseif action == "fal" then

		local nods = lucky_list[luck][2]
		local switch = lucky_list[luck][3]
		local spread = lucky_list[luck][4]
		local range = lucky_list[luck][5] or 5

		if switch == 1 then
			pos = digger:get_pos()
		end

		if spread then
			pos.y = pos.y + 10
		else
			pos.y = pos.y + #nods
		end

		minetest.remove_node(pos)

		local pos2 = {x = pos.x, y = pos.y, z = pos.z}

		for s = 1, #nods do

			minetest.after(0.5 * s, function()

				if spread then
					pos2.x = pos.x + math.random(-range, range)
					pos2.z = pos.z + math.random(-range, range)
				end

				local n = minetest.registered_nodes[nods[s]]

				if n then

					local obj = minetest.add_entity(pos2, "__builtin:falling_node")

					obj:get_luaentity():set_node(n)
				end
			end)
		end

	-- troll block, disappears or explodes after 2 seconds
	elseif action == "tro" then

		local nod = lucky_list[luck][2]
		local snd = lucky_list[luck][3]
		local exp = lucky_list[luck][4]

		minetest.set_node(pos, {name = nod})

		if snd then
			minetest.sound_play(snd, {
				pos = pos,
				gain = 1.0,
				max_hear_distance = 10
			})
		end

		if not minetest.registered_nodes[nod] then
			print (nod)
			nod = "default:goldblock"
		end

		minetest.after(2.0, function()

			if exp then

				minetest.set_node(pos, {name = "air"})

				explode(pos, 2)
			else

				minetest.set_node(pos, {name = "air"})

				minetest.sound_play("default_hard_footstep", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 10
				})
			end
		end)

	-- floor paint
	elseif action == "flo" then

		local size = lucky_list[luck][2] or 1
		local nods = lucky_list[luck][3] or {"default:dirt"}
		local offs = lucky_list[luck][4] or 0
		local num = 1

		for x = 0, size - 1 do
			for z = 0, size - 1 do

				minetest.after(0.5 * num, function()

					minetest.set_node({
						x = (pos.x + x) - offs,
						y = pos.y - 1,
						z = (pos.z + z) - offs
					}, {name = nods[math.random(#nods)]})

					minetest.sound_play("default_place_node", {
						pos = pos,
						gain = 1.0,
						max_hear_distance = 10
					})
				end)

				num = num + 1
			end
		end

	-- custom function
	elseif action == "cus" then

		local func = lucky_list[luck][2]

		if func then func(pos, digger) end
	end
end


-- lucky block itself
minetest.register_node('lucky_block:lucky_block', {
	description = S("Lucky Block"),
	tiles = {{
		name = "lucky_block_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		},
	}},
	inventory_image = minetest.inventorycube("lucky_block.png"),
	sunlight_propagates = false,
	is_ground_content = false,
	paramtype = "light",
	light_source = 3,
	groups = {oddly_breakable_by_hand = 3},
	drop = {},
	sounds = default.node_sound_wood_defaults(),

	on_dig = function(pos, node, digger)
		minetest.set_node(pos, {name = "air"})
		lucky_block(pos, digger)
	end,

	on_blast = function() end,
})

minetest.register_craft({
	output = "lucky_block:lucky_block",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "default:chest", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"}
	}
})


-- super lucky block
minetest.register_node('lucky_block:super_lucky_block', {
	description = S("Super Lucky Block (use pick)"),
	tiles = {{
		name="lucky_block_super_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		},
	}},
	inventory_image = minetest.inventorycube("lucky_block_super.png"),
	sunlight_propagates = false,
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 1, level = 2},
	drop = {},
	sounds = default.node_sound_stone_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Super Lucky Block")
	end,

	on_dig = function(pos)

		if math.random(1, 10) < 8 then

			minetest.set_node(pos, {name = "air"})

			effect(pos, 25, "tnt_smoke.png", 8, 8, 1, -10, 0)

			minetest.sound_play("fart1", {
				pos = pos,
				gain = 1.0,
				max_hear_distance = 10
			})

			if math.random(1, 5) == 1 then
				pos.y = pos.y + 0.5
				minetest.add_item(pos, "default:goldblock " .. math.random(1, 5))
			end

		else
			minetest.set_node(pos, {name = "lucky_block:lucky_block"})
		end
	end,

	on_blast = function() end,
})


minetest.after(0, function()
	print (S("[MOD] Lucky Blocks loaded (@1 in total)", #lucky_list))
end)

