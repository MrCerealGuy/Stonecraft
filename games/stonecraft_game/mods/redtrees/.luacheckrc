unused_args = false
allow_defined_top = true
max_line_length = 999

ignore = {
    "can_grow",
    "x",
    "y",
    "z",
}

globals = {
    "minetest"
}

read_globals = {
    string = {fields = {"split", "trim"}},
    table = {fields = {"copy", "getn"}},

    "VoxelArea", "biome_lib",
    "intllib", "default", "doors",

    "stairs", "bonemeal",
}
