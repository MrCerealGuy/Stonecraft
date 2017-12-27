-- Helper functions for reading setting files

local CHAR_CLASSES = {
	SPACE = "[%s]",
	VARIABLE = "[%w_%-%.]",
	INTEGER = "[+-]?[%d]",
	FLOAT = "[+-]?[%d%.]",
	FLAGS = "[%w_%-%.,]",
}

local function flags_to_table(flags)
	return flags:gsub("%s+", ""):split(",", true) -- Remove all spaces and split
end

-- returns error message, or nil
function parse_setting_line(settings, line, read_all, base_level, allow_secure)
	-- comment
	local comment = line:match("^#" .. CHAR_CLASSES.SPACE .. "*(.*)$")
	if comment then
		if settings.current_comment == "" then
			settings.current_comment = comment
		else
			settings.current_comment = settings.current_comment .. "\n" .. comment
		end
		return
	end

	-- clear current_comment so only comments directly above a setting are bound to it
	-- but keep a local reference to it for variables in the current line
	local current_comment = settings.current_comment
	settings.current_comment = ""

	-- empty lines
	if line:match("^" .. CHAR_CLASSES.SPACE .. "*$") then
		return
	end

	-- category
	local stars, category = line:match("^%[([%*]*)([^%]]+)%]$")
	if category then
		table.insert(settings, {
			name = category,
			level = stars:len() + base_level,
			type = "category",
		})
		return
	end

	-- settings
	local first_part, name, readable_name, setting_type = line:match("^"
			-- this first capture group matches the whole first part,
			--  so we can later strip it from the rest of the line
			.. "("
				.. "([" .. CHAR_CLASSES.VARIABLE .. "+)" -- variable name
				.. CHAR_CLASSES.SPACE .. "*"
				.. "%(([^%)]*)%)"  -- readable name
				.. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.VARIABLE .. "+)" -- type
				.. CHAR_CLASSES.SPACE .. "*"
			.. ")")

	if not first_part then
		return "Invalid line"
	end

	if name:match("secure%.[.]*") and not allow_secure then
		return "Tried to add \"secure.\" setting"
	end

	if readable_name == "" then
		readable_name = nil
	end
	local remaining_line = line:sub(first_part:len() + 1)

	if setting_type == "int" then
		local default, min, max = remaining_line:match("^"
				-- first int is required, the last 2 are optional
				.. "(" .. CHAR_CLASSES.INTEGER .. "+)" .. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.INTEGER .. "*)" .. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.INTEGER .. "*)"
				.. "$")

		if not default or not tonumber(default) then
			return "Invalid integer setting"
		end

		min = tonumber(min)
		max = tonumber(max)
		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = "int",
			default = default,
			min = min,
			max = max,
			comment = current_comment,
		})
		return
	end

	if setting_type == "string"
			or setting_type == "key" or setting_type == "v3f" then
		local default = remaining_line:match("^(.*)$")

		if not default then
			return "Invalid string setting"
		end
		if setting_type == "key" and not read_all then
			-- ignore key type if read_all is false
			return
		end

		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = setting_type,
			default = default,
			comment = current_comment,
		})
		return
	end

	if setting_type == "noise_params_2d"
			or setting_type == "noise_params_3d" then
		local default = remaining_line:match("^(.*)$")

		if not default then
			return "Invalid string setting"
		end

		local values = {}
		local ti = 1
		local index = 1
		for line in default:gmatch("[+-]?[%d.-e]+") do -- All numeric characters
			index = default:find("[+-]?[%d.-e]+", index) + line:len()
			table.insert(values, line)
			ti = ti + 1
			if ti > 9 then
				break
			end
		end
		index = default:find("[^, ]", index)
		local flags = ""
		if index then
			flags = default:sub(index)
			default = default:sub(1, index - 3) -- Make sure no flags in single-line format
		end
		table.insert(values, flags)

		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = setting_type,
			default = default,
			default_table = {
				offset = values[1],
				scale = values[2],
				spread = {
					x = values[3],
					y = values[4],
					z = values[5]
				},
				seed = values[6],
				octaves = values[7],
				persistence = values[8],
				lacunarity = values[9],
				flags = values[10]
			},
			values = values,
			comment = current_comment,
			noise_params = true,
			flags = flags_to_table("defaults,eased,absvalue")
		})
		return
	end

	if setting_type == "bool" then
		if remaining_line ~= "false" and remaining_line ~= "true" then
			return "Invalid boolean setting"
		end

		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = "bool",
			default = remaining_line,
			comment = current_comment,
		})
		return
	end

	if setting_type == "float" then
		local default, min, max = remaining_line:match("^"
				-- first float is required, the last 2 are optional
				.. "(" .. CHAR_CLASSES.FLOAT .. "+)" .. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.FLOAT .. "*)" .. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.FLOAT .. "*)"
				.."$")

		if not default or not tonumber(default) then
			return "Invalid float setting"
		end

		min = tonumber(min)
		max = tonumber(max)
		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = "float",
			default = default,
			min = min,
			max = max,
			comment = current_comment,
		})
		return
	end

	if setting_type == "enum" then
		local default, values = remaining_line:match("^"
				-- first value (default) may be empty (i.e. is optional)
				.. "(" .. CHAR_CLASSES.VARIABLE .. "*)" .. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.FLAGS .. "+)"
				.. "$")

		if not default or values == "" then
			return "Invalid enum setting"
		end

		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = "enum",
			default = default,
			values = values:split(",", true),
			comment = current_comment,
		})
		return
	end

	if setting_type == "path" or setting_type == "filepath" then
		local default = remaining_line:match("^(.*)$")

		if not default then
			return "Invalid path setting"
		end

		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = setting_type,
			default = default,
			comment = current_comment,
		})
		return
	end

	if setting_type == "flags" then
		local default, possible = remaining_line:match("^"
				-- first value (default) may be empty (i.e. is optional)
				-- this is implemented by making the last value optional, and
				-- swapping them around if it turns out empty.
				.. "(" .. CHAR_CLASSES.FLAGS .. "+)" .. CHAR_CLASSES.SPACE .. "*"
				.. "(" .. CHAR_CLASSES.FLAGS .. "*)"
				.. "$")

		if not default or not possible then
			return "Invalid flags setting"
		end

		if possible == "" then
			possible = default
			default = ""
		end

		table.insert(settings, {
			name = name,
			readable_name = readable_name,
			type = "flags",
			default = default,
			possible = flags_to_table(possible),
			comment = current_comment,
		})
		return
	end

	return "Invalid setting type \"" .. setting_type .. "\""
end

function parse_single_file(file, filepath, read_all, result, base_level, allow_secure)
	-- store this helper variable in the table so it's easier to pass to parse_setting_line()
	result.current_comment = ""

	local line = file:read("*line")
	while line do
		local error_msg = parse_setting_line(result, line, read_all, base_level, allow_secure)
		if error_msg then
			core.log("error", error_msg .. " in " .. filepath .. " \"" .. line .. "\"")
		end
		line = file:read("*line")
	end

	result.current_comment = nil
end

-- read_all: whether to ignore certain setting types for GUI or not
-- parse_mods: whether to parse settingtypes.txt in mods and games
function parse_config_file(read_all, parse_mods, settingfilename)
	local builtin_path = core.get_builtin_path() .. DIR_DELIM .. settingfilename
	local file = io.open(builtin_path, "r")
	local settings = {}
	if not file then
		core.log("error", "Can't load " .. settingfilename)
		return settings
	end

	parse_single_file(file, builtin_path, read_all, settings, 0, true)

	file:close()

	if parse_mods then
		-- Parse games
		local games_category_initialized = false
		local index = 1
		local game = gamemgr.get_game(index)
		while game do
			local path = game.path .. DIR_DELIM .. settingfilename
			local file = io.open(path, "r")
			if file then
				if not games_category_initialized then
					local translation = fgettext_ne("Games"), -- not used, but needed for xgettext
					table.insert(settings, {
						name = "Games",
						level = 0,
						type = "category",
					})
					games_category_initialized = true
				end

				table.insert(settings, {
					name = game.name,
					level = 1,
					type = "category",
				})

				parse_single_file(file, path, read_all, settings, 2, false)

				file:close()
			end

			index = index + 1
			game = gamemgr.get_game(index)
		end

		-- Parse mods
		local mods_category_initialized = false
		local mods = {}
		get_mods(core.get_modpath(), mods)
		for _, mod in ipairs(mods) do
			local path = mod.path .. DIR_DELIM .. settingfilename
			local file = io.open(path, "r")
			if file then
				if not mods_category_initialized then
					local translation = fgettext_ne("Mods"), -- not used, but needed for xgettext
					table.insert(settings, {
						name = "Mods",
						level = 0,
						type = "category",
					})
					mods_category_initialized = true
				end

				table.insert(settings, {
					name = mod.name,
					level = 1,
					type = "category",
				})

				parse_single_file(file, path, read_all, settings, 2, false)

				file:close()
			end
		end
	end

	return settings
end

function get_current_value(setting)
	local value = core.settings:get(setting.name)
	if value == nil then
		value = setting.default
	end
	return value
end

local function get_current_np_group(setting)
	local value = core.settings:get_np_group(setting.name)
	local t = {}
	if value == nil then
		t = setting.values
	else
		table.insert(t, value.offset)
		table.insert(t, value.scale)
		table.insert(t, value.spread.x)
		table.insert(t, value.spread.y)
		table.insert(t, value.spread.z)
		table.insert(t, value.seed)
		table.insert(t, value.octaves)
		table.insert(t, value.persistence)
		table.insert(t, value.lacunarity)
		table.insert(t, value.flags)
	end
	return t
end

function get_current_np_group_as_string(setting)
	local value = core.settings:get_np_group(setting.name)
	local t
	if value == nil then
		t = setting.default
	else
		t = value.offset .. ", " ..
			value.scale .. ", (" ..
			value.spread.x .. ", " ..
			value.spread.y .. ", " ..
			value.spread.z .. "), " ..
			value.seed .. ", " ..
			value.octaves .. ", " ..
			value.persistence .. ", " ..
			value.lacunarity .. ", " ..
			value.flags
	end
	return t
end



