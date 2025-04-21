-- More trees!  2013-04-07
--
-- This mod adds more types of trees to the game
--
-- Some of the node definitions and textures came from cisoun's conifers mod
-- and bas080's jungle trees mod.
--
-- Brought together into one mod and made L-systems compatible by Vanessa
-- Ezekowitz.
--
-- Firs and Jungle tree axioms/rules by Vanessa Dannenberg, with the
-- latter having been tweaked by RealBadAngel, most other axioms/rules written
-- by RealBadAngel.
--

moretrees = {}

local S = minetest.get_translator("moretrees")

if minetest.get_modpath("default") then
	minetest.override_item("default:sapling", {
		description = S("Sapling")
	})

	minetest.override_item("default:tree", {
		description = S("Tree")
	})

	minetest.override_item("default:wood", {
		description = S("Wooden Planks")
	})

	minetest.override_item("default:leaves", {
		description = S("Leaves")
	})

	minetest.override_item("default:fence_wood", {
		description = S("Wooden Fence")
	})

	minetest.override_item("default:fence_rail_wood", {
		description = S("Wooden Fence Rail")
	})
end

if minetest.get_modpath("doors") then
	minetest.override_item("doors:gate_wood_closed", {
		description = S("Wooden Fence Gate")
	})

	minetest.override_item("doors:gate_wood_open", {
		description = S("Wooden Fence Gate")
	})
end


-- Read the default config file (and if necessary, copy it to the world folder).

local worldpath=minetest.get_worldpath()
local modpath=minetest.get_modpath("moretrees")

dofile(modpath.."/settings.lua")

if io.open(worldpath.."/moretrees_settings.txt","r") then
	io.close()
	dofile(worldpath.."/moretrees_settings.txt")
end

-- Validate that if ethereal exists, that it's version is greater than 20220424.
-- Lower versions of ethereal clear registered biomes and decorations during
-- initialization which results in lost content from this mod (and others)
-- depending on where they are in the mod load order.
minetest.register_on_mods_loaded(function()
	if minetest.global_exists("ethereal") then
		local ethereal_ver = tonumber(ethereal.version)
		if (ethereal_ver and ethereal_ver < 20220424) then
			error("[moretrees] The version of ethereal detected can result " ..
				  "in parts of this mod and others disappearing due to mod " ..
				  "load order. Please update ethereal.");
		end
	end
end)

-- infinite stacks checking

if minetest.get_modpath("unified_inventory") or not
		minetest.settings:get_bool("creative_mode") then
	moretrees.expect_infinite_stacks = false
else
	moretrees.expect_infinite_stacks = true
end

-- tables, load other files

moretrees.cutting_tools = {
	"default:axe_mese",
	xcompat.materials.axe_steel,
	xcompat.materials.axe_diamond,
	xcompat.materials.axe_bronze,
	"glooptest:axe_alatro",
	"glooptest:axe_arol",
	"moreores:axe_mithril",
	"moreores:axe_silver",
	"titanium:axe",
}

dofile(modpath.."/tree_models.lua")
dofile(modpath.."/node_defs.lua")
dofile(modpath.."/date_palm.lua")
dofile(modpath.."/cocos_palm.lua")
dofile(modpath.."/biome_defs.lua")
dofile(modpath.."/saplings.lua")
dofile(modpath.."/crafts.lua")

-- tree spawning setup
moretrees.spawn_beech_object = moretrees.beech_model
moretrees.spawn_apple_tree_object = moretrees.apple_tree_model
moretrees.spawn_oak_object = moretrees.oak_model
moretrees.spawn_sequoia_object = moretrees.sequoia_model
moretrees.spawn_palm_object = moretrees.palm_model
moretrees.spawn_date_palm_object = moretrees.date_palm_model
moretrees.spawn_cedar_object = moretrees.cedar_model
moretrees.spawn_rubber_tree_object = moretrees.rubber_tree_model
moretrees.spawn_willow_object = moretrees.willow_model
moretrees.spawn_birch_object = "moretrees.grow_birch"
moretrees.spawn_spruce_object = "moretrees.grow_spruce"
moretrees.spawn_jungletree_object = "moretrees.grow_jungletree"
moretrees.spawn_fir_object = "moretrees.grow_fir"
moretrees.spawn_fir_snow_object = "moretrees.grow_fir_snow"
moretrees.spawn_poplar_object = moretrees.poplar_model
moretrees.spawn_poplar_small_object = moretrees.poplar_small_model

local deco_ids = {}

function translate_biome_defs(def, treename, index)
	if not index then index = 1 end
	local deco_def = {
		name = treename .. "_" .. index,
		deco_type = "simple",
		place_on = def.place_on,
		sidelen = 16,
		fill_ratio = def.fill_ratio or 0.001,
		--biomes eventually?
		y_min = def.min_elevation,
		y_max = def.max_elevation,
		spawn_by = def.spawn_by,
		num_spawn_by = def.num_spawn_by,
		decoration = "moretrees:"..treename.."_sapling_ongen"
	}

	deco_ids[#deco_ids+1] = treename .. ("_" .. index or "_1")

	return deco_def
end

minetest.register_decoration(translate_biome_defs(moretrees.beech_biome, "beech"))
minetest.register_decoration(translate_biome_defs(moretrees.apple_tree_biome, "apple_tree"))
minetest.register_decoration(translate_biome_defs(moretrees.oak_biome, "oak"))
minetest.register_decoration(translate_biome_defs(moretrees.sequoia_biome, "sequoia"))
minetest.register_decoration(translate_biome_defs(moretrees.palm_biome, "palm"))
minetest.register_decoration(translate_biome_defs(moretrees.date_palm_biome, "date_palm", 1))
minetest.register_decoration(translate_biome_defs(moretrees.date_palm_biome_2, "date_palm", 2))
minetest.register_decoration(translate_biome_defs(moretrees.cedar_biome, "cedar"))
minetest.register_decoration(translate_biome_defs(moretrees.rubber_tree_biome, "rubber_tree"))
minetest.register_decoration(translate_biome_defs(moretrees.willow_biome, "willow"))
minetest.register_decoration(translate_biome_defs(moretrees.birch_biome, "birch"))
minetest.register_decoration(translate_biome_defs(moretrees.spruce_biome, "spruce"))
if minetest.get_modpath("default") then
	minetest.register_decoration(translate_biome_defs(moretrees.jungletree_biome, "jungletree"))
end
minetest.register_decoration(translate_biome_defs(moretrees.fir_biome, "fir", 1))
if minetest.get_modpath("snow") then
	minetest.register_decoration(translate_biome_defs(moretrees.fir_biome_snow, "fir", 2))
end
minetest.register_decoration(translate_biome_defs(moretrees.poplar_biome, "poplar", 1))
minetest.register_decoration(translate_biome_defs(moretrees.poplar_biome_2, "poplar", 2))
minetest.register_decoration(translate_biome_defs(moretrees.poplar_biome_3, "poplar", 3))
minetest.register_decoration(translate_biome_defs(moretrees.poplar_small_biome, "poplar_small", 4))
minetest.register_decoration(translate_biome_defs(moretrees.poplar_small_biome_2, "poplar_small", 5))

--[[
	this is purposefully wrapped in a on mods loaded callback to that it gets the proper ids
	if other mods clear the registered decorations
]]
minetest.register_on_mods_loaded(function()
	for k, v in pairs(deco_ids) do
		deco_ids[k] = minetest.get_decoration_id(v)
	end
	minetest.set_gen_notify("decoration", deco_ids)
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
    local g = minetest.get_mapgen_object("gennotify")
    local locations = {}
	for _, id in pairs(deco_ids) do
		local deco_locations = g["decoration#" .. id] or {}
		for _, pos in pairs(deco_locations) do
			locations[#locations+1] = pos
		end
	end

    if #locations == 0 then return end
    for _, pos in ipairs(locations) do
        local timer = minetest.get_node_timer({x=pos.x, y=pos.y+1, z=pos.z})
        timer:start(math.random(2,10))
    end
end)

-- Code to spawn a birch tree

function moretrees.grow_birch(pos)
	minetest.swap_node(pos, {name = "air"})
	if math.random(1,2) == 1 then
		minetest.spawn_tree(pos, moretrees.birch_model1)
	else
		minetest.spawn_tree(pos, moretrees.birch_model2)
	end
end

-- Code to spawn a spruce tree

function moretrees.grow_spruce(pos)
	minetest.swap_node(pos, {name = "air"})
	if math.random(1,2) == 1 then
		minetest.spawn_tree(pos, moretrees.spruce_model1)
	else
		minetest.spawn_tree(pos, moretrees.spruce_model2)
	end
end

-- Code to spawn jungle trees

moretrees.jt_axiom1 = "FFFA"
moretrees.jt_rules_a1 = "FFF[&&-FBf[&&&Ff]^^^Ff][&&+FBFf[&&&FFf]^^^Ff][&&---FBFf[&&&Ff]^^^Ff][&&+++FBFf[&&&Ff]^^^Ff]F/A"
moretrees.jt_rules_b1 = "[-Ff&f][+Ff&f]B"

moretrees.jt_axiom2 = "FFFFFA"
-- luacheck: no max line length
moretrees.jt_rules_a2 = "FFFFF[&&-FFFBF[&&&FFff]^^^FFf][&&+FFFBFF[&&&FFff]^^^FFf][&&---FFFBFF[&&&FFff]^^^FFf][&&+++FFFBFF[&&&FFff]^^^FFf]FF/A"
moretrees.jt_rules_b2 = "[-FFf&ff][+FFf&ff]B"

moretrees.ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b1 = "[-FBf][+FBf]"

moretrees.ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b2 = "[-fB][+fB]"

function moretrees.grow_jungletree(pos)
	local r1 = math.random(2)
	local r2 = math.random(3)
	if r1 == 1 then
		moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_red"
	else
		moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_yellow"
	end
	moretrees.jungletree_model.leaves2_chance = math.random(25, 75)

	if r2 == 1 then
		moretrees.jungletree_model.trunk_type = "single"
		moretrees.jungletree_model.iterations = 2
		moretrees.jungletree_model.axiom = moretrees.jt_axiom1
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a1
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b1
	elseif r2 == 2 then
		moretrees.jungletree_model.trunk_type = "double"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	elseif r2 == 3 then
		moretrees.jungletree_model.trunk_type = "crossed"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	end

	minetest.swap_node(pos, {name = "air"})
	local leaves = minetest.find_nodes_in_area(
		{x = pos.x-1, y = pos.y, z = pos.z-1}, {x = pos.x+1, y = pos.y+10, z = pos.z+1},
		xcompat.materials.apple_leaves
	)
	for leaf in ipairs(leaves) do
			minetest.swap_node(leaves[leaf], {name = "air"})
	end
	minetest.spawn_tree(pos, moretrees.jungletree_model)
end

-- code to spawn fir trees

function moretrees.grow_fir(pos)
	if math.random(2) == 1 then
		moretrees.fir_model.leaves="moretrees:fir_leaves"
	else
		moretrees.fir_model.leaves="moretrees:fir_leaves_bright"
	end
	if math.random(2) == 1 then
		moretrees.fir_model.rules_a = moretrees.ct_rules_a1
		moretrees.fir_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.fir_model.rules_a = moretrees.ct_rules_a2
		moretrees.fir_model.rules_b = moretrees.ct_rules_b2
	end

	moretrees.fir_model.iterations = 7
	moretrees.fir_model.random_level = 5

	minetest.swap_node(pos, {name = "air"})
	local leaves = minetest.find_nodes_in_area(
		{x = pos.x, y = pos.y, z = pos.z},
		{x = pos.x, y = pos.y+5, z = pos.z},
		xcompat.materials.apple_leaves
	)
	for leaf in ipairs(leaves) do
		minetest.swap_node(leaves[leaf], {name = "air"})
	end
	minetest.spawn_tree(pos,moretrees.fir_model)
end

-- same thing, but a smaller version that grows only in snow biomes

function moretrees.grow_fir_snow(pos)
	if math.random(2) == 1 then
		moretrees.fir_model.leaves="moretrees:fir_leaves"
	else
		moretrees.fir_model.leaves="moretrees:fir_leaves_bright"
	end
	if math.random(2) == 1 then
		moretrees.fir_model.rules_a = moretrees.ct_rules_a1
		moretrees.fir_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.fir_model.rules_a = moretrees.ct_rules_a2
		moretrees.fir_model.rules_b = moretrees.ct_rules_b2
	end

	moretrees.fir_model.iterations = 2
	moretrees.fir_model.random_level = 2

	minetest.swap_node(pos, {name = "air"})
	local leaves = minetest.find_nodes_in_area(
		{x = pos.x, y = pos.y, z = pos.z},
		{x = pos.x, y = pos.y+5, z = pos.z},
		xcompat.materials.apple_leaves
	)
	for leaf in ipairs(leaves) do
			minetest.swap_node(leaves[leaf], {name = "air"})
	end
	minetest.spawn_tree(pos,moretrees.fir_model)
end

if moretrees.grow_legacy_saplings then
	minetest.register_lbm({
		name = "moretrees:grow_ongen_saplings",
		label = "Grow legacy ongen saplings",
		nodenames = {"group:moretrees_ongen"},
		run_at_every_load = true,
		action = function(pos)
			minetest.log("info", "[moretrees] Starting growth timer for legacy ongen sapling at "..minetest.pos_to_string(pos, 0))
			minetest.get_node_timer(pos):start(math.random(2, 10))
		end
	})
end

minetest.log("info", "[moretrees] Loading done")
