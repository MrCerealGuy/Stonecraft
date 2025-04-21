unused_args = false
allow_defined_top = true

exclude_files = {".luacheckrc"}


globals = {
	"minetest",
	"vector",
	"VoxelManip",
	"VoxelArea",
	"PseudoRandom",
	"ItemStack",
	"default",
	"dump",
	"moretrees",
	"ethereal",
}

read_globals = {
	string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

	"stairsplus",
	"stairs",
	"doors",
	"xcompat",
}
