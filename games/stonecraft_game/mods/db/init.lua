--This is a Libary for minetest mods
--author: addi <addi at king-arhtur dot eu>
--for doku see : https://project.king-arthur.eu/projects/db/wiki
--license: LGPL v3
local modpath= minetest.get_modpath("db");
dofile(modpath.."/playerDB.lua")
DB = {}
DB.__index = DB
setmetatable(DB, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})
function DB.new(strategies)
	local self = setmetatable({}, DB)
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
	print("new instance of DB created")
	return self
end

function DB:save()
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

function DB:load()
if self.strategies.fs then
	print("loading DB from file"..self.file)
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

function DB:set(key,value)
	assert(type(key) == "string","param 1 key must be a string!");
	assert(type(value) == "string" or type(value) == "number" or type(value) == "table" or type(value) == "boolean","param 2 default must be a string, number, table or a boolean value. Userdata,functions or nil is not alowed!")

	self.storage[key]=value;
	self:save();
	return true;
end


function DB:get(player,key,default)
	assert(type(key) == "string","param 1 key have to be a string!");
	assert(type(default) == "string" or type(default) == "number" or type(default) == "table" or type(default) == "boolean","param 2 default must be a string, number, table or a boolean value. Userdata,functions or nil is not alowed!")

	if self.storage[player] and self.storage[player][key] then
		return self.storage[player][key]	
	end
	
	print("nothing found, returning default")
			return default
end

function DB:getAll(default)
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
-------------------------------------------------------
