function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_small_empty = {
	"barn_3d_bottom.png",
}

local textures_small_filled = {
	"barn_3d_small_top.png",
	"barn_3d_bottom.png",
	"barn_3d_bottom.png",
}


local textures_empty = {
	"barn_3d_bottom.png",
	"barn_3d_empty_top.png",
	"barn_3d_empty_side.png",
	"barn_3d_empty_side.png",
	"barn_3d_empty_side.png",
	"barn_3d_empty_side.png",
}

local textures_filled = {
	"barn_3d_filled_top.png",
	"barn_3d_bottom.png",
	"barn_3d_filled_side.png",
	"barn_3d_filled_side.png",
	"barn_3d_filled_side.png",
	"barn_3d_filled_side.png",
}

local box_barn_small_empty = {
	--floor
	{ x(0) , y(-150), z(160), 
			x(160), y(-160), z(0) },
			
	{ x(0) , y(-120),z(160),
			x(160),y(-150),z(150) },
			
	{ x(0) , y(-120),z(10),
			x(160),y(-150),z(0) },
			
	{ x(0) , y(-120),z(160),
			x(10),y(-150),z(0) },
	{ x(150) , y(-120),z(160),
			x(160),y(-150),z(0) }
}

local box_barn_small_filled = {
	--floor
	{ x(0) , y(-150), z(160), 
			x(160), y(-160), z(0) },
			
	{ x(0) , y(-120),z(160),
			x(160),y(-150),z(150) },
			
	{ x(0) , y(-120),z(10),
			x(160),y(-150),z(0) },
			
	{ x(0) , y(-120),z(160),
			x(10),y(-150),z(0) },
			
	{ x(150) , y(-120),z(160),
			x(160),y(-150),z(0) },
			
	{ x(10), y(-125), z(150),
			x(150),y(-150),z(10) }
}


local box_barn_empty = {
	--floor
	{ x(0) , y(-150), z(160), 
			x(160), y(-160), z(0) },
			
			
	--x edge front
	{ x(0) , y(0), z(160),
			x(20), y(-150), z(140) },
			
	{ x(47), y(0), z(160),
			x(66), y(-150), z(140) },
			
	{ x(94), y(0), z(160),
			x(113), y(-150), z(140) },
	
	{ x(140), y(0), z(160),
			x(160), y(-150), z(140) },
	
	--x edge back
	{ x(0), y(0), z(20),
			x(20), y(-150), z(0) },
			
	{ x(47), y(0), z(20),
			x(66), y(-150), z(0) },
			
	{ x(94), y(0), z(20),
			x(113), y(-150), z(0) },
			
	{ x(140), y(0), z(20),
			x(160), y(-150), z(0) },
	
	-- z edge right
	{ x(140), y(0), z(66),
			x(160), y(-160), z(47) },
			
	{ x(140), y(0), z(113),
			x(160), y(-150), z(94) },
			
	-- z edge left
	{ x(0), y(0), z(66),
			x(20), y(-150), z(47) },
			
	{ x(0), y(0), z(113),
			x(20), y(-150), z(94) },
			
	--metal plates
	{ x(10), y(-50), z(150),
	  x(150), y(-70), z(140),},
	{ x(10), y(-130), z(150),
	  x(150), y(-150), z(140)},
	  
	{ x(10), y(-50), z(20),
	  x(150), y(-70), z(10),},
	{ x(10), y(-130), z(20),
	  x(150), y(-150), z(10)},
	  
	{ x(10), y(-50), z(150),
	  x(20), y(-70), z(10),},	  
	{ x(10), y(-130), z(150),
	  x(20), y(-150), z(10),},
	  
	{ x(140), y(-50), z(150),
	  x(150), y(-70), z(10),},	  
	{ x(140), y(-130), z(150),
	  x(150), y(-150), z(10),},
}

local box_barn_filled = {
	--floor
	{ x(0) , y(-150), z(160), 
			x(160), y(-160), z(0) },
			
			
	--x edge front
	{ x(0) , y(0), z(160),
			x(20), y(-150), z(140) },
			
	{ x(47), y(0), z(160),
			x(66), y(-150), z(140) },
			
	{ x(94), y(0), z(160),
			x(113), y(-150), z(140) },
	
	{ x(140), y(0), z(160),
			x(160), y(-150), z(140) },
	
	--x edge back
	{ x(0), y(0), z(20),
			x(20), y(-150), z(0) },
			
	{ x(47), y(0), z(20),
			x(66), y(-150), z(0) },
			
	{ x(94), y(0), z(20),
			x(113), y(-150), z(0) },
			
	{ x(140), y(0), z(20),
			x(160), y(-150), z(0) },
	
	-- z edge right
	{ x(140), y(0), z(66),
			x(160), y(-160), z(47) },
			
	{ x(140), y(0), z(113),
			x(160), y(-150), z(94) },
			
	-- z edge left
	{ x(0), y(0), z(66),
			x(20), y(-150), z(47) },
			
	{ x(0), y(0), z(113),
			x(20), y(-150), z(94) },
			
	--metal plates
	{ x(10), y(-50), z(150),
	  x(150), y(-70), z(140)},
	{ x(10), y(-130), z(150),
	  x(150), y(-150), z(140)},
	  
	{ x(10), y(-50), z(20),
	  x(150), y(-70), z(10)},
	{ x(10), y(-130), z(20),
	  x(150), y(-150), z(10)},
	  
	{ x(10), y(-50), z(150),
	  x(20), y(-70), z(10)},	  
	{ x(10), y(-130), z(150),
	  x(20), y(-150), z(10)},
	  
	{ x(140), y(-50), z(150),
	  x(150), y(-70), z(10)},	  
	{ x(140), y(-130), z(150),
	  x(150), y(-150), z(10)},
	  
	--grass
	{ x(20), y(-30), z(140),
		x(140), y(-130), z(20)}
}

minetest.register_node("barn:box_empty", {
	tiles = textures_empty,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box_barn_empty
		},
		})
		
minetest.register_node("barn:box_filled", {
	tiles = textures_filled,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box_barn_filled
		},
		})
		
		
minetest.register_node("barn:box_small_empty", {
	tiles = textures_small_empty,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box_barn_small_empty
		},
		})
		
minetest.register_node("barn:box_small_filled", {
	tiles = textures_small_filled,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box_barn_small_filled
		},
		})