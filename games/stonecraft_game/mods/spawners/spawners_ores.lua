-- Formspecs
local ore_formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[2,1.7;Input Ingot]"..
	"list[current_name;fuel;3.5,1.5;1,1;]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"button_exit[5,1.5;2,1;exit;Save]"..
	"listring[current_name;fuel]"..
	"listring[current_player;main]"..
	default.get_hotbar_bg(0, 4.25)

function spawners.get_formspec(pos)

	-- Inizialize metadata
	local meta = minetest.get_meta(pos)
	
	-- Inizialize inventory
	local inv = meta:get_inventory()
	for listname, size in pairs({
			fuel = 1,
	}) do
		if inv:get_size(listname) ~= size then
			inv:set_size(listname, size)
		end
	end

	-- Update formspec, infotext and node
	meta:set_string("formspec", ore_formspec)
end

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		minetest.record_protection_violation(pos, player:get_player_name())
		return
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local ingot = minetest.get_node_or_nil(pos).name

	ingot = string.split(ingot, ":")
	ingot = string.split(ingot[2], "_")

	if ingot[3] == "iron" then
		ingot[3] = "steel"
	end

	if stack:get_name() == "default:"..ingot[3].."_ingot" then
		return stack:get_count()
	else
		return 0
	end
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		minetest.record_protection_violation(pos, player:get_player_name())
		return 0
	end
	return stack:get_count()
end

local function on_receive_fields(pos, formname, fields, sender)
	local ore_node = minetest.get_node_or_nil(pos)

	if minetest.is_protected(pos, sender:get_player_name()) then
		minetest.record_protection_violation(pos, sender:get_player_name())
		return
	end

	-- get the ore name
	local ingot = ore_node.name
	ingot = string.split(ingot, ":")
	ingot = string.split(ingot[2], "_")

	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local fuellist = inv:get_list("fuel")

	if inv:is_empty("fuel") then
		if ore_node.name ~= "spawners:stone_with_"..ingot[3].."_spawner" then
			minetest.swap_node(pos, {name="spawners:stone_with_"..ingot[3].."_spawner"})
		end
		meta:set_string("infotext", ingot[3].." ore spawner is empty")
	else
		meta:set_string("infotext", ingot[3].." ore spawner fuel: "..inv:get_stack("fuel", 1):get_count())
	end

	-- fix iron vs. steel issue
	if ingot[3] == "iron" then
		ingot[3] = "steel"
	end

	if not fuellist[1]:is_empty() and inv:get_stack("fuel", 1):get_name() == "default:"..ingot[3].."_ingot" then
		
		-- fix iron vs. steel issue
		if ingot[3] == "steel" then
			ingot[3] = "iron"
		end

		local waiting, found_node = spawners.check_node_status_ores(pos, "stone_with_"..ingot[3], "default:stone")

		if found_node then
			minetest.swap_node(pos, {name="spawners:stone_with_"..ingot[3].."_spawner_active"})
		elseif waiting then
			minetest.swap_node(pos, {name="spawners:stone_with_"..ingot[3].."_spawner_waiting"})

			meta:set_string("infotext", "Waiting status - player was away or no stone around, "..ingot[3].." ore spawner fuel: "..inv:get_stack("fuel", 1):get_count())
		else
			return
		end
	end
end

-- Ores creation
function spawners.create_ore(ore_name, mod_prefix, size, offset, texture, sound_custom)
	-- dummy inside the spawner
	local dummy_ore_definition = {
		hp_max = 1,
		physical = false,
		collisionbox = {0,0,0,0,0,0},
		visual = "wielditem",
		visual_size = size,
		timer = 0,
		textures={"default:"..ore_name},
		makes_footstep_sound = false,
		automatic_rotate = math.pi * -3,
		m_name = "dummy_ore"
	}

	local ore = string.split(ore_name, "_")

	dummy_ore_definition.on_activate = function(self)
		self.object:setvelocity({x=0, y=0, z=0})
		self.object:setacceleration({x=0, y=0, z=0})
		self.object:set_armor_groups({immortal=1})
	end

	-- remove dummy after dug up the spawner
	dummy_ore_definition.on_step = function(self, dtime)
		self.timer = self.timer + dtime
		local n = minetest.get_node_or_nil(self.object:getpos())
		if self.timer > 2 then
			if n and n.name and n.name ~= "spawners:"..ore_name.."_spawner_active" and n.name ~= "spawners:"..ore_name.."_spawner_waiting" and n.name ~= "spawners:"..ore_name.."_spawner" then
				self.object:remove()
			end
		end
	end

	minetest.register_entity("spawners:dummy_ore_"..ore_name, dummy_ore_definition)

	-- node spawner active
	minetest.register_node("spawners:"..ore_name.."_spawner_active", {
		description = ore_name.." spawner active",
		paramtype = "light",
		light_source = 4,
		drawtype = "allfaces",
		walkable = true,
		sounds = default.node_sound_stone_defaults(),
		damage_per_second = 4,
		sunlight_propagates = true,
		tiles = {
			{
				name = "spawners_spawner_animated.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 32,
					aspect_h = 32,
					length = 2.0
				},
			}
		},
		is_ground_content = true,
		groups = {cracky=1,level=2,igniter=1,not_in_creative_inventory=1},
		drop = "spawners:"..ore_name.."_spawner",
		can_dig = can_dig,
		allow_metadata_inventory_put = allow_metadata_inventory_put,
		allow_metadata_inventory_take = allow_metadata_inventory_take,
		on_receive_fields = on_receive_fields,
	})

	-- node spawner waiting - no stone around or no fuel
	minetest.register_node("spawners:"..ore_name.."_spawner_waiting", {
		description = ore_name.." spawner waiting",
		paramtype = "light",
		light_source = 2,
		drawtype = "allfaces",
		walkable = true,
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
		tiles = {
			{
				name = "spawners_spawner_waiting_animated.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 32,
					aspect_h = 32,
					length = 2.0
				},
			}
		},
		is_ground_content = true,
		groups = {cracky=1,level=2,not_in_creative_inventory=1},
		drop = "spawners:"..ore_name.."_spawner",
		can_dig = can_dig,
		allow_metadata_inventory_put = allow_metadata_inventory_put,
		allow_metadata_inventory_take = allow_metadata_inventory_take,
		on_receive_fields = on_receive_fields,
	})

	-- node spawner inactive (default)
	minetest.register_node("spawners:"..ore_name.."_spawner", {
		description = ore_name.." spawner",
		paramtype = "light",
		drawtype = "allfaces",
		walkable = true,
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
		tiles = {"spawners_spawner.png"},
		is_ground_content = true,
		groups = {cracky=1,level=2},
		stack_max = 1,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			spawners.get_formspec(pos)
			pos.y = pos.y + offset
			minetest.add_entity(pos,"spawners:dummy_ore_"..ore_name)
			meta:set_string("infotext", ore[3].." ore spawner is empty")
		end,

		can_dig = can_dig,
	
		allow_metadata_inventory_put = allow_metadata_inventory_put,
		allow_metadata_inventory_take = allow_metadata_inventory_take,
		on_receive_fields = on_receive_fields,
	})

	-- ABM
	minetest.register_abm({
		nodenames = {"spawners:"..ore_name.."_spawner_active", "spawners:"..ore_name.."_spawner_waiting"},
		interval = 5.0,
		chance = 5,
		action = function(pos, node, active_object_count, active_object_count_wider)

			local waiting, found_node = spawners.check_node_status_ores(pos, ore_name,  "default:stone")


			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			if found_node then
				-- make sure the right node status is shown
				if node.name ~= "spawners:"..ore_name.."_spawner_active" then
					minetest.swap_node(pos, {name="spawners:"..ore_name.."_spawner_active"})
				end

				
				-- take fuel
				local stack = inv:get_stack("fuel", 1)
				stack:take_item()


				inv:set_stack("fuel", 1, stack)

				meta:set_string("infotext", ore[3].." ore spawner fuel: "..inv:get_stack("fuel", 1):get_count())

				-- enough place to spawn more ores
				spawners.start_spawning_ores(found_node, "default:"..ore_name, sound_custom)

				-- empty / no fuel
				if inv:is_empty("fuel") then
					minetest.swap_node(pos, {name="spawners:"..ore_name.."_spawner"})
					meta:set_string("infotext", ore[3].." ore spawner is empty.")

				end
			else
				-- waiting status
				if node.name ~= "spawners:"..ore_name.."_spawner_waiting" then
					minetest.swap_node(pos, {name="spawners:"..ore_name.."_spawner_waiting"})
					
					meta:set_string("infotext", "Waiting status - player was away or no stone around, "..ore[3].." ore spawner fuel: "..inv:get_stack("fuel", 1):get_count())
				end
			end

		end
	})

end

-- default:stone_with_gold
spawners.create_ore("stone_with_gold", "", {x=.33,y=.33}, 0, {"default_stone.png^default_mineral_gold.png"}, "strike")

-- default:stone_with_iron
spawners.create_ore("stone_with_iron", "", {x=.33,y=.33}, 0, {"default_stone.png^default_mineral_gold.png"}, "strike")

-- default:stone_with_copper
spawners.create_ore("stone_with_copper", "", {x=.33,y=.33}, 0, {"default_stone.png^default_mineral_gold.png"}, "strike")


-- recipes
minetest.register_craft({
	output = "spawners:stone_with_gold_spawner",
	recipe = {
		{"default:diamondblock", "fake_fire:flint_and_steel", "default:diamondblock"},
		{"xpanes:bar", "default:goldblock", "xpanes:bar"},
		{"default:diamondblock", "xpanes:bar", "default:diamondblock"},
	}
})

minetest.register_craft({
	output = "spawners:stone_with_iron_spawner",
	recipe = {
		{"default:diamondblock", "fake_fire:flint_and_steel", "default:diamondblock"},
		{"xpanes:bar", "default:steelblock", "xpanes:bar"},
		{"default:diamondblock", "xpanes:bar", "default:diamondblock"},
	}
})

minetest.register_craft({
	output = "spawners:stone_with_copper_spawner",
	recipe = {
		{"default:diamondblock", "fake_fire:flint_and_steel", "default:diamondblock"},
		{"xpanes:bar", "default:copperblock", "xpanes:bar"},
		{"default:diamondblock", "xpanes:bar", "default:diamondblock"},
	}
})
