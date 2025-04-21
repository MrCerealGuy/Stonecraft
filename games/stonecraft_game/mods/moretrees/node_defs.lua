local S = minetest.get_translator("moretrees")

moretrees.avoidnodes = {}

local jungle_sapling_texture = minetest.get_modpath("default") and "default_junglesapling.png"
	or "moretrees_cedar_sapling.png"

moretrees.treelist = {
	{"beech",        S("Beech Tree")},
	{"apple_tree",   S("Apple Tree")},
	{"oak",          S("Oak Tree"),       "acorn",                S("Acorn"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"sequoia",      S("Giant Sequoia")},
	{"birch",        S("Birch Tree")},
	{"palm",         S("Palm Tree"),      "palm_fruit_trunk_gen", S("Palm Tree"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 1.0 },
	{"date_palm",    S("Date Palm Tree"), "date_palm_fruit_trunk",S("Date Palm Tree"), {0, 0, 0, 0, 0, 0}, 0.0 },
	{"spruce",       S("Spruce Tree"),    "spruce_cone",          S("Spruce Cone"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"cedar",        S("Cedar Tree"),     "cedar_cone",           S("Cedar Cone"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"poplar",       S("Poplar Tree")},
	{"poplar_small", S("Poplar Tree")},
	{"willow",       S("Willow Tree")},
	{"rubber_tree",  S("Rubber Tree")},
	{"fir",          S("Douglas Fir"),    "fir_cone",             S("Fir Cone"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"jungletree",   S("Jungle Tree"),     nil,                   nil, nil, nil, jungle_sapling_texture  },
}

moretrees.treedesc = {
	beech = {
		trunk = S("Beech Tree Trunk"),
		planks = S("Beech Tree Planks"),
		sapling = S("Beech Tree Sapling"),
		leaves = S("Beech Tree Leaves"),
		trunk_stair = S("Beech Tree Trunk Stair"),
		trunk_slab = S("Beech Tree Trunk Slab"),
		planks_stair = S("Beech Tree Planks Stair"),
		planks_slab = S("Beech Tree Planks Slab"),
		fence = S("Beech Tree Fence"),
		fence_rail = S("Beech Tree Fence Rail"),
		fence_gate = S("Beech Tree Fence Gate"),
	},
	apple_tree = {
		trunk = S("Apple Tree Trunk"),
		planks = S("Apple Tree Planks"),
		sapling = S("Apple Tree Sapling"),
		leaves = S("Apple Tree Leaves"),
		trunk_stair = S("Apple Tree Trunk Stair"),
		trunk_slab = S("Apple Tree Trunk Slab"),
		planks_stair = S("Apple Tree Planks Stair"),
		planks_slab = S("Apple Tree Planks Slab"),
		fence = S("Apple Tree Fence"),
		fence_rail = S("Apple Tree Fence Rail"),
		fence_gate = S("Apple Tree Fence Gate"),
	},
	oak = {
		trunk = S("Oak Tree Trunk"),
		planks = S("Oak Tree Planks"),
		sapling = S("Oak Tree Sapling"),
		leaves = S("Oak Tree Leaves"),
		trunk_stair = S("Oak Tree Trunk Stair"),
		trunk_slab = S("Oak Tree Trunk Slab"),
		planks_stair = S("Oak Tree Planks Stair"),
		planks_slab = S("Oak Tree Planks Slab"),
		fence = S("Oak Tree Fence"),
		fence_rail = S("Oak Tree Fence Rail"),
		fence_gate = S("Oak Tree Fence Gate"),
	},
	sequoia = {
		trunk = S("Giant Sequoia Trunk"),
		planks = S("Giant Sequoia Planks"),
		sapling = S("Giant Sequoia Sapling"),
		leaves = S("Giant Sequoia Leaves"),
		trunk_stair = S("Giant Sequoia Trunk Stair"),
		trunk_slab = S("Giant Sequoia Trunk Slab"),
		planks_stair = S("Giant Sequoia Planks Stair"),
		planks_slab = S("Giant Sequoia Planks Slab"),
		fence = S("Giant Sequoia Fence"),
		fence_rail = S("Giant Sequoia Fence Rail"),
		fence_gate = S("Giant Sequoia Fence Gate"),
	},
	birch = {
		trunk = S("Birch Tree Trunk"),
		planks = S("Birch Tree Planks"),
		sapling = S("Birch Tree Sapling"),
		leaves = S("Birch Tree Leaves"),
		trunk_stair = S("Birch Tree Trunk Stair"),
		trunk_slab = S("Birch Tree Trunk Slab"),
		planks_stair = S("Birch Tree Planks Stair"),
		planks_slab = S("Birch Tree Planks Slab"),
		fence = S("Birch Tree Fence"),
		fence_rail = S("Birch Tree Fence Rail"),
		fence_gate = S("Birch Tree Fence Gate"),
	},
	palm = {
		trunk = S("Palm Tree Trunk"),
		planks = S("Palm Tree Planks"),
		sapling = S("Palm Tree Sapling"),
		leaves = S("Palm Tree Leaves"),
		trunk_stair = S("Palm Tree Trunk Stair"),
		trunk_slab = S("Palm Tree Trunk Slab"),
		planks_stair = S("Palm Tree Planks Stair"),
		planks_slab = S("Palm Tree Planks Slab"),
		fence = S("Palm Tree Fence"),
		fence_rail = S("Palm Tree Fence Rail"),
		fence_gate = S("Palm Tree Fence Gate"),
	},
	date_palm = {
		trunk = S("Date Palm Tree Trunk"),
		planks = S("Date Palm Tree Planks"),
		sapling = S("Date Palm Tree Sapling"),
		leaves = S("Date Palm Tree Leaves"),
		trunk_stair = S("Date Palm Tree Trunk Stair"),
		trunk_slab = S("Date Palm Tree Trunk Slab"),
		planks_stair = S("Date Palm Tree Planks Stair"),
		planks_slab = S("Date Palm Tree Planks Slab"),
		fence = S("Date Palm Tree Fence"),
		fence_rail = S("Date Palm Tree Fence Rail"),
		fence_gate = S("Date Palm Tree Fence Gate"),
	},
	spruce = {
		trunk = S("Spruce Tree Trunk"),
		planks = S("Spruce Tree Planks"),
		sapling = S("Spruce Tree Sapling"),
		leaves = S("Spruce Tree Leaves"),
		trunk_stair = S("Spruce Tree Trunk Stair"),
		trunk_slab = S("Spruce Tree Trunk Slab"),
		planks_stair = S("Spruce Tree Planks Stair"),
		planks_slab = S("Spruce Tree Planks Slab"),
		fence = S("Spruce Tree Fence"),
		fence_rail = S("Spruce Tree Fence Rail"),
		fence_gate = S("Spruce Tree Fence Gate"),
	},
	cedar =  {
		trunk = S("Cedar Tree Trunk"),
		planks = S("Cedar Tree Planks"),
		sapling = S("Cedar Tree Sapling"),
		leaves = S("Cedar Tree Leaves"),
		trunk_stair = S("Cedar Tree Trunk Stair"),
		trunk_slab = S("Cedar Tree Trunk Slab"),
		planks_stair = S("Cedar Tree Planks Stair"),
		planks_slab = S("Cedar Tree Planks Slab"),
		fence = S("Cedar Tree Fence"),
		fence_rail = S("Cedar Tree Fence Rail"),
		fence_gate = S("Cedar Tree Fence Gate"),
	},
	poplar = {
		trunk = S("Poplar Tree Trunk"),
		planks = S("Poplar Tree Planks"),
		sapling = S("Poplar Tree Sapling"),
		leaves = S("Poplar Tree Leaves"),
		trunk_stair = S("Poplar Tree Trunk Stair"),
		trunk_slab = S("Poplar Tree Trunk Slab"),
		planks_stair = S("Poplar Tree Planks Stair"),
		planks_slab = S("Poplar Tree Planks Slab"),
		fence = S("Poplar Tree Fence"),
		fence_rail = S("Poplar Tree Fence Rail"),
		fence_gate = S("Poplar Tree Fence Gate"),
	},
	poplar_small = {
		sapling = S("Small poplar Tree Sapling"),
	},
	willow = {
		trunk = S("Willow Tree Trunk"),
		planks = S("Willow Tree Planks"),
		sapling = S("Willow Tree Sapling"),
		leaves = S("Willow Tree Leaves"),
		trunk_stair = S("Willow Tree Trunk Stair"),
		trunk_slab = S("Willow Tree Trunk Slab"),
		planks_stair = S("Willow Tree Planks Stair"),
		planks_slab = S("Willow Tree Planks Slab"),
		fence = S("Willow Tree Fence"),
		fence_rail = S("Willow Tree Fence Rail"),
		fence_gate = S("Willow Tree Fence Gate"),
	},
	rubber_tree = {
		trunk = S("Rubber Tree Trunk"),
		planks = S("Rubber Tree Planks"),
		sapling = S("Rubber Tree Sapling"),
		leaves = S("Rubber Tree Leaves"),
		trunk_stair = S("Rubber Tree Trunk Stair"),
		trunk_slab = S("Rubber Tree Trunk Slab"),
		planks_stair = S("Rubber Tree Planks Stair"),
		planks_slab = S("Rubber Tree Planks Slab"),
		fence = S("Rubber Tree Fence"),
		fence_rail = S("Rubber Tree Fence Rail"),
		fence_gate = S("Rubber Tree Fence Gate"),
	},
	fir = {
		trunk = S("Douglas Fir Trunk"),
		planks = S("Douglas Fir Planks"),
		sapling = S("Douglas Fir Sapling"),
		leaves = S("Douglas Fir Leaves"),
		trunk_stair = S("Douglas Fir Trunk Stair"),
		trunk_slab = S("Douglas Fir Trunk Slab"),
		planks_stair = S("Douglas Fir Planks Stair"),
		planks_slab = S("Douglas Fir Planks Slab"),
		fence = S("Douglas Fir Fence"),
		fence_rail = S("Douglas Fir Fence Rail"),
		fence_gate = S("Douglas Fir Fence Gate"),
	},
	jungletree = {
		trunk = S("Jungle Tree Trunk"),
		planks = S("Jungle Tree Planks"),
		sapling = S("Jungle Tree Sapling"),
		leaves = S("Jungle Tree Leaves"),
		trunk_stair = S("Jungle Tree Trunk Stair"),
		trunk_slab = S("Jungle Tree Trunk Slab"),
		planks_stair = S("Jungle Tree Planks Stair"),
		planks_slab = S("Jungle Tree Planks Slab"),
		fence = S("Jungle Tree Fence"),
		fence_rail = S("Jungle Tree Fence Rail"),
		fence_gate = S("Jungle Tree Fence Gate"),
	},
}


-- local dirs1 = { 21, 20, 23, 22, 21 }
local dirs2 = { 12, 9, 18, 7, 12 }
-- local dirs3 = { 14, 11, 16, 5, 14 }

local moretrees_new_leaves_drawtype = "allfaces_optional"
local moretrees_plantlike_leaves_visual_scale = 1

if moretrees.plantlike_leaves then
	moretrees_new_leaves_drawtype = "plantlike"
	moretrees_plantlike_leaves_visual_scale = math.sqrt(2)
end

-- redefine default leaves to handle plantlike and/or leaf decay options

if minetest.get_modpath("default") and moretrees.plantlike_leaves then
	minetest.override_item(xcompat.materials.apple_leaves, {
		inventory_image = minetest.inventorycube("default_leaves.png"),
		drawtype = "plantlike",
		visual_scale = math.sqrt(2)
	})
end

-- redefine default jungle leaves for same

if minetest.get_modpath("default") and moretrees.plantlike_leaves then
	minetest.override_item(xcompat.materials.jungle_leaves, {
		inventory_image = minetest.inventorycube("default_jungleleaves.png"),
		drawtype = "plantlike",
		visual_scale = math.sqrt(2)
	})
end

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]
	local fruit = moretrees.treelist[i][3]
	local fruitdesc = moretrees.treelist[i][4]
	local selbox = moretrees.treelist[i][5]
	local vscale = moretrees.treelist[i][6]

	local saptex = moretrees.treelist[i][7]

	-- player will get a sapling with 1/100 chance
	-- player will get leaves only if he/she gets no saplings,
	-- this is because max_items is 1

	local droprarity = 100
	local decay = moretrees.leafdecay_radius

	if treename == "palm" then
		droprarity = 20
		decay = moretrees.palm_leafdecay_radius
	elseif treename == "date_palm" then
		decay = moretrees.date_palm_leafdecay_radius
	end

	-- dont register planks/nodes for trees from default and small varients for trees
	local split_tn = treename:split("_")
	if treename ~= "jungletree" and treename ~= "pine" and split_tn[2]~="small" then

		saptex = "moretrees_"..treename.."_sapling.png"

		minetest.register_node("moretrees:"..treename.."_trunk", {
			description = moretrees.treedesc[treename].trunk,
			tiles = {
				"moretrees_"..treename.."_trunk_top.png",
				"moretrees_"..treename.."_trunk_top.png",
				"moretrees_"..treename.."_trunk.png"
			},
			paramtype2 = "facedir",
			is_ground_content = false,
			groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
			sounds = xcompat.sounds.node_sound_wood_defaults(),
			on_place = minetest.rotate_node,
		})

		if moretrees.enable_planks then
			minetest.register_node("moretrees:"..treename.."_planks", {
				description = moretrees.treedesc[treename].planks,
				tiles = {"moretrees_"..treename.."_wood.png"},
				is_ground_content = false,
				groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
				sounds = xcompat.sounds.node_sound_wood_defaults(),
			})
		end

		local moretrees_leaves_inventory_image = nil
		local moretrees_new_leaves_waving = nil

		if moretrees.plantlike_leaves then
			moretrees_leaves_inventory_image = minetest.inventorycube("moretrees_"..treename.."_leaves.png")
		else
			moretrees_new_leaves_waving = 1
		end

		minetest.register_node("moretrees:"..treename.."_leaves", {
			description = moretrees.treedesc[treename].leaves,
			drawtype = moretrees_new_leaves_drawtype,
			waving = moretrees_new_leaves_waving,
			visual_scale = moretrees_plantlike_leaves_visual_scale,
			tiles = { "moretrees_"..treename.."_leaves.png" },
			inventory_image = moretrees_leaves_inventory_image,
			paramtype = "light",
			is_ground_content = false,
			groups = {snappy = 3, flammable = 2, leaves = 1, moretrees_leaves = 1, leafdecay = 1},
			sounds = xcompat.sounds.node_sound_leaves_defaults(),

			drop = {
				max_items = 1,
				items = {
					{items = {"moretrees:"..treename.."_sapling"}, rarity = droprarity },
					{items = {"moretrees:"..treename.."_leaves"} }
				}
			},
		})

		if minetest.get_modpath("moreblocks") then

			stairsplus:register_all(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{
					groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2, not_in_creative_inventory=1 },
					tiles =	{
						"moretrees_"..treename.."_trunk_top.png",
						"moretrees_"..treename.."_trunk_top.png",
						"moretrees_"..treename.."_trunk.png"
					},
					description = moretrees.treedesc[treename].trunk,
					drop = treename.."_trunk",
				}
			)

			if moretrees.enable_planks then
				stairsplus:register_all(
					"moretrees",
					treename.."_planks",
					"moretrees:"..treename.."_planks",
					{
						groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_in_creative_inventory=1 },
						tiles = { "moretrees_"..treename.."_wood.png" },
						description = moretrees.treedesc[treename].planks,
						drop = treename.."_planks",
					}
				)
			end
		elseif minetest.get_modpath("stairs") then
			stairs.register_stair_and_slab(
				"moretrees_"..treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				moretrees.treedesc[treename].trunk_stair,
				moretrees.treedesc[treename].trunk_slab,
				xcompat.sounds.node_sound_wood_defaults()
			)

			if moretrees.enable_planks then
				stairs.register_stair_and_slab(
					"moretrees_"..treename.."_planks",
					"moretrees:"..treename.."_planks",
					{ snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
					{ "moretrees_"..treename.."_wood.png" },
					moretrees.treedesc[treename].planks_stair,
					moretrees.treedesc[treename].planks_slab,
					xcompat.sounds.node_sound_wood_defaults()
				)
			end

		end

		if minetest.get_modpath("default") and moretrees.enable_planks then
			local planks_name = "moretrees:" .. treename .. "_planks"
			local planks_tile = "moretrees_" .. treename .. "_wood.png"
			default.register_fence("moretrees:" .. treename .. "_fence", {
				description = moretrees.treedesc[treename].fence,
				texture = planks_tile,
				inventory_image = "default_fence_overlay.png^" .. planks_tile ..
										"^default_fence_overlay.png^[makealpha:255,126,126",
				wield_image = "default_fence_overlay.png^" .. planks_tile ..
										"^default_fence_overlay.png^[makealpha:255,126,126",
				material = planks_name,
				groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
				sounds = xcompat.sounds.node_sound_wood_defaults()
			})
			default.register_fence_rail("moretrees:" .. treename .. "_fence_rail", {
				description = moretrees.treedesc[treename].fence_rail,
				texture = planks_tile,
				inventory_image = "default_fence_rail_overlay.png^" .. planks_tile ..
										"^default_fence_rail_overlay.png^[makealpha:255,126,126",
				wield_image = "default_fence_rail_overlay.png^" .. planks_tile ..
										"^default_fence_rail_overlay.png^[makealpha:255,126,126",
				material = planks_name,
				groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
				sounds = xcompat.sounds.node_sound_wood_defaults()
			})
			if minetest.global_exists("doors") then
				doors.register_fencegate("moretrees:" .. treename .. "_gate", {
					description = moretrees.treedesc[treename].fence_gate,
					texture = planks_tile,
					material = planks_name,
					groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
				})
			end
		end
	end

	-- the default game provides jungle tree and pine saplings.
	if treename~="jungletree" and treename ~= "pine" then
		local regular_groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,sapling=1}
		if minetest.settings:get_bool("creative_mode", false) then
			regular_groups["not_in_creative_inventory"]=1
		end

		minetest.register_node("moretrees:"..treename.."_sapling", {
			description = moretrees.treedesc[treename].sapling,
			drawtype = "plantlike",
			tiles = {split_tn[2] and split_tn[2]=="small" and "moretrees_" .. treename .. "_sapling.png" or saptex},
			inventory_image = split_tn[2] and split_tn[2]=="small" and "moretrees_" .. treename .. "_sapling.png" or saptex,
			paramtype = "light",
			paramtype2 = "waving",
			walkable = false,
			is_ground_content = true,
			selection_box = {
				type = "fixed",
				fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
			},
			groups = regular_groups,
			sounds = xcompat.sounds.node_sound_default(),
			on_place = function(itemstack, placer, pointed_thing)
				itemstack = xcompat.functions.sapling_on_place(itemstack, placer, pointed_thing,
					"moretrees:" ..treename.. "_sapling",
					-- minp, maxp to be checked, relative to sapling pos
					-- minp_relative.y = 1 because sapling pos has been checked
					{x = -3, y = 1, z = -3},
					{x = 3, y = 6, z = 3},
					-- maximum interval of interior volume check
					4)

				return itemstack
			end,
			on_construct = function(pos)
				minetest.get_node_timer(pos):start(300)
			end,
			on_timer = function(pos, elapsed)
				if moretrees.can_grow(pos, treename) then
					--moretrees["grow_" .. treename](pos)
					minetest.set_node(pos, {name="air"})
					if type(moretrees["spawn_" .. treename .. "_object"])=="string" then
						local split = moretrees["spawn_" .. treename .. "_object"]:split(".")
						moretrees[split[2]](pos)
					else
						minetest.spawn_tree(pos, moretrees["spawn_" .. treename .. "_object"])
					end
				else
					minetest.get_node_timer(pos):start(300)
				end
			end,
		})
	end

	local ongen_groups = {
		snappy = 2,
		dig_immediate = 3,
		flammable = 2,
		attached_node = 1,
		sapling = 1,
		moretrees_ongen = 1,
		not_in_creative_inventory = 1
	}
	if minetest.settings:get_bool("creative_mode", false) then
		ongen_groups["not_in_creative_inventory"]=nil
	end
	minetest.register_node("moretrees:"..treename.."_sapling_ongen", {
		description = S("@1 (fast growth)", moretrees.treedesc[treename].sapling),
		drawtype = "plantlike",
		tiles = {split_tn[2] and split_tn[2]=="small" and "moretrees_" .. treename .. "_sapling.png" or saptex,},
		inventory_image = split_tn[2] and split_tn[2]=="small" and "moretrees_" .. treename .. "_sapling.png" or saptex,
		paramtype = "light",
		paramtype2 = "waving",
		walkable = false,
		is_ground_content = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
		},
		groups = ongen_groups,
		sounds = xcompat.sounds.node_sound_default(),
		drop = "moretrees:"..treename.."_sapling",
		on_place = function(itemstack, placer, pointed_thing)
			itemstack = xcompat.functions.sapling_on_place(itemstack, placer, pointed_thing,
				"moretrees:" ..treename.. "_sapling_ongen",
				-- minp, maxp to be checked, relative to sapling pos
				-- minp_relative.y = 1 because sapling pos has been checked
				{x = -3, y = 1, z = -3},
				{x = 3, y = 6, z = 3},
				-- maximum interval of interior volume check
				4)

			return itemstack
		end,
		on_construct = function(pos)
			minetest.get_node_timer(pos):start(2)
		end,
		on_timer = function(pos, elapsed)
			if moretrees.can_grow(pos, treename) then
				--moretrees["grow_" .. treename](pos)
				minetest.set_node(pos, {name="air"})
				if type(moretrees["spawn_" .. treename .. "_object"])=="string" then
					local split = moretrees["spawn_" .. treename .. "_object"]:split(".")
					moretrees[split[2]](pos)
				else
					minetest.spawn_tree(pos, moretrees["spawn_" .. treename .. "_object"])
				end
			else
				minetest.get_node_timer(pos):start(300)
			end
		end,
	})

	local fruitname = nil
	if fruit then
		fruitname = "moretrees:"..fruit
		minetest.register_node(fruitname, {
			description = fruitdesc,
			drawtype = "plantlike",
			tiles = { "moretrees_"..fruit..".png" },
			inventory_image = "moretrees_"..fruit..".png^[transformR180",
			wield_image = "moretrees_"..fruit..".png^[transformR180",
			visual_scale = vscale,
			paramtype = "light",
			sunlight_propagates = true,
			is_ground_content = false,
			walkable = false,
			selection_box = {
				type = "fixed",
					fixed = selbox
				},
			groups = {fleshy=3,dig_immediate=3,flammable=2, attached_node=1, leafdecay = 1, leafdecay_drop = 1},
			sounds = xcompat.sounds.node_sound_default(),
			after_place_node = function(pos, placer)
				if placer:is_player() then
					minetest.set_node(pos, {name = "moretrees:"..fruit, param2 = 1})
				end
			end
		})
	end

	if treename ~= "jungletree"
		and treename ~= "poplar_small"
		and treename ~= "pine"
		and minetest.get_modpath("default") then
			default.register_leafdecay({
				trunks = { "moretrees:"..treename.."_trunk" },
				leaves = { "moretrees:"..treename.."_leaves", fruitname },
				radius = decay,
			})
	end

	minetest.register_abm({
		nodenames = { "moretrees:"..treename.."_trunk_sideways" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
				local nfdir = dirs2[fdir+1]
			minetest.add_node(pos, {name = "moretrees:"..treename.."_trunk", param2 = nfdir})
		end,
	})

	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_trunk")

	if moretrees.spawn_saplings then
			table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling")
			table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling_ongen")
	end
end

-- poplar saplings leaves
local poplar_leaves_drop = minetest.registered_nodes["moretrees:poplar_leaves"].drop
minetest.override_item("moretrees:poplar_leaves", {
	drop = {
		max_items = poplar_leaves_drop.max_items,
		items = {
			{items = {"moretrees:poplar_sapling"}, rarity = 1.33 * poplar_leaves_drop.items[1].rarity },
			{items = {"moretrees:poplar_small_sapling"}, rarity = 1.33 * poplar_leaves_drop.items[1].rarity },
			{items = {"moretrees:poplar_leaves"} }
		}
	}
})

-- Extra nodes for jungle trees:

local jungleleaves = {"yellow","red"}
local jungleleavesnames = {S("Yellow"), S("Red")}
for color = 1, #jungleleaves do
	local leave_name = "moretrees:jungletree_leaves_"..jungleleaves[color]

	local moretrees_leaves_inventory_image = nil

	if moretrees.plantlike_leaves then
		moretrees_leaves_inventory_image = minetest.inventorycube("moretrees_jungletree_leaves_"..jungleleaves[color]..".png")
	else
		moretrees_new_leaves_waving = 1
	end

	minetest.register_node(leave_name, {
		description = S("Jungle Tree Leaves (@1)", jungleleavesnames[color]),
		drawtype = moretrees_new_leaves_drawtype,
		waving = moretrees_new_leaves_waving,
		visual_scale = moretrees_plantlike_leaves_visual_scale,
		tiles = {"moretrees_jungletree_leaves_"..jungleleaves[color]..".png"},
		inventory_image = moretrees_leaves_inventory_image,
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy = 3, flammable = 2, leaves = 1, moretrees_leaves = 1, leafdecay = 3 },
		drop = minetest.get_modpath("default") and {
			max_items = 1,
			items = {
				{items = {"default:junglesapling"}, rarity = 100 },
				{items = {"moretrees:jungletree_leaves_"..jungleleaves[color]} }
			}
		} or nil,
		sounds = xcompat.sounds.node_sound_leaves_defaults(),
	})
end

-- To get Moretrees to generate its own jungle trees among the default mapgen
-- we need our own copy of that node, which moretrees will match against.

if minetest.get_modpath("default") then
	local jungle_tree = table.copy(minetest.registered_nodes["default:jungletree"])
	jungle_tree.drop = "default:jungletree"
	minetest.register_node("moretrees:jungletree_trunk", jungle_tree)

	default.register_leafdecay({
		trunks = { "default:jungletree", "moretrees:jungletree_trunk" },
		leaves = { xcompat.materials.jungle_leaves, "moretrees:jungletree_leaves_yellow", "moretrees:jungletree_leaves_red" },
		radius = moretrees.leafdecay_radius,
	})
end

-- Extra needles for firs

local moretrees_leaves_inventory_image = nil

if moretrees.plantlike_leaves then
	moretrees_leaves_inventory_image = minetest.inventorycube("moretrees_fir_leaves_bright.png")
end

minetest.register_node("moretrees:fir_leaves_bright", {
	drawtype = moretrees_new_leaves_drawtype,
	waving = moretrees_new_leaves_waving,
	visual_scale = moretrees_plantlike_leaves_visual_scale,
	description = S("Douglas Fir Leaves (Bright)"),
	tiles = { "moretrees_fir_leaves_bright.png" },
	inventory_image = moretrees_leaves_inventory_image,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, flammable = 2, leaves = 1, moretrees_leaves = 1, leafdecay = 3 },
	drop = {
		max_items = 1,
		items = {
			{items = {'moretrees:fir_sapling'}, rarity = 100 },
			{items = {'moretrees:fir_leaves_bright'} }
		}
	},
	sounds = xcompat.sounds.node_sound_leaves_defaults()
})

if minetest.get_modpath("default") then
	default.register_leafdecay({
		trunks = { "moretrees:fir_trunk" },
		leaves = { "moretrees:fir_leaves", "moretrees:fir_leaves_bright" },
		radius = moretrees.leafdecay_radius,
	})
end


if minetest.get_modpath("default") and moretrees.enable_redefine_apple then
	local appledef = table.copy(minetest.registered_nodes["default:apple"])
	appledef.groups.attached_node = 1
	minetest.register_node(":default:apple", appledef)
end

table.insert(moretrees.avoidnodes, "default:jungletree")
table.insert(moretrees.avoidnodes, "default:pine_tree")
table.insert(moretrees.avoidnodes, "default:acacia_tree")
table.insert(moretrees.avoidnodes, "moretrees:fir_trunk")
table.insert(moretrees.avoidnodes, "default:tree")

if moretrees.spawn_saplings then
	table.insert(moretrees.avoidnodes, "snow:sapling_pine")
	table.insert(moretrees.avoidnodes, "default:junglesapling")
	table.insert(moretrees.avoidnodes, "default:pine_sapling")
end

-- "empty" (tapped) rubber tree nodes

minetest.register_node("moretrees:rubber_tree_trunk_empty", {
	description = S("Rubber Tree Trunk (Empty)"),
	tiles = {
		"moretrees_rubber_tree_trunk_top.png",
		"moretrees_rubber_tree_trunk_top.png",
		"moretrees_rubber_tree_trunk_empty.png"
	},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = xcompat.sounds.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

minetest.register_abm({
	nodenames = { "moretrees:rubber_tree_trunk_empty_sideways" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2 or 0
			local nfdir = dirs2[fdir+1]
		minetest.add_node(pos, {name = "moretrees:rubber_tree_trunk_empty", param2 = nfdir})
	end,
})

-- For compatibility with old nodes, recently-changed nodes, and default nodes

minetest.register_alias("technic:rubber_tree_full",				"moretrees:rubber_tree_trunk")
minetest.register_alias("farming_plus:rubber_tree_full",		"moretrees:rubber_tree_trunk")
minetest.register_alias("farming:rubber_tree_full",				"moretrees:rubber_tree_trunk")

minetest.register_alias("technic:rubber_leaves",				"moretrees:rubber_tree_leaves")
minetest.register_alias("farming_plus:rubber_leaves",			"moretrees:rubber_tree_leaves")
minetest.register_alias("farming:rubber_leaves",				"moretrees:rubber_tree_leaves")

minetest.register_alias("technic:rubber_tree_sapling",			"moretrees:rubber_tree_sapling")
minetest.register_alias("farming_plus:rubber_sapling",			"moretrees:rubber_tree_sapling")
minetest.register_alias("farming:rubber_sapling",				"moretrees:rubber_tree_sapling")

minetest.register_alias("moretrees:conifer_trunk",				"moretrees:fir_trunk")
minetest.register_alias("moretrees:conifer_trunk_sideways",		"moretrees:fir_trunk_sideways")
minetest.register_alias("moretrees:conifer_leaves",				"moretrees:fir_leaves")
minetest.register_alias("moretrees:conifer_leaves_bright",		"moretrees:fir_leaves_bright")
minetest.register_alias("moretrees:conifer_sapling",			"moretrees:fir_sapling")

minetest.register_alias("conifers:trunk",						"moretrees:fir_trunk")
minetest.register_alias("conifers:trunk_reversed",				"moretrees:fir_trunk_sideways")
minetest.register_alias("conifers:leaves",						"moretrees:fir_leaves")
minetest.register_alias("conifers:leaves_special",				"moretrees:fir_leaves_bright")
minetest.register_alias("conifers:sapling",						"moretrees:fir_sapling")

minetest.register_alias("moretrees:jungletree_sapling",			"default:junglesapling")
minetest.register_alias("moretrees:jungletree_trunk_sideways",	"moreblocks:horizontal_jungle_tree")
minetest.register_alias("moretrees:jungletree_planks",			"default:junglewood")
minetest.register_alias("moretrees:jungletree_leaves_green",	xcompat.materials.jungle_leaves)

minetest.register_alias("moretrees:acacia_trunk",				"default:acacia_tree")
minetest.register_alias("moretrees:acacia_planks",				"default:acacia_wood")
minetest.register_alias("moretrees:acacia_sapling",				"default:acacia_sapling")
minetest.register_alias("moretrees:acacia_leaves",				"default:acacia_leaves")

minetest.register_alias("moretrees:pine_trunk",					"moretrees:cedar_trunk")
minetest.register_alias("moretrees:pine_planks",				"moretrees:cedar_planks")
minetest.register_alias("moretrees:pine_sapling",				"moretrees:cedar_sapling")
minetest.register_alias("moretrees:pine_leaves",				"moretrees:cedar_leaves")
minetest.register_alias("moretrees:pine_cone",					"moretrees:cedar_cone")
minetest.register_alias("moretrees:pine_nuts",					"moretrees:cedar_nuts")
minetest.register_alias("moretrees:pine_sapling_ongen",			"moretrees:cedar_sapling_ongen")

minetest.register_alias("moretrees:dates",					"moretrees:dates_f4")
