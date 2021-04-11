-- Translation support
local S = minetest.get_translator("throwing_arrows")

local function register_bow_craft(name, itemcraft)
	minetest.register_craft({
		output = "throwing:" .. name,
		recipe = {
			{"farming:string", itemcraft, ""},
			{"farming:string", "", itemcraft},
			{"farming:string", itemcraft, ""},
		}
	})
end

throwing.register_bow(":throwing:bow_wood", {
	description = S("Wooden Bow"),
	texture = "throwing_bow_wood.png",
	uses = 50,
	strength = .5
})
register_bow_craft("bow_wood", "default:wood")

throwing.register_bow(":throwing:bow_stone", {
	description = S("Stone Bow"),
	texture = "throwing_bow_stone.png",
	uses = 100,
	strength = .65
})
register_bow_craft("bow_stone", "default:cobble")

throwing.register_bow(":throwing:bow_steel", {
	description = S("Steel Bow"),
	texture = "throwing_bow_steel.png",
	uses = 150,
	strength = .8
})
register_bow_craft("bow_steel", "default:steel_ingot")

throwing.register_bow(":throwing:bow_bronze", {
	description = S("Bronze Bow"),
	texture = "throwing_bow_bronze.png",
	uses = 200,
	strength = .95
})
register_bow_craft("bow_bronze", "default:bronze_ingot")

throwing.register_bow(":throwing:bow_gold", {
	description = S("Gold Bow"),
	texture = "throwing_bow_gold.png",
	uses = 250,
	strength = 1.1
})
register_bow_craft("bow_gold", "default:gold_ingot")

throwing.register_bow(":throwing:bow_mese", {
	description = S("Mese Bow"),
	texture = "throwing_bow_mese.png",
	uses = 300,
	strength = 1.25
})
register_bow_craft("bow_mese", "default:mese_crystal")

throwing.register_bow(":throwing:bow_diamond", {
	description = S("Diamond Bow"),
	texture = "throwing_bow_diamond.png",
	uses = 320,
	strength = 1.4
})
register_bow_craft("bow_diamond", "default:diamond")

local function get_setting(name)
	local value = minetest.settings:get_bool("throwing.enable_"..name)
	if value == true or value == nil then
		return true
	else
		return false
	end
end

local function register_arrow_craft(name, itemcraft, craft_quantity)
	minetest.register_craft({
		output = "throwing:"..name.." "..tostring(craft_quantity or 1),
		recipe = {
			{itemcraft, "default:stick", "default:stick"}
		}
	})
	minetest.register_craft({
		output = "throwing:"..name.." "..tostring(craft_quantity or 1),
		recipe = {
			{ "default:stick", "default:stick", itemcraft}
		}
	})
end

local last_punch_times = {}

local function arrow_punch(object, hitter, caps)
	local time_from_last_punch = caps.full_punch_interval or 1
	local hitter_name = hitter:get_player_name()
	local player_name = object:get_player_name()
	if last_punch_times[hitter_name] then
		if last_punch_times[hitter_name][player_name] then
			time_from_last_punch = os.difftime(os.time(), last_punch_times[hitter_name][player_name])
		end
	else
		last_punch_times[hitter_name] = {}
	end
	if time_from_last_punch >= (caps.full_punch_interval or 1) then
		last_punch_times[hitter_name][player_name] = os.time()
	end
	object:punch(hitter, time_from_last_punch, caps, nil)
end

if get_setting("arrow") then
	throwing.register_arrow("throwing:arrow", {
		description = S("Arrow"),
		tiles = {"throwing_arrow.png", "throwing_arrow.png", "throwing_arrow_back.png", "throwing_arrow_front.png", "throwing_arrow_2.png", "throwing_arrow.png"},
		target = throwing.target_both,
		allow_protected = true,
		mass = 1,
		on_hit_sound = "throwing_arrow",
		on_hit = function(self, pos, _, node, object, hitter)
			if object then
				arrow_punch(object, hitter, {
					full_punch_interval = 0.7,
					max_drop_level = 1,
					damage_groups = {fleshy = 3}
				})
			elseif node then
				if node.name == "mesecons_button:button_off" and minetest.get_modpath("mesecons_button") and minetest.get_modpath("mesecons") then
					minetest.registered_items["mesecons_button:button_off"].on_rightclick(vector.round(pos), node)
				end
			end
		end
	})
	register_arrow_craft("arrow", "default:steel_ingot", 16)
end

if get_setting("golden_arrow") then
	throwing.register_arrow("throwing:arrow_gold", {
		description = S("Golden Arrow"),
		tiles = {"throwing_arrow_gold.png", "throwing_arrow_gold.png", "throwing_arrow_gold_back.png", "throwing_arrow_gold_front.png", "throwing_arrow_gold_2.png", "throwing_arrow_gold.png"},
		target = throwing.target_object,
		allow_protected = true,
		on_hit_sound = "throwing_arrow",
		mass = 2,
		on_hit = function(self, pos, _, _, object, hitter)
			arrow_punch(object, hitter, {
				full_punch_interval = 0.6,
				max_drop_level = 1,
				damage_groups = {fleshy = 5}
			})
		end
	})
	register_arrow_craft("arrow_gold", "default:gold_ingot", 16)
end

if get_setting("diamond_arrow") then
	throwing.register_arrow("throwing:arrow_diamond", {
		description = S("Diamond Arrow"),
		tiles = {"throwing_arrow_diamond.png", "throwing_arrow_diamond.png", "throwing_arrow_diamond_back.png", "throwing_arrow_diamond_front.png", "throwing_arrow_diamond_2.png", "throwing_arrow_diamond.png"},
		target = throwing.target_object,
		allow_protected = true,
		on_hit_sound = "throwing_arrow",
		mass = .7,
		on_hit = function(self, pos, _, _, object, hitter)
			arrow_punch(object, hitter, {
				full_punch_interval = 0.5,
				max_drop_level = 1,
				damage_groups = {fleshy = 7}
			})
		end
	})
	register_arrow_craft("arrow_diamond", "default:diamond", 4)
end

if get_setting("dig_arrow") then
	throwing.register_arrow("throwing:arrow_dig", {
		description = S("Dig Arrow"),
		tiles = {"throwing_arrow_dig.png", "throwing_arrow_dig.png", "throwing_arrow_dig_back.png", "throwing_arrow_dig_front.png", "throwing_arrow_dig_2.png", "throwing_arrow_dig.png"},
		target = throwing.target_node,
		mass = 1,
		on_hit_sound = "throwing_dig_arrow",
		on_hit = function(self, pos, _, node, _, hitter)
			return minetest.dig_node(pos)
		end
	})
	register_arrow_craft("arrow_dig", "default:pick_wood")
end

if get_setting("dig_arrow_admin") then
	throwing.register_arrow("throwing:arrow_dig_admin", {
		description = S("Admin Dig Arrow"),
		tiles = {"throwing_arrow_dig.png", "throwing_arrow_dig.png", "throwing_arrow_dig_back.png", "throwing_arrow_dig_front.png", "throwing_arrow_dig_2.png", "throwing_arrow_dig.png"},
		target = throwing.target_node,
		mass = 1,
		on_hit = function(self, pos, _, node, _, _)
			minetest.remove_node(pos)
		end,
		groups = {not_in_creative_inventory = 1}
	})
end

if get_setting("teleport_arrow") then
	throwing.register_arrow("throwing:arrow_teleport", {
		description = S("Teleport Arrow"),
		tiles = {"throwing_arrow_teleport.png", "throwing_arrow_teleport.png", "throwing_arrow_teleport_back.png", "throwing_arrow_teleport_front.png", "throwing_arrow_teleport_2.png", "throwing_arrow_teleport.png"},
		allow_protected = true,
		mass = 1,
		on_hit_sound = "throwing_teleport_arrow",
		on_hit = function(self, _, last_pos, _, _, hitter)
			if minetest.get_node(last_pos).name ~= "air" then
				minetest.log("warning", "[throwing] BUG: node at "..minetest.pos_to_string(last_pos).." was not air")
				return
			end

			if minetest.settings:get_bool("throwing.allow_teleport_in_protected") == false then
				return false
			end

			hitter:move_to(last_pos)
		end
	})
	register_arrow_craft("arrow_teleport", "default:mese_crystal")
end

if get_setting("fire_arrow") then
	throwing.register_arrow("throwing:arrow_fire", {
		description = S("Torch Arrow"),
		tiles = {"throwing_arrow_fire.png", "throwing_arrow_fire.png", "throwing_arrow_fire_back.png", "throwing_arrow_fire_front.png", "throwing_arrow_fire_2.png", "throwing_arrow_fire.png"},
		mass = 1,
		on_hit_sound = "default_place_node",
		on_hit = function(self, pos, last_pos, _, _, hitter)
			if minetest.get_node(last_pos).name ~= "air" then
				minetest.log("warning", "[throwing] BUG: node at "..minetest.pos_to_string(last_pos).." was not air")
				return
			end

			local r_pos = vector.round(pos)
			local r_last_pos = vector.round(last_pos)
			-- Make sure that only one key is different
			if r_pos.y ~= r_last_pos.y then
				r_last_pos.x = r_pos.x
				r_last_pos.z = r_pos.z
			elseif r_pos.x ~= r_last_pos.x then
				r_last_pos.y = r_pos.y
				r_last_pos.z = r_pos.z
			end
			minetest.registered_items["default:torch"].on_place(ItemStack("default:torch"), hitter,
					{type="node", under=r_pos, above=r_last_pos})
		end
	})
	register_arrow_craft("arrow_fire", "default:torch")
end

if get_setting("build_arrow") then
	throwing.register_arrow("throwing:arrow_build", {
		description = S("Build Arrow"),
		tiles = {"throwing_arrow_build.png", "throwing_arrow_build.png", "throwing_arrow_build_back.png", "throwing_arrow_build_front.png", "throwing_arrow_build_2.png", "throwing_arrow_build.png"},
		mass = 1,
		on_hit_sound = "throwing_build_arrow",
		on_hit = function(self, pos, last_pos, _, _, hitter)
			if minetest.get_node(last_pos).name ~= "air" then
				minetest.log("warning", "[throwing] BUG: node at "..minetest.pos_to_string(last_pos).." was not air")
				return
			end

			local r_pos = vector.round(pos)
			local r_last_pos = vector.round(last_pos)
			-- Make sure that only one key is different
			if r_pos.y ~= r_last_pos.y then
				r_last_pos.x = r_pos.x
				r_last_pos.z = r_pos.z
			elseif r_pos.x ~= r_last_pos.x then
				r_last_pos.y = r_pos.y
				r_last_pos.z = r_pos.z
			end
			minetest.registered_items["default:obsidian_glass"].on_place(ItemStack("default:obsidian_glass"), hitter,
					{type="node", under=r_pos, above=r_last_pos})
		end
	})
	register_arrow_craft("arrow_build", "default:obsidian_glass")
end

if get_setting("drop_arrow") then
	throwing.register_arrow("throwing:arrow_drop", {
		description = S("Drop Arrow"),
		tiles = {"throwing_arrow_drop.png", "throwing_arrow_drop.png", "throwing_arrow_drop_back.png", "throwing_arrow_drop_front.png", "throwing_arrow_drop_2.png", "throwing_arrow_drop.png"},
		on_hit_sound = "throwing_build_arrow",
		allow_protected = true,
		mass = 1,
		on_throw = function(self, _, thrower, _, index, data)
			local inventory = thrower:get_inventory()
			if index >= inventory:get_size("main") or inventory:get_stack("main", index+1):get_name() == "" then
				return false, "nothing to drop"
			end
			data.itemstack = inventory:get_stack("main", index+1)
			data.index = index+1
			thrower:get_inventory():set_stack("main", index+1, nil)
		end,
		on_hit = function(self, _, last_pos, _, _, hitter, data)
			minetest.item_drop(ItemStack(data.itemstack), hitter, last_pos)
		end,
		on_hit_fails = function(self, _, thrower, data)
			if not minetest.settings:get_bool("creative_mode") then
				thrower:get_inventory():set_stack("main", data.index, data.itemstack)
			end
		end
	})
	register_arrow_craft("arrow_drop", "default:copper_ingot", 16)
end
