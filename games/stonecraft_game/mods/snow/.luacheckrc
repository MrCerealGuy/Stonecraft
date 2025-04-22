read_globals = {
	"dump", "vector",
	"table", "math", "PseudoRandom", "VoxelArea",
	"stairs", "stairsplus", "skins", "treecapitator",
	default = {
		fields = {
			player_attached = {
				read_only = false,
				other_fields = true
			}
		},
		other_fields = true
	},
	minetest = {
		fields = {
			registered_nodes = {
				read_only = false,
				other_fields = true
			}
		},
		other_fields = true
	}
}
globals = {"snow"}
-- ignore = {"421", "423"}
