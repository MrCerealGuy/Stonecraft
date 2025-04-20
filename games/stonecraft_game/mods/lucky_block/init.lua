
-- translation and mod support

local S = minetest.get_translator("lucky_block")
local def = minetest.get_modpath("default")
local mcl = minetest.get_modpath("mcl_core")

-- global

lucky_block = {
	mod_def = def,
	mod_mcl = mcl,
	snd_stone = def and default.node_sound_stone_defaults(),
	snd_wood = def and default.node_sound_wood_defaults(),
	snd_glass = def and default.node_sound_glass_defaults(),
	snd_pop = "default_hard_footstep",
	snd_pop2 = "default_place_node",
	def_item = "default:coal_lump",
	def_node = mcl and "mcl_core:dirt" or "default:dirt",
	def_flame = mcl and "mcl_fire:fire" or "fire:basic_flame",
	def_gold = mcl and "mcl_core:goldblock" or "default:goldblock",
	def_glass = mcl and "mcl_core:glass" or "default:glass",
	green = minetest.get_color_escape_sequence("#1eff00"),
	S = S
}

-- schematic table and local math

lucky_schems = {}

local random = math.random

-- quick sound setup

if mcl then
	lucky_block.snd_glass = mcl_sounds.node_sound_glass_defaults()
	lucky_block.snd_wood = mcl_sounds.node_sound_wood_defaults()
	lucky_block.snd_stone = mcl_sounds.node_sound_stone_defaults()
end

-- default blocks

local lucky_list = {
	{"nod", "lucky_block:super_lucky_block", 0}
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

-- for random colour selection

local all_colours = {
	"grey", "black", "red", "yellow", "green", "cyan", "blue", "magenta",
	"orange", "violet", "brown", "pink", "dark_grey", "dark_green", "white"
}

if lucky_block.mcl then

	all_colours = {
		"red", "blue", "cyan", "grey", "silver", "black", "yellow", "green", "magenta",
		"orange", "purple", "brown", "pink", "lime", "light_blue", "white"
	}
end

-- default chests items

local chest_stuff = {}

-- call to purge the chest item list

function lucky_block:purge_chest_items()
	chest_stuff = {}
end

-- ability to add to chest item list

function lucky_block:add_chest_items(list)

	for s = 1, #list do
		table.insert(chest_stuff, list[s])
	end
end

-- particle effects

local function effect(pos, amount, texture, min_size, max_size, radius, gravity, glow)

	radius = radius or 2
	gravity = gravity or -10

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
		minsize = min_size or 0.5,
		maxsize = max_size or 1.0,
		texture = texture,
		glow = glow
	})
end

-- temp entity for mob damage

minetest.register_entity("lucky_block:temp", {
	physical = true,
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual_size = {x = 0, y = 0},
	visual = "sprite",
	textures = {"tnt_smoke.png"},
	_is_arrow = true,

	on_step = function(self, dtime)

		self.timer = (self.timer or 0) + dtime

		if self.timer > 0.5 then self.object:remove() end
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

		objs[n]:punch(tmp_ent, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = damage}
		}, pos)
	end
end

-- fill chest at position

local function fill_chest(pos, items)

	local stacks = items or chest_stuff
	local meta = minetest.get_meta(pos)
	local inv = meta and meta:get_inventory() ; if not inv then return end
	local size = inv and inv:get_size("main")
	local stack

	-- loop through inventory
	for _, def in ipairs(stacks) do

		if random((def.chance or 1)) == 1 then

			-- only add if item existd
			if minetest.registered_items[def.name] then

				stack = ItemStack(def.name .. " " .. random((def.max or 1)))

				-- if wear levels found choose random wear between both values
				if def.max_wear and def.min_wear then

					stack:set_wear(65535 - (random(def.max_wear, def.min_wear)))
				end

				-- set stack in random position
				inv:set_stack("main", random(size), stack)
			end
		end
	end
end

-- explosion with protection check

local function explode(pos, radius, sound)

	sound = sound or "tnt_explode"

	if minetest.get_modpath("tnt") and tnt and tnt.boom
	and not minetest.is_protected(pos, "") then

		tnt.boom(pos, {radius = radius, damage_radius = radius, sound = sound})
	else
		minetest.sound_play(sound, {pos = pos, gain = 1.0, max_hear_distance = 32}, true)

		entity_physics(pos, radius)

		effect(pos, 32, "tnt_smoke.png", radius * 3, radius * 5, radius, 1, 0)
	end
end

-- place schematic

local function lb_schematic(pos, digger, def)

	if #lucky_schems == 0 then
		core.log("warning", S("[lucky_block] No schematics to load!"))
		return
	end

	local schem = def[2]
	local switch = def[3] or 0
	local force = def[4]
	local reps = def[5] or {}

	if switch == 1 then pos = vector.round(digger:get_pos()) end

	for i = 1, #lucky_schems do

		if schem == lucky_schems[i][1] then

			local p1 = vector.subtract(pos, lucky_schems[i][3])

			minetest.place_schematic(p1, lucky_schems[i][2], "", reps, force)

			break
		end
	end

	if switch == 1 then digger:set_pos(pos, false) end
end

-- place node

local function lb_node(pos, digger, def)

	local nod = def[2]
	local switch = def[3]
	local items = def[4]

	if switch == 1 then pos = digger:get_pos() end

	if not minetest.registered_nodes[nod] then
		nod = lucky_block.def_node
	end

	effect(pos, 25, "tnt_smoke.png", 8, 8, 2, 1, 0)

	minetest.set_node(pos, {name = nod})

	if nod == "default:chest" or nod == "mcl_chests:chest_small" then
		fill_chest(pos, items)
	end
end

-- spawn entity/mob

local function lb_spawn(pos, digger, def)

	local pos2 = {}
	local num = def[3] or 1
	local tame = def[4]
	local own = def[5]
	local range = def[6] or 5
	local name = def[7]

	for i = 1, num do

		pos2.x = pos.x + random(-range, range)
		pos2.y = pos.y + 1
		pos2.z = pos.z + random(-range, range)

		local nod = minetest.get_node(pos2)
		local nodef = minetest.registered_nodes[nod.name]

		if nodef and nodef.walkable == false then

			local entity

			-- select between random or single entity
			if type(def[2]) == "table" then
				entity = def[2][random(#def[2])]
			else
				entity = def[2]
			end

			-- coloured sheep
			if entity == "mobs:sheep" then
				local colour = "_" .. all_colours[random(#all_colours)]
				entity = "mobs:sheep" .. colour
			end

			if entity == "mobs_animal:sheep" then
				local colour = "_" .. all_colours[random(#all_colours)]
				entity = "mobs_animal:sheep" .. colour
			end

			-- has entity been registered?
			if minetest.registered_entities[entity] then

				local obj = minetest.add_entity(pos2, entity)

				if obj then

					local ent = obj:get_luaentity()

					if tame then ent.tamed = true end

					if own then ent.owner = digger:get_player_name() end

					if name then

						ent.nametag = name
						ent.object:set_properties({
							nametag = name,
							nametag_color = "#FFFF00"
						})
					end
				else
					core.log("error", S("[lucky_block] @1 could not be spawned!", entity))
				end
			end
		end
	end
end

-- explosion

local function lb_explode(pos, def)

	local rad = def[2] or 2
	local snd = def[3] or "tnt_explode"

	explode(pos, rad, snd)
end

-- teleport player

local function lb_teleport(pos, digger, def)

	local xz_range = def[2] or 10
	local y_range = def[3] or 5

	pos.x = pos.x + random(-xz_range, xz_range)
	pos.y = pos.y + random(-y_range, y_range)
	pos.z = pos.z + random(-xz_range, xz_range)

	effect(pos, 25, "tnt_smoke.png", 8, 8, 1, -10, 0)

	digger:set_pos(pos, false)

	effect(pos, 25, "tnt_smoke.png", 8, 8, 1, -10, 0)

	minetest.chat_send_player(digger:get_player_name(),
			lucky_block.green .. S("Random Teleport!"))
end

-- drop items

local function lb_drop(pos, digger, def)

	local num = def[3] or 1
	local colours = def[4]
	local items = #def[2]
	local nametag = def[5]

	if items > 1 or colours then -- drop multiple different items or colours

		for i = 1, num do

			local item = def[2][random(items)]

			if colours then
				item = item .. all_colours[random(#all_colours)]
			end

			if not minetest.registered_items[item] then
				item = lucky_block.def_item
			end

			local obj = minetest.add_item(pos, item)

			if obj then
				obj:set_velocity({x = random() - 0.5, y = 5, z = random() - 0.5})
			end
		end

	else -- drop single item in a stack

		local item = def[2][1]

		if not minetest.registered_items[item] then
			item = ItemStack(lucky_block.def_item .. " " .. tonumber(num))
		else
			item = ItemStack(item .. " " .. tonumber(num))
		end

		local obj = minetest.add_item(pos, item)

		if obj then

			obj:set_velocity({x = random() - 0.5, y = 5, z = random() - 0.5})

			if nametag then
				obj:set_properties({nametag = nametag, nametag_color = "#ffff00"})
			end
		end
	end
end

-- lightning bolt

local function lb_lightning(pos, digger, def)

	local nod = def[2]

	if not minetest.registered_nodes[nod] then nod = lucky_block.def_flame end

	pos = digger:get_pos()

	local bnod = minetest.get_node_or_nil(pos)
	local bref = bnod and minetest.registered_items[bnod.name]

	if bref and bref.buildable_to then minetest.set_node(pos, {name = nod}) end

	minetest.add_particle({
		pos = pos,
		velocity = {x = 0, y = 0, z = 0},
		acceleration = {x = 0, y = 0, z = 0},
		expirationtime = 1.0,
		collisiondetection = false,
		texture = "lucky_lightning.png",
		size = random(100, 150),
		glow = 15
	})

	entity_physics(pos, 2)

	minetest.sound_play("lightning", {
			pos = pos, gain = 1.2, max_hear_distance = 30}, true)
end

-- falling nodes

local function lb_falling(pos, digger, def)

	local nods = def[2]
	local switch = def[3]
	local spread = def[4]
	local range = def[5] or 5

	if switch == 1 then pos = digger:get_pos() end

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
				pos2.x = pos.x + random(-range, range)
				pos2.z = pos.z + random(-range, range)
			end

			local node = nods[s] and minetest.registered_nodes[nods[s]]
			local n = node and table.copy(minetest.registered_nodes[nods[s]])

			if n then

				local obj = minetest.add_entity(pos2, "__builtin:falling_node")

				if obj then

					local ent = obj:get_luaentity()

					if ent then
						n.param2 = 1 -- set default rotation
						ent:set_node(n)
					end
				end
			else
				core.log("error", S("[lucky_block] Falling Node Error! Not Found: @1.",
						nods[s]))
			end
		end)
	end
end

-- troll block

local function lb_troll(pos, def)

	local nod = def[2]
	local snd = def[3]
	local exp = def[4]

	if not minetest.registered_nodes[nod] then nod = lucky_block.def_gold end

	minetest.set_node(pos, {name = nod})

	if snd then
		minetest.sound_play(snd, {pos = pos, gain = 1.0, max_hear_distance = 10}, true)
	end

	minetest.after(2.0, function()

		minetest.set_node(pos, {name = "air"})

		if exp then
			explode(pos, 2)
		else
			minetest.sound_play(lucky_block.snd_pop, {
					pos = pos, gain = 1.0, max_hear_distance = 10}, true)
		end
	end)
end

-- floor of nodes

local function lb_floor(pos, def)

	local size = def[2] or 1
	local nods = def[3] or {lucky_block.def_node}
	local offs = def[4] or 0
	local num = 1

	for x = 0, size - 1 do
		for z = 0, size - 1 do

			minetest.after(0.5 * num, function()

				local nod = nods[random(#nods)]
				local def = minetest.registered_nodes[nod]
				local snd = def and def.sounds and def.sounds.place

				minetest.set_node({
					x = (pos.x + x) - offs,
					y = pos.y - 1,
					z = (pos.z + z) - offs}, {name = nod})

				minetest.sound_play(snd, {
						pos = pos, gain = 1.0, max_hear_distance = 10}, true)
			end)

			num = num + 1
		end
	end
end

-- this is what happens when you dig a lucky block

function lucky_block:open(pos, digger, blocks_list)

	-- check for custom blocks list or use default
	blocks_list = blocks_list or lucky_list

	-- make sure it's really random
	local tod = minetest.get_timeofday() ; if tod == 0 then tod = random() end
	math.randomseed(os.time() * tod)

	local luck = random(#blocks_list) ; -- luck = 1
	local result = blocks_list[luck] ; if not result then return end
	local action = result[1]

--	print ("luck ["..luck.." of "..#blocks_list.."]", action)

	-- place schematic
	if action == "sch" then lb_schematic(pos, digger, result)

	-- place node (if chest then fill chest)
	elseif action == "nod" then lb_node(pos, digger, result)

	-- place entity
	elseif action == "spw" then lb_spawn(pos, digger, result)

	-- explosion
	elseif action == "exp" then lb_explode(pos, result)

	-- teleport
	elseif action == "tel" then lb_teleport(pos, digger, result)

	-- drop items
	elseif action == "dro" then lb_drop(pos, digger, result)

	-- lightning strike
	elseif action == "lig" then lb_lightning(pos, digger, result)

	-- falling nodes
	elseif action == "fal" then lb_falling(pos, digger, result)

	-- troll block, disappears or explodes after 2 seconds
	elseif action == "tro" then lb_troll(pos, result)

	-- floor paint
	elseif action == "flo" then lb_floor(pos, result)

	-- custom function
	elseif action == "cus" then
		if result[2] then result[2](pos, digger, result[3]) end
	end
end

-- lucky block node

minetest.register_node("lucky_block:lucky_block", {
	description = S("Lucky Block"),
	tiles = {{
		name = "lucky_block_animated.png",
		animation = {
			type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1
		}
	}},
	inventory_image = minetest.inventorycube("lucky_block.png"),
	sunlight_propagates = false,
	is_ground_content = false,
	paramtype = "light",
	light_source = 3,
	groups = {handy = 1, oddly_breakable_by_hand = 3, unbreakable = 1},
	drop = {},
	sounds = lucky_block.snd_wood,

	on_dig = function(pos, node, digger)

		if digger and digger:is_player() then

			minetest.set_node(pos, {name = "air"})

			lucky_block:open(pos, digger)
		end
	end,

	on_blast = function() end,

	_mcl_hardness = 0.7,
	_mcl_blast_resistance = 1200
})

-- lucky block recipe

local gitem = mcl and "mcl_core:gold_ingot" or "default:gold_ingot"
local citem = mcl and "mcl_chests:chest" or "default:chest"

minetest.register_craft({
	output = "lucky_block:lucky_block",
	recipe = {
		{gitem, gitem, gitem},
		{gitem, citem, gitem},
		{gitem, gitem, gitem}
	}
})

-- set default groups for super lucky block and change if mineclone found

local grp = {cracky = 1, level = 2, unbreakable = 1}

if mcl then
	grp.handy = 5
	grp.level = nil
end

-- super lucky block

local function super_lucky(pos, player)

	if random(10) < 8 then

		effect(pos, 25, "tnt_smoke.png", 8, 8, 1, -10, 0)

		local pitch = 1.0 + random(-10, 10) * 0.005 -- little random pitch difference

		minetest.sound_play("fart1", {
				pos = pos, gain = 1.0, max_hear_distance = 10, pitch = pitch}, true)

		if random(5) == 1 then
			pos.y = pos.y + 0.5
			minetest.add_item(pos, lucky_block.def_gold .. " " .. random(5))
		end
	else
		minetest.set_node(pos, {name = "lucky_block:lucky_block"})
	end
end

local super_lucky_list = {
	{"cus", super_lucky}
}

minetest.register_node("lucky_block:super_lucky_block", {
	description = S("Super Lucky Block (use pick)"),
	tiles = {{
		name = "lucky_block_super_animated.png",
		animation = {
			type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1
		}
	}},
	inventory_image = minetest.inventorycube("lucky_block_super.png"),
	sunlight_propagates = false,
	is_ground_content = false,
	paramtype = "light",
	groups = grp,
	drop = {},
	sounds = lucky_block.snd_stone,

	on_construct = function(pos)

		local meta = minetest.get_meta(pos)

		meta:set_string("infotext", S("Super Lucky Block"))
	end,

	on_dig = function(pos, node, digger)

		if digger and digger:is_player() then

			minetest.set_node(pos, {name = "air"})

			lucky_block:open(pos, digger, super_lucky_list) -- alt list example
		end
	end,

	on_blast = function() end,

	_mcl_hardness = 8,
	_mcl_blast_resistance = 1200
})

-- get mod path and import blocks

local path = minetest.get_modpath("lucky_block")

dofile(path .. "/lb_schems.lua") -- schematics
dofile(path .. "/lb_well.lua") -- wishing well & drops
dofile(path .. "/lb_special.lua") -- special items & drops

if mcl then
	dofile(path .. "/lb_mineclone.lua") -- mineclone only
else
	dofile(path .. "/lb_default.lua") -- default drops
end

dofile(path .. "/lb_other.lua") -- 3rd party mod drops

-- wait until mods loaded and show how many lucky blocks we have in use

minetest.after(1, function()
	print("[MOD] Lucky Blocks loaded: ", #lucky_list)
end)
