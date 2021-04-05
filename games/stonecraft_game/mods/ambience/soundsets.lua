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
	end
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
	end
})

-- check for env_sounds mod, if not found enable water flowing sounds
if not minetest.get_modpath("env_sounds") then

-- Water sound plays when near flowing water

ambience.add_set("flowing_water", {

	frequency = 1000,

	sounds = {
		{name = "waterfall", length = 6}
	},

	nodes = {"default:water_flowing"},

	sound_check = function(def)

		local c = (def.totals["default:water_flowing"] or 0)

		if c > 40 then
			return "flowing_water", 0.5

		elseif c > 5 then
			return "flowing_water"
		end
	end
})

-- River sound plays when near flowing river

ambience.add_set("river", {

	frequency = 1000,

	sounds = {
		{name = "river", length = 4, gain = 0.1}
	},

	nodes = {"default:river_water_flowing"},

	sound_check = function(def)

		local c = (def.totals["default:river_water_flowing"] or 0)

		if c > 20 then
			return "river", 0.5

		elseif c > 5 then
			return "river"
		end
	end
})

else
	print ("[Ambience] found env_sounds, flowing water sounds disabled.")
end

-- Only add fire sounds set if flame_sound is disabled or fire redo active

local flame_sound = minetest.settings:get_bool("flame_sound", true)
local fire_redo = minetest.get_modpath("fire") and fire.mod and fire.mod == "redo"

if flame_sound and not fire_redo then

	print ("[Ambience] fire sounds not enabled, already active in fire mod.")

else

-- Small fire sound plays when near lower than 9 flames

ambience.add_set("smallfire", {

	frequency = 1000,

	sounds = {
		{name = "fire_small", length = 6, gain = 0.1}
	},

	nodes = {"fire:basic_flame", "fire:permanent_flame"},

	sound_check = function(def)

		local c = (def.totals["fire:basic_flame"] or 0)
			+ (def.totals["fire:permanent_flame"] or 0)

		if c > 5 and c < 9 then
			return "smallfire", 0.5

		elseif c > 0 and c < 9 then
			return "smallfire"
		end
	end
})

-- Large fire sound plays when near more than 9 flames

ambience.add_set("largefire", {

	frequency = 1000,

	sounds = {
		{name = "fire_large", length = 8, gain = 0.4}
	},

	sound_check = function(def)

		-- fire nodes were added in last set, so don't need to be added in this one
		local c = (def.totals["fire:basic_flame"] or 0)
			+ (def.totals["fire:permanent_flame"] or 0)

		if c > 20 then
			return "largefire", 0.5

		elseif c > 8 then
			return "largefire"
		end
	end
})

end

-- Lava sound plays when near lava

ambience.add_set("lava", {

	frequency = 1000,

	sounds = {
		{name = "lava", length = 7}
	},

	nodes = {"default:lava_source", "default:lava_flowing"},

	sound_check = function(def)

		local c = (def.totals["default:lava_source"] or 0)
			+ (def.totals["default:lava_flowing"] or 0)

		if c > 20 then
			return "lava", 0.5

		elseif c > 5 then
			return "lava"
		end
	end
})

-- Beach sounds play when below y-pos 6 and 150+ water source found

ambience.add_set("beach", {

	frequency = 40,

	sounds = {
		{name = "seagull", length = 4.5, ephemeral = true},
		{name = "beach", length = 13},
		{name = "gull", length = 1, ephemeral = true},
		{name = "beach_2", length = 6}
	},

	nodes = {"default:water_source"},

	sound_check = function(def)

		local c = (def.totals["default:water_source"] or 0)

		if def.pos.y < 6 and def.pos.y > 0 and c > 150 then
			return "beach"
		end
	end
})

-- Ice sounds play when 100 or more ice are nearby

ambience.add_set("ice", {

	frequency = 250,

	sounds = {
		{name = "icecrack", length = 23},
		{name = "desertwind", length = 8},
		{name = "wind", length = 9}
	},

	nodes = {"default:ice"},

	sound_check = function(def)

		local c = (def.totals["default:ice"] or 0)

		if c > 100 then
			return "ice"
		end
	end
})

-- Desert sounds play when near 150+ desert or normal sand

ambience.add_set("desert", {

	frequency = 20,

	sounds = {
		{name = "coyote", length = 2.5, ephemeral = true},
		{name = "wind", length = 9},
		{name = "desertwind", length = 8}
	},

	nodes = {"default:desert_sand", "default:sand"},

	sound_check = function(def)

		local c = (def.totals["default:desert_sand"] or 0)
			+ (def.totals["default:sand"] or 0)

		if c > 150 and def.pos.y > 10 then
			return "desert"
		end
	end
})

-- Cave sounds play when below player position Y -25

ambience.add_set("cave", {

	frequency = 60,

	sounds = {
		{name = "drippingwater1", length = 1.5, ephemeral = true},
		{name = "drippingwater2", length = 1.5, ephemeral = true}
	},

	sound_check = function(def)

		if def.pos.y < -25 then
			return "cave"
		end
	end
})

-- Jungle sounds play during day and when around 90 jungletree trunks

ambience.add_set("jungle", {

	frequency = 200,

	sounds = {
		{name = "jungle_day_1", length = 7},
		{name = "deer", length = 7, ephemeral = true},
		{name = "canadianloon2", length = 14},
		{name = "bird1", length = 11},
		{name = "peacock", length = 2, ephemeral = true}
	},

	nodes = {"default:jungletree"},

	sound_check = function(def)

		local c = (def.totals["default:jungletree"] or 0)

		if def.tod > 0.2 and def.tod < 0.8 and c > 90 then
			return "jungle"
		end
	end
})

-- Jungle sounds play during night and when around 90 jungletree trunks

ambience.add_set("jungle_night", {

	frequency = 200,

	sounds = {
		{name = "jungle_night_1", length = 4, ephemeral = true},
		{name = "jungle_night_2", length = 4, ephemeral = true},
		{name = "deer", length = 7, ephemeral = true},
		{name = "frog", length = 1, ephemeral = true}
	},

	sound_check = function(def)

		-- jungle tree was added in last set, so doesnt need to be added in this one
		local c = (def.totals["default:jungletree"] or 0)

		if (def.tod < 0.2 or def.tod > 0.8) and c > 90 then
			return "jungle_night"
		end
	end
})

-- Daytime sounds play during day when around leaves and above ground

ambience.add_set("day", {

	frequency = 40,

	sounds = {
		{name = "cardinal", length = 3, ephemeral = true},
		{name = "craw", length = 3, ephemeral = true},
		{name = "bluejay", length = 6, ephemeral = true},
		{name = "robin", length = 4, ephemeral = true},
		{name = "bird1", length = 11},
		{name = "bird2", length = 6, ephemeral = true},
		{name = "crestedlark", length = 6, ephemeral = true},
		{name = "peacock", length = 2, ephemeral = true},
		{name = "wind", length = 9}
	},

	nodes = {"group:leaves"},

	sound_check = function(def)

		-- we used group:leaves but still need to specify actual nodes for total
		local c = (def.totals["default:leaves"] or 0)
			+ (def.totals["default:bush_leaves"] or 0)
			+ (def.totals["default:pine_needles"] or 0)
			+ (def.totals["default:aspen_leaves"] or 0)

		if (def.tod > 0.2 and def.tod < 0.8)
		and def.pos.y > -10
		and c > 5 then
			return "day"
		end
	end
})

-- Nighttime sounds play at night when above ground near leaves

ambience.add_set("night", {

	frequency = 40,

	sounds = {
		{name = "hornedowl", length = 2, ephemeral = true},
		{name = "wolves", length = 4, gain = 0.4, ephemeral = true},
		{name = "cricket", length = 6, ephemeral = true},
		{name = "deer", length = 7, ephemeral = true},
		{name = "frog", length = 1, ephemeral = true}
	},

	sound_check = function(def)

		-- leaves were added in last set, so don't need to be added to this one
		local c = (def.totals["default:leaves"] or 0)
			+ (def.totals["default:bush_leaves"] or 0)
			+ (def.totals["default:pine_needles"] or 0)
			+ (def.totals["default:aspen_leaves"] or 0)

		if (def.tod < 0.2 or def.tod > 0.8)
		and def.pos.y > -10
		and c > 5 then
			return "night"
		end
	end
})

-- Winds play when player is above 50 y-pos or near 150+ snow blocks

ambience.add_set("high_up", {

	frequency = 40,

	sounds = {
		{name = "desertwind", length = 8},
		{name = "wind", length = 9}
	},

	nodes = {"default:snowblock"},

	sound_check = function(def)

		local c = (def.totals["default:snowblock"] or 0)

		if def.pos.y > 50 or c > 150 then
			return "high_up"
		end
	end
})
