local S = minetest.get_translator("tsm_pyramids")

-- Pyramid width (must be an odd number)
local PYRA_W = 23
-- Pyramid width minus 1
local PYRA_Wm = PYRA_W - 1
-- Half of (Pyramid width minus 1)
local PYRA_Wh = PYRA_Wm / 2
-- Minimum spawn height
local PYRA_MIN_Y = 3

tsm_pyramids = {}

dofile(minetest.get_modpath("tsm_pyramids").."/mummy.lua")
dofile(minetest.get_modpath("tsm_pyramids").."/nodes.lua")
dofile(minetest.get_modpath("tsm_pyramids").."/room.lua")

local mg_name = minetest.get_mapgen_setting("mg_name")

local chest_stuff = {
	normal = {
		{name="default:steel_ingot", max = 3},
		{name="default:copper_ingot", max = 3},
		{name="default:gold_ingot", max = 2},
		{name="default:diamond", max = 1},
		{name="default:pick_steel", max = 1},
	},
	desert_stone = {
		{name="default:mese_crystal", max = 4},
		{name="default:gold_ingot", max = 10},
		{name="default:pick_diamond", max = 1},
	},
	desert_sandstone = {
		{name="default:apple", max = 1},
		{name="default:stick", max = 64},
		{name="default:acacia_bush_sapling", max = 1},
		{name="default:paper", max = 9},
		{name="default:shovel_bronze", max = 1},
		{name="default:pick_mese", max = 1},
	},
	sandstone = {
		{name="default:obsidian_shard", max = 5},
		{name="default:apple", max = 3},
		{name="default:blueberries", max = 9},
		{name="default:glass", max = 64},
		{name="default:bush_sapling", max = 1},
		{name="default:pick_bronze", max = 1},
	},
}

if minetest.get_modpath("farming") then
	table.insert(chest_stuff.desert_sandstone, {name="farming:bread", max = 3})
	table.insert(chest_stuff.sandstone, {name="farming:bread", max = 4})
	table.insert(chest_stuff.normal, {name="farming:cotton", max = 32})
	table.insert(chest_stuff.desert_sandstone, {name="farming:seed_cotton", max = 3})
	table.insert(chest_stuff.desert_sandstone, {name="farming:hoe_stone", max = 1})
else
	table.insert(chest_stuff.normal, {name="farming:apple", max = 8})
	table.insert(chest_stuff.normal, {name="farming:apple", max = 3})
end
if minetest.get_modpath("tnt") then
	table.insert(chest_stuff.normal, {name="tnt:gunpowder", max = 6})
	table.insert(chest_stuff.desert_stone, {name="tnt:gunpowder", max = 6})
else
	table.insert(chest_stuff.normal, {name="farming:apple", max = 3})
end

function tsm_pyramids.fill_chest(pos, stype, flood_sand, treasure_chance)
	local sand = "default:sand"
	if not treasure_chance then
		treasure_chance = 100
	end
	if stype == "desert_sandstone" or stype == "desert_stone" then
		sand = "default:desert_sand"
	end
	local n = minetest.get_node(pos)
	local treasure_added = false
	if n and n.name and n.name == "default:chest" then
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		local stacks = {}
		-- Fill with sand in sand-flooded pyramids
		if flood_sand then
			table.insert(stacks, {name=sand, count = math.random(1,32)})
		end
		-- Add treasures
		if math.random(1,100) <= treasure_chance then
			if minetest.get_modpath("treasurer") ~= nil then
				stacks = treasurer.select_random_treasures(3,7,9,{"minetool", "food", "crafting_component"})
			else
				for i=0,2,1 do
					local stuff = chest_stuff.normal[math.random(1,#chest_stuff.normal)]
					table.insert(stacks, {name=stuff.name, count = math.random(1,stuff.max)})
				end
				if math.random(1,100) <= 75 then
					local stuff = chest_stuff[stype][math.random(1,#chest_stuff[stype])]
					table.insert(stacks, {name=stuff.name, count = math.random(1,stuff.max)})
				end
				treasure_added = true
			end
		end
		for s=1,#stacks do
			if not inv:contains_item("main", stacks[s]) then
				inv:set_stack("main", math.random(1,32), stacks[s])
			end
		end
	end
	return treasure_added
end

local function add_spawner(pos, mummy_offset)
	minetest.set_node(pos, {name="tsm_pyramids:spawner_mummy"})
	if not minetest.settings:get_bool("only_peaceful_mobs") then
		for i=1,2 do
			tsm_pyramids.attempt_mummy_spawn(pos, false)
		end
	end
end

local function can_replace(pos)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and minetest.registered_nodes[n.name] and not minetest.registered_nodes[n.name].walkable then
		return true
	elseif not n then
		return true
	else
		return false
	end
end

local function make_foundation_part(pos, set_to_stone)
	local p2 = pos
	local cnt = 0
	p2.y = p2.y-1
	while can_replace(p2)==true do
		cnt = cnt+1
		if cnt > 25 then
			break
		end
		table.insert(set_to_stone, table.copy(p2))
		p2.y = p2.y-1
	end
end

local function make_entrance(pos, rot, brick, sand, flood_sand)
	local roffset_arr = {
		{ x=0, y=0, z=1 }, -- front
		{ x=-1, y=0, z=0 }, -- left
		{ x=0, y=0, z=-1 }, -- back
		{ x=1, y=0, z=0 }, -- right
	}
	local roffset = roffset_arr[rot + 1]
	local way
	if rot == 0 then
		way = vector.add(pos, {x=PYRA_Wh, y=0, z=0})
	elseif rot == 1 then
		way = vector.add(pos, {x=PYRA_Wm, y=0, z=PYRA_Wh})
	elseif rot == 2 then
		way = vector.add(pos, {x=PYRA_Wh, y=0, z=PYRA_Wm})
	else
		way = vector.add(pos, {x=0, y=0, z=PYRA_Wh})
	end
	local max_sand_height = math.random(1,3)
	for ie=0,6,1 do
		local sand_height = math.random(1,max_sand_height)
		for iy=2,3,1 do
			-- dig hallway
			local way_dir = vector.add(vector.add(way, {x=0,y=iy,z=0}), vector.multiply(roffset, ie))
			if flood_sand and sand ~= "ignore" and iy <= sand_height and ie >= 3 then
				minetest.set_node(way_dir, {name=sand})
			else
				minetest.remove_node(way_dir)
			end
			-- build decoration above entrance
			if ie == 3 and iy == 3 then
				local deco = {x=way_dir.x, y=way_dir.y+1,z=way_dir.z}
				minetest.set_node(deco, {name=brick})
				if rot == 0 or rot == 2 then
					minetest.set_node(vector.add(deco, {x=-1, y=0, z=0}), {name=brick})
					minetest.set_node(vector.add(deco, {x=1, y=0, z=0}), {name=brick})
				else
					minetest.set_node(vector.add(deco, {x=0, y=0, z=-1}), {name=brick})
					minetest.set_node(vector.add(deco, {x=0, y=0, z=1}), {name=brick})
				end
			end
		end
	end
end

local function make_pyramid(pos, brick, sandstone, stone, sand)
	local set_to_brick = {}
	local set_to_stone = {}
	-- Build pyramid
	for iy=0,math.random(10,PYRA_Wh),1 do
		for ix=iy,PYRA_W-1-iy,1 do
			for iz=iy,PYRA_W-1-iy,1 do
				if iy < 1 then
					make_foundation_part({x=pos.x+ix,y=pos.y,z=pos.z+iz}, set_to_stone)
				end
				table.insert(set_to_brick, {x=pos.x+ix,y=pos.y+iy,z=pos.z+iz})
			end
		end
	end
	minetest.bulk_set_node(set_to_stone , {name=stone})
	minetest.bulk_set_node(set_to_brick, {name=brick})
end

local function make(pos, brick, sandstone, stone, sand, ptype, room_id)
	local bpos = table.copy(pos)
	-- Build pyramid
	make_pyramid(bpos, brick, sandstone, stone, sand)

	local rot = math.random(0, 3)
	-- Build room
	local ok, msg, flood_sand = tsm_pyramids.make_room(bpos, ptype, room_id, rot)
	-- Place mummy spawner
	local r = math.random(1,3)
	-- 4 possible spawner positions
	local spawner_posses = {
		-- front
		{{x=bpos.x+PYRA_Wh,y=bpos.y+2, z=bpos.z+5}, {x=0, y=0, z=2}},
		-- left
		{{x=bpos.x+PYRA_Wm-5,y=bpos.y+2, z=bpos.z+PYRA_Wh}, {x=-2, y=0, z=0}},
		-- back
		{{x=bpos.x+PYRA_Wh,y=bpos.y+2, z=bpos.z+PYRA_W-5}, {x=0, y=0, z=-2}},
		-- right
		{{x=bpos.x+5,y=bpos.y+2, z=bpos.z+PYRA_Wh}, {x=2, y=0, z=0}},
	}
	-- Delete the spawner position in which the entrance will be placed
	table.remove(spawner_posses, (rot % 4) + 1)
	add_spawner(spawner_posses[r][1], spawner_posses[r][2])
	-- Build entrance
	make_entrance(bpos, rot, brick, sand, flood_sand)
	-- Done
	minetest.log("action", "[tsm_pyramids] Created pyramid at "..minetest.pos_to_string(bpos)..".")
	return ok, msg
end

local perl1 = {SEED1 = 9130, OCTA1 = 3,	PERS1 = 0.5, SCAL1 = 250} -- Values should match minetest mapgen V6 desert noise.
local perlin1 -- perlin noise buffer

local function hlp_fnct(pos, name)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and n.name == name then
		return true
	else
		return false
	end
end
local function ground(pos, old)
	local p2 = table.copy(pos)
	while hlp_fnct(p2, "air") do
		p2.y = p2.y -1
	end
	if p2.y < old.y then
		return {x=old.x, y=p2.y, z=old.z}
	else
		return old
	end
end

-- Select the recommended type of pyramid to use, based on the environment.
-- One of sandstone, desert sandstone, desert stone.
local select_pyramid_type = function(minp, maxp)
	local mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}

	local sand
	local sands = {"default:sand", "default:desert_sand", "default:desert_stone"}
	local p2
	local psand = {}
	local sand
	local cnt = 0
	local sand_cnt_max = 0
	local sand_cnt_max_id
	-- Look for sand or desert stone to place the pyramid on
	for s=1, #sands do
		cnt = 0
		local sand_cnt = 0
		sand = sands[s]
		psand[s] = minetest.find_node_near(mpos, 25, sand)
		while cnt < 5 do
			cnt = cnt+1
			mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}
			local spos = minetest.find_node_near(mpos, 25, sand)
			if spos ~= nil then
				sand_cnt = sand_cnt + 1
				if psand[s] == nil then
					psand[s] = spos
				end
			end
			if sand_cnt > sand_cnt_max then
				sand_cnt_max = sand_cnt
				sand_cnt_max_id = s
				p2 = psand[s]
			end
		end
	end

	-- Select the material type by the most prominent node type
	-- E.g. if desert sand is most prominent, we place a desert sandstone pyramid
	if sand_cnt_max_id then
		sand = sands[sand_cnt_max_id]
	else
		sand = nil
		p2 = nil
	end
	return sand, p2
end

-- Attempt to generate a pyramid in the generated area.
-- Up to one pyramid per mapchunk.
minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y < PYRA_MIN_Y then return end

	-- TODO: Use Minetests pseudo-random tools
	math.randomseed(seed)

	if not perlin1 then
		perlin1 = minetest.get_perlin(perl1.SEED1, perl1.OCTA1, perl1.PERS1, perl1.SCAL1)
	end
	--[[ Make sure the pyramid doesn't bleed outside of maxp,
	so it doesn't get placed incompletely by the mapgen.
	This creates a bias somewhat, as this means there are some coordinates in
        which pyramids cannot spawn. But it's still better than to have broken pyramids.
	]]
	local limit = function(pos, maxp)
		pos.x = math.min(pos.x, maxp.x - PYRA_W+1)
		pos.y = math.min(pos.y, maxp.y - PYRA_Wh)
		pos.z = math.min(pos.z, maxp.z - PYRA_W+1)
		return pos
	end
	local noise1 = perlin1:get_2d({x=minp.x,y=minp.y})

	if noise1 > 0.25 or noise1 < -0.26 then
		-- Need a bit of luck to place a pyramid
		if math.random(0,10) > 7 then
			minetest.log("verbose", "[tsm_pyramids] Pyramid not placed, bad dice roll. minp="..minetest.pos_to_string(minp))
			return
		end
		local sand, p2
		sand, p2 = select_pyramid_type(minp, maxp)

		if p2 == nil then
			minetest.log("verbose", "[tsm_pyramids] Pyramid not placed, no suitable surface. minp="..minetest.pos_to_string(minp))
			return
		end
		if p2.y < PYRA_MIN_Y then
			minetest.log("info", "[tsm_pyramids] Pyramid not placed, too deep. p2="..minetest.pos_to_string(p2))
			return
		end
		-- Now sink the pyramid until each corner of it is no longer floating in mid-air
		p2 = limit(p2, maxp)
		local oposses = {
			{x=p2.x,y=p2.y-1,z=p2.z},
			{x=p2.x+PYRA_Wm,y=p2.y-1,z=p2.z+PYRA_Wm},
			{x=p2.x+PYRA_Wm,y=p2.y-1,z=p2.z},
			{x=p2.x,y=p2.y-1,z=p2.z+PYRA_Wm},
		}
		for o=1, #oposses do
			local opos = oposses[o]
			local n = minetest.get_node_or_nil(opos)
			if n and n.name and n.name == "air" then
				local old = table.copy(p2)
				p2 = ground(opos, p2)
			end
		end
		-- Random bonus sinking
		p2.y = math.max(p2.y - math.random(0,3), PYRA_MIN_Y)

		-- Bad luck, we have hit the chunk border!
		if p2.y < minp.y then
			minetest.log("info", "[tsm_pyramids] Pyramid not placed, sunken too much. p2="..minetest.pos_to_string(p2))
			return
		end

		-- Make sure the pyramid is not near a "killer" node, like water
		local middle = vector.add(p2, {x=PYRA_Wh, y=0, z=PYRA_Wh})
		if minetest.find_node_near(p2, 5, {"default:water_source"}) ~= nil or
				minetest.find_node_near(vector.add(p2, {x=PYRA_W, y=0, z=0}), 5, {"default:water_source"}) ~= nil or
				minetest.find_node_near(vector.add(p2, {x=0, y=0, z=PYRA_W}), 5, {"default:water_source"}) ~= nil or
				minetest.find_node_near(vector.add(p2, {x=PYRA_W, y=0, z=PYRA_W}), 5, {"default:water_source"}) ~= nil or

				minetest.find_node_near(middle, PYRA_W, {"default:dirt_with_grass"}) ~= nil or
				minetest.find_node_near(middle, 52, {"default:sandstonebrick", "default:desert_sandstone_brick", "default:desert_stonebrick"}) ~= nil or
				minetest.find_node_near(middle, PYRA_Wh + 3, {"default:cactus", "group:leaves", "group:tree"}) ~= nil then
			minetest.log("info", "[tsm_pyramids] Pyramid not placed, inappropriate node nearby. p2="..minetest.pos_to_string(p2))
			return
		end

		-- Bonus chance to spawn a sandstone pyramid in v6 desert because otherwise they would be too rare in v6
		if (mg_name == "v6" and sand == "default:desert_sand" and math.random(1, 2) == 1) then
			sand = "default:sand"
		end

		-- Desert stone pyramids only generate in areas with almost no sand
		if sand == "default:desert_stone" then
			local nodes = minetest.find_nodes_in_area(vector.add(p2, {x=-1, y=-2, z=-1}), vector.add(p2, {x=PYRA_W+1, y=PYRA_Wh, z=PYRA_W+1}), {"group:sand"})
			if #nodes > 5 then
				sand = "default:desert_sand"
			end
		end

		-- Generate the pyramid!
		if sand == "default:desert_sand" then
			-- Desert sandstone pyramid
			make(p2, "default:desert_sandstone_brick", "default:desert_sandstone", "default:desert_stone", "default:desert_sand", "desert_sandstone")
		elseif sand == "default:sand" then
			-- Sandstone pyramid
			make(p2, "default:sandstonebrick", "default:sandstone", "default:sandstone", "default:sand", "sandstone")
		else
			-- Desert stone pyramid
			make(p2, "default:desert_stonebrick", "default:desert_stone_block", "default:desert_stone", "ignore", "desert_stone")
		end
	end
end)

-- Add backwards-compability for nodes from the original pyramids mod
if minetest.get_modpath("pyramids") == nil then
	-- Nodes
	minetest.register_alias("pyramids:trap", "tsm_pyramids:trap")
	minetest.register_alias("pyramids:trap_2", "tsm_pyramids:trap_2")
	minetest.register_alias("pyramids:deco_stone1", "tsm_pyramids:deco_stone1")
	minetest.register_alias("pyramids:deco_stone2", "tsm_pyramids:deco_stone2")
	minetest.register_alias("pyramids:deco_stone3", "tsm_pyramids:deco_stone3")
	minetest.register_alias("pyramids:spawner_mummy", "tsm_pyramids:spawner_mummy")
end

minetest.register_chatcommand("spawnpyramid", {
	description = S("Generate a pyramid"),
		params = S("[<room_type>]"),
		privs = { server = true },
		func = function(name, param)
			local player = minetest.get_player_by_name(name)
			if not player then
				return false, S("No player.")
			end
			local pos = player:get_pos()
			pos = vector.round(pos)
			local s = math.random(1,3)
			local r = tonumber(param)
			local room_id
			if r then
				room_id = r
			end
			local ok, msg
			pos = vector.add(pos, {x=-PYRA_Wh, y=-1, z=0})
			if s == 1 then
				-- Sandstone
				ok, msg = make(pos, "default:sandstonebrick", "default:sandstone", "default:sandstone", "default:sand", "sandstone", room_id)
			elseif s == 2 then
				-- Desert sandstone
				ok, msg = make(pos, "default:desert_sandstone_brick", "default:desert_sandstone", "default:desert_stone", "default:desert_sand", "desert_sandstone", room_id)
			else
				-- Desert stone
				ok, msg = make(pos, "default:desert_stonebrick", "default:desert_stone_block", "default:desert_stone", "ignore", "desert_stone", room_id)
			end
			if ok then
				return true, S("Pyramid generated at @1.", minetest.pos_to_string(pos))
			else
				return false, msg
			end
		end,
	}
)
