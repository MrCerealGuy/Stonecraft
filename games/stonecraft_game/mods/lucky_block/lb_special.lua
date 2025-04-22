
local S = lucky_block.S

-- custom function (punches player with 5 damage)

local function punchy(pos, player)

	player:punch(player, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = 5}
	}, nil)

	minetest.sound_play("player_damage", {pos = pos, gain = 1.0}, true)

	minetest.chat_send_player(player:get_player_name(),
			lucky_block.green .. S("Stop hitting yourself!"))
end

-- custom function (pint sized player) and potion with recipe

local function pint(pos, player)

	player:set_properties({
		visual_size = {x = 0.5, y = 0.5},
		collisionbox = {-0.15, 0.0, -0.15, 0.15, .85, 0.15},
		eye_height = 0.73,
		stepheight = 0.3
	})

	minetest.chat_send_player(player:get_player_name(),
			lucky_block.green .. S("Pint Sized Player!"))

	minetest.sound_play(lucky_block.snd_pop2, {pos = pos, gain = 1.0}, true)

	minetest.after (180, function(player, pos) -- 3 minutes

		if player and player:is_player() then

			player:set_properties({
				visual_size = {x = 1.0, y = 1.0},
				collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
				eye_height = 1.47,
				stepheight = 0.6
			})

			minetest.sound_play(lucky_block.snd_pop2, {
				pos = player:get_pos(), gain = 1.0}, true)
		end
	end, player)
end

-- pint sized potion item

minetest.register_craftitem("lucky_block:pint_sized_potion", {
	description = S("Pint Sized Potion (DRINK ME)"),
	inventory_image = "lucky_pint_sized_potion.png",
	groups = {vessel = 1},

	on_use = function(itemstack, user, pointed_thing)

		itemstack:take_item()

		local pos = user:get_pos()
		local inv = user:get_inventory()
		local item = "vessels:glass_bottle"

		if inv:room_for_item("main", {name = item}) then
			inv:add_item("main", item)
		else
			minetest.add_item(pos, {name = item})
		end

		pint(pos, user)

		return itemstack
	end
})

-- pint sized potion recipe (default)

if lucky_block.mod_def then

	minetest.register_craft({
		output = "lucky_block:pint_sized_potion",
		recipe = {
			{"default:bush_sapling", "flowers:tulip", "default:acacia_bush_sapling"},
			{"dye:blue", "default:apple", "dye:cyan"},
			{"", "vessels:glass_bottle", ""}
		}
	})
end

-- custom function (slender player) and potion with recipe

local function slender(pos, player)

	player:set_properties({
		visual_size = {x = 1.0, y = 1.5},
		collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7 + .85, 0.3},
		eye_height = 1.47 + 0.73,
		stepheight = 0.9
	})

	minetest.chat_send_player(player:get_player_name(),
			lucky_block.green .. S("Slender Player!"))

	minetest.sound_play(lucky_block.snd_pop2, {pos = pos, gain = 1.0}, true)

	minetest.after (180, function(player, pos) -- 3 minutes

		if player and player:is_player() then

			player:set_properties({
				visual_size = {x = 1.0, y = 1.0},
				collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
				eye_height = 1.47,
				stepheight = 0.6
			})

			minetest.sound_play(lucky_block.snd_pop2, {
				pos = player:get_pos(), gain = 1.0}, true)
		end
	end, player)
end

-- slender player potion item

minetest.register_craftitem("lucky_block:slender_player_potion", {
	description = S("Slender Player Potion (DRINK ME)"),
	inventory_image = "lucky_slender_potion.png",
	groups = {vessel = 1},

	on_use = function(itemstack, user, pointed_thing)

		itemstack:take_item()

		local pos = user:get_pos()
		local inv = user:get_inventory()
		local item = "vessels:glass_bottle"

		if inv:room_for_item("main", {name = item}) then
			inv:add_item("main", item)
		else
			minetest.add_item(pos, {name = item})
		end

		slender(pos, user)

		return itemstack
	end
})

-- slender player potion recipe

if lucky_block.mod_def then

	minetest.register_craft({
		output = "lucky_block:slender_player_potion",
		recipe = {
			{"default:bush_sapling", "flowers:rose", "default:pine_bush_sapling"},
			{"dye:red", "default:apple", "dye:orange"},
			{"", "vessels:glass_bottle", ""}
		}
	})
end

-- lightning staff

minetest.register_tool("lucky_block:lightning_staff", {
	description = S("Lightning Staff"),
	inventory_image = "lucky_lightning_staff.png",
	range = 10,
	groups = {not_in_creative_inventory = 1},

	on_use = function(itemstack, user, pointed_thing)

		local pos = user:get_pos()

		if pointed_thing.type == "object" then
			pos = pointed_thing.ref:get_pos()
		elseif pointed_thing.type == "node" then
			pos = pointed_thing.above
		end

		if not pos then return end

		local bnod = pos and minetest.get_node_or_nil(pos)
		local bref = bnod and minetest.registered_items[bnod.name]

		if bref and bref.buildable_to == true then
			minetest.set_node(pos, {name = "fire:basic_flame"})
		end

		local radius = 4
		local objs = minetest.get_objects_inside_radius(pos, radius)
		local obj_pos, dist

		-- add temp entity to cause damage
		local tmp_ent = minetest.add_entity(pos, "lucky_block:temp")

		for n = 1, #objs do

			obj_pos = objs[n]:get_pos()

			dist = vector.distance(pos, obj_pos)

			if dist < 1 then dist = 1 end

			local damage = math.floor((4 / dist) * radius)
			local ent = objs[n]:get_luaentity()

			-- if you blast yourself then delay hurt for bones mod if dead
			if objs[n] == user then

				minetest.after(0.1, function()
					objs[n]:punch(tmp_ent, 1.0, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = damage, fire = 1}
					}, pos)
				end)
			else
				objs[n]:punch(tmp_ent, 1.0, {
					full_punch_interval = 1.0,
					damage_groups = {fleshy = damage, fire = 1}
				}, pos)
			end
		end

		minetest.add_particle({
			pos = {x = pos.x, y = pos.y + 4, z = pos.z},
			velocity = {x = 0, y = 0, z = 0},
			acceleration = {x = 0, y = 0, z = 0},
			expirationtime = 1.0,
			collisiondetection = false,
			texture = "lucky_lightning.png",
			size = 100,
			glow = 15
		})

		minetest.sound_play("lightning", {
				pos = pos, gain = 1.0, max_hear_distance = 25}, true)

		itemstack:add_wear(65535 / 50) -- 50 uses

		return itemstack
	end
})

-- custom function (drop player inventory and replace with items and show msg)

local function dropsy(pos, player, def)

	local player_inv = player:get_inventory()

	pos = player:get_pos() or pos

	for i = 1, player_inv:get_size("main") do

		local obj = minetest.add_item(pos, player_inv:get_stack("main", i))

		if obj then

			obj:set_velocity({
				x = math.random(-10, 10) / 9,
				y = 5,
				z = math.random(-10, 10) / 9
			})
		end

		player_inv:set_stack("main", i, def.item)
	end

	minetest.chat_send_player(player:get_player_name(), lucky_block.green .. S(def.msg))
end

-- void mirror block (place to see through solid walls)

local tex = lucky_block.mod_mcl and "default_glass.png"
		or "default_obsidian_glass.png^[brighten"

minetest.register_node("lucky_block:void_mirror", {
	description = S("Void Mirror (Place to see through solid walls during daytime)"),
	drawtype = "normal",
	tiles = {tex},
	use_texture_alpha = "clip",
	groups = {handy = 1, snappy = 3, not_in_creative_inventory = 1},
	sounds = lucky_block.snd_glass,
	_mcl_hardness = 0.6
})

-- Troll item drop

local function fake_items(pos, player, def)

	for n = 1, 25 do

		minetest.add_particle({
			time = 15,
			pos = {
				x = pos.x + math.random(-20, 20) / 10,
				y = pos.y,
				z = pos.z + math.random(-20, 20) / 10
			},
			velocity = {x = 0, y = 2, z = 0},
			acceleration = {x = 0, y = -10, z = 0},
			expirationtime = 4,
			maxsize = 4,
			texture = def.tex,
			glow = 2,
			size = 5,
			collisiondetection = true,
			vertical = true
		})
	end

	minetest.chat_send_player(player:get_player_name(),
			lucky_block.green .. S("Wow! So many faux @1!", S(def.txt) ))
end

-- Void Pick (disable for mineclone since it has silk touch tools)

if not lucky_block.mod_mcl then

	local old_handle_node_drops = minetest.handle_node_drops

	function minetest.handle_node_drops(pos, drops, digger)

		-- are we holding Crystal Shovel?
		if not digger
		or digger:get_wielded_item():get_name() ~= "lucky_block:pick_void" then
			return old_handle_node_drops(pos, drops, digger)
		end

		local nn = minetest.get_node(pos).name

		if nn == "default:furnace_active"
		or nn:find("xpanes:")
		or nn:find("door")
		or minetest.get_item_group(nn, "cracky") == 0
		or minetest.get_item_group(nn, "no_silktouch") == 1 then
			return old_handle_node_drops(pos, drops, digger)
		end

		return old_handle_node_drops(pos, {ItemStack(nn)}, digger)
	end

	minetest.register_tool("lucky_block:pick_void", {
		description = S("Void pick (Silk Touch)"),
		inventory_image = "lucky_void_pick.png",
		wield_image = "lucky_void_pick.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 3,
			groupcaps = {
				cracky = {
					times = {[1] = 2.4, [2] = 1.2, [3] = 0.60}, uses = 20, maxlevel = 3
				}
			},
			damage_groups = {fleshy = 5},
		},
		groups = {pickaxe = 1, not_in_creative_inventory = 1},
		sound = {breaks = "default_tool_breaks"},
		_repair_material = "lucky_block:void_mirror",
		_repair_material_total = 3
	})
end

-- add custom functions and special drops

lucky_block:add_blocks({
	{"cus", pint},
	{"cus", punchy},
	{"cus", slender},
	{"dro", {"lucky_block:pint_sized_potion"}, 1},
	{"dro", {"lucky_block:slender_player_potion"}, 1},
	{"dro", {"lucky_block:void_mirror"}}
})

-- custom items for default mod

if lucky_block.mod_def then

	lucky_block:add_blocks({
		{"cus", dropsy, {item = "default:dry_shrub", msg = "Dry shrub takeover!"} },
		{"cus", fake_items, {tex = "default_diamond.png", txt = "diamonds"} },
		{"cus", fake_items, {tex = "default_gold_ingot.png", txt = "ingots"} },
		{"cus", fake_items, {tex = "default_mese_crystal.png", txt = "crystals"} },
		{"nod", "default:chest", 0, {
			{name = "lucky_block:pick_void", max = 1, chance = 7},
			{name = "default:stone_with_coal", max = 5},
			{name = "default:stone_with_iron", max = 5},
			{name = "default:stone_with_copper", max = 5},
			{name = "default:stone_with_mese", max = 5},
			{name = "default:stone_with_gold", max = 5},
			{name = "default:stone_with_diamond", max = 5}
		}},
		{"nod", "default:chest", 0, {
			{name = "default:stick", max = 10},
			{name = "default:acacia_bush_stem", max = 10},
			{name = "default:bush_stem", max = 10},
			{name = "default:pine_bush_stem", max = 10},
			{name = "default:grass_1", max = 10},
			{name = "default:dry_grass_1", max = 10},
			{name = "lucky_block:lightning_staff", max = 1, chance = 10}
		}}
	})
end

-- pova mod effects

if minetest.get_modpath("pova") then

	local function slowmo(pos, player, def) -- slowmo effect

		local name = player:get_player_name()

		minetest.chat_send_player(name,
				lucky_block.green .. S("You suddenly feel sluggish, take 30 seconds!"))

		pova.add_override(name, "lb_sluggish", {speed = -0.9})
		pova.do_override(player)

		minetest.after(30, function(player)

			local name = player:get_player_name()

			if name then
				pova.del_override(name, "lb_sluggish")
				pova.do_override(player)
			end
		end, player)
	end

	local function highfly(pos, player, def) -- high jump effect

		local name = player:get_player_name()

		minetest.chat_send_player(name,
				lucky_block.green .. S("You suddenly feel lighter, wait 30 seconds!"))

		pova.add_override(name, "lb_lighter", {jump = 4})
		pova.do_override(player)

		minetest.after(30, function(player)

			local name = player:get_player_name()

			if name then
				pova.del_override(name, "lb_lighter")
				pova.do_override(player)
			end
		end, player)
	end

	lucky_block:add_blocks({
		{"cus", slowmo},
		{"cus", highfly}
	})
end

-- Ocarina

minetest.register_craftitem("lucky_block:ocarina", {
	description = S("Ocarina"),
	inventory_image = "lucky_block_ocarina.png",
	stack_max = 1,

	on_use = function(itemstack, user, pointed_thing)

		--if pointed_thing.type == "node" then return end

		local pitch = (user and user:get_look_vertical() or 0) / 7

		minetest.sound_play("ocarina", {
			object = user,
			max_hear_distance = 8,
			pitch = 1.0 - pitch,
			gain = 1.0}, true)
	end
})

lucky_block:add_blocks({ {"dro", {"lucky_block:ocarina"}, 1} })
