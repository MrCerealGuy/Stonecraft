-- main tables
spawners_ores = {}
local percent = 10

-- how often node timers for minerals will tick, +/- some random value
function spawners_ores.tick(pos)
  minetest.get_node_timer(pos):start(math.random(30, 60))
end

-- how often a growth failure tick is retried (e.g. not enough place to spawn minerals)
function spawners_ores.tick_short(pos)
  minetest.get_node_timer(pos):start(math.random(15, 20))
end

-- adds smoke particles
function spawners_ores.add_effects(pos, radius)
	minetest.add_particlespawner({
		amount = 32,
		time = 2,
		minpos = vector.subtract({x=pos.x, y=pos.y+1, z=pos.z}, radius / 2),
		maxpos = vector.add({x=pos.x, y=pos.y+1, z=pos.z}, radius / 2),
		minvel = {x=-0.5, y=3, z=-0.5},
		maxvel = {x=0.5,  y=10,  z=0.5},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 0.5,
		maxexptime = 2,
		minsize = 0.5,
		maxsize = 8,
		texture = "spawners_ores_smoke_particle.png^[transform"..math.random(0,3)
	})
end

-- start spawning ores
function spawners_ores.start_spawning_ores(pos, ore_name, how_many)
	if not pos or not ore_name then return end
	local player_near = false
	local how_many = how_many or 1

	for i=1, how_many do
		
		if i > 1 then
			pos = spawners_ores.get_available_node(pos, "default:stone")

			if not pos then return end

			minetest.sound_play("spawners_ores_strike", {
				pos = pos,
				max_hear_distance = 16,
				gain = 10,
			})

			minetest.set_node(pos, {name=ore_name})
			spawners_ores.add_effects(pos, 1)
		else
			minetest.sound_play("spawners_ores_strike", {
				pos = pos,
				max_hear_distance = 16,
				gain = 10,
			})

			minetest.set_node(pos, {name=ore_name})
			spawners_ores.add_effects(pos, 1)
		end
	end
	
end

function spawners_ores.get_available_node(pos, check_node, radius)
	if not pos then return end

	local check_node = check_node or "default:stone"
	local radius = radius or 2

	local node_ore_pos = minetest.find_node_near(pos, radius, {check_node})
	
	if node_ore_pos and node_ore_pos ~= nil then
		return node_ore_pos
	else
		return false
	end
end

-- build form for spawners
function spawners_ores.get_formspec(pos, table)
	-- Inizialize metadata and variables
	local table = table or {}
	local meta = minetest.get_meta(pos)
	local mineral = table.ore or meta:get_string("mineral")
	local ingot = table.ore or meta:get_string("mineral")
	local status = meta:get_string("status")
	local inv = meta:get_inventory()
	local stack = inv:get_stack("fuel", 1)

	-- fix different Ingot namings
	if ingot == "iron" then
		ingot = "steel"
	end

	-- add extra ores based on percentage
	local stack_per_obj = spawners_ores.stack_per({
		stack_count = stack:get_count(),
		percent = percent
	})
	local stack_per = stack_per_obj.stack_per or 0
	local extra_per = stack_per_obj.extra_per or 0

	local colorize = {
		gold = "^[colorize:#ffe4008C",
		tin = "^[colorize:#d0d0d08C",
		iron = "^[colorize:#b66d498C",
		copper = "^[colorize:#b587528C",
	}

	local colorize_arrow = ""
	local button = ""

	if status == "active" then
		colorize_arrow = colorize[mineral]
	elseif status == "waiting" then
		button = "button[1.8,2.5;2,1.5;restart;RE-START]"	
	end
	
	-- dynamic formspec
	local formspec = "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[1.8,0.3;Input "..ingot.." Ingot]"..
		"list[current_name;fuel;1.8,1;1,1;]"..
		"image[1.8,1;1,1;spawners_ores_ingot_slot.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"image[2.9,1;1,1;gui_furnace_arrow_bg.png^[transformR270"..colorize_arrow.."]"..
		"label[1.8,2;"..stack_per.." minerals ("..extra_per.." extra)]"..
		"image[4,1;1,1;spawners_ores_stone_with_"..mineral..".png]"..
		button..
		"listring[current_name;fuel]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)

	meta:set_string("formspec", formspec)

	-- infotext
	local infotext = mineral.." fuel: "..inv:get_stack("fuel", 1):get_count()

	if inv:is_empty("fuel") then
		infotext = mineral.." ore spawner is empty."
	elseif status == "waiting" then
		infotext = "Waiting - no default:stone was found near by, "..mineral.." fuel: "..inv:get_stack("fuel", 1):get_count()
	end

	meta:set_string("infotext", infotext)
end

-- check if is fuel empty in the node
function spawners_ores.can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel")
end

-- add extra percentage on top of the stack
function spawners_ores.stack_per(table)
	local table = table or {}
	local stack_count = table.stack_count or nil
	local extra_per = (stack_count / 100) * percent
	
	extra_per = math.floor(extra_per)
	
	local stack_per = extra_per + stack_count
	
	-- print(percent.."% from stack("..stack_count..") = "..stack_per.." ("..extra_per.." extra ore(s))")
	
	return {
		stack_per = stack_per,
		extra_per = extra_per
	}
end

-- set status and update formspec/infotext
function spawners_ores.on_timer(pos, elapsed)
	
	local available_node = spawners_ores.get_available_node(pos, "default:stone")
	
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack("fuel", 1)
	local how_many = 1

	local ore_name = meta:get_string("ore_name")
	local mineral = meta:get_string("mineral")
	local status = meta:get_string("status")
	local tick = meta:get_int("tick")

	-- 
	-- active
	-- 
	if available_node and inv:is_empty("fuel") ~= true then
		-- make sure the right node status is shown
		if status ~= "active" then
			meta:set_string("status", "active")
			
			spawners_ores.get_formspec(pos)
			minetest.swap_node(pos, {name="spawners_ores:"..ore_name.."_spawner_active"})
		end

		-- start spawning only on proper 'tick'
		if tick ~= 0 then
			if stack:get_count() % percent == 0 then
				-- TODO: should get countent based on 'percent'
				how_many = 2
			end

			-- enough place to spawn more ores
			spawners_ores.start_spawning_ores(available_node, "default:"..ore_name, how_many)
			
			-- take fuel
			stack:take_item()
			inv:set_stack("fuel", 1, stack)

			spawners_ores.get_formspec(pos)
		end

		-- dont wait for proper 'tick' and change state after 1 sec.
		local next_available_node = spawners_ores.get_available_node(pos, "default:stone")

		if inv:is_empty("fuel") or next_available_node == false then
			minetest.get_node_timer(pos):start(1.0)
			return
		end

		if tick == 0 then
			-- start new proper timer
			meta:set_int("tick", 1)
		end
		
		-- start new proper timer
		spawners_ores.tick(pos)
	-- 
	-- default
	-- 
	elseif inv:is_empty("fuel") then
		-- empty / no fuel -- stop timer
		-- make sure that default status/node is shown
		meta:set_string("status", "")
		minetest.swap_node(pos, {name="spawners_ores:"..ore_name.."_spawner"})
		
		spawners_ores.get_formspec(pos)
		return

	-- 
	-- waiting
	-- 
	else
		-- stop timer and show "refresh" button in order to start timer again
		-- make sure that waiting status/node is shown
		if status ~= "waiting" then
			meta:set_string("status", "waiting")
			minetest.swap_node(pos, {name="spawners_ores:"..ore_name.."_spawner_waiting"})
		end

		spawners_ores.get_formspec(pos)
		return
	end

end
