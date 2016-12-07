trees = {}
apportionment = {}
ores = {}
seasons = {}
winterblock = {}
num_ore = 0

function distance(pos1, pos2)
	return math.sqrt((pos1.x - pos2.x) ^ 2 + (pos1.y - pos2.y) ^ 2 + (pos1.z - pos2.z) ^ 2)
end

function get_instant_temperature(pos)
	local temperature = minetest.get_perlin(554, 3, 0.6, 40)
	local season = - math.cos(math.rad(math.mod(minetest.get_gametime(), 14400) / 40)) * 5
	local time = - math.cos(math.rad(minetest.get_timeofday() * 360 - 45)) * 2
	local value = temperature:get3d(pos) * 4 - pos.y * 0.16 + 16 + season + time
	if value < 0 then
		value = 0
	elseif value > 20 then
		value = 20
	end
	return value
end

function get_average_temperature(pos)
	local temperature = minetest.get_perlin(554, 3, 0.6, 40)
	local season = minetest.get_gametime()
	local value = temperature:get3d(pos) * 4 - pos.y * 0.16 + 16
	if value < 0 then
		value = 0
	elseif value > 20 then
		value = 20
	end
	return value
end

function register_season(nodename, params)
		-- the season params are from 1.00 (early January) to 12.99 (end of December). Convert it into number like this : 0 ≥ n > 12.
	params.start = params.start - 1
	params.stop = params.stop - 1
	if params.type == "appear" then
		if not winterblock[nodename] then
			winterblock[nodename] = {}
		end
		table.insert(winterblock[nodename], params)
	else
		if not seasons[nodename] then
			seasons[nodename] = {}
		end
		table.insert(seasons[nodename], params)
	end
	local paramnode = minetest.registered_nodes[nodename]
		-- set the group "season"
	if not paramnode.groups then
		paramnode.groups = {}
	end
	paramnode.groups.season = 1
	minetest.register_node(":"..nodename, paramnode)
end

minetest.register_node("forest:winterblock", {
	description = "Bloc hiver",
	drawtype = "airlike",
	is_ground_content = true,
	groups = {not_in_creative_inventory = 1},
	paramtype = "light",
	sunlight_propagates = true,
	buildable_to = true,
	pointable = false,
	walkable = false,
})

minetest.register_abm({
	nodenames = {"forest:winterblock"},
	interval = 60,
	chance = 1,
	action = function(pos)
		local meta = minetest.get_meta(pos)
		local node = minetest.deserialize(meta:get_string("old_node"))
		if not node then
			minetest.dig_node(pos)
			return
		end
		local superparams = winterblock[node.name]
		for num, params in pairs(superparams) do
			local time = math.mod(params.stop - params.start + 12, 12)
			local season = math.mod(minetest.get_gametime(), 14400) / 1200
			if math.random() * 100 < params.speed and math.mod(season - params.start + 12, 12) < time then
				if minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "air" then
					if params.new_node then
						minetest.set_node(pos, params.new_node)
						print("[forest] "..node.name.." reappear as "..params.new_node.name.." at "..minetest.pos_to_string(pos))
					else
						minetest.set_node(pos, node)
						print("[forest] "..node.name.." reappear at "..minetest.pos_to_string(pos))
					end
				else
					minetest.dig_node(pos)
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"group:season"},
	interval = 60,
	chance = 1,
	action = function(pos, node)
		local superparams = seasons[node.name]
		for num, params in pairs(superparams) do
			if math.random() * 100 < params.speed then
				local time = math.mod(params.stop - params.start + 12, 12)
				local season = math.mod(minetest.get_gametime(), 14400) / 1200
				if math.mod(season - params.start + 12, 12) < time then
					if params.type == "disappear" then
						minetest.set_node(pos, {name = "forest:winterblock"})
						print("[forest] "..node.name.." disappears at "..minetest.pos_to_string(pos))
						local meta = minetest.get_meta(pos)
							-- memorize the old node
						if params.new_node then
							meta:set_string("old_node", minetest.serialize(params.new_node))
						else
							meta:set_string("old_node", minetest.serialize(node))
						end
					elseif params.type == "transforms" then
						minetest.set_node(pos, params.new_node)
						print("[forest] "..node.name.." turn into "..params.new_node.name.." at "..minetest.pos_to_string(pos))
					end
				end
			end
		end
	end,
})

function register_ore(def)
	num_ore = num_ore + 1
	ores[num_ore] = def
end

dofile(minetest.get_modpath("forest").."/tree_growing.lua")
dofile(minetest.get_modpath("forest").."/register_tree.lua")
dofile(minetest.get_modpath("forest").."/fir.lua")
dofile(minetest.get_modpath("forest").."/trees.lua")
dofile(minetest.get_modpath("forest").."/mud.lua")
dofile(minetest.get_modpath("forest").."/oil.lua")
dofile(minetest.get_modpath("forest").."/ores.lua")
dofile(minetest.get_modpath("forest").."/mapgen.lua")
dofile(minetest.get_modpath("forest").."/thermometer.lua")
dofile(minetest.get_modpath("forest").."/seasons.lua")

minetest.register_abm({
	nodenames = {"default:dirt_with_grass", "default:dirt_with_snow"},
	interval = 20,
	chance = 3,
	action = function(pos)
		if get_instant_temperature(pos) + math.random() < 8 then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		else
			minetest.set_node(pos, {name = "default:dirt_with_grass"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"default:water_source", "default:ice"},
	interval = 20,
	chance = 3,
	action = function(pos)
		if get_instant_temperature(pos) + math.random() < 8 then
			minetest.set_node(pos, {name = "default:ice"})
		else
			minetest.set_node(pos, {name = "default:water_source"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"forest:mud_source", "forest:mud_ice"},
	interval = 20,
	chance = 3,
	action = function(pos)
		if get_instant_temperature(pos) + math.random() < 8 then
			minetest.set_node(pos, {name = "forest:mud_ice"})
		else
			minetest.set_node(pos, {name = "forest:mud_source"})
		end
	end,
})
	-- I DETEST floating trees !
minetest.register_abm({
	nodenames = {"group:tree"},
	interval = 10,
	chance = 1,
	action = function(pos)
	pos.y = pos.y - 1
		if minetest.get_node(pos).name == "air" then
			pos.y = pos.y + 1
			minetest.dig_node(pos)
		end
	end,
})

minetest.register_node(":default:ice", {
	description = "Ice",
	drawtype = "glasslike",
	tiles = {"new_ice.png"},
	inventory_image = minetest.inventorycube("default_ice.png"),
	is_ground_content = true,
	paramtype = "light",
	freezemelt = "default:water_source",
	groups = {cracky=3, melts=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("forest:_clock", {
	description = "Clock",
	tiles = {"clock.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {dig_immediate=2},
	on_construct = function(pos)
		clockblock(pos)
	end,
	on_place = minetest.rotate_node
})

function clockblock(pos)
	local season = math.floor(math.mod(minetest.get_gametime() + 600 - minetest.get_timeofday() * 1200, 14400) / 1200)
	local month = nil
	if season == 0 then
		month = "Janvier"
	elseif season == 1 then
		month = "Fevrier"
	elseif season == 2 then
		month = "Mars"
	elseif season == 3 then
		month = "Avril"
	elseif season == 4 then
		month = "Mai"
	elseif season == 5 then
		month = "Juin"
	elseif season == 6 then
		month = "Juillet"
	elseif season == 7 then
		month = "Aout"
	elseif season == 8 then
		month = "Septembre"
	elseif season == 9 then
		month = "Octobre"
	elseif season == 10 then
		month = "Novembre"
	elseif season == 11 then
		month = "Decembre"
	end
	local year = math.floor((minetest.get_gametime() + 600 - minetest.get_timeofday() * 1200) / 14400)
	local time = math.floor(minetest.get_timeofday() * 1440)
	local hour = math.floor(time / 60)
	local minute = math.mod(time, 60)
	local meta = minetest.get_meta(pos)
	local separator = nil
	if minute < 10 then
		separator = ":0"
	else
		separator = ":"
	end
	meta:set_string("infotext", month.." "..year..", "..hour..separator..minute)
end

minetest.register_abm({
	nodenames = {"forest:_clock"},
	interval = 2,
	chance = 1,
	action = function(pos)
		clockblock(pos)
	end,
})

minetest.register_craft({
	output = 'forest:_clock',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'group:wood', 'default:mese_crystal', 'group:stick'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'dye:black',
	recipe = {
		{'default:coal_lump'},
	}
})

minetest.register_node("forest:sand_way", {
	description = "Sand heap",
	drawtype = "raillike",
	tiles = {"sand_way.png", "sand_way_curved.png", "sand_way_t_junction.png", "sand_way_crossing.png"},
	inventory_image = "sand_heap.png",
	wield_image = "sand_heap.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=3,way=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("forest:gravel_way", {
	description = "Gravel heap",
	drawtype = "raillike",
	tiles = {"gravel_way.png", "gravel_way_curved.png", "gravel_way_t_junction.png", "gravel_way_crossing.png"},
	inventory_image = "gravel_heap.png",
	wield_image = "gravel_heap.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=3,way=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("forest:desert_sand_way", {
	description = "Desert sand heap",
	drawtype = "raillike",
	tiles = {"desert_sand_way.png", "desert_sand_way_curved.png", "desert_sand_way_t_junction.png", "desert_sand_way_crossing.png"},
	inventory_image = "desert_sand_heap.png",
	wield_image = "desert_sand_heap.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=3,way=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_craft({
	output = 'forest:sand_way 9',
	recipe = {
		{'default:sand'},
	}
})

minetest.register_craft({
	output = 'forest:gravel_way 9',
	recipe = {
		{'default:gravel'},
	}
})

minetest.register_craft({
	output = 'forest:desert_sand_way 9',
	recipe = {
		{'default:desert_sand'},
	}
})

minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'forest:sand_way', 'forest:sand_way', 'forest:sand_way'},
		{'forest:sand_way', 'forest:sand_way', 'forest:sand_way'},
		{'forest:sand_way', 'forest:sand_way', 'forest:sand_way'},
	}
})

minetest.register_craft({
	output = 'default:gravel',
	recipe = {
		{'forest:gravel_way', 'forest:gravel_way', 'forest:gravel_way'},
		{'forest:gravel_way', 'forest:gravel_way', 'forest:gravel_way'},
		{'forest:gravel_way', 'forest:gravel_way', 'forest:gravel_way'},
	}
})

minetest.register_craft({
	output = 'default:desert_sand',
	recipe = {
		{'forest:desert_sand_way', 'forest:desert_sand_way', 'forest:desert_sand_way'},
		{'forest:desert_sand_way', 'forest:desert_sand_way', 'forest:desert_sand_way'},
		{'forest:desert_sand_way', 'forest:desert_sand_way', 'forest:desert_sand_way'},
	}
})

minetest.register_craft({
		output = "moreblocks:circular_saw 1", 
		recipe = {
				{ "",  "default:steel_ingot",  "" },
				{ "group:tree",  "group:tree",  "group:tree"},
				{ "group:tree",  "",  "group:tree"},
		}
})

minetest.register_craft({
	output = 'default:mese_crystal',
	recipe = {
		{'default:mese_crystal_fragment', 'default:mese_crystal_fragment', 'default:mese_crystal_fragment'},
		{'default:mese_crystal_fragment', 'default:mese_crystal_fragment', 'default:mese_crystal_fragment'},
		{'default:mese_crystal_fragment', 'default:mese_crystal_fragment', 'default:mese_crystal_fragment'},
	}
})
