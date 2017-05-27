--[[

2017-05-27 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--[[
minetest.register_craft({
	output = 'teleporter:teleporter_pad',
	recipe = {
                {'moreores:copper_ingot', 'default:glass', 'moreores:copper_ingot'},
                {'moreores:copper_ingot', 'moreores:gold_block', 'moreores:copper_ingot'},
                {'moreores:copper_ingot', 'mesecons_powerplant:power_plant', 'moreores:copper_ingot'},
        }
})
]]

minetest.register_craft({
	output = 'teleporter:teleporter',
	recipe = {
		{'default:copper_ingot', 'default:glass', 'default:copper_ingot'},
		{'default:steel_ingot', 'default:mese', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:gold_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'teleporter:receiver',
	recipe = {
		{'', '', ''},
		{'default:copper_ingot', 'default:steel_ingot', 'default:copper_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

--TELEPORTER

minetest.register_node("teleporter:teleporter", {
	description = S("Teleporter Pad"),
	tiles = {
		"teleporter.png",
		"default_stone.png"

	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = teleporter.groups,
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.4375, -0.5, 0.5,	-0.5, 0.5 },
		},
	},
	sounds = default.node_sound_stone_defaults(),

	on_place = teleporter.placed,

    on_receive_fields = teleporter.received_fields,
	
	can_dig = teleporter.can_access
})

minetest.register_node("teleporter:teleporter_active", {
	description = S("Teleporter Pad (cheater!)"),
	tiles = {
		"teleporter_active.png",
		"default_stone.png"

	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = teleporter.active_light,
	groups = teleporter.groups2,
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.4375, -0.5, 0.5,	-0.5, 0.5 },
		},
	},
	drop = "teleporter:teleporter",
	sounds = default.node_sound_stone_defaults(),



    on_receive_fields = teleporter.received_fields,
	
	can_dig = teleporter.can_access
})

--RECEIVER

minetest.register_node("teleporter:receiver", {
	description = S("Receiver Pad"),
	tiles = {
		"teleporter_receiver.png",
		"default_stone.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = teleporter.groups,
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.4375, -0.5, 0.5, -0.5, 0.5 },
		},
	},
	sounds = default.node_sound_stone_defaults(),
	on_place = teleporter.receiver_placed, --minetest.rotate_node, --used to rotate the node does not work correctly!
	--after_place_node = , --used to set metadata
	on_receive_fields = teleporter.receiver_receive_fields,
	can_dig =  teleporter.can_access,
	on_destruct = teleporter.receiver_removed,
})

minetest.register_node("teleporter:receiver_active", {
	description = S("Receiver Pad (cheater!)"),
	tiles = {
		"teleporter_receiver_active.png",
		"default_stone.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = teleporter.active_light,
	groups = teleporter.groups2,
	drop = "teleporter:receiver",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.4375, -0.5, 0.5, -0.5, 0.5 },
		},
	},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = teleporter.receiver_placed,
	on_receive_fields = teleporter.receiver_receive_fields,
	can_dig =  teleporter.can_access,
	on_destruct = teleporter.receiver_removed,
})
