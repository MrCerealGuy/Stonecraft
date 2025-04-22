--        ______
--       |
--       |
--       |        __       ___  _   __         _  _
-- |   | |       |  | |\ |  |  |_| |  | |  |  |_ |_|
-- |___| |______ |__| | \|  |  | \ |__| |_ |_ |_ |\  tube
-- |
-- |
--

-- Reference
-- ports = get_real_port_states(pos): gets if inputs are powered from outside
-- newport = merge_port_states(state1, state2): just does result = state1 or state2 for every port
-- set_port(pos, rule, state): activates/deactivates the mesecons according to the port states
-- set_port_states(pos, ports): Applies new port states to a Luacontroller at pos
-- run_inner(pos, code, event): runs code on the controller at pos and event
-- reset_formspec(pos, code, errmsg): installs new code and prints error messages, without resetting LCID
-- reset_meta(pos, code, errmsg): performs a software-reset, installs new code and prints error message
-- run(pos, event): a wrapper for run_inner which gets code & handles errors via reset_meta
-- resetn(pos): performs a hardware reset, turns off all ports
--
-- The Sandbox
-- The whole code of the controller runs in a sandbox,
-- a very restricted environment.
-- Actually the only way to damage the server is to
-- use too much memory from the sandbox.
-- You can add more functions to the environment
-- (see where local env is defined)
-- Something nice to play is appending minetest.env to it.

local BASENAME = "pipeworks:lua_tube"

local rules = {
	red    = {x = -1, y =  0, z =  0, name = "red"},
	blue   = {x =  1, y =  0, z =  0, name = "blue"},
	yellow = {x =  0, y = -1, z =  0, name = "yellow"},
	green  = {x =  0, y =  1, z =  0, name = "green"},
	black  = {x =  0, y =  0, z = -1, name = "black"},
	white  = {x =  0, y =  0, z =  1, name = "white"},
}

local digiline_rules_luatube = {
	{x=0,  y=0,  z=-1},
	{x=1,  y=0,  z=0},
	{x=-1, y=0,  z=0},
	{x=0,  y=0,  z=1},
	{x=1,  y=1,  z=0},
	{x=1,  y=-1, z=0},
	{x=-1, y=1,  z=0},
	{x=-1, y=-1, z=0},
	{x=0,  y=1,  z=1},
	{x=0,  y=-1, z=1},
	{x=0,  y=1,  z=-1},
	{x=0,  y=-1, z=-1},
	-- vertical connectivity
	{x=0,  y=1,  z=0},
	{x=0,  y=-1, z=0},
}

------------------
-- Action stuff --
------------------
-- These helpers are required to set the port states of the lua_tube

local function update_real_port_states(pos, rule_name, new_state)
	local meta = minetest.get_meta(pos)
	if rule_name == nil then
		meta:set_int("real_portstates", 1)
		return
	end
	local n = meta:get_int("real_portstates") - 1
	local L = {}
	for i = 1, 6 do
		L[i] = n % 2
		n = math.floor(n / 2)
	end
	--                  (0,0,-1) (0,-1,0) (-1,0,0)      (1,0,0) (0,1,0) (0,0,1)
	local pos_to_side = {  5,        3,       1,   nil,    2,      4,      6  }
	if rule_name.x == nil then
		for _, rname in ipairs(rule_name) do
			local port = pos_to_side[rname.x + (2 * rname.y) + (3 * rname.z) + 4]
			L[port] = (new_state == "on") and 1 or 0
		end
	else
		local port = pos_to_side[rule_name.x + (2 * rule_name.y) + (3 * rule_name.z) + 4]
		L[port] = (new_state == "on") and 1 or 0
	end
	meta:set_int("real_portstates",
		 1 +
		 1 * L[1] +
		 2 * L[2] +
		 4 * L[3] +
		 8 * L[4] +
		16 * L[5] +
		32 * L[6])
end


local port_names = {"red", "blue", "yellow", "green", "black", "white"}

local function get_real_port_states(pos)
	-- Determine if ports are powered (by itself or from outside)
	local meta = minetest.get_meta(pos)
	local L = {}
	local n = meta:get_int("real_portstates") - 1
	for _, name in ipairs(port_names) do
		L[name] = ((n % 2) == 1)
		n = math.floor(n / 2)
	end
	return L
end


local function merge_port_states(ports, vports)
	return {
		red    = ports.red    or vports.red,
		blue   = ports.blue   or vports.blue,
		yellow = ports.yellow or vports.yellow,
		green  = ports.green  or vports.green,
		black  = ports.black  or vports.black,
		white  = ports.white  or vports.white,
	}
end

local function generate_name(ports)
	local red    = ports.red    and 1 or 0
	local blue   = ports.blue   and 1 or 0
	local yellow = ports.yellow and 1 or 0
	local green  = ports.green  and 1 or 0
	local black  = ports.black  and 1 or 0
	local white  = ports.white  and 1 or 0
	return BASENAME..white..black..green..yellow..blue..red
end


local function set_port(pos, rule, state)
	if state then
		mesecon.receptor_on(pos, {rule})
	else
		mesecon.receptor_off(pos, {rule})
	end
end


local function clean_port_states(ports)
	ports.red    = ports.red    and true or false
	ports.blue   = ports.blue   and true or false
	ports.yellow = ports.yellow and true or false
	ports.green  = ports.green  and true or false
	ports.black  = ports.black  and true or false
	ports.white  = ports.white  and true or false
end


local function set_port_states(pos, ports)
	local node = minetest.get_node(pos)
	local name = node.name
	clean_port_states(ports)
	local vports = minetest.registered_nodes[name].virtual_portstates
	local new_name = generate_name(ports)

	if name ~= new_name and vports then
		-- Problem:
		-- We need to place the new node first so that when turning
		-- off some port, it won't stay on because the rules indicate
		-- there is an onstate output port there.
		-- When turning the output off then, it will however cause feedback
		-- so that the lua_tube will receive an "off" event by turning
		-- its output off.
		-- Solution / Workaround:
		-- Remember which output was turned off and ignore next "off" event.
		local meta = minetest.get_meta(pos)
		local ign = minetest.deserialize(meta:get_string("ignore_offevents"), true) or {}
		if ports.red    and not vports.red    and not mesecon.is_powered(pos, rules.red)    then ign.red    = true end
		if ports.blue   and not vports.blue   and not mesecon.is_powered(pos, rules.blue)   then ign.blue   = true end
		if ports.yellow and not vports.yellow and not mesecon.is_powered(pos, rules.yellow) then ign.yellow = true end
		if ports.green  and not vports.green  and not mesecon.is_powered(pos, rules.green)  then ign.green  = true end
		if ports.black  and not vports.black  and not mesecon.is_powered(pos, rules.black)  then ign.black  = true end
		if ports.white  and not vports.white  and not mesecon.is_powered(pos, rules.white)  then ign.white  = true end
		meta:set_string("ignore_offevents", minetest.serialize(ign))

		minetest.swap_node(pos, {name = new_name, param2 = node.param2})

		if ports.red    ~= vports.red    then set_port(pos, rules.red,    ports.red)    end
		if ports.blue   ~= vports.blue   then set_port(pos, rules.blue,   ports.blue)   end
		if ports.yellow ~= vports.yellow then set_port(pos, rules.yellow, ports.yellow) end
		if ports.green  ~= vports.green  then set_port(pos, rules.green,  ports.green)  end
		if ports.black  ~= vports.black  then set_port(pos, rules.black,  ports.black)  end
		if ports.white  ~= vports.white  then set_port(pos, rules.white,  ports.white)  end
	end
end


-----------------
-- Overheating --
-----------------
local function burn_controller(pos)
	local node = minetest.get_node(pos)
	node.name = BASENAME.."_burnt"
	minetest.swap_node(pos, node)
	minetest.get_meta(pos):set_string("lc_memory", "");
	-- Wait for pending operations
	minetest.after(0.2, mesecon.receptor_off, pos, mesecon.rules.flat)
end

local function overheat(pos, meta)
	if mesecon.do_overheat(pos) then -- If too hot
		burn_controller(pos)
		return true
	end
end

------------------------
-- Ignored off events --
------------------------

local function ignore_event(event, meta)
	if event.type ~= "off" then return false end
	local ignore_offevents = minetest.deserialize(meta:get_string("ignore_offevents"), true) or {}
	if ignore_offevents[event.pin.name] then
		ignore_offevents[event.pin.name] = nil
		meta:set_string("ignore_offevents", minetest.serialize(ignore_offevents))
		return true
	end
end

-------------------------
-- Parsing and running --
-------------------------

local function safe_print(param)
	if (minetest.settings:get("pipeworks_lua_tube_print_behavior") or "log") == "log" then
		local string_meta = getmetatable("")
		local sandbox = string_meta.__index
		string_meta.__index = string -- Leave string sandbox temporarily
		minetest.log("action", string.format("[pipeworks.tubes.lua] print(%s)", dump(param)))
		string_meta.__index = sandbox -- Restore string sandbox
	end
end

local function safe_date()
	return(os.date("*t",os.time()))
end

-- string.rep(str, n) with a high value for n can be used to DoS
-- the server. Therefore, limit max. length of generated string.
local function safe_string_rep(str, n)
	if #str * n > mesecon.setting("luacontroller_string_rep_max", 64000) then
		debug.sethook() -- Clear hook
		error("string.rep: string length overflow", 2)
	end

	return string.rep(str, n)
end

-- string.find with a pattern can be used to DoS the server.
-- Therefore, limit string.find to patternless matching.
local function safe_string_find(...)
	if (select(4, ...)) ~= true then
		debug.sethook() -- Clear hook
		error("string.find: 'plain' (fourth parameter) must always be true in a lua controlled tube")
	end

	return string.find(...)
end

local function remove_functions(x)
	local tp = type(x)
	if tp == "function" then
		return nil
	end

	-- Make sure to not serialize the same table multiple times, otherwise
	-- writing mem.test = mem in the lua controlled tube will lead to infinite recursion
	local seen = {}

	local function rfuncs(x)
		if x == nil then return end
		if seen[x] then return end
		seen[x] = true
		if type(x) ~= "table" then return end

		for key, value in pairs(x) do
			if type(key) == "function" or type(value) == "function" then
				x[key] = nil
			else
				if type(key) == "table" then
					rfuncs(key)
				end
				if type(value) == "table" then
					rfuncs(value)
				end
			end
		end
	end

	rfuncs(x)

	return x
end

-- The setting affects API so is not intended to be changeable at runtime
local get_interrupt
if mesecon.setting("luacontroller_lightweight_interrupts", false) then
	-- use node timer
	get_interrupt = function(pos, itbl, send_warning)
		return (function(time, iid)
			if type(time) ~= "number" then error("Delay must be a number") end
			if iid ~= nil then send_warning("Interrupt IDs are disabled on this server") end
			table.insert(itbl, function() minetest.get_node_timer(pos):start(time) end)
		end)
	end
else
	-- use global action queue
	-- itbl: Flat table of functions to run after sandbox cleanup, used to prevent various security hazards
	get_interrupt = function(pos, itbl, send_warning)
		-- iid = interrupt id
		local function interrupt(time, iid)
			-- NOTE: This runs within string metatable sandbox, so don't *rely* on anything of the form (""):y
			-- Hence the values get moved out. Should take less time than original, so totally compatible
			if type(time) ~= "number" then error("Delay must be a number") end
			table.insert(itbl, function ()
				-- Outside string metatable sandbox, can safely run this now
				local luac_id = minetest.get_meta(pos):get_int("luac_id")
				-- Check if IID is dodgy, so you can't use interrupts to store an infinite amount of data.
				-- Note that this is safe from alter-after-free because this code gets run after the sandbox has ended.
				-- This runs outside of the timer and *shouldn't* harm perf. unless dodgy data is being sent in the first place
				iid = remove_functions(iid)
				local msg_ser = minetest.serialize(iid)
				if #msg_ser <= mesecon.setting("luacontroller_interruptid_maxlen", 256) then
					mesecon.queue:add_action(pos, "pipeworks:lc_tube_interrupt", {luac_id, iid}, time, iid, 1)
				else
					send_warning("An interrupt ID was too large!")
				end
			end)
		end
		return interrupt
	end
end

-- Given a message object passed to digiline_send, clean it up into a form
-- which is safe to transmit over the network and compute its "cost" (a very
-- rough estimate of its memory usage).
--
-- The cleaning comprises the following:
-- 1. Functions (and userdata, though user scripts ought not to get hold of
--    those in the first place) are removed, because they break the model of
--    Digilines as a network that carries basic data, and they could exfiltrate
--    references to mutable objects from one Luacontroller to another, allowing
--    inappropriate high-bandwidth, no-wires communication.
-- 2. Tables are duplicated because, being mutable, they could otherwise be
--    modified after the send is complete in order to change what data arrives
--    at the recipient, perhaps in violation of the previous cleaning rule or
--    in violation of the message size limit.
--
-- The cost indication is only approximate; it’s not a perfect measurement of
-- the number of bytes of memory used by the message object.
--
-- Parameters:
-- msg -- the message to clean
-- back_references -- for internal use only; do not provide
--
-- Returns:
-- 1. The cleaned object.
-- 2. The approximate cost of the object.
local function clean_and_weigh_digiline_message(msg, back_references)
	local t = type(msg)
	if t == "string" then
		-- Strings are immutable so can be passed by reference, and cost their
		-- length plus the size of the Lua object header (24 bytes on a 64-bit
		-- platform) plus one byte for the NUL terminator.
		return msg, #msg + 25
	elseif t == "number" then
		-- Numbers are passed by value so need not be touched, and cost 8 bytes
		-- as all numbers in Lua are doubles. NaN values are removed.
		if msg ~= msg then
			return nil, 0
		end
		return msg, 8
	elseif t == "boolean" then
		-- Booleans are passed by value so need not be touched, and cost 1
		-- byte.
		return msg, 1
	elseif t == "table" then
		-- Tables are duplicated. Check if this table has been seen before
		-- (self-referential or shared table); if so, reuse the cleaned value
		-- of the previous occurrence, maintaining table topology and avoiding
		-- infinite recursion, and charge zero bytes for this as the object has
		-- already been counted.
		back_references = back_references or {}
		local bref = back_references[msg]
		if bref then
			return bref, 0
		end
		-- Construct a new table by cleaning all the keys and values and adding
		-- up their costs, plus 8 bytes as a rough estimate of table overhead.
		local cost = 8
		local ret = {}
		back_references[msg] = ret
		for k, v in pairs(msg) do
			local k_cost, v_cost
			k, k_cost = clean_and_weigh_digiline_message(k, back_references)
			v, v_cost = clean_and_weigh_digiline_message(v, back_references)
			if k ~= nil and v ~= nil then
				-- Only include an element if its key and value are of legal
				-- types.
				ret[k] = v
			end
			-- If we only counted the cost of a table element when we actually
			-- used it, we would be vulnerable to the following attack:
			-- 1. Construct a huge table (too large to pass the cost limit).
			-- 2. Insert it somewhere in a table, with a function as a key.
			-- 3. Insert it somewhere in another table, with a number as a key.
			-- 4. The first occurrence doesn’t pay the cost because functions
			--    are stripped and therefore the element is dropped.
			-- 5. The second occurrence doesn’t pay the cost because it’s in
			--    back_references.
			-- By counting the costs regardless of whether the objects will be
			-- included, we avoid this attack; it may overestimate the cost of
			-- some messages, but only those that won’t be delivered intact
			-- anyway because they contain illegal object types.
			cost = cost + k_cost + v_cost
		end
		return ret, cost
	else
		return nil, 0
	end
end


-- itbl: Flat table of functions to run after sandbox cleanup, used to prevent various security hazards
local function get_digiline_send(pos, itbl, send_warning)
	if not minetest.get_modpath("digilines") then return end
	local chan_maxlen = mesecon.setting("luacontroller_digiline_channel_maxlen", 256)
	local maxlen = mesecon.setting("luacontroller_digiline_maxlen", 50000)
	return function(channel, msg)
		-- NOTE: This runs within string metatable sandbox, so don't *rely* on anything of the form (""):y
		--        or via anything that could.
		-- Make sure channel is string, number or boolean
		if type(channel) == "string" then
			if #channel > chan_maxlen then
				send_warning("Channel string too long.")
				return false
			end
		elseif (type(channel) ~= "string" and type(channel) ~= "number" and type(channel) ~= "boolean") then
			send_warning("Channel must be string, number or boolean.")
			return false
		end

		local msg_cost
		msg, msg_cost = clean_and_weigh_digiline_message(msg)
		if msg == nil or msg_cost > maxlen then
			send_warning("Message was too complex, or contained invalid data.")
			return false
		end

		table.insert(itbl, function ()
			-- Runs outside of string metatable sandbox
			local luac_id = minetest.get_meta(pos):get_int("luac_id")
			mesecon.queue:add_action(pos, "pipeworks:lt_digiline_relay", {channel, luac_id, msg})
		end)
		return true
	end
end

local safe_globals = {
	-- Don't add pcall/xpcall unless willing to deal with the consequences (unless very careful, incredibly likely to allow killing server indirectly)
	"assert", "error", "ipairs", "next", "pairs", "select",
	"tonumber", "tostring", "type", "unpack", "_VERSION"
}

local function create_environment(pos, mem, event, itbl, send_warning)
	-- Make sure the tube hasn't broken.
	local vports = minetest.registered_nodes[minetest.get_node(pos).name].virtual_portstates
	if not vports then return {} end

	-- Gather variables for the environment
	local vports_copy = {}
	for k, v in pairs(vports) do vports_copy[k] = v end
	local rports = get_real_port_states(pos)

	-- Create new library tables on each call to prevent one Luacontroller
	-- from breaking a library and messing up other Luacontrollers.
	local env = {
		pin = merge_port_states(vports, rports),
		port = vports_copy,
		event = event,
		mem = mem,
		heat = mesecon.get_heat(pos),
		heat_max = mesecon.setting("overheat_max", 20),
		print = safe_print,
		interrupt = get_interrupt(pos, itbl, send_warning),
		digiline_send = get_digiline_send(pos, itbl, send_warning),
		string = {
			byte = string.byte,
			char = string.char,
			format = string.format,
			len = string.len,
			lower = string.lower,
			upper = string.upper,
			rep = safe_string_rep,
			reverse = string.reverse,
			sub = string.sub,
			find = safe_string_find,
		},
		math = {
			abs = math.abs,
			acos = math.acos,
			asin = math.asin,
			atan = math.atan,
			atan2 = math.atan2,
			ceil = math.ceil,
			cos = math.cos,
			cosh = math.cosh,
			deg = math.deg,
			exp = math.exp,
			floor = math.floor,
			fmod = math.fmod,
			frexp = math.frexp,
			huge = math.huge,
			ldexp = math.ldexp,
			log = math.log,
			log10 = math.log10,
			max = math.max,
			min = math.min,
			modf = math.modf,
			pi = math.pi,
			pow = math.pow,
			rad = math.rad,
			random = math.random,
			sin = math.sin,
			sinh = math.sinh,
			sqrt = math.sqrt,
			tan = math.tan,
			tanh = math.tanh,
		},
		table = {
			concat = table.concat,
			insert = table.insert,
			maxn = table.maxn,
			remove = table.remove,
			sort = table.sort,
		},
		os = {
			clock = os.clock,
			difftime = os.difftime,
			time = os.time,
			datetable = safe_date,
		},
	}
	env._G = env

	for _, name in pairs(safe_globals) do
		env[name] = _G[name]
	end

	return env
end


local function timeout()
	debug.sethook() -- Clear hook
	error("Code timed out!", 2)
end


local function create_sandbox(code, env)
	if code:byte(1) == 27 then
		return nil, "Binary code prohibited."
	end
	local f, msg = loadstring(code)
	if not f then return nil, msg end
	setfenv(f, env)

	-- Turn off JIT optimization for user code so that count
	-- events are generated when adding debug hooks
	if rawget(_G, "jit") then
		jit.off(f, true)
	end

	local maxevents = mesecon.setting("luacontroller_maxevents", 10000)
	return function(...)
		-- NOTE: This runs within string metatable sandbox, so the setting's been moved out for safety
		-- Use instruction counter to stop execution
		-- after luacontroller_maxevents
		debug.sethook(timeout, "", maxevents)
		local ok, ret = pcall(f, ...)
		debug.sethook()  -- Clear hook
		if not ok then error(ret, 0) end
		return ret
	end
end


local function load_memory(meta)
	return minetest.deserialize(meta:get_string("lc_memory"), true) or {}
end


local function save_memory(pos, meta, mem)
	local memstring = minetest.serialize(remove_functions(mem))
	local memsize_max = mesecon.setting("luacontroller_memsize", 100000)

	if (#memstring <= memsize_max) then
		meta:set_string("lc_memory", memstring)
		meta:mark_as_private("lc_memory")
	else
		minetest.log("info", "lua_tube memory overflow. "..memsize_max.." bytes available, "
				..#memstring.." required. Controller overheats.")
		burn_controller(pos)
	end
end

-- Returns success (boolean), errmsg (string), retval(any, return value of the user supplied code)
-- run (as opposed to run_inner) is responsible for setting up meta according to this output
local function run_inner(pos, code, event)
	local meta = minetest.get_meta(pos)
	-- Note: These return success, presumably to avoid changing LC ID.
	if overheat(pos) then return true, "", nil end
	if ignore_event(event, meta) then return true, "", nil end

	-- Load code & mem from meta
	local mem  = load_memory(meta)
	local code = meta:get_string("code")

	-- 'Last warning' label.
	local warning = ""
	local function send_warning(str)
		warning = "Warning: " .. str
	end

	-- Create environment
	local itbl = {}
	local env = create_environment(pos, mem, event, itbl, send_warning)

	-- Create the sandbox and execute code
	local f, msg = create_sandbox(code, env)
	if not f then return false, msg, nil end
	-- Start string true sandboxing
	local onetruestring = getmetatable("")
	-- If a string sandbox is already up yet inconsistent, something is very wrong
	assert(onetruestring.__index == string)
	onetruestring.__index = env.string
	local success, msg = pcall(f)
	onetruestring.__index = string
	-- End string true sandboxing
	if not success then return false, msg, nil end
	if type(env.port) ~= "table" then
		return false, "Ports set are invalid.", nil
	end

	-- Actually set the ports
	set_port_states(pos, env.port)

	-- Save memory. This may burn the luacontroller if a memory overflow occurs.
	save_memory(pos, meta, env.mem)

	-- Execute deferred tasks
	for _, v in ipairs(itbl) do
		local failure = v()
		if failure then
			return false, failure, nil
		end
	end
	return true, warning, msg
end

local function reset_formspec(meta, code, errmsg)
	meta:set_string("code", code)
	meta:mark_as_private("code")
	code = minetest.formspec_escape(code or "")
	errmsg = minetest.formspec_escape(tostring(errmsg or ""))
	meta:set_string("formspec", "size[12,10]"
		.."style_type[label,textarea;font=mono]"
		.."background[-0.2,-0.25;12.4,10.75;jeija_luac_background.png]"
		.."label[0.1,8.3;"..errmsg.."]"
		.."textarea[0.2,0.2;12.2,9.5;code;;"..code.."]"
		.."image_button[4.75,8.75;2.5,1;jeija_luac_runbutton.png;program;]"
		.."image_button_exit[11.72,-0.25;0.425,0.4;jeija_close_window.png;exit;]"
		)
end

local function reset_meta(pos, code, errmsg)
	local meta = minetest.get_meta(pos)
	reset_formspec(meta, code, errmsg)
	meta:set_int("luac_id", math.random(1, 65535))
end

-- Wraps run_inner with LC-reset-on-error
local function run(pos, event)
	local meta = minetest.get_meta(pos)
	local code = meta:get_string("code")
	local ok, errmsg, retval = run_inner(pos, code, event)
	if not ok then
		reset_meta(pos, code, errmsg)
	else
		reset_formspec(meta, code, errmsg)
	end
	return ok, errmsg, retval
end

local function reset(pos)
	set_port_states(pos, {red = false, blue = false, yellow = false,
		green = false, black = false, white = false})
end

local function node_timer(pos)
	if minetest.registered_nodes[minetest.get_node(pos).name].is_burnt then
		return false
	end
	run(pos, {type="interrupt"})
	return false
end

-----------------------
-- A.Queue callbacks --
-----------------------

mesecon.queue:add_function("pipeworks:lc_tube_interrupt", function (pos, luac_id, iid)
	-- There is no lua_tube anymore / it has been reprogrammed / replaced / burnt
	if (minetest.get_meta(pos):get_int("luac_id") ~= luac_id) then return end
	if (minetest.registered_nodes[minetest.get_node(pos).name].is_burnt) then return end
	run(pos, {type="interrupt", iid = iid})
end)

mesecon.queue:add_function("pipeworks:lt_digiline_relay", function (pos, channel, luac_id, msg)
	if not digiline then return end
	-- This check is only really necessary because in case of server crash, old actions can be thrown into the future
	if (minetest.get_meta(pos):get_int("luac_id") ~= luac_id) then return end
	if (minetest.registered_nodes[minetest.get_node(pos).name].is_burnt) then return end
	-- The actual work
	digiline:receptor_send(pos, digiline_rules_luatube, channel, msg)
end)

-----------------------
-- Node Registration --
-----------------------

local output_rules = {}
local input_rules = {}

local node_box = {
	type = "fixed",
	fixed = {
		pipeworks.tube_leftstub[1],   -- tube segment against -X face
		pipeworks.tube_rightstub[1],  -- tube segment against +X face
		pipeworks.tube_bottomstub[1], -- tube segment against -Y face
		pipeworks.tube_topstub[1],    -- tube segment against +Y face
		pipeworks.tube_frontstub[1],  -- tube segment against -Z face
		pipeworks.tube_backstub[1],   -- tube segment against +Z face
	}
}

local selection_box = {
	type = "fixed",
	fixed = pipeworks.tube_selectboxes,
}

local digiline = {
	receptor = {},
	effector = {
		action = function(pos, node, channel, msg)
			msg = clean_and_weigh_digiline_message(msg)
			run(pos, {type = "digiline", channel = channel, msg = msg})
		end
	},
	wire = {
		rules = pipeworks.digilines_rules
	},
}

local function get_program(pos)
	local meta = minetest.get_meta(pos)
	return meta:get_string("code")
end

local function set_program(pos, code)
	reset(pos)
	reset_meta(pos, code)
	return run(pos, {type="program"})
end

local function on_receive_fields(pos, form_name, fields, sender)
	if not fields.program then
		return
	end
	local name = sender:get_player_name()
	if minetest.is_protected(pos, name) and not minetest.check_player_privs(name, {protection_bypass=true}) then
		minetest.record_protection_violation(pos, name)
		return
	end
	local ok, err = set_program(pos, fields.code)
	if not ok then
		-- it's not an error from the server perspective
		minetest.log("action", "Lua controller programming error: " .. tostring(err))
	end
end

local function go_back(velocity)
	local adjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}}
	local speed = math.abs(velocity.x + velocity.y + velocity.z)
	if speed == 0 then
		speed = 1
	end
	local vel = {x = velocity.x/speed, y = velocity.y/speed, z = velocity.z/speed,speed=speed}
	if speed >= 4.1 then
		speed = 4
	elseif speed >= 1.1 then
		speed = speed - 0.1
	else
		speed = 1
	end
	vel.speed = speed
	return pipeworks.notvel(adjlist, vel)
end

local tiles_base = {
	"pipeworks_mese_tube_plain_4.png", "pipeworks_mese_tube_plain_3.png",
	"pipeworks_mese_tube_plain_2.png", "pipeworks_mese_tube_plain_1.png",
	"pipeworks_mese_tube_plain_6.png", "pipeworks_mese_tube_plain_5.png"}

local tiles_on_off = {
	R__0   = "^pipeworks_lua_tube_port_%s.png",
	R_90  = "^(pipeworks_lua_tube_port_%s.png^[transformR90)",
	R180 = "^(pipeworks_lua_tube_port_%s.png^[transformR180)",
	R270 = "^(pipeworks_lua_tube_port_%s.png^[transformR270)"
}

local texture_alpha_mode = minetest.features.use_texture_alpha_string_modes
	and "clip" or true

for red    = 0, 1 do -- 0 = off  1 = on
for blue   = 0, 1 do
for yellow = 0, 1 do
for green  = 0, 1 do
for black  = 0, 1 do
for white  = 0, 1 do
	local cid = white..black..green..yellow..blue..red
	local node_name = BASENAME..cid

	local tiles = table.copy(tiles_base)
	-- Red
	tiles[1] = tiles[1]..tiles_on_off.R_90:format(red == 1 and "on" or "off");
	tiles[2] = tiles[2]..tiles_on_off.R_90:format(red == 1 and "on" or "off");
	tiles[5] = tiles[5]..tiles_on_off.R270:format(red == 1 and "on" or "off");
	tiles[6] = tiles[6]..tiles_on_off.R_90:format(red == 1 and "on" or "off");
	-- Blue
	tiles[1] = tiles[1]..tiles_on_off.R270:format(blue == 1 and "on" or "off");
	tiles[2] = tiles[2]..tiles_on_off.R270:format(blue == 1 and "on" or "off");
	tiles[5] = tiles[5]..tiles_on_off.R_90:format(blue == 1 and "on" or "off");
	tiles[6] = tiles[6]..tiles_on_off.R270:format(blue == 1 and "on" or "off");
	-- Yellow
	tiles[1] = tiles[1]..tiles_on_off.R180:format(yellow == 1 and "on" or "off");
	tiles[2] = tiles[2]..tiles_on_off.R180:format(yellow == 1 and "on" or "off");
	tiles[5] = tiles[5]..tiles_on_off.R180:format(yellow == 1 and "on" or "off");
	tiles[6] = tiles[6]..tiles_on_off.R180:format(yellow == 1 and "on" or "off");
	-- Green
	tiles[3] = tiles[3]..tiles_on_off.R__0:format(green == 1 and "on" or "off");
	tiles[4] = tiles[4]..tiles_on_off.R__0:format(green == 1 and "on" or "off");
	tiles[5] = tiles[5]..tiles_on_off.R__0:format(green == 1 and "on" or "off");
	tiles[6] = tiles[6]..tiles_on_off.R__0:format(green == 1 and "on" or "off");
	-- Black
	tiles[1] = tiles[1]..tiles_on_off.R180:format(black == 1 and "on" or "off");
	tiles[2] = tiles[2]..tiles_on_off.R__0:format(black == 1 and "on" or "off");
	tiles[3] = tiles[3]..tiles_on_off.R_90:format(black == 1 and "on" or "off");
	tiles[4] = tiles[4]..tiles_on_off.R270:format(black == 1 and "on" or "off");
	-- White
	tiles[1] = tiles[1]..tiles_on_off.R__0:format(white == 1 and "on" or "off");
	tiles[2] = tiles[2]..tiles_on_off.R180:format(white == 1 and "on" or "off");
	tiles[3] = tiles[3]..tiles_on_off.R270:format(white == 1 and "on" or "off");
	tiles[4] = tiles[4]..tiles_on_off.R_90:format(white == 1 and "on" or "off");

	local groups = {snappy = 3, tube = 1, tubedevice = 1, overheat = 1, dig_generic = 4, axey=1, handy=1, pickaxey=1}
	if red + blue + yellow + green + black + white ~= 0 then
		groups.not_in_creative_inventory = 1
	end

	output_rules[cid] = {}
	input_rules[cid] = {}
	if red    == 1 then table.insert(output_rules[cid], rules.red)    end
	if blue   == 1 then table.insert(output_rules[cid], rules.blue)   end
	if yellow == 1 then table.insert(output_rules[cid], rules.yellow) end
	if green  == 1 then table.insert(output_rules[cid], rules.green)  end
	if black  == 1 then table.insert(output_rules[cid], rules.black)  end
	if white  == 1 then table.insert(output_rules[cid], rules.white)  end

	if red    == 0 then table.insert( input_rules[cid], rules.red)    end
	if blue   == 0 then table.insert( input_rules[cid], rules.blue)   end
	if yellow == 0 then table.insert( input_rules[cid], rules.yellow) end
	if green  == 0 then table.insert( input_rules[cid], rules.green)  end
	if black  == 0 then table.insert( input_rules[cid], rules.black)  end
	if white  == 0 then table.insert( input_rules[cid], rules.white)  end

	local mesecons = {
		effector = {
			rules = input_rules[cid],
			action_change = function (pos, _, rule_name, new_state)
				update_real_port_states(pos, rule_name, new_state)
				run(pos, {type=new_state, pin=rule_name})
			end,
		},
		receptor = {
			state = mesecon.state.on,
			rules = output_rules[cid]
		},
		luacontroller = {
			get_program = get_program,
			set_program = set_program,
		},
	}

	minetest.register_node(node_name, {
		description = "Lua controlled Tube",
		drawtype = "nodebox",
		tiles = tiles,
		use_texture_alpha = texture_alpha_mode,
		paramtype = "light",
		is_ground_content = false,
		groups = groups,
		_mcl_hardness=0.8,
		drop = BASENAME.."000000",
		sunlight_propagates = true,
		selection_box = selection_box,
		node_box = node_box,
		on_construct = reset_meta,
		on_receive_fields = on_receive_fields,
		_sound_def = {
			key = "node_sound_wood_defaults",
		},
		mesecons = mesecons,
		digiline = digiline,
		-- Virtual portstates are the ports that
		-- the node shows as powered up (light up).
		virtual_portstates = {
			red    = red    == 1,
			blue   = blue   == 1,
			yellow = yellow == 1,
			green  = green  == 1,
			black  = black  == 1,
			white  = white  == 1,
		},
		after_dig_node = function(pos, node)
			mesecon.do_cooldown(pos)
			mesecon.receptor_off(pos, output_rules)
			pipeworks.after_dig(pos, node)
		end,
		is_luacontroller = true,
		on_timer = node_timer,
		tubelike = 1,
		tube = {
			connect_sides = {front = 1, back = 1, left = 1, right = 1, top = 1, bottom = 1},
			priority = 50,
			can_go = function(pos, node, velocity, stack, tags)
				local src = {name = nil}
				-- add color of the incoming tube explicitly; referring to rules, in case they change later
				for _, rule in pairs(rules) do
					if (-velocity.x == rule.x and -velocity.y == rule.y and -velocity.z == rule.z) then
						src.name = rule.name
						break
					end
				end
				local succ, _, msg = run(pos, {
					type = "item",
					pin = src,
					itemstring = stack:to_string(),
					item = stack:to_table(),
					velocity = velocity,
					tags = table.copy(tags),
					side = src.name,
				})
				if not succ then
					return go_back(velocity)
				end
				if type(msg) == "string" then
					local side = rules[msg]
					return side and {side} or go_back(velocity)
				elseif type(msg) == "table" then
					if pipeworks.enable_item_tags then
						local new_tags
						if type(msg.tags) == "table" or type(msg.tags) == "string" then
							new_tags = pipeworks.sanitize_tags(msg.tags)
						elseif type(msg.tag) == "string" then
							new_tags = pipeworks.sanitize_tags({msg.tag})
						end
						if new_tags then
							for i=1, math.max(#tags, #new_tags) do
								tags[i] = new_tags[i]
							end
						end
					end
					local side = rules[msg.side]
					return side and {side} or go_back(velocity)
				end
				return go_back(velocity)
			end,
		},
		after_place_node = pipeworks.after_place,
		on_blast = function(pos, intensity)
			if not intensity or intensity > 1 + 3^0.5 then
				minetest.remove_node(pos)
				return
			end
			minetest.swap_node(pos, {name = "pipeworks:broken_tube_1"})
			pipeworks.scan_for_tube_objects(pos)
		end,
	})
end
end
end
end
end
end

pipeworks.ui_cat_tube_list[#pipeworks.ui_cat_tube_list+1] = BASENAME.."000000"

------------------------------------
-- Overheated Lua controlled Tube --
------------------------------------

local tiles_burnt = table.copy(tiles_base)
tiles_burnt[1] = tiles_burnt[1].."^(pipeworks_lua_tube_port_burnt.png^[transformR90)"
tiles_burnt[2] = tiles_burnt[2].."^(pipeworks_lua_tube_port_burnt.png^[transformR90)"
tiles_burnt[5] = tiles_burnt[5].."^(pipeworks_lua_tube_port_burnt.png^[transformR270)"
tiles_burnt[6] = tiles_burnt[6].."^(pipeworks_lua_tube_port_burnt.png^[transformR90)"
tiles_burnt[1] = tiles_burnt[1].."^(pipeworks_lua_tube_port_burnt.png^[transformR270)"
tiles_burnt[2] = tiles_burnt[2].."^(pipeworks_lua_tube_port_burnt.png^[transformR270)"
tiles_burnt[5] = tiles_burnt[5].."^(pipeworks_lua_tube_port_burnt.png^[transformR90)"
tiles_burnt[6] = tiles_burnt[6].."^(pipeworks_lua_tube_port_burnt.png^[transformR270)"
tiles_burnt[3] = tiles_burnt[3].."^(pipeworks_lua_tube_port_burnt.png^[transformR180)"
tiles_burnt[4] = tiles_burnt[4].."^(pipeworks_lua_tube_port_burnt.png^[transformR180)"
tiles_burnt[5] = tiles_burnt[5].."^(pipeworks_lua_tube_port_burnt.png^[transformR180)"
tiles_burnt[6] = tiles_burnt[6].."^(pipeworks_lua_tube_port_burnt.png^[transformR180)"
tiles_burnt[3] = tiles_burnt[3].."^pipeworks_lua_tube_port_burnt.png"
tiles_burnt[4] = tiles_burnt[4].."^pipeworks_lua_tube_port_burnt.png"
tiles_burnt[5] = tiles_burnt[5].."^pipeworks_lua_tube_port_burnt.png"
tiles_burnt[6] = tiles_burnt[6].."^pipeworks_lua_tube_port_burnt.png"
tiles_burnt[1] = tiles_burnt[1].."^(pipeworks_lua_tube_port_burnt.png^[transformR180)"
tiles_burnt[2] = tiles_burnt[2].."^pipeworks_lua_tube_port_burnt.png"
tiles_burnt[3] = tiles_burnt[3].."^(pipeworks_lua_tube_port_burnt.png^[transformR90)"
tiles_burnt[4] = tiles_burnt[4].."^(pipeworks_lua_tube_port_burnt.png^[transformR270)"
tiles_burnt[1] = tiles_burnt[1].."^pipeworks_lua_tube_port_burnt.png"
tiles_burnt[2] = tiles_burnt[2].."^(pipeworks_lua_tube_port_burnt.png^[transformR180)"
tiles_burnt[3] = tiles_burnt[3].."^(pipeworks_lua_tube_port_burnt.png^[transformR270)"
tiles_burnt[4] = tiles_burnt[4].."^(pipeworks_lua_tube_port_burnt.png^[transformR90)"

minetest.register_node(BASENAME .. "_burnt", {
	drawtype = "nodebox",
	tiles = tiles_burnt,
	use_texture_alpha = texture_alpha_mode,
	is_burnt = true,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, tube = 1, tubedevice = 1, not_in_creative_inventory=1, dig_generic = 4, axey=1, handy=1, pickaxey=1},
	_mcl_hardness=0.8,
	drop = BASENAME.."000000",
	sunlight_propagates = true,
	selection_box = selection_box,
	node_box = node_box,
	on_construct = reset_meta,
	on_receive_fields = on_receive_fields,
	_sound_def = {
        key = "node_sound_wood_defaults",
    },
	virtual_portstates = {red = false, blue = false, yellow = false,
		green = false, black = false, white = false},
	mesecons = {
		effector = {
			rules = mesecon.rules.alldirs,
			action_change = function(pos, _, rule_name, new_state)
				update_real_port_states(pos, rule_name, new_state)
			end,
		},
	},
	tubelike = 1,
	tube = {
		connect_sides = {front = 1, back = 1, left = 1, right = 1, top = 1, bottom = 1},
		priority = 50,
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_blast = function(pos, intensity)
		if not intensity or intensity > 1 + 3^0.5 then
			minetest.remove_node(pos)
			return
		end
		minetest.swap_node(pos, {name = "pipeworks:broken_tube_1"})
		pipeworks.scan_for_tube_objects(pos)
	end,
})

------------------------
-- Craft Registration --
------------------------

minetest.register_craft({
	type = "shapeless",
	output = BASENAME.."000000",
	recipe = {"pipeworks:mese_tube_000000", "mesecons_luacontroller:luacontroller0000"},
})
