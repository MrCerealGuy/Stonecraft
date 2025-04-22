unused_args = false

-- Exclude regression tests / unit tests
exclude_files = {
	"**/spec/**",
}

globals = {
    "technic", "technic_cnc", "minetest", "wrench"
}

read_globals = {
	-- Lua
    string = {fields = {"split", "trim"}},
    table = {fields = {"copy", "getn"}},
	
	-- Minetest
    "PseudoRandom", "ItemStack",
	"VoxelArea", "VoxelManip",
	"Settings", "vector",
	
	-- Mods
    "default", "stairsplus",
	"screwdriver", "bucket",
	"digilines", "pipeworks",
	"mesecon", "moretrees",
    "unified_inventory", "protector",
    "unifieddyes", "digiline_remote",
    "monitoring", "drawers", "mg",
	
	-- Only used in technic/machines/MV/lighting.lua (disabled)
	"isprotect", "homedecor_expect_infinite_stacks",
	
	-- TODO: Remove after translation update
	"intllib"
}
