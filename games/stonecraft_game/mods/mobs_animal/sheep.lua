
-- translation and localize function

local S = minetest.get_translator("mobs_animal")
local random = math.random

-- should sheep eat grass blocks and mess up the environment?

local eat_gb = minetest.settings:get_bool("mobs_animal.eat_grass_block")
local replace_what = { {"group:grass", "air", -1} }

if eat_gb then
	table.insert(replace_what, {"default:dirt_with_grass", "default:dirt", -2})
end

-- sheep colour table

local all_colours = {
	{"black",      S("Black"),      "#212121b0"}, -- referenced down in mobs:spawn
	{"blue",       S("Blue"),       "#015dbb70"},
	{"brown",      S("Brown"),      "#663300a0"}, -- referenced down in mobs:spawn
	{"cyan",       S("Cyan"),       "#00b4bf70"},
	{"dark_green", S("Dark Green"), "#005b0770"},
	{"dark_grey",  S("Dark Grey"),  "#444444b0"}, -- referenced down in mobs:spawn
	{"green",      S("Green"),      "#61ff0170"},
	{"grey",       S("Grey"),       "#919191b0"}, -- referenced down in mobs:spawn
	{"magenta",    S("Magenta"),    "#ed03ad70"},
	{"orange",     S("Orange"),     "#ff840170"},
	{"pink",       S("Pink"),       "#ff85c470"},
	{"red",        S("Red"),        "#ff0000a0"},
	{"violet",     S("Violet"),     "#5c00c970"},
	{"white",      S("White"),      "#ffffffc0"}, -- referenced down in mobs:spawn
	{"yellow",     S("Yellow"),     "#fff80070"}
}

-- Sheep by PilzAdam/K Pavel, texture converted to minetest by AMMOnym from Summerfield pack

for _, col in ipairs(all_colours) do

	local drops_normal = {
		{name = "mobs:mutton_raw", chance = 1, min = 1, max = 2},
		{name = "wool:" .. col[1], chance = 1, min = 1, max = 1}
	}

	local drops_gotten = {
		{name = "mobs:mutton_raw", chance = 1, min = 1, max = 2}
	}

	local function horn_texture_sel(horns, gotten, colr)

		-- get override colours hex value from table
		if colr then

			for _2, col2 in ipairs(all_colours) do

				if col2[1] == colr then colr = col2[3] ; break end
			end
		end

		local base_text = "mobs_sheep_base.png"
		local wool_shave_text = "mobs_sheep_wool.png"
		local shav_text = "mobs_sheep_shaved.png"
		local horn_text = "mobs_sheep_horns.png"
		local col_override = colr and colr or col[3]
		local col_text = "^[multiply:" .. col_override

		if gotten then
			wool_shave_text = shav_text ; col_text = ""
		end

		-- results in unneccesary brackets for shaved but these are ignored by engine
		local textures = base_text .. "^(" .. wool_shave_text .. col_text .. ")"

		if horns then
			textures = base_text .. "^" .. horn_text .. "^(" .. wool_shave_text
				.. col_text .. ")"
		end

		return textures
	end

	mobs:register_mob("mobs_animal:sheep_" .. col[1], {
		stay_near = {"farming:straw", 10},
		stepheight = 0.6,
		type = "animal",
		passive = true,
		hp_min = 8,
		hp_max = 12,
		armor = 100,
		collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
		visual = "mesh",
		mesh = "mobs_sheep.b3d",
		textures = {
			{"mobs_sheep_base.png^(mobs_sheep_wool.png^[multiply:" .. col[3] .. ")"}
		},
		gotten_texture = {"mobs_sheep_base.png^mobs_sheep_shaved.png"},
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_sheep",
			replace = "default_dig_crumbly"
		},
		walk_velocity = 1,
		run_velocity = 2,
		runaway = true,
		jump = true,
		jump_height = 6,
		pushable = true,
		drops = drops_normal,
		water_damage = 0.01,
		lava_damage = 5,
		light_damage = 0,
		animation = {
			speed_normal = 15, speed_run = 15,
			stand_start = 0, stand_end = 80,
			walk_start = 81, walk_end = 100,
			-- no death animation so we'll re-use 2 standing frames at a speed of 1 fps
			-- and have mob rotate while dying.
			die_start = 1, die_end = 2, die_speed = 1,
			die_loop = false, die_rotate = true
		},
		follow = {
			"farming:wheat", "default:grass_1", "farming:barley",
			"farming:oat", "farming:rye"
		},
		view_range = 8,
		replace_rate = 10,
		replace_what = replace_what,
		fear_height = 3,

		on_replace = function(self, pos, oldnode, newnode)

			self.food = (self.food or 0) + 1

			-- if sheep replaces 8x grass then it regrows wool
			if self.food >= 8 then

				self.food = 0
				self.gotten = false
				self.drops = drops_normal

				local textures = horn_texture_sel(self.attribute_horns, self.gotten)

				self.object:set_properties({textures = {textures}})

				-- base_texture must be kept up to date for static_save so horns persist
				-- visually on server/game restart
				self.base_texture = {textures}
			end
		end,

		on_breed = function(parent1, parent2)

			-- simple truth table P1/P2 horns/no_horns
			local breed_out = {
				["P1_N"] = {["P2_N"] = 5 ,["P2_H"] = 50},
				["P1_H"] = {["P2_N"] = 50,["P2_H"] = 95}
			}

			local p1 = parent1.attribute_horns and "P1_H" or "P1_N"
			local p2 = parent2.attribute_horns and "P2_H" or "P2_N"
			local horn_chance = breed_out[p1][p2]
			local horns = random(100) <= horn_chance
			local pos = parent1.object:get_pos()

			-- can't see an easy way to pass horn attribute into
			-- child entity def, handle all spawning here, unfortunate
			-- code replication from mobs_redo api.lua line 1497+
			-- replace "self" with "parent1" and few other minor tweaks
			----------------------------------------------------
			pos.y = pos.y + 0.5 -- spawn child a little higher

			local mob = minetest.add_entity(pos, parent1.name)
			local ent2 = mob:get_luaentity()

			-- remove horns from parents' texture string, lambs dont have horns
			local textures = string.gsub(parent1.base_texture[1],
					"%^mobs_sheep_horns.png", "")

			-- using specific child texture (if found)
			if parent1.child_texture then
				textures = parent1.child_texture[1]
			end

			-- and resize to half height
			mob:set_properties({
				textures = {textures},
				visual_size = {
					x = parent1.base_size.x * .5, y = parent1.base_size.y * .5
				},
				collisionbox = {
					parent1.base_colbox[1] * .5, parent1.base_colbox[2] * .5,
					parent1.base_colbox[3] * .5, parent1.base_colbox[4] * .5,
					parent1.base_colbox[5] * .5, parent1.base_colbox[6] * .5
				},
				selectionbox = {
					parent1.base_selbox[1] * .5, parent1.base_selbox[2] * .5,
					parent1.base_selbox[3] * .5, parent1.base_selbox[4] * .5,
					parent1.base_selbox[5] * .5, parent1.base_selbox[6] * .5
				}
			})

			-- tamed and owned by parents' owner
			ent2.child = true
			ent2.tamed = true
			ent2.owner = parent1.owner
			ent2.attribute_horns = horns

			-- stop mobs_redo api from spawning child
			return false
		end,

		-- fix any issue with horns by re-checking
		on_spawn = function(self)

			if self.child then return end -- baby sheep dont have horns

			local textures = horn_texture_sel(self.attribute_horns, self.gotten)

			self.object:set_properties({textures = {textures}})
			self.base_texture = {textures}
		end,

		on_grown = function(self)

			-- add the horns if we have horns when fully grown
			local textures = horn_texture_sel(self.attribute_horns, self.gotten)

			self.object:set_properties({textures = {textures}})
			self.base_texture = {textures}

			local pos = self.object:get_pos()
			local prop = self.object:get_properties()

			pos.y = pos.y + (prop.collisionbox[2] * -1) - 0.4

			self.object:set_pos(pos)

			-- jump slightly when fully grown so as not to fall into ground
			self.object:set_velocity({x = 0, y = 2, z = 0 })
		end,

		on_rightclick = function(self, clicker)

			-- are we feeding?
			if mobs:feed_tame(self, clicker, 8, true, true) then

				if not self.child then

					local textures = horn_texture_sel(self.attribute_horns, self.gotten)

					self.object:set_properties({textures = {textures}})
					self.base_texture = {textures}
				end

				--if fed 7 times then sheep regrows wool
				if self.food and self.food > 6 then

					self.gotten = false
					self.drops = drops_normal

					local textures = horn_texture_sel(self.attribute_horns, self.gotten)

					self.object:set_properties({textures = {textures}})
					self.base_texture = {textures}
				end

				return
			end

			local item = clicker:get_wielded_item()
			local itemname = item:get_name()
			local name = clicker:get_player_name()

			-- are we giving a haircut>
			if itemname == "mobs:shears" then

				if self.gotten ~= false or self.child ~= false
				or name ~= self.owner or not minetest.get_modpath("wool") then
					return
				end

				self.gotten = true -- shaved
				self.drops = drops_gotten
				self.food = 0 -- reset food

				local obj = minetest.add_item(
					self.object:get_pos(),
					ItemStack("wool:" .. col[1] .. " " .. random(3))
				)

				if obj then
					obj:set_velocity({x = random(-1, 1), y = 5, z = random(-1, 1)})
				end

				item:add_wear(650) -- 100 uses

				clicker:set_wielded_item(item)

				local textures = horn_texture_sel(self.attribute_horns, self.gotten)

				self.object:set_properties({textures = {textures}})
				self.base_texture = {textures}

				return
			end

			-- are we coloring?
			if itemname:find("dye:") then

				if self.gotten == false and self.child == false
				and self.tamed == true and name == self.owner then

					local colr = string.split(itemname, ":")[2]

					for _,c in pairs(all_colours) do

						-- only dye if colour option available and sheep not same colour
						if c[1] == colr and self.name ~= "mobs_animal:sheep_" .. colr then

							local pos = self.object:get_pos()

							-- add new coloured sheep
							local mob = minetest.add_entity(pos, "mobs_animal:sheep_" .. colr)
							local ent = mob:get_luaentity()

							if ent then

								local prop = self.object:get_properties()

								-- add old sheep attributes
								ent.attribute_horns = self.attribute_horns
								ent._nametag = prop.nametag
								ent.owner = name
								ent.tamed = true
								ent.protected = self.protected
								ent.fire_damage = self.fire_damage

								-- set sheep texture with colour override since we're
								-- calling function inside different sheep
								local textures = horn_texture_sel(
										self.attribute_horns, false, colr)

								ent.base_texture = {textures}
								ent.object:set_properties({
									textures = {textures}
								})

								-- remove old sheep
								self.object:remove()

								-- take item
								if not mobs.is_creative(clicker:get_player_name()) then
									item:take_item()
									clicker:set_wielded_item(item)
								end

								break
							end
						end
					end
				end

				return
			end

			-- protect mod with mobs:protector item
			if mobs:protect(self, clicker) then return end

			--are we capturing?
			if mobs:capture_mob(self, clicker, 0, 5, 60, false, nil) then return end
		end
	})

	-- spawn egg
	mobs:register_egg("mobs_animal:sheep_"..col[1], S("@1 Sheep", col[2]),
			"wool_" .. col[1] .. ".png^mobs_sheep_inv.png")

	-- compatibility
	mobs:alias_mob("mobs:sheep_" .. col[1], "mobs_animal:sheep_" .. col[1])
end

-- where to spawn

if not mobs.custom_spawn_animal then

	local max_ht = 400
	local spawn_on = {"default:dirt_with_grass", "ethereal:green_dirt"}
	local mod_ethereal = minetest.get_modpath("ethereal")
	local spawn_chance = mod_ethereal and 12000 or 8000

	mobs:spawn({
		name = "mobs_animal:sheep_white",
		nodes = spawn_on,
		neighbors = {"group:grass"},
		min_light = 14,
		interval = 60,
		chance = spawn_chance,
		min_height = 0,
		max_height = max_ht,
		day_toggle = true,
		active_object_count = 3,

		-- custom function to spawn sheep herds around main mob
		on_spawn = function(self, pos)

			local nat_colors = {-- reference for all_colours table
				["white"] = 14,
				["grey"] = 8,
				["dark_grey"] = 6,
				["black"] = 1,
				["brown"] = 3
			}

			local function random_sheep(pos, first)

				local types = "white"
				local color = all_colours[nat_colors["white"]][3]

				-- Random colour selection
				-- black(1/8), brown(1/16), dark_grey(1/32), grey(1/32), 6/8 white
				local ran_col = random(32)

				if ran_col <= 8 then
					if ran_col == 1 then
						types = "dark_grey"
					elseif ran_col == 2 then
						types = "grey"
					elseif ran_col >= 3 and ran_col <= 4 then
						types = "brown"
					else
						types = "black"
					end
				end

				-- 1/4 chance of lamb
				local lamb

				if not first then
					lamb = random(4) == 1
				end

				-- store returned entity data from mobs:add_mob, "nil" indicates the
				-- rules in mobs:add_mob stopped mob from being spawned/created.
				local entity = mobs:add_mob(pos,
						{name = "mobs_animal:sheep_" .. types, child = lamb})

				-- nil check
				if not entity then return end

				if not lamb then
					-- Set horns attribute, lower height will be rarer.
					-- This wont affect mobs spawned by egg those only spawn hornless sheep.
					local horns = random(max_ht) <= pos.y

					if horns then

						local text = "mobs_sheep_base.png^mobs_sheep_horns.png"
						.."^(mobs_sheep_wool.png^[multiply:"
						.. all_colours[nat_colors[types]][3] .. ")"

						entity.object:set_properties({textures = {text}})
						entity.base_texture = {text}
						entity.attribute_horns = horns
					end
				end
			end

			-- First Sheep, Randomize color/horns
			self.object:remove()

			random_sheep(pos, true)

			-- Rest of herd
			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4}, spawn_on)

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						-- Add a sheep or lamb
						random_sheep(pos2, false)
					end
				end
			end
		end
	})
end

-- compatibility with older mobs mod

mobs:alias_mob("mobs:sheep", "mobs_animal:sheep_white")

-- raw mutton

minetest.register_craftitem(":mobs:mutton_raw", {
	description = S("Raw Mutton"),
	inventory_image = "mobs_mutton_raw.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, food_mutton_raw = 1}
})

mobs.add_eatable("mobs:mutton_raw", 2)

-- cooked mutton and recipe

minetest.register_craftitem(":mobs:mutton_cooked", {
	description = S("Cooked Mutton"),
	inventory_image = "mobs_mutton_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_meat = 1, food_mutton = 1}
})

mobs.add_eatable("mobs:mutton_cooked", 6)

minetest.register_craft({
	type = "cooking",
	output = "mobs:mutton_cooked",
	recipe = "mobs:mutton_raw",
	cooktime = 5
})
