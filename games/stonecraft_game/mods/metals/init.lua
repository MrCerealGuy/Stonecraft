-- Metals mod.
-- Jordan Snelling, jordach@blokkeren.co.cc / jordach.snelling@gmail.com / http://twitter.com/jordansnelling

-- Nodes

minetest.register_node("metals:cross_girders", {
	description = "Girders",
	drawtype = "glasslike",
	tiles ={"metals_girders_a.png"},
	inventory_image = minetest.inventorycube("metals_girders_a.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=1,bendy=2},
})

minetest.register_node("metals:cross_girders_warning", {
	description = "Girders",
	drawtype = "glasslike",
	tiles ={"metals_girders_b.png"},
	inventory_image = minetest.inventorycube("metals_girders_b.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=1,bendy=2},
})

minetest.register_node("metals:warning", {
	description = "Warning Marker",
	tiles ={"metals_warning.png"},
	inventory_image = minetest.inventorycube("metals_warning.png"),
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("metals:pipe_ud", {
	description = "Pipe",
	tiles ={"metals_pipe_ud_join.png", "metals_pipe_ud_join.png", "metals_pipe_ud.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2},
})

minetest.register_node("metals:pipe_lr", {
	description = "Pipe",
	tile_images = { 'metals_pipe_lr.png',
			'metals_pipe_lr.png',
			'metals_pipe_lr.png',
			'metals_pipe_lr.png',
			'metals_pipe_lr_join.png',
			'metals_pipe_lr_join.png', },
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {snappy=1,bendy=2},
})

minetest.register_node("metals:pipe_cover", {
	description = "Pipe Cap",
	drawtype = "nodebox",
	tiles = {"metals_pipe_cover.png"},
	inventory_image = "metals_pipe_cover.png",
	wield_image = "metals_pipe_cover.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
        type = "fixed",
        fixed = {-0.4999, -0.4999, 0.4999, 0.4999, 0.4999, 0.4999},
    },
    node_box = {
        type = "fixed",
        fixed = {-0.4999, -0.4999, 0.4999, 0.4999, 0.4999, 0.4999},
    },
	groups = {snappy=1, bendy=2},
})

minetest.register_node("metals:metal_rails", {
	description = "Metal Railings",
	drawtype = "fencelike",
	tiles ={"metals_fence.png"},
	inventory_image = "metals_fence_icon.png",
	wield_image = "metals_fence_icon.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=1,bendy=2},
})

minetest.register_node("metals:corregated_iron", {
	description = "Corregated Ironr",
	tiles ={"metals_corregated_iron.png"},
	inventory_image = minetest.inventorycube("metals_corregated_iron.png"),
	is_ground_content = true,
	groups = {snappy=1,bendy=2},
})

--Register Special

minetest.register_craftitem("metals:half_ingot", {
	description = "Half Ingot",
	inventory_image = "metals_half_ingot.png",
})

--Crafts

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 5",
	recipe = "metals:cross_girders",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 5",
	recipe = "metals:cross_girders_warning",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 6",
	recipe = "metals:pipe_ud",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 6",
	recipe = "metals:pipe_lr",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 6",
	recipe = "metals:metal_rails",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 5",
	recipe = "metals:pipe_cover",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot 4",
	recipe = "metals:cross_girders",
})

-- Next

minetest.register_craft({
	output = 'metals:cross_girders',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'metals:warning',
	recipe = {
		{'default:wood', 'unifieddyes:yellow', 'unifieddyes:black'},
	}
})

minetest.register_craft({
	output = 'metals:cross_girders_warning',
	recipe = {
		{'metals:cross_girders', 'unifieddyes:yellow', 'unifieddyes:black'},
	}
})

minetest.register_craft({
	output = 'metals:pipe_ud',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'metals:pipe_lr',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', '', ''},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'metals:metal_rails',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'metals:pipe_cover',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_craft({
    type = "shapeless",
        output = 'metals:half_ingot 2',
        recipe = {
                "default:steel_ingot",
        }
})
 
minetest.register_craft({
        type = "shapeless",
	output = 'default:steel_ingot',
        recipe = {
                "metals:half_ingot", "metals:half_ingot",
        }
})

minetest.register_craft({
	output = 'metals:corregated_iron 4',
	recipe = {
		{'metals:half_ingot', 'metals:half_ingot', 'metals:half_ingot'},
		{'metals:half_ingot', 'metals:half_ingot', 'metals:half_ingot'},
		{'metals:half_ingot', 'metals:half_ingot', 'metals:half_ingot'},
	}
})
