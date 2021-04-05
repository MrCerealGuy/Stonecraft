-- sapling growth
-- these tables only affect hand-placed saplings
-- mapgen-placed always use their biome def settings, which are much more
-- limited, in the interest of speed.

local dirt_surfaces = {
	set = true,
	["default:dirt"] = true,
	["default:dirt_with_grass"] = true,
	["default:dirt_with_dry_grass"] = true,
	["default:dirt_with_coniferous_litter"] = true,
	["default:dirt_with_rainforest_litter"] = true,
	["woodsoils:dirt_with_leaves_1"] = true,
	["woodsoils:dirt_with_leaves_2"] = true,
	["woodsoils:grass_with_leaves_1"] = true,
	["woodsoils:grass_with_leaves_2"] = true
}

local conifer_surfaces =  {
	set = true,
	["default:dirt"] = true,
	["default:dirt_with_grass"] = true,
	["default:dirt_with_dry_grass"] = true,
	["default:dirt_with_coniferous_litter"] = true,
	["default:dirt_with_rainforest_litter"] = true,
	["woodsoils:dirt_with_leaves_1"] = true,
	["woodsoils:dirt_with_leaves_2"] = true,
	["woodsoils:grass_with_leaves_1"] = true,
	["woodsoils:grass_with_leaves_2"] = true,
	["default:dirt_with_snow"] = true
}

local sand_surfaces = {
	set = true,
	["default:sand"] = true,
	["default:desert_sand"] = true,
	["cottages:loam"] = true,
	-- note, no silver sand here.
	-- too cold for a palm, too... well... sandy for anything else.
}

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]
	local tree_model = treename.."_model"
	local tree_biome = treename.."_biome"
	local surfaces
	local grow_function = moretrees[tree_model]

	if treename == "spruce"
	  or treename == "fir"
	  or treename == "cedar"
	  or treename == "pine" then
		surfaces = conifer_surfaces
	elseif string.find(treename, "palm") then
		surfaces = sand_surfaces
	else
		surfaces = dirt_surfaces
	end

	if treename == "spruce"
	  or treename == "fir"
	  or treename == "birch"
	  or treename == "jungletree" then
		grow_function = "moretrees.grow_"..treename
	end

	biome_lib:dbg(dump(moretrees[tree_biome].surface))

	biome_lib:grow_plants({
		grow_delay = moretrees.sapling_interval,
		grow_chance = moretrees.sapling_chance,
		grow_plant = "moretrees:"..treename.."_sapling",
		grow_nodes = surfaces,
		grow_function = grow_function,
	})

	biome_lib:grow_plants({
		grow_delay = 2,
		grow_chance = 1,
		grow_plant = "moretrees:"..treename.."_sapling_ongen",
		grow_nodes = surfaces,
		grow_function = grow_function,
	})
end
