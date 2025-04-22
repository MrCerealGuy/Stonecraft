
local _ = {name = "air", param1 = 0}
local a = {name = "air", param1 = 255, force_place = true}
local w = {name = "default:river_water_source", param1 = 255, force_place = true}
local C = {name = "default:clay", param1 = 255, force_place = true}
local D = {name = "default:dirt", param1 = 255, force_place = true}
local M = {name = "default:mossycobble", param1 = 127, force_place = true}
local e = {name = "ethereal:bush2", param1 = 127, force_place = true}
local f = {name = "default:fern_1", param1 = 127, force_place = true}
local g = {name = "default:fern_2", param1 = 127, force_place = true}
local h = {name = "default:fern_3", param1 = 127, force_place = true}
local i = {name = "default:grass_4", param1 = 127, force_place = true}


ethereal.pond = {

	size = {x = 12, y = 4, z = 15},

	data = {

	_,_,_,_,_,_,_,_,_,_,_,_,	_,_,_,_,D,D,D,D,_,_,_,_,	_,_,_,_,f,g,i,f,e,_,_,_,
			_,_,_,_,a,a,a,a,_,_,_,_,
	_,_,_,_,_,C,C,_,_,_,_,_,	_,_,D,D,M,w,w,D,M,_,_,_,	_,_,f,g,a,a,a,a,a,a,_,_,
			_,_,a,a,a,a,a,a,a,_,_,_,
	_,_,_,C,C,C,C,C,_,_,_,_,	_,M,D,w,w,w,w,w,D,D,_,_,	_,_,f,a,a,a,a,a,g,i,_,_,
			_,a,a,a,a,a,a,a,a,a,_,_,
	_,_,_,C,C,C,C,C,C,C,_,_,	_,D,D,w,w,w,w,w,w,w,M,_,	e,i,a,a,a,a,a,a,a,a,_,_,
			a,a,a,a,a,a,a,a,a,a,a,_,
	_,_,_,C,C,C,C,C,C,C,_,_,	M,D,M,w,w,w,w,w,w,w,D,_,	_,f,a,a,a,a,a,a,a,a,g,_,
			a,a,a,a,a,a,a,a,a,a,a,_,
	_,_,C,C,C,C,C,C,C,C,_,_,	D,D,w,w,w,w,w,w,w,w,D,D,	e,i,a,a,a,a,a,a,a,a,h,i,
			a,a,a,a,a,a,a,a,a,a,a,a,
	_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	h,a,a,a,a,a,a,a,a,a,a,f,
			a,a,a,a,a,a,a,a,a,a,a,a,
	_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,M,	g,a,a,a,a,a,a,a,a,a,a,_,
			a,a,a,a,a,a,a,a,a,a,a,a,
	_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	f,a,a,a,a,a,a,a,a,a,a,i,
			a,a,a,a,a,a,a,a,a,a,a,a,
	_,_,C,C,C,C,C,C,C,C,_,_,	_,D,w,w,w,w,w,w,w,w,D,M,	i,f,a,a,a,a,a,a,a,a,g,_,
			a,a,a,a,a,a,a,a,a,a,a,a,
	_,_,C,C,C,C,C,C,C,C,_,_,	_,D,w,w,w,w,w,w,w,w,D,_,	_,i,a,a,a,a,a,a,a,a,a,_,
			_,a,a,a,a,a,a,a,a,a,a,_,
	_,_,C,C,C,C,C,C,C,_,_,_,	D,D,w,w,w,w,w,w,w,D,D,_,	g,h,a,a,a,a,a,a,a,a,f,i,
			a,a,a,a,a,a,a,a,a,a,a,_,
	_,_,C,C,C,C,C,C,_,_,_,_,	D,D,w,w,w,w,w,w,D,D,_,_,	_,e,g,a,a,a,a,a,a,g,e,_,
			a,a,a,a,a,a,a,a,a,a,_,_,
	_,_,_,C,C,C,C,_,_,_,_,_,	_,M,D,w,w,w,w,D,M,_,_,_,	_,_,i,a,a,a,a,a,a,a,_,_,
			_,a,a,a,a,a,a,a,a,_,_,_,
	_,_,_,_,_,_,_,_,_,_,_,_,	_,_,D,D,D,D,D,D,D,_,_,_,	_,_,e,f,i,g,g,i,h,_,_,_,
			_,_,a,a,a,a,a,a,a,_,_,_,

	}
}

minetest.register_node("ethereal:pond", {
	paramtype = "light",
	sunlight_propagetes = true,
	walkable = false, pointable = false, diggable = false, floodable = false,
	drawtype = "airlike",
	drops = "",
	groups = {not_in_creative_inventory = 1},
	on_blast = function() end,
})

local math_random = math.random
local replace_with = {
	"air", "air", "air", "air", "default:dry_grass_2", "default:dry_shrub",
	"default:grass_2", "default:fern_1", "air", "air", "default:dry_shrub"}

minetest.register_abm({
	label = "Ethereal pond",
	nodenames = {"ethereal:pond"},
	interval = 5,
	chance = 1,
	action = function(pos, node)

		minetest.swap_node(pos, {name = replace_with[math_random(#replace_with)]})

		local radius = 7

		pos.y = pos.y - 1

		local num = #minetest.find_nodes_in_area(
				{x = pos.x - radius, y = pos.y, z = pos.z - radius},
				{x = pos.x + radius, y = pos.y, z = pos.z + radius}, "group:bakedclay")

		if num > 200 then

			pos.y = pos.y - 1

			minetest.place_schematic(pos, ethereal.pond, "random", nil, false,
					"place_center_x, place_center_z")
		end
	end
})
