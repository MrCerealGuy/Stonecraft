
-- language support
local S = ethereal.intllib

-- stair mods active
local stairs_redo = stairs and stairs.mod and stairs.mod == "redo"
local stairs_plus = minetest.global_exists("stairsplus")

-- stair selection function
local do_stair = function(description, name, node, groups, texture, sound)

	if stairs_redo then

		stairs.register_all(name, node,	groups, texture, S(description), sound)

	elseif stairs_plus then

		stairsplus:register_all("ethereal", name, node, {
			description = S(description),
			tiles = texture,
			groups = groups,
			sounds = sound,
		})

	else

		stairs.register_stair_and_slab(name, node, groups, texture,
				S(description .. " Stair"), S(description .. " Slab"), sound)
	end
end


-- Register Stairs (stair mod will be auto-selected)

do_stair(
	"Blue Marble",
	"blue_marble",
	"ethereal:blue_marble",
	{cracky = 1},
	{"ethereal_blue_marble.png"},
	default.node_sound_stone_defaults())

do_stair(
	"Blue Marble Tile",
	"blue_marble_tile",
	"ethereal:blue_marble_tile",
	{cracky = 1},
	{"ethereal_blue_marble_tile.png"},
	default.node_sound_stone_defaults())

do_stair(
	"Crystal Block",
	"crystal_block",
	"ethereal:crystal_block",
	{cracky = 1, level = 2, puts_out_fire = 1, cools_lava = 1},
	{"crystal_block.png"},
	default.node_sound_glass_defaults())

do_stair(
	"Ice Brick",
	"icebrick",
	"ethereal:icebrick",
	{cracky = 3, puts_out_fire = 1, cools_lava = 1},
	{"brick_ice.png"},
	default.node_sound_glass_defaults())

do_stair(
	"Snow Brick",
	"snowbrick",
	"ethereal:snowbrick",
	{crumbly = 3, puts_out_fire = 1, cools_lava = 1},
	{"brick_snow.png"},
	default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.25},
		dug = {name = "default_snow_footstep", gain = 0.75},
	}))

do_stair(
	"Dried Dirt",
	"dry_dirt",
	"ethereal:dry_dirt",
	{crumbly = 3},
	{"ethereal_dry_dirt.png"},
	default.node_sound_dirt_defaults())

do_stair(
	"Mushroom Trunk",
	"mushroom_trunk",
	"ethereal:mushroom_trunk",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	{"mushroom_trunk.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Mushroom Top",
	"mushroom",
	"ethereal:mushroom",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	{"mushroom_block.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Frost Wood",
	"frost_wood",
	"ethereal:frost_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, put_out_fire = 1},
	{"frost_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Healing Wood",
	"yellow_wood",
	"ethereal:yellow_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, put_out_fire = 1},
	{"yellow_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Palm Wood",
	"palm_wood",
	"ethereal:palm_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"moretrees_palm_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Birch Wood",
	"birch_wood",
	"ethereal:birch_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"moretrees_birch_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Banana Wood",
	"banana_wood",
	"ethereal:banana_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"banana_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Willow Wood",
	"willow_wood",
	"ethereal:willow_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"willow_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Redwood",
	"redwood_wood",
	"ethereal:redwood_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"redwood_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Bamboo",
	"bamboo_wood",
	"ethereal:bamboo_block",
	{snappy = 3, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"bamboo_floor.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Sakura Wood",
	"sakura_wood",
	"ethereal:sakura_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"ethereal_sakura_wood.png"},
	default.node_sound_wood_defaults())

do_stair(
	"Olive Wood",
	"olive_wood",
	"ethereal:olive_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"olive_wood.png"},
	default.node_sound_wood_defaults())
