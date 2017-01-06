function register_tree(specie, def)
	if not def.description then
		def.description = specie
	end
	if not def.descriptions then
		def.descriptions = {}
	end
	if not def.descriptions.tree then
		def.descriptions.tree = def.description.." tree"
	end
	if not def.descriptions.leaves then
		def.descriptions.leaves = def.description.." leaves"
	end
	if not def.descriptions.wood then
		def.descriptions.wood = def.description.." wood"
	end
	if not def.descriptions.sapling then
		def.descriptions.sapling = def.description.." sapling"
	end
	if not def.descriptions.fruitleaves then
		def.descriptions.fruitleaves = def.description.." fruitleaves"
	end
	if not def.descriptions.fruit then
		def.descriptions.fruit = def.description.." fruit"
	end
	if not def.descriptions.stair then
		def.descriptions.stair = def.description.." stair"
	end
	if not def.descriptions.slab then
		def.descriptions.slab = def.description.." slab"
	end
	if not def.apportionment then
		def.apportionment = {}
	end
	if not def.tiles then
		def.tiles = {}
	end
	if not def.tiles.tree then
		def.tiles.tree = specie.."_tree.png"
	end
	if not def.tiles.tree_top then
		def.tiles.tree_top = specie.."_tree_top.png"
	end
	if not def.tiles.leaves then
		def.tiles.leaves = specie.."_leaves.png"
	end
	if not def.tiles.sapling then
		def.tiles.sapling = specie.."_sapling.png"
	end
	if not def.tiles.wood then
		def.tiles.wood = specie.."_wood.png"
	end
	if not def.tiles.fruitleaves then
		def.tiles.fruitleaves = specie.."_fruitleaves.png"
	end
	if not def.tiles.fruit then
		def.tiles.fruit = specie.."_fruit.png"
	end
	if not def.growing.method then
		def.growing.method = tree_growing
	end
	if not def.register then
		def.register = {tree = true, leaves = true, sapling = true, wood = true, stair = true, slab = true, fruitleaves = true, fruit = true, abm = true, craft = true}
	end
	if not def.wood_by_trunk then
		def.wood_by_trunk = 4
	end
	if not def.names then
		def.names = {
			tree = "forest:"..specie.."_tree",
			leaves = "forest:"..specie.."_leaves",
			sapling = "forest:"..specie.."_sapling",
			wood = "forest:"..specie.."_wood",
			fruitleaves = "forest:"..specie.."_fruitleaves",
			fruit = "forest:"..specie.."_fruit",
			stair_slab = specie.."_wood"}
	end
	if def.register.tree then
		minetest.register_node(def.names.tree, {
			description = def.descriptions.tree,
			tiles = {def.tiles.tree_top, def.tiles.tree_top, def.tiles.tree},
			paramtype2 = "facedir",
			is_ground_content = false,
			groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
			sounds = default.node_sound_wood_defaults(),
			on_place = minetest.rotate_node
		})
	end
	
	trees[specie] = def.growing
	trees[specie].nodes = def.names
	apportionment[specie] = def.apportionment
	
	if def.register.leaves then
		minetest.register_node(def.names.leaves, {
			description = def.descriptions.leaves,
			drawtype = "allfaces_optional",
			visual_scale = 1.3,
			tiles = {def.tiles.leaves},
			paramtype = "light",
			waving = 1,
			is_ground_content = false,
			groups = {snappy=3, leafdecay=def.growing.radius + 1, flammable=2, leaves=1},
			drop = {
				max_items = 1,
				items = {
					{
						-- player will get sapling with 1 out of chance_sapling chance
						items = {def.names.sapling},
						rarity = 100 / def.sapling.chance,
					},
					{
						-- player will get leaves only if he get no saplings,
						-- this is because max_items is 1
						items = {def.names.leaves},
					}
				}
			},
			sounds = default.node_sound_leaves_defaults(),
		})
	end
	
	if def.register.sapling then
		minetest.register_node(def.names.sapling, {
			description = def.descriptions.sapling,
			drawtype = "plantlike",
			visual_scale = 1.0,
			tiles = {def.tiles.sapling},
			inventory_image = def.tiles.sapling,
			wield_image = def.tiles.sapling,
			paramtype = "light",
			walkable = false,
			is_ground_content = true,
			selection_box = {
				type = "fixed",
				fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
			},
			groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
			sounds = default.node_sound_leaves_defaults(),
		})
	end
	
	if def.register.abm then
		minetest.register_abm({
			nodenames = {def.names.sapling},
			interval = 60,
			chance = 100 / def.sapling.growing,
			action = function(pos)
				def.growing.method(pos, specie)
			end
		})
	end
	
	if def.register.wood then
		minetest.register_node(def.names.wood, {
			description = def.descriptions.wood,
			tiles = {def.tiles.wood},
			groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
			sounds = default.node_sound_wood_defaults(),
		})
			-- Code from stairs
		if def.register.stair then
			stairs.register_stair(def.names.stair_slab, def.names.wood,
				{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
				{def.tiles.wood},
				def.descriptions.stair,
				default.node_sound_wood_defaults()
			)
		end
		if def.register.slab then
			stairs.register_slab(def.names.stair_slab, def.names.wood,
				{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
				{def.tiles.wood},
				def.descriptions.slab,
				default.node_sound_wood_defaults()
			)
		end
	end
	
	if def.register.craft then
		minetest.register_craft({
			output = def.names.wood..' '..def.wood_by_trunk,
			recipe = {
				{def.names.tree},
			}
		})
	end
	
	if def.fruits then
		if def.register.fruitleaves then
			minetest.register_node(def.names.fruitleaves, {
				description = def.descriptions.fruitleaves,
				drawtype = "allfaces_optional",
				visual_scale = 1.3,
				tiles = {def.tiles.fruitleaves},
				paramtype = "light",
				waving = 1,
				is_ground_content = false,
				groups = {snappy=3, dig_immediate=3, leafdecay=def.growing.radius + 1, flammable=2, leaves=1},
				drop = {items = {{items = {def.names.fruit}}}},
				sounds = default.node_sound_leaves_defaults(),
				after_destruct = function(pos)
					minetest.set_node(pos, {name = def.names.leaves})
				end
			})
		end
		
		if def.register.fruit then
			if def.fruits.hearts > 0 then
				minetest.register_craftitem(def.names.fruit, {
					description = def.descriptions.fruit,
					inventory_image = def.tiles.fruit,
					on_use = minetest.item_eat(def.fruits.hearts * 2),
				})
			else
				minetest.register_craftitem(def.names.fruit, {
					description = def.descriptions.fruit,
					inventory_image = def.tiles.fruit,
				})
			end
		end
		
		minetest.register_abm({
			nodenames = {def.names.leaves},
			interval = 60,
			chance = 100 / def.fruits.chance,
			action = function(pos)
				minetest.set_node(pos, {name = def.names.fruitleaves})
			end
		})
		
		minetest.register_abm({
			nodenames = {def.names.fruitleaves},
			interval = 60,
			chance = (100 * def.fruits.max) / (def.fruits.chance * (100 - def.fruits.max)),
			action = function(pos)
				minetest.set_node(pos, {name = def.names.leaves})
			end
		})
		if def.fruits.craft then
			minetest.register_craft({
				output = def.fruits.craft,
				recipe = {
					{def.names.fruit},
				}
			})
		end
		if def.fruits.craft_sapling then
			minetest.register_craft({
				output = def.names.sapling,
				recipe = {
					{def.names.fruit, def.names.fruit, def.names.fruit},
					{def.names.fruit, def.names.fruit, def.names.fruit},
					{def.names.fruit, def.names.fruit, def.names.fruit},
				}
			})
		end
	end
end
