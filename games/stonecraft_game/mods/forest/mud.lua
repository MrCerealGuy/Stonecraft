minetest.register_node("forest:mud_flowing", {
	description = "Mud flowing",
	inventory_image = minetest.inventorycube("mud.png"),
	drawtype = "flowingliquid",
	tiles = {"mud.png"},
	special_tiles = {
		{
			image="mud_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4}
		},
		{
			image="mud_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4}
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "forest:mud_flowing",
	liquid_alternative_source = "forest:mud_source",
	liquid_viscosity = 6,
	freezemelt = "default:snow",
	post_effect_color = {a=224, r=112, g=64, b=32},
	groups = {liquid=3, puts_out_fire=1, not_in_creative_inventory=1, freezes=1, melt_around=1, water=1},
})

minetest.register_node("forest:mud_source", {
	description = "Mud source",
	inventory_image = minetest.inventorycube("mud.png"),
	drawtype = "liquid",
	tiles = {
		{name="mud_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=9}}
	},
	special_tiles = {
		{
			name="mud_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=9},
			backface_culling = false,
		}
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "forest:mud_flowing",
	liquid_alternative_source = "forest:mud_source",
	liquid_viscosity = 6,
	freezemelt = "default:ice",
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {liquid=3, puts_out_fire=1, freezes=1, water=1},
})

minetest.register_node("forest:mud_ice", {
	description = "Mud ice",
	drawtype = "glasslike",
	tiles = {"mud.png^new_ice.png"},
	is_ground_content = true,
	paramtype = "light",
	freezemelt = "default:mud_source",
	groups = {cracky=3, melts=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "forest:bucket_mud",
	recipe = {"bucket:bucket_water", "default:dirt"},
})

bucket.register_liquid(
	"forest:mud_source",
	"forest:mud_flowing",
	"forest:bucket_mud",
	"bucket_mud.png",
	"Mud bucket"
)
