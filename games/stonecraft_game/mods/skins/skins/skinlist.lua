skins.list = {}
skins.add = function(skin)
	table.insert(skins.list,skin)
end

local id

id = 1
while true do
	local f = io.open(minetest.get_modpath("skins").."/textures/player_"..id..".png")
	if (not f) then break end
	f:close()
	skins.add("player_"..id)
	id = id +1
end

id = 1
while true do
	local f = io.open(minetest.get_modpath("skins").."/textures/character_"..id..".png")
	if (not f) then break end
	f:close()
	skins.add("character_"..id)
	id = id +1
end

