
playerDB = {}
playerDB.__index = playerDB
setmetatable(playerDB, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})
function playerDB.new(strategies)
	local self = setmetatable({}, playerDB)
	if strategies == nil then
		print("WARNING: strategies is nil, so the database is only temporary aviable, and will deleted after shutdown")
	end
	self.strategies = strategies or {}
	if self.strategies.fs then
		print("safing database to filesystem")
		local dir ="";
		if self.strategies.fs.place == "world" then dir = minetest.get_worldpath() else dir = self.strategies.fs.place end
		self.file = dir.."/"..self.strategies.fs.name.."."..self.strategies.fs.form
	end
	if self.strategies.mysql then
		print("using existing mysql Table is currently not ready")
	end
	
	
	
	self.storage = {};
	self:load()
	print("new instance of playerDB created")
	return self
end

function playerDB:save()
	if self.strategies.fs then
		local output = io.open(self.file,'w')	
		if self.strategies.fs.form == "json" then
			output:write(minetest.write_json(self.storage,true));
		elseif self.strategies.fs.form == "minetest" then
			output:write(minetest.serialize(self.storage));
		end
		io.close(output)
	end
	if self.strategies.mysql then
		print("mysql is not ready currently")
	end
end

function playerDB:load()
if self.strategies.fs then
	print("loading playerDB from file"..self.file)
	local input = io.open(self.file, "r")
	local data = nil
	if input then
		data = input:read('*all')
	end
	if data and data ~= "" then
		if self.strategies.fs.form == "json" then
		local json = minetest.parse_json(data);
		self.storage = json or {}
		elseif self.strategies.fs.form == "minetest" then
		local serialize = minetest.deserialize(data);
		self.storage = serialize or {}
		end
		io.close(input)
	end
end
if self.strategies.mysql then
	print("mysql is not ready currently")
end
end

function playerDB:set(player,key,value)
print("db:set wurde aufgerufen")
	assert(type(player) == "string" or player:is_player(),"param 1 player must be the playername or a player object!");
	assert(type(key) == "string","param 2 key must be a string!");
	assert(type(value) == "string" or type(value) == "number" or type(value) == "table" or type(value) == "boolean","param 3 default must be a string, number, table or a boolean value. Userdata,functions or nil is not alowed!")
	if type(player) ~= "string" then
		player = player:get_player_name();
	end
	if not self.storage[player] then
	self.storage[player] = {};
	end
	self.storage[player][key]=value;
	self:save();
	return true;
end
function playerDB:del(player,key)
print("db:del wurde aufgerufen")
print(dump(key))
	assert(type(player) == "string" or player:is_player(),"param 1 player must be the playername or a player object!");
	assert(type(key) == "string","param 2 key must be a string!");
	if type(player) ~= "string" then
		player = player:get_player_name();
	end
	if not self.storage[player] then
	self.storage[player] = {};
	end
	self.storage[player][key]=nil;
	print("db:wurde geloescht")
	self:save();
	return true;
end

function playerDB:get(player,key,default)

--print("db:get wurde aufgerufen")
	assert(type(player) == "string" or player:is_player(),"param 1 player must be the playername or a player object!");
	assert(type(key) == "string","param 2 key have to be a string!");
	assert(type(default) == "string" or type(default) == "number" or type(default) == "table" or type(default) == "boolean","param 3 default must be a string, number, table or a boolean value. Userdata,functions or nil is not alowed!")
	if  type(player) ~= "string" then
		player = player:get_player_name();
	end

	if self.storage[player] and self.storage[player][key] then
		return self.storage[player][key]	
	end
	
	print("nothing found, returning default")
			return default
end

function playerDB:getAll(player,default)

--print("db:get wurde aufgerufen")
	assert(type(player) == "string" or player:is_player(),"param 1 player must be the playername or a player object!");
	assert(type(default) == "string" or type(default) == "number" or type(default) == "table" or type(default) == "boolean","param 3 default must be a string, number, table or a boolean value. Userdata,functions or nil is not alowed!")
	if  type(player) ~= "string" then
		player = player:get_player_name();
	end

	if self.storage[player] then
		return self.storage[player]	
	end
	
	print("nothing found, returning default")
			return default
end