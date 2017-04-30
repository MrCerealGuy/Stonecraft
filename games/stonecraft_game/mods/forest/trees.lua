register_tree("oak", {
	description = "chene",
	sapling = {chance = 1, growing = 6},
	growing = {
		trunk_height = {min = 7, max = 13},
		height_above_trunk = 3,
		percent_size = 70,
		radius = 3,
		corners = 1,
		percent_leaves = 55,
		associated = {
			["flowers:viola"] = 8,
			["flowers:rose"] = 2,
		}
	},
	apportionment = {
		frequency = 15,
		temperature = {min = 8, max = 16},
		density = 15,
		biome = 40,
		tolerance = 20,
	},
})

register_tree("birch", {
	description = "bouleau",
	sapling = {chance = 5, growing = 12},
	growing = {
		trunk_height = {min = 4, max = 6},
		height_above_trunk = 2,
		percent_size = 70,
		radius = 2,
		corners = 2,
		percent_leaves = 65,
	},
	apportionment = {
		frequency = 5,
		temperature = {min = 9, max = 18},
		density = 5,
		biome = 20,
		tolerance = 30,
	},
})

register_tree("willow", {
	description = "saule",
	sapling = {chance = 20, growing = 14},
	growing = {
		trunk_height = {min = 7, max = 10},
		height_above_trunk = 3,
		percent_size = 80,
		radius = 3,
		corners = 1,
		percent_leaves = 55,
	},
	apportionment = {
		frequency = 4,
		temperature = {min = 7, max = 15},
		density = 8,
		biome = 30,
		tolerance = 35,
		water_proximity = 6,
	},
})

register_tree("fir", {
	description = "sapin",
	sapling = {chance = 3.5, growing = 3.2},
	growing = {
		radius = 3,
		method = function(pos, tree)
			fir_growing(pos)
		end,
	},
	apportionment = {
		frequency = 20,
		temperature = {min = 2, max = 10},
		density = 15,
		biome = 70,
		tolerance = 25,
	},
})

register_tree("mirabelle", {
	description = "mirabellier",
	descriptions = {
		fruitleaves = "Feuilles de mirabellier avec mirabelles",
		fruit = "Mirabelle",
	},
	tiles = {
		leaves = "default_leaves.png",
		tree = "default_tree.png",
		tree_top = "default_tree_top.png",
		sapling = "mirabelle_sapling.png",
		fruitleaves = "mirabelle_fruitleaves.png",
		fruit = "mirabelle_fruit.png",
		wood = "default_wood.png",
	},
	sapling = {chance = 7, growing = 15},
	fruits = {chance = 4, max = 20, hearts = 0.5, craft = "dye:yellow", craft_sapling = true},
	growing = {
		trunk_height = {min = 4, max = 5},
		height_above_trunk = 2,
		percent_size = 70,
		radius = 2,
		corners = 2,
		percent_leaves = 72,
	},
	apportionment = {
		frequency = 3,
		temperature = {min = 6, max = 16},
		density = 3,
		biome = 25,
		tolerance = 10,
	},
})

register_tree("cherry", {
	description = "cerisier",
	descriptions = {
		fruitleaves = "Feuilles de cerisier avec cerises",
		fruit = "Cerise",
	},
	tiles = {
		leaves = "default_leaves.png",
		tree = "default_tree.png",
		tree_top = "default_tree_top.png",
		sapling = "cherry_sapling.png",
		fruitleaves = "cherry_fruitleaves.png",
		fruit = "cherry_fruit.png",
		wood = "default_wood.png",
	},
	sapling = {chance = 7, growing = 15},
	fruits = {chance = 4, max = 20, hearts = 0.5, craft = "dye:red", craft_sapling = true},
	growing = {
		trunk_height = {min = 4, max = 5},
		height_above_trunk = 2,
		percent_size = 70,
		radius = 2,
		corners = 2,
		percent_leaves = 72,
	},
	apportionment = {
		frequency = 3,
		temperature = {min = 6, max = 16},
		density = 3,
		biome = 25,
		tolerance = 10,
	},
})

register_tree("plum", {
	description = "prunier",
	descriptions = {
		fruitleaves = "Feuilles de prunier avec prunes",
		fruit = "Prune",
	},
	tiles = {
		leaves = "default_leaves.png",
		tree = "default_tree.png",
		tree_top = "default_tree_top.png",
		sapling = "plum_sapling.png",
		fruitleaves = "plum_fruitleaves.png",
		fruit = "plum_fruit.png",
		wood = "default_wood.png",
	},
	sapling = {chance = 7, growing = 15},
	fruits = {chance = 4, max = 20, hearts = 0.5, craft = "dye:violet", craft_sapling = true},
	growing = {
		trunk_height = {min = 4, max = 5},
		height_above_trunk = 2,
		percent_size = 70,
		radius = 2,
		corners = 2,
		percent_leaves = 72,
	},
	apportionment = {
		frequency = 3,
		temperature = {min = 6, max = 16},
		density = 3,
		biome = 25,
		tolerance = 10,
	},
})

register_tree("apple_tree", {
	description = "pommier",
	descriptions = {
		fruitleaves = "Feuilles de pommier avec pommes",
	},
	register = {fruitleaves = true},
	names = {
		tree = "default:tree",
		leaves = "default:leaves",
		wood = "default:wood",
		sapling = "default:sapling",
		fruitleaves = "forest:apple_fruitleaves",
		fruit = "default:apple",
	},
	tiles = {fruitleaves = "default_leaves.png^default_apple.png"},
	fruits = {chance = 2, max = 12, craft_sapling = true},
	growing = {
		trunk_height = {min = 4, max = 5},
		height_above_trunk = 2,
		percent_size = 70,
		radius = 2,
		corners = 2,
		percent_leaves = 72,
	},
	apportionment = {
		frequency = 3,
		temperature = {min = 4, max = 16},
		density = 4,
		biome = 25,
		tolerance = 10,
	},
})

register_tree("jungle", {
	description = "arbre de jungle",
	register = {},
	names = {
		tree = "default:jungletree",
		leaves = "default:jungleleaves",
		wood = "default:junglewood",
		sapling = "default:junglesapling",
	},
	growing = {
		trunk_height = {min = 8, max = 12},
		height_above_trunk = 3,
		percent_size = 40,
		radius = 3,
		corners = 1,
		percent_leaves = 64,
		base = 60,
		associated = {
			["default:junglegrass"] = 30
		}
	},
	apportionment = {
		frequency = 18,
		temperature = {min = 13, max = 20},
		water_proximity = 16,
		density = 20,
		biome = 75,
		tolerance = 15,
	},
})

register_tree("beech", {
	description = "hetre",
	sapling = {chance = 1.5, growing = 8},
	growing = {
		trunk_height = {min = 6, max = 10},
		height_above_trunk = 3,
		percent_size = 60,
		radius = 3,
		corners = 1,
		percent_leaves = 68,
		associated = {
			["flowers:viola"] = 4,
			["flowers:tulip"] = 3,
			["flowers:rose"] = 1,
		}
	},
	apportionment = {
		frequency = 12,
		temperature = {min = 6, max = 16},
		density = 16,
		biome = 35,
		tolerance = 20,
	},
})

register_tree("ginkgo", {
	description = "ginkgo",
	sapling = {chance = 1.2, growing = 3.5},
	growing = {
		trunk_height = {min = 6, max = 12},
		height_above_trunk = 3,
		percent_size = 72,
		radius = 3,
		corners = 1,
		percent_leaves = 45,
		associated = {
			["flowers:viola"] = 10,
			["flowers:tulip"] = 2,
		}
	},
	apportionment = {
		frequency = 1,
		temperature = {min = 7, max = 13},
		density = 2,
		biome = 60,
		tolerance = 5,
	},
})

register_tree("lavender", {
	description = "lavande",
	descriptions = {
		fruitleaves = "Feuilles de lavande avec fleurs",
		fruit = "Fleurs de lavande",
	},
	sapling = {chance = 10, growing = 14},
	growing = {
		trunk_height = {min = 1, max = 2},
		height_above_trunk = 1,
		percent_size = 180,
		radius = 2,
		corners = 1,
		percent_leaves = 75,
		associated = {
			["flowers:viola"] = 4,
			["flowers:tulip"] = 7,
		}
	},
	fruits = {chance = 6, max = 35, hearts = 0, craft = "dye:violet", craft_sapling = true},
	wood_by_trunk = 1,
	apportionment = {
		frequency = 3,
		temperature = {min = 8, max = 18},
		water_proximity = -30,
		density = 1,
		biome = 80,
		tolerance = 15,
	},
})
