datastorage = {data = {}}

local DIR_DELIM = DIR_DELIM or "/"
local data_path = minetest.get_worldpath()..DIR_DELIM.."datastorage"..DIR_DELIM

function datastorage.save(id)
	local data = datastorage.data[id]
	-- Check if the container is empty
	if not data or not next(data) then return end
	for _, sub_data in pairs(data) do
		if not next(sub_data) then return end
	end

	local file = io.open(data_path..id, "w")
	if not file then
		-- Most likely the data directory doesn't exist, create it
		-- and try again.
		if minetest.mkdir then
			minetest.mkdir(data_path)
		else
			-- Using os.execute like this is not very platform
			-- independent or safe, but most platforms name their
			-- directory creation utility mkdir, the data path is
			-- unlikely to contain special characters, and the
			-- data path is only mutable by the admin.
			os.execute('mkdir "'..data_path..'"')
		end
		file = io.open(data_path..id, "w")
		if not file then return end
	end

	local datastr = minetest.serialize(data)
	if not datastr then return end

	file:write(datastr)
	file:close()
	return true
end

function datastorage.load(id)
	local file = io.open(data_path..id, "r")
	if not file then return end

	local data = minetest.deserialize(file:read("*all"))
	datastorage.data[id] = data

	file:close()
	return data
end

-- Compatability
function datastorage.get_container(player, id)
	return datastorage.get(player:get_player_name(), id)
end

-- Retrieves a value from the data storage
function datastorage.get(id, ...)
	local last = datastorage.data[id]
	if last == nil then last = datastorage.load(id) end
	if last == nil then
		last = {}
		datastorage.data[id] = last
	end
	local cur = last
	for _, sub_id in ipairs({...}) do
		last = cur
		cur = cur[sub_id]
		if cur == nil then
			cur = {}
			last[sub_id] = cur
		end
	end
	return cur
end

-- Saves a container and reomves it from memory
function datastorage.finish(id)
	datastorage.save(id)
	datastorage.data[id] = nil
end

-- Compatability
function datastorage.save_container(player)
	return datastorage.save(player:get_player_name())
end

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	datastorage.save(player_name)
	datastorage.data[player_name] = nil
end)

minetest.register_on_shutdown(function()
	for id in pairs(datastorage.data) do
		datastorage.save(id)
	end
end)

