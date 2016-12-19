
-- water and lava...
local mc_add_liquid = function( name, static_image, animated_image_flowing, animated_image_source, light )

   minetest.register_node( "mccompat:"..name.."_flowing", {
	description = "Flowing "..name,
	drawtype = "flowingliquid",
	tiles = static_image,
	special_tiles = {
		{
			name = animated_image_flowing,
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8, -- 3.3 for lava
			},
		},
		{
			name = animated_image_flowing,
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8, -- 3.3 for lava
			},
		},
	},
	alpha = 160,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "mccompat:"..name.."_flowing",
	liquid_alternative_source = "mccompat:"..name.."_source",
	liquid_viscosity = 1,
	post_effect_color = {a=120, r=30, g=60, b=90},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
	light_source = light, -- for lava
   });


   minetest.register_node( "mccompat:"..name.."_source", {
	description = name.." source",
	inventory_image = minetest.inventorycube( static_image),
	drawtype = "liquid",
	tiles = {
		{
			name = animated_image_source,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0, -- 3.0 for lava
			},
		},
	},
	special_tiles = {
		{
			name = animated_image_source,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0, -- 3.0 for lava
			},
			backface_culling = false,
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "mccompat:"..name.."_flowing",
	liquid_alternative_source = "mccompat:"..name.."_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a=120, r=30, g=76, b=90},
	groups = {water=3, liquid=3, puts_out_fire=1},
	light_source = light, -- for lava
   });
end

-- actually add water and lava
mc_add_liquid( "water", "default_water.png", "water_flow.png", "water_still.png", nil );
mc_add_liquid( "lava",  "default_lava.png",  "lava_flow.png",  "lava_still.png",  14 );
