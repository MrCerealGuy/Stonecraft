--[[
	Default Sound Sets
	------------------

	Order is very important when adding a sound set so it will play
	certain sound sets before any another.
--]]

-- mod support

local mod_def = minetest.get_modpath("default")
local mod_mcl = minetest.get_modpath("mcl_core")

-- Underwater sounds play when player head is submerged

ambience.add_set("underwater", {

	frequency = 1000,

	sounds = {
		{name = "scuba", length = 8}
	},

	sound_check = function(def)

		local nodef = minetest.registered_nodes[def.head_node]

		if nodef and nodef.groups and nodef.groups.water then
			return "underwater"
		end
	end
})

-- Splashing sound plays when player walks inside water nodes (if enabled)

if minetest.settings:get_bool("ambience_water_move") ~= false then

	-- override default water sounds

	if mod_def then
		minetest.override_item("default:water_source", { sounds = {} })
		minetest.override_item("default:water_flowing", { sounds = {} })
		minetest.override_item("default:river_water_source", { sounds = {} })
		minetest.override_item("default:river_water_flowing", { sounds = {} })
	elseif mod_mcl then
		minetest.override_item("mcl_core:water_source", { sounds = {} })
		minetest.override_item("mcl_core:water_flowing", { sounds = {} })
		minetest.override_item("mclx_core:river_water_source", { sounds = {} })
		minetest.override_item("mclx_core:river_water_flowing", { sounds = {} })
	end

	ambience.add_set("splash", {

		frequency = 1000,

		sounds = {
			{name = "default_water_footstep", length = 2}
		},

		sound_check = function(def)

			local nodef = minetest.registered_nodes[def.feet_node]

			if nodef and nodef.groups and nodef.groups.water then

				local control = def.player:get_player_control()

				if control.up or control.down or control.left or control.right then
					return "splash"
				end
			end
		end
	})
end

-- check for env_sounds mod, if not found enable water flowing and lava sounds
if not minetest.get_modpath("env_sounds") then

	-- Water sound plays when near flowing water

	ambience.add_set("flowing_water", {

		frequency = 1000,

		sounds = {
			{name = "waterfall", length = 6}
		},

		nodes = {"group:water"},

		sound_check = function(def)

			local c = (def.totals["default:water_flowing"] or 0)
				+ (def.totals["mcl_core:water_flowing"] or 0)

			if c > 40 then return "flowing_water", 0.5

			elseif c > 5 then return "flowing_water" end
		end
	})

	-- River sound plays when near flowing river

	ambience.add_set("river", {

		frequency = 1000,

		sounds = {
			{name = "river", length = 4, gain = 0.1}
		},

		sound_check = function(def)

			local c = (def.totals["default:river_water_flowing"] or 0)
				+ (def.totals["mclx_core:river_water_flowing"] or 0)

			if c > 20 then return "river", 0.5

			elseif c > 5 then return "river" end
		end
	})

	-- Lava sound plays when near lava

	ambience.add_set("lava", {

		frequency = 1000,

		sounds = {
			{name = "lava", length = 7}
		},

		nodes = {"group:lava"},

		sound_check = function(def)

			local c = (def.totals["default:lava_source"] or 0)
				+ (def.totals["default:lava_flowing"] or 0)
				+ (def.totals["mcl_core:lava_source"] or 0)
				+ (def.totals["mcl_core:lava_flowing"] or 0)

			if c > 20 then return "lava", 0.5

			elseif c > 5 then return "lava" end
		end
	})
else
	print ("[MOD] Ambience - found env_sounds, using for water and lava sounds.")
end

-- Beach sounds play when below y-pos 6 and 150+ water source found

ambience.add_set("beach", {

	frequency = 40,

	sounds = {
		{name = "seagull", length = 4.5, ephemeral = true},
		{name = "seagull", length = 4.5, pitch = 1.2, ephemeral = true},
		{name = "beach", length = 13},
		{name = "gull", length = 1, ephemeral = true},
		{name = "beach_2", length = 6}
	},

	sound_check = function(def)

		local c = (def.totals["default:water_source"] or 0)
			+ (def.totals["mcl_core:water_source"] or 0)

		if def.pos.y < 6 and def.pos.y > 0 and c > 150 then
			return "beach"
		end
	end
})

-- Ice sounds play when 100 or more ice are nearby

ambience.add_set("ice", {

	frequency = 80,

	sounds = {
		{name = "icecrack", length = 5, gain = 1.1},
		{name = "desertwind", length = 8},
		{name = "wind", length = 9}
	},

	nodes = (mod_mcl and {"mcl_core:ice", "mcl_core:packed_ice"} or {"default:ice"}),

	sound_check = function(def)

		local c = (def.totals["default:ice"] or 0)
			+(def.totals["mcl_core:ice"] or 0)
			+ (def.totals["mcl_core:packed_ice"] or 0)

		if c > 400 then return "ice" end
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

	nodes = {
		(mod_mcl and "mcl_core:redsand" or "default:desert_sand"),
		(mod_mcl and "mcl_core:sand" or "default:sand")
	},

	sound_check = function(def)

		local c = (def.totals["default:desert_sand"] or 0)
			+ (def.totals["default:sand"] or 0)
			+ (def.totals["mcl_core:sand"] or 0)
			+ (def.totals["mcl_core:redsand"] or 0)

		if c > 150 and def.pos.y > 10 then return "desert" end
	end
})

-- Cave sounds play when below player position Y -25 and water nearby

ambience.add_set("cave", {

	frequency = 60,

	sounds = {
		{name = "drippingwater1", length = 1.5, ephemeral = true},
		{name = "drippingwater2", length = 1.5, ephemeral = true},
		{name = "drippingwater2", length = 1.5, pitch = 1.2, ephemeral = true},
		{name = "drippingwater2", length = 1.5, pitch = 1.4, ephemeral = true},
		{name = "bats", length = 5, ephemeral = true}
	},

	sound_check = function(def)

		local c = (def.totals["default:water_source"] or 0)
			+ (def.totals["mcl_core:water_source"] or 0)

		if c > 0 and def.pos.y < -25 then return "cave" end
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
		{name = "peacock", length = 2, ephemeral = true},
		{name = "peacock", length = 2, pitch = 1.2, ephemeral = true}
	},

	nodes = {(mod_mcl and "mcl_trees:tree_jungle" or "default:jungletree")},

	sound_check = function(def)

		local c = (def.totals["default:jungletree"] or 0)
			+ (def.totals["mcl_trees:tree_jungle"] or 0)

		if def.tod > 0.2 and def.tod < 0.8 and c > 79 then return "jungle" end
	end
})

-- Jungle sounds play during night and when around 90 jungletree trunks

ambience.add_set("jungle_night", {

	frequency = 200,

	sounds = {
		{name = "jungle_night_1", length = 4, ephemeral = true},
		{name = "jungle_night_2", length = 4, ephemeral = true},
		{name = "deer", length = 7, ephemeral = true},
		{name = "frog", length = 1, ephemeral = true},
		{name = "frog", length = 1, pitch = 1.3, ephemeral = true}
	},

	sound_check = function(def)

		-- jungle tree was added in last set, so doesnt need to be added in this one
		local c = (def.totals["default:jungletree"] or 0)
			+ (def.totals["mcl_trees:tree_jungle"] or 0)

		if (def.tod < 0.2 or def.tod > 0.8) and c > 79 then return "jungle_night" end
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
		{name = "robin", length = 4, pitch = 1.2, ephemeral = true},
		{name = "bird1", length = 11},
		{name = "bird2", length = 6, ephemeral = true},
		{name = "crestedlark", length = 6, ephemeral = true},
		{name = "crestedlark", length = 6, pitch = 1.1, ephemeral = true},
		{name = "peacock", length = 2, ephemeral = true},
		{name = "peacock", length = 2, pitch = 1.2, ephemeral = true},
		{name = "wind", length = 9}
	},

	nodes = {"group:leaves"},

	sound_check = function(def)

		-- use handy function to count all nodes in group:leaves
		local c = ambience.group_total(def.totals, "leaves")

		if (def.tod > 0.2 and def.tod < 0.8) and def.pos.y > 0 and c > 50 then
			return "day"
		end
	end
})

-- Nighttime sounds play at night when above ground near leaves

ambience.add_set("night", {

	frequency = 40,

	sounds = {
		{name = "hornedowl", length = 2, ephemeral = true},
		{name = "hornedowl", length = 2, pitch = 1.1, ephemeral = true},
		{name = "wolves", length = 4, gain = 0.4, ephemeral = true},
		{name = "cricket", length = 6, ephemeral = true},
		{name = "deer", length = 7, ephemeral = true},
		{name = "frog", length = 1, ephemeral = true},
		{name = "frog", length = 1, pitch = 1.2, ephemeral = true},
		{name = "wind", length = 9}
	},

	sound_check = function(def)

		-- use handy function to count all nodes in group:leaves
		local c = ambience.group_total(def.totals, "leaves")

		if (def.tod < 0.2 or def.tod > 0.8) and def.pos.y > 0 and c > 50 then
			return "night"
		end
	end
})

-- Winds play when player is above 50 y-pos or near 150+ snow blocks

ambience.add_set("high_up", {

	frequency = 40,

	sounds = {
		{name = "desertwind", length = 8},
		{name = "desertwind", length = 8, pitch = 1.3},
		{name = "wind", length = 9},
		{name = "wind", length = 9, pitch = 1.4}
	},

	nodes = {(mod_mcl and "mcl_core:snowblock" or "default:snowblock")},

	sound_check = function(def)

		local c = (def.totals["default:snowblock"] or 0)
			+ (def.totals["mcl_core:snowblock"] or 0)

		if def.pos.y > 50 or c > 100 then return "high_up" end
	end
})
