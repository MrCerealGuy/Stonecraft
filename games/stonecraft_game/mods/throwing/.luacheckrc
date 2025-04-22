std = "lua51+minetest"
unused_args = false
allow_defined_top = true
max_line_length = 999

stds.minetest = {
	read_globals = {
		"minetest",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		"default",
		table = {
			fields = {
				"copy",
			},
		},
	}
}

read_globals = {
	"toolranks",
	"toolranks_extras",
	"wielded_light",
}
