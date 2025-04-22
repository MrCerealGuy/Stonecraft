
local S = minetest.get_translator("farming")
local a = farming.recipe_items

-- Flour

minetest.register_craftitem("farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1}
})

-- Garlic bulb

minetest.register_craftitem("farming:garlic", {
	description = S("Garlic"),
	inventory_image = "crops_garlic.png",
	on_use = minetest.item_eat(1),
	groups = {food_garlic = 1, compostability = 55}
})

farming.add_eatable("farming:garlic", 1)

-- Garlic braid

minetest.register_node("farming:garlic_braid", {
	description = S("Garlic Braid"),
	inventory_image = "crops_garlic_braid.png",
	wield_image = "crops_garlic_braid.png",
	drawtype = "nodebox",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"crops_garlic_braid_top.png",
		"crops_garlic_braid.png",
		"crops_garlic_braid_side.png^[transformFx",
		"crops_garlic_braid_side.png",
		"crops_garlic_braid.png",
		"crops_garlic_braid.png"
	},
	groups = {vessel = 1, dig_immediate = 3, flammable = 3, compostability = 65, handy = 1},
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed", fixed = {{-0.1875, -0.5, 0.5, 0.1875, 0.5, 0.125}}
	}
})

-- Corn on the cob (texture by TenPlus1)

minetest.register_craftitem("farming:corn_cob", {
	description = S("Corn on the Cob"),
	inventory_image = "farming_corn_cob.png",
	groups = {compostability = 65, food_corn_cooked = 1},
	on_use = minetest.item_eat(5)
})

farming.add_eatable("farming:corn_cob", 5)

-- Popcorn

minetest.register_craftitem("farming:popcorn", {
	description = S("Popcorn"),
	inventory_image = "farming_popcorn.png",
	groups = {compostability = 55, food_popcorn = 1},
	on_use = minetest.item_eat(4)
})

farming.add_eatable("farming:popcorn", 4)

-- Cornstarch

minetest.register_craftitem("farming:cornstarch", {
	description = S("Cornstarch"),
	inventory_image = "farming_cornstarch.png",
	groups = {food_cornstarch = 1, food_gelatin = 1, flammable = 2, compostability = 65}
})

-- Cup of coffee

minetest.register_node("farming:coffee_cup", {
	description = S("Cup of Coffee"),
	drawtype = "torchlike",
	tiles = {"farming_coffee_cup.png"},
	inventory_image = "farming_coffee_cup.png",
	wield_image = "farming_coffee_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, drink = 1, handy = 1},
	is_ground_content = false,
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	sounds = farming.node_sound_glass_defaults()
})

farming.add_eatable("farming:coffee_cup", 2)

minetest.register_alias("farming:coffee_cup_hot", "farming:coffee_cup")
minetest.register_alias("farming:drinking_cup", "vessels:drinking_glass")

-- Bar of of dark chocolate (thx to Ice Pandora for her deviantart.com chocolate tutorial)

minetest.register_craftitem("farming:chocolate_dark", {
	description = S("Bar of Dark Chocolate"),
	inventory_image = "farming_chocolate_dark.png",
	on_use = minetest.item_eat(3)
})

farming.add_eatable("farming:chocolate_dark", 3)

-- Chocolate block (not edible)

minetest.register_node("farming:chocolate_block", {
	description = S("Chocolate Block"),
	tiles = {"farming_chocolate_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, oddly_breakable_by_hand = 2, handy = 1},
	sounds = farming.node_sound_stone_defaults()
})

-- Bowl of chili

minetest.register_craftitem("farming:chili_bowl", {
	description = S("Bowl of Chili"),
	inventory_image = "farming_chili_bowl.png",
	on_use = minetest.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:chili_bowl", 8)

-- Chili powder

minetest.register_craftitem("farming:chili_powder", {
	description = S("Chili Powder"),
	on_use = minetest.item_eat(-1),
	inventory_image = "farming_chili_powder.png",
	groups = {compostability = 45}
})

-- Carrot juice

minetest.register_craftitem("farming:carrot_juice", {
	description = S("Carrot Juice"),
	inventory_image = "farming_carrot_juice.png",
	on_use = minetest.item_eat(4, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})

farming.add_eatable("farming:carrot_juice", 4)

-- Blueberry Pie

minetest.register_craftitem("farming:blueberry_pie", {
	description = S("Blueberry Pie"),
	inventory_image = "farming_blueberry_pie.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 75}
})

farming.add_eatable("farming:blueberry_pie", 6)

-- Blueberry muffin (thanks to sosogirl123 @ deviantart.com for muffin image)

minetest.register_craftitem("farming:muffin_blueberry", {
	description = S("Blueberry Muffin"),
	inventory_image = "farming_blueberry_muffin.png",
	on_use = minetest.item_eat(2),
	groups = {compostability = 65}
})

farming.add_eatable("farming:muffin_blueberry", 2)

-- Tomato soup

minetest.register_craftitem("farming:tomato_soup", {
	description = S("Tomato Soup"),
	inventory_image = "farming_tomato_soup.png",
	groups = {compostability = 65, drink = 1},
	on_use = minetest.item_eat(8, "farming:bowl")
})

farming.add_eatable("farming:tomato_soup", 8)

-- sliced bread

minetest.register_craftitem("farming:bread_slice", {
	description = S("Sliced Bread"),
	inventory_image = "farming_bread_slice.png",
	on_use = minetest.item_eat(1),
	groups = {food_bread_slice = 1, compostability = 65}
})

farming.add_eatable("farming:bread_slice", 1)

-- toast

minetest.register_craftitem("farming:toast", {
	description = S("Toast"),
	inventory_image = "farming_toast.png",
	on_use = minetest.item_eat(1),
	groups = {food_toast = 1, compostability = 65}
})

farming.add_eatable("farming:toast", 1)

-- toast sandwich

minetest.register_craftitem("farming:toast_sandwich", {
	description = S("Toast Sandwich"),
	inventory_image = "farming_toast_sandwich.png",
	on_use = minetest.item_eat(4),
	groups = {compostability = 85}
})

farming.add_eatable("farming:toast_sandwich", 4)

-- glass of water

minetest.register_craftitem("farming:glass_water", {
	description = S("Glass of Water"),
	inventory_image = "farming_water_glass.png",
	groups = {food_glass_water = 1, flammable = 3, vessel = 1}
})

-- Sugar cube

minetest.register_node("farming:sugar_cube", {
	description = S("Sugar Cube"),
	tiles = {"farming_sugar_cube.png"},
	groups = {shovely = 1, handy = 1, crumbly = 2},
	is_ground_content = false,
	floodable = true,
	sounds = farming.node_sound_gravel_defaults(),
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- Sugar caramel

minetest.register_craftitem("farming:caramel", {
	description = S("Caramel"),
	inventory_image = "farming_caramel.png",
	groups = {compostability = 40}
})

-- Salt

minetest.register_node("farming:salt", {
	description = S("Salt"),
	inventory_image = "farming_salt.png",
	wield_image = "farming_salt.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_salt.png"},
	groups = {food_salt = 1, vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	-- special function to make salt crystals form inside water
	dropped_step = function(self, pos, dtime)

		self.ctimer = (self.ctimer or 0) + dtime
		if self.ctimer < 15.0 then return end
		self.ctimer = 0

		local needed

		if self.node_inside and self.node_inside.name == a.water_source then
			needed = 8

		elseif self.node_inside and self.node_inside.name == a.river_water_source then
			needed = 9
		end

		if not needed then return end

		local objs = core.get_objects_inside_radius(pos, 0.5)

		if not objs or #objs ~= 1 then return end

		local salt, ent = nil, nil

		for k, obj in pairs(objs) do

			ent = obj:get_luaentity()

			if ent and ent.name == "__builtin:item"
			and ent.itemstring == "farming:salt " .. needed then

				obj:remove()

				core.add_item(pos, "farming:salt_crystal")

				return false -- return with no further action
			end
		end
	end
})

-- Salt Crystal

minetest.register_node("farming:salt_crystal", {
	description = S("Salt crystal"),
	inventory_image = "farming_salt_crystal.png",
	wield_image = "farming_salt_crystal.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	light_source = 1,
	tiles = {"farming_salt_crystal.png"},
	groups = {dig_immediate = 3, attached_node = 1, handy = 1},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- Mayonnaise

minetest.register_node("farming:mayonnaise", {
	description = S("Mayonnaise"),
	drawtype = "plantlike",
	tiles = {"farming_mayo.png"},
	inventory_image = "farming_mayo.png",
	wield_image = "farming_mayo.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(3),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.45, 0.25}
	},
	groups = {
		compostability = 65, food_mayonnaise = 1, vessel = 1, dig_immediate = 3,
		attached_node = 1, handy = 1
	},
	sounds = farming.node_sound_glass_defaults()
})

farming.add_eatable("farming:mayonnaise", 3)

-- Rose Water

minetest.register_node("farming:rose_water", {
	description = S("Rose Water"),
	inventory_image = "farming_rose_water.png",
	wield_image = "farming_rose_water.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_rose_water.png"},
	groups = {
		food_rose_water = 1, vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1
	},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

-- Turkish Delight

minetest.register_craftitem("farming:turkish_delight", {
	description = S("Turkish Delight"),
	inventory_image = "farming_turkish_delight.png",
	groups = {compostability = 85},
	on_use = minetest.item_eat(2)
})

farming.add_eatable("farming:turkish_delight", 2)

-- Garlic Bread

minetest.register_craftitem("farming:garlic_bread", {
	description = S("Garlic Bread"),
	inventory_image = "farming_garlic_bread.png",
	groups = {compostability = 65},
	on_use = minetest.item_eat(2)
})

farming.add_eatable("farming:garlic_bread", 2)

-- Donuts (thanks to Bockwurst for making the donut images)

minetest.register_craftitem("farming:donut", {
	description = S("Donut"),
	inventory_image = "farming_donut.png",
	on_use = minetest.item_eat(4),
	groups = {compostability = 65}
})

farming.add_eatable("farming:donut", 4)

minetest.register_craftitem("farming:donut_chocolate", {
	description = S("Chocolate Donut"),
	inventory_image = "farming_donut_chocolate.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 65}
})

farming.add_eatable("farming:donut_chocolate", 6)

minetest.register_craftitem("farming:donut_apple", {
	description = S("Apple Donut"),
	inventory_image = "farming_donut_apple.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 65}
})

farming.add_eatable("farming:donut_apple", 6)

-- Porridge Oats

minetest.register_craftitem("farming:porridge", {
	description = S("Porridge"),
	inventory_image = "farming_porridge.png",
	on_use = minetest.item_eat(6, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:porridge", 6)

-- Jaffa Cake

minetest.register_craftitem("farming:jaffa_cake", {
	description = S("Jaffa Cake"),
	inventory_image = "farming_jaffa_cake.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 65}
})

farming.add_eatable("farming:jaffa_cake", 6)

-- Apple Pie

minetest.register_craftitem("farming:apple_pie", {
	description = S("Apple Pie"),
	inventory_image = "farming_apple_pie.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 75}
})

farming.add_eatable("farming:apple_pie", 6)

-- Cactus Juice

minetest.register_craftitem("farming:cactus_juice", {
	description = S("Cactus Juice"),
	inventory_image = "farming_cactus_juice.png",
	groups = {vessel = 1, drink = 1, compostability = 55},

	on_use = function(itemstack, user, pointed_thing)

		if user then

			local num = math.random(5) == 1 and -1 or 2

			return minetest.do_item_eat(num, "vessels:drinking_glass",
					itemstack, user, pointed_thing)
		end
	end
})

farming.add_eatable("farming:cactus_juice", 1)

-- Pasta

minetest.register_craftitem("farming:pasta", {
	description = S("Pasta"),
	inventory_image = "farming_pasta.png",
	groups = {compostability = 65, food_pasta = 1}
})

-- Mac & Cheese

minetest.register_craftitem("farming:mac_and_cheese", {
	description = S("Mac & Cheese"),
	inventory_image = "farming_mac_and_cheese.png",
	on_use = minetest.item_eat(6, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:mac_and_cheese", 6)

-- Spaghetti

minetest.register_craftitem("farming:spaghetti", {
	description = S("Spaghetti"),
	inventory_image = "farming_spaghetti.png",
	on_use = minetest.item_eat(8),
	groups = {compostability = 65}
})

farming.add_eatable("farming:spaghetti", 8)

-- Korean Bibimbap

minetest.register_craftitem("farming:bibimbap", {
	description = S("Bibimbap"),
	inventory_image = "farming_bibimbap.png",
	on_use = minetest.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:bibimbap", 8)

-- Burger

minetest.register_craftitem("farming:burger", {
	description = S("Burger"),
	inventory_image = "farming_burger.png",
	on_use = minetest.item_eat(16),
	groups = {compostability = 95}
})

farming.add_eatable("farming:burger", 16)

-- Salad

minetest.register_craftitem("farming:salad", {
	description = S("Salad"),
	inventory_image = "farming_salad.png",
	on_use = minetest.item_eat(8, a.bowl),
	groups = {compostability = 45}
})

farming.add_eatable("farming:salad", 8)

-- Triple Berry Smoothie

minetest.register_craftitem("farming:smoothie_berry", {
	description = S("Triple Berry Smoothie"),
	inventory_image = "farming_berry_smoothie.png",
	on_use = minetest.item_eat(6, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1, compostability = 65}
})

farming.add_eatable("farming:smoothie_berry", 6)

-- Patatas a la importancia

minetest.register_craftitem("farming:spanish_potatoes", {
	description = S("Spanish Potatoes"),
	inventory_image = "farming_spanish_potatoes.png",
	on_use = minetest.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:spanish_potatoes", 8)

-- Potato omelette

minetest.register_craftitem("farming:potato_omelet", {
	description = S("Potato omelette"),
	inventory_image = "farming_potato_omelet.png",
	on_use = minetest.item_eat(6, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:potato_omelet", 6)

-- Paella

minetest.register_craftitem("farming:paella", {
	description = S("Paella"),
	inventory_image = "farming_paella.png",
	on_use = minetest.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

farming.add_eatable("farming:paella", 8)

-- Vanilla Flan

minetest.register_craftitem("farming:flan", {
	description = S("Vanilla Flan"),
	inventory_image = "farming_vanilla_flan.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 65}
})

farming.add_eatable("farming:flan", 6)

-- Vegan Cheese

minetest.register_craftitem("farming:cheese_vegan", {
	description = S("Vegan Cheese"),
	inventory_image = "farming_cheese_vegan.png",
	on_use = minetest.item_eat(2),
	groups = {compostability = 65, food_cheese = 1}
})

farming.add_eatable("farming:cheese_vegan", 2)

-- Vegan Butter

minetest.register_craftitem("farming:butter_vegan", {
	description = S("Vegan Butter"),
	inventory_image = "farming_vegan_butter.png",
	groups = {food_butter = 1}
})

-- Onigiri

minetest.register_craftitem("farming:onigiri", {
	description = S("Onigiri"),
	inventory_image = "farming_onigiri.png",
	on_use = minetest.item_eat(2),
	groups = {compostability = 65}
})

farming.add_eatable("farming:onigiri", 2)

-- Gyoza

minetest.register_craftitem("farming:gyoza", {
	description = S("Gyoza"),
	inventory_image = "farming_gyoza.png",
	on_use = minetest.item_eat(4),
	groups = {compostability = 65}
})

farming.add_eatable("farming:gyoza", 4)

-- Mochi

minetest.register_craftitem("farming:mochi", {
	description = S("Mochi"),
	inventory_image = "farming_mochi.png",
	on_use = minetest.item_eat(3),
	groups = {compostability = 65}
})

farming.add_eatable("farming:mochi", 3)

-- Gingerbread Man

minetest.register_craftitem("farming:gingerbread_man", {
	description = S("Gingerbread Man"),
	inventory_image = "farming_gingerbread_man.png",
	on_use = minetest.item_eat(2),
	groups = {compostability = 85}
})

farming.add_eatable("farming:gingerbread_man", 2)

-- Mint tea
minetest.register_craftitem("farming:mint_tea", {
	description = S("Mint Tea"),
	inventory_image = "farming_mint_tea.png",
	on_use = minetest.item_eat(2, a.drinking_glass),
	groups = {drink = 1}
})

farming.add_eatable("farming:mint_tea", 2)

-- Onion soup
minetest.register_craftitem("farming:onion_soup", {
	description = S("Onion Soup"),
	inventory_image = "farming_onion_soup.png",
	groups = {compostability = 65, drink = 1},
	on_use = minetest.item_eat(6, a.bowl)
})

farming.add_eatable("farming:onion_soup", 6)

-- Pea soup

minetest.register_craftitem("farming:pea_soup", {
	description = S("Pea Soup"),
	inventory_image = "farming_pea_soup.png",
	groups = {compostability = 65, drink = 1},
	on_use = minetest.item_eat(4, a.bowl)
})

farming.add_eatable("farming:pea_soup", 4)

-- Ground pepper

minetest.register_node("farming:pepper_ground", {
	description = S("Ground Pepper"),
	inventory_image = "crops_pepper_ground.png",
	wield_image = "crops_pepper_ground.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"crops_pepper_ground.png"},
	groups = {
		vessel = 1, food_pepper_ground = 1, handy = 1,
		dig_immediate = 3, attached_node = 1, compostability = 30
	},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

-- pineapple ring

minetest.register_craftitem("farming:pineapple_ring", {
	description = S("Pineapple Ring"),
	inventory_image = "farming_pineapple_ring.png",
	groups = {food_pineapple_ring = 1, compostability = 45},
	on_use = minetest.item_eat(1)
})

farming.add_eatable("farming:pineapple_ring", 1)

-- Pineapple juice

minetest.register_craftitem("farming:pineapple_juice", {
	description = S("Pineapple Juice"),
	inventory_image = "farming_pineapple_juice.png",
	on_use = minetest.item_eat(4, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1, compostability = 35}
})

farming.add_eatable("farming:pineapple_juice", 4)

-- Potato & cucumber Salad

minetest.register_craftitem("farming:potato_salad", {
	description = S("Cucumber and Potato Salad"),
	inventory_image = "farming_potato_salad.png",
	on_use = minetest.item_eat(10, "farming:bowl")
})

farming.add_eatable("farming:potato_salad", 10)

-- Pumpkin dough

minetest.register_craftitem("farming:pumpkin_dough", {
	description = S("Pumpkin Dough"),
	inventory_image = "farming_pumpkin_dough.png"
})

-- Pumpkin bread

minetest.register_craftitem("farming:pumpkin_bread", {
	description = S("Pumpkin Bread"),
	inventory_image = "farming_pumpkin_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_bread = 1}
})

farming.add_eatable("farming:pumpkin_bread", 8)

-- Raspberry smoothie

minetest.register_craftitem("farming:smoothie_raspberry", {
	description = S("Raspberry Smoothie"),
	inventory_image = "farming_raspberry_smoothie.png",
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1, compostability = 65}
})

farming.add_eatable("farming:smoothie_raspberry", 2)

-- Rhubarb pie

minetest.register_craftitem("farming:rhubarb_pie", {
	description = S("Rhubarb Pie"),
	inventory_image = "farming_rhubarb_pie.png",
	on_use = minetest.item_eat(6),
	groups = {compostability = 65}
})

farming.add_eatable("farming:rhubarb_pie", 6)

-- Rice flour

minetest.register_craftitem("farming:rice_flour", {
	description = S("Rice Flour"),
	inventory_image = "farming_rice_flour.png",
	groups = {food_rice_flour = 1, flammable = 1, compostability = 65}
})

-- Rice bread

minetest.register_craftitem("farming:rice_bread", {
	description = S("Rice Bread"),
	inventory_image = "farming_rice_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_rice_bread = 1, compostability = 65}
})

farming.add_eatable("farming:rice_bread", 5)

-- Multigrain flour

minetest.register_craftitem("farming:flour_multigrain", {
	description = S("Multigrain Flour"),
	inventory_image = "farming_flour_multigrain.png",
	groups = {food_flour = 1, flammable = 1},
})


-- Multigrain bread

minetest.register_craftitem("farming:bread_multigrain", {
	description = S("Multigrain Bread"),
	inventory_image = "farming_bread_multigrain.png",
	on_use = minetest.item_eat(7),
	groups = {food_bread = 1, compostability = 65}
})

farming.add_eatable("farming:bread_multigrain", 7)

-- Soy sauce

minetest.register_node("farming:soy_sauce", {
	description = S("Soy Sauce"),
	drawtype = "plantlike",
	tiles = {"farming_soy_sauce.png"},
	inventory_image = "farming_soy_sauce.png",
	wield_image = "farming_soy_sauce.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {
		vessel = 1, food_soy_sauce = 1, dig_immediate = 3, attached_node = 1,
		compostability = 65, handy = 1
	},
	is_ground_content = false,
	sounds = farming.node_sound_glass_defaults()
})

-- Soy milk

minetest.register_node("farming:soy_milk", {
	description = S("Soy Milk"),
	drawtype = "plantlike",
	tiles = {"farming_soy_milk_glass.png"},
	inventory_image = "farming_soy_milk_glass.png",
	wield_image = "farming_soy_milk_glass.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {
		vessel = 1, food_milk_glass = 1, dig_immediate = 3, handy = 1,
		attached_node = 1, drink = 1, compostability = 65
	},
	is_ground_content = false,
	sounds = farming.node_sound_glass_defaults()
})

farming.add_eatable("farming:soy_milk", 2)

-- Tofu

minetest.register_craftitem("farming:tofu", {
	description = S("Tofu"),
	inventory_image = "farming_tofu.png",
	groups = {
		food_tofu = 1, food_meat_raw = 1, compostability = 65,
	},
	on_use = minetest.item_eat(3)
})

farming.add_eatable("farming:tofu", 3)

-- Cooked tofu

minetest.register_craftitem("farming:tofu_cooked", {
	description = S("Cooked Tofu"),
	inventory_image = "farming_tofu_cooked.png",
	groups = {food_meat = 1, compostability = 65},
	on_use = minetest.item_eat(6)
})

farming.add_eatable("farming:tofu_cooked", 6)

-- Toasted sunflower seeds

minetest.register_craftitem("farming:sunflower_seeds_toasted", {
	description = S("Toasted Sunflower Seeds"),
	inventory_image = "farming_sunflower_seeds_toasted.png",
	groups = {food_sunflower_seeds_toasted = 1, compostability = 65},
	on_use = minetest.item_eat(1)
})

farming.add_eatable("farming:sunflower_seeds_toasted", 1)

-- Sunflower oil

minetest.register_node("farming:sunflower_oil", {
	description = S("Bottle of Sunflower Oil"),
	drawtype = "plantlike",
	tiles = {"farming_sunflower_oil.png"},
	inventory_image = "farming_sunflower_oil.png",
	wield_image = "farming_sunflower_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {
		food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1,
		flammable = 2, compostability = 65, handy = 1
	},
	sounds = farming.node_sound_glass_defaults()
})

-- Sunflower seed bread

minetest.register_craftitem("farming:sunflower_bread", {
	description = S("Sunflower Seed Bread"),
	inventory_image = "farming_sunflower_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_bread = 1}
})

farming.add_eatable("farming:sunflower_bread", 8)

-- Vanilla extract

minetest.register_node("farming:vanilla_extract", {
	description = S("Vanilla Extract"),
	drawtype = "plantlike",
	tiles = {"farming_vanilla_extract.png"},
	inventory_image = "farming_vanilla_extract.png",
	wield_image = "farming_vanilla_extract.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1},
	sounds = farming.node_sound_glass_defaults(),
})

-- Jerusalem Artichokes with miso butter

minetest.register_craftitem("farming:jerusalem_artichokes", {
	description = S("Jerusalem Artichokes"),
	inventory_image = "farming_jerusalem_artichokes.png",
	on_use = minetest.item_eat(11, a.bowl)
})

farming.add_eatable("ethereal:jerusalem_artichokes", 11)

--= Foods we shouldn't add when using Mineclonia/VoxeLibre

if not farming.mcl then

	-- Bread

	minetest.register_craftitem("farming:bread", {
		description = S("Bread"),
		inventory_image = "farming_bread.png",
		on_use = minetest.item_eat(5),
		groups = {food_bread = 1}
	})

	farming.add_eatable("farming:bread", 5)

	-- Cocoa beans

	minetest.register_craftitem("farming:cocoa_beans", {
		description = S("Cocoa Beans"),
		inventory_image = "farming_cocoa_beans.png",
		groups = {compostability = 65, food_cocoa = 1, flammable = 2}
	})

	-- Chocolate cookie

	minetest.register_craftitem("farming:cookie", {
		description = S("Cookie"),
		inventory_image = "farming_cookie.png",
		on_use = minetest.item_eat(2)
	})

	farming.add_eatable("farming:cookie", 2)

	-- Golden carrot

	minetest.register_craftitem("farming:carrot_gold", {
		description = S("Golden Carrot"),
		inventory_image = "farming_carrot_gold.png",
		on_use = minetest.item_eat(10)
	})

	farming.add_eatable("farming:carrot_gold", 10)

	-- Beetroot soup

	minetest.register_craftitem("farming:beetroot_soup", {
		description = S("Beetroot Soup"),
		inventory_image = "farming_beetroot_soup.png",
		on_use = minetest.item_eat(6, "farming:bowl"),
		groups = {drink = 1}
	})

	farming.add_eatable("farming:beetroot_soup", 6)

	-- Sugar

	minetest.register_craftitem("farming:sugar", {
		description = S("Sugar"),
		inventory_image = "farming_sugar.png",
		groups = {food_sugar = 1, flammable = 3}
	})

	-- Baked potato

	minetest.register_craftitem("farming:baked_potato", {
		description = S("Baked Potato"),
		inventory_image = "farming_baked_potato.png",
		on_use = minetest.item_eat(6)
	})

	farming.add_eatable("farming:baked_potato", 6)
end
