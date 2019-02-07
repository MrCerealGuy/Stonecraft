--[[
	Default Sound Sets
	------------------

	Order is very important when adding a sound set so it will play a certain
	set of sounds before any another.
--]]

-- Underwater sounds play when player head is submerged

ambience.add_set("underwater", {
	frequency = 1000,
	sounds = {
		{name = "scuba", length = 8}
	},
	sound_check = function(def)

		if minetest.registered_nodes[def.head_node]
		and minetest.registered_nodes[def.head_node].groups.water then
			return "underwater"
		end
	end,
})

-- Splashing sound plays when player walks inside water nodes

ambience.add_set("splash", {
	frequency = 1000,
	sounds = {
		{name = "swim_splashing", length = 3},
	},
	sound_check = function(def)

		if minetest.registered_nodes[def.feet_node]
		and minetest.registered_nodes[def.feet_node].groups.water then

			local control = def.player:get_player_control()

			if control.up or control.down or control.left or control.right then
				return "splash"
			end
		end
	end,
})

-- Water sound plays when near flowing water, will get louder if more than 50

ambience.add_set("flowing_water", {
	frequency = 1000,
	sounds = {
		{name = "waterfall", length = 6}
	},
	sound_check = function(def)

		local c = (def.totals["default:water_flowing"] or 0)

		if c > 50 then
			return "flowing_water", 0.5

		elseif c > 20 then
			return "flowing_water"
		end
	end,
	nodes = {"default:water_flowing"}
})

-- River sound plays when near flowing river, will get louder if more than 20

ambience.add_set("river", {
	frequency = 1000,
	sounds = {
		{name = "river", length = 4, gain = 0.1}
	},
	sound_check = function(def)

		local c = (def.totals["default:river_water_flowing"] or 0)

		if c > 20 then
			return "river", 0.4

		elseif c > 5 then
			return "river"
		end
	end,
	nodes = {"default:river_water_flowing"}
})

-- Small fire sound plays when near flame, will get louder if more than 3

ambience.add_set("smallfire", {
	frequency = 1000,
	sounds = {
		{name = "fire_small", length = 6, gain = 0.1}
	},
	sound_check = function(def)

		if fire and fire.mod and fire.mod == "redo" then

			local c = (def.totals["fire:basic_flame"] or 0)
				+ (def.totals["fire:permanent_flame"] or 0)

			if c > 3 and c < 9 then
				return "smallfire", 0.2

			elseif c > 0 and c < 4 then
				return "smallfire"
			end
		end
	end,
	nodes = {"fire:basic_flame", "fire:permanent_flame"}
})

-- Large fire sound plays when near flames, will get louder if more than 16

ambience.add_set("largefire", {
	frequency = 1000,
	sounds = {
		{name = "fire_large", length = 8, gain = 0.4}
	},
	sound_check = function(def)

		if fire and fire.mod and fire.mod == "redo" then

			local c = (def.totals["fire:basic_flame"] or 0)
				+ (def.totals["fire:permanent_flame"] or 0)

			if c > 16 then
				return "largefire", 0.4

			elseif c > 8 then
				return "largefire"
			end
		end
	end,
	nodes = {"fire:basic_flame", "fire:permanent_flame"}
})

-- Lava sound plays when near lava, will get louder if more than 50

ambience.add_set("lava", {
	frequency = 1000,
	sounds = {
		{name = "lava", length = 7}
	},
	sound_check = function(def)

		local c = (def.totals["default:lava_source"] or 0)
			+ (def.totals["default:lava_flowing"] or 0)

		if c > 50 then
			return "lava", 0.5

		elseif c > 5 then
			return "lava"
		end
	end,
	nodes = {"default:lava_source", "default:lava_flowing"}
})

-- Beach sounds play when around 0-7 player Y position and 150+ water source found

ambience.add_set("beach", {
	frequency = 40,
	sounds = {
		{name = "seagull", length = 4.5},
		{name = "beach", length = 13},
		{name = "gull", length = 1},
		{name = "beach_2", length = 6},
	},
	sound_check = function(def)

		local c = (def.totals["default:water_source"] or 0)

		if def.pos.y < 7 and def.pos.y > 0
		and c > 150 then
			return "beach"
		end
	end,
	nodes = {"default:water_source"}
})

-- Ice sounds play when 100 or more ice are nearby

ambience.add_set("ice", {
	frequency = 250,
	sounds = {
		{name = "icecrack", length = 23},
		{name = "desertwind", length = 8},
		{name = "wind", length = 9},
	},
	sound_check = function(def)

		local c = (def.totals["default:ice"] or 0)

		if c > 100 then
			return "ice"
		end
	end,
	nodes = {"default:ice"},
})

-- Desert sounds play when near 150+ desert or normal sand

ambience.add_set("desert", {
	frequency = 20,
	sounds = {
		{name = "coyote", length = 2.5},
		{name = "wind", length = 9},
		{name = "desertwind", length = 8}
	},
	sound_check = function(def)

		local c = (def.totals["default:desert_sand"] or 0)
			+ (def.totals["default:sand"] or 0)

		if c > 150 and def.pos.y > 10 then
			return "desert"
		end
	end,
	nodes = {"default:desert_sand", "default:sand"}
})

-- Winds play when player is above 50 Y position and near 150+ snow blocks

ambience.add_set("high_up", {
	frequency = 40,
	sounds = {
		{name = "desertwind", length = 8},
		{name = "wind", length = 9},
	},
	sound_check = function(def)

		local c = (def.totals["default:snowblock"] or 0)

		if def.pos.y > 50
		or c > 150 then
			return "high_up"
		end
	end,
	nodes = {"default:snowblock"}
})

-- Cave sounds play when below player position Y -25

ambience.add_set("cave", {
	frequency = 60,
	sounds = {
		{name = "drippingwater1", length = 1.5},
		{name = "drippingwater2", length = 1.5}
	},
	sound_check = function(def)

		if def.pos.y < -25 then
			return "cave"
		end
	end,
})

-- Jungle sounds play during daytime and when around 90 jungletree trunks

ambience.add_set("jungle", {
	frequency = 200,
	sounds = {
		{name = "jungle_day_1", length = 7},
		{name = "deer", length = 7},
		{name = "canadianloon2", length = 14},
		{name = "bird1", length = 11},
		{name = "peacock", length = 2},
	},
	sound_check = function(def)

		local c = (def.totals["default:jungletree"] or 0)

		if def.tod > 0.2 and def.tod < 0.8 and c > 90 then
			return "jungle"
		end
	end,
	nodes = {"default:jungletree"}
})

-- Jungle sounds play during nighttime and when around 90 jungletree trunks

ambience.add_set("jungle_night", {
	frequency = 200,
	sounds = {
		{name = "jungle_night_1", length = 4},
		{name = "jungle_night_2", length = 4},
		{name = "deer", length = 7},
		{name = "frog", length = 1},
	},
	sound_check = function(def)

		local c = (def.totals["default:jungletree"] or 0)

		if (def.tod < 0.2 or def.tod > 0.8) and c > 90 then
			return "jungle"
		end
	end,
	nodes = {"default:jungletree"}
})

-- Nighttime sounds play at night when around leaves and above ground

ambience.add_set("night", {
	frequency = 40,
	sounds = {
		{name = "hornedowl", length = 2},
		{name = "wolves", length = 4, gain = 0.4},
		{name = "cricket", length = 6},
		{name = "deer", length = 7},
		{name = "frog", length = 1},
	},
	sound_check = function(def)

		local c = (def.totals["default:leaves"] or 0)
			+ (def.totals["default:bush_leaves"] or 0)
			+ (def.totals["default:pine_leaves"] or 0)
			+ (def.totals["default:aspen_leaves"] or 0)

		if (def.tod < 0.2 or def.tod > 0.8)
		and def.pos.y > -10
		and c > 5 then
			return "night"
		end
	end,
})

-- Daytime sounds play during day when around leaves and above ground

ambience.add_set("day", {
	frequency = 40,
	sounds = {
		{name = "cardinal", length = 3},
		{name = "craw", length = 3},
		{name = "bluejay", length = 6},
		{name = "robin", length = 4},
		{name = "bird1", length = 11},
		{name = "bird2", length = 6},
		{name = "crestedlark", length = 6},
		{name = "peacock", length = 2},
		{name = "wind", length = 9},
	},
	sound_check = function(def)

		local c = (def.totals["default:leaves"] or 0)
			+ (def.totals["default:bush_leaves"] or 0)
			+ (def.totals["default:pine_leaves"] or 0)
			+ (def.totals["default:aspen_leaves"] or 0)

		if (def.tod > 0.2 and def.tod < 0.8)
		and def.pos.y > -10
		and c > 5 then
			return "day"
		end
	end,
	nodes = {"group:leaves"}
})
