--[[

2017-05-13 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


local all_colours = {
	{"black",      S("Black"),      "#000000b0"},
	{"blue",       S("Blue"),       "#015dbb70"},
	{"brown",      S("Brown"),      "#663300a0"},
	{"cyan",       S("Cyan"),       "#01ffd870"},
	{"dark_green", S("Dark Green"), "#005b0770"},
	{"dark_grey",  S("Dark Grey"),  "#303030b0"},
	{"green",      S("Green"),      "#61ff0170"},
	{"grey",       S("Grey"),       "#5b5b5bb0"},
	{"magenta",    S("Magenta"),    "#ff05bb70"},
	{"orange",     S("Orange"),     "#ff840170"},
	{"pink",       S("Pink"),       "#ff65b570"},
	{"red",        S("Red"),        "#ff0000a0"},
	{"violet",     S("Violet"),     "#2000c970"},
	{"white",      S("White"),      "#abababc0"},
	{"yellow",     S("Yellow"),     "#e3ff0070"},
}

-- Sheep by PilzAdam, texture converted to minetest by AMMOnym from Summerfield pack

for _, col in pairs(all_colours) do

	mobs:register_mob("mobs:sheep_"..col[1], {
		type = "animal",
		passive = true,
		hp_min = 8,
		hp_max = 10,
		armor = 200,
		collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
		visual = "mesh",
		mesh = "mobs_sheep.b3d",
		textures = {
			{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:" .. col[3] .. ")"},
		},
		gotten_texture = {"mobs_sheep_shaved.png"},
		gotten_mesh = "mobs_sheep_shaved.b3d",
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_sheep",
		},
		walk_velocity = 1,
		run_velocity = 2,
		runaway = true,
		jump = true,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			{name = "wool:"..col[1], chance = 1, min = 1, max = 1},
		},
		water_damage = 1,
		lava_damage = 5,
		light_damage = 0,
		animation = {
			speed_normal = 15,
			speed_run = 15,
			stand_start = 0,
			stand_end = 80,
			walk_start = 81,
			walk_end = 100,
		},
		follow = {"farming:wheat", "default:grass_5"},
		view_range = 8,
		replace_rate = 10,
		replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
		replace_with = "air",
		replace_offset = -1,
		fear_height = 3,
		on_rightclick = function(self, clicker)

			local shpcolor = string.split(self.name,"_")[2]

			if shpcolor =="dark" then
				shpcolor = shpcolor.."_"..string.split(self.name,"_")[3]
			end

			--are we feeding?
			if mobs:feed_tame(self, clicker, 8, true, true) then

				--if full grow fuzz
				if self.gotten == false then
					self.object:set_properties({
						textures = {"mobs_sheep_wool.png^[colorize:" .. col[3] .. "^mobs_sheep_base.png"},
						mesh = "mobs_sheep.b3d",
					})
				end

				return
			end

			local item = clicker:get_wielded_item()
			local itemname = item:get_name()

			--are we giving a haircut>
			if itemname == "mobs:shears" then

				if self.gotten == false and self.child == false then

					self.gotten = true -- shaved

					if minetest.get_modpath("wool") then

						local pos = self.object:getpos()
						pos.y = pos.y + 0.5

						local obj = minetest.add_item(pos, ItemStack("wool:"..shpcolor.." "..math.random(1,3)))

						if obj then
							obj:setvelocity({
								x = math.random(-1,1),
								y = 5,
								z = math.random(-1,1)
							})
						end

						item:add_wear(650) -- 100 uses

						clicker:set_wielded_item(item)
					end

					self.object:set_properties({
						textures = {"mobs_sheep_shaved.png"},
						mesh = "mobs_sheep_shaved.b3d",
					})
				end

				return
			end

			local name = clicker:get_player_name()

			--are we coloring?
			if itemname:find("dye:") then

				if self.gotten == false
				and self.child == false
				and self.tamed == true
				and name == self.owner then

					local colr = string.split(itemname,":")[2]

					for _,c in pairs(all_colours) do

						if c[1] == colr then

							local pos = self.object:getpos()

							self.object:remove()

							local mob = minetest.add_entity(pos, "mobs:sheep_"..colr)
							local ent = mob:get_luaentity()

							ent.owner = name
							ent.tamed = true

							-- take item
							if not minetest.setting_getbool("creative_mode") then
								item:take_item()
								clicker:set_wielded_item(item)
							end

							break
						end
					end
				end

				return
			end

			--are we capturing?
			mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
		end
	})

	mobs:register_egg("mobs:sheep_"..col[1], col[2] .. " " .. S("Sheep"), "wool_"..col[1]..".png", 1)

end

mobs:register_spawn("mobs:sheep_white",
	{"default:dirt_with_grass", "ethereal:green_dirt"}, 20, 10, 15000, 1, 31000, true)

-- compatibility (item and entity)
minetest.register_alias("mobs:sheep", "mobs:sheep_white")

-- replace old sheep entity with new white sheep
minetest.register_entity("mobs:sheep", {

	on_activate = function(self, staticdata, dtime_s)

		self.object:remove()

		minetest.add_entity(self.object:getpos(), "mobs:sheep_white")
	end
})
