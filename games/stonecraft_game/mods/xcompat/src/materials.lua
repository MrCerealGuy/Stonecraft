local filename = xcompat.gameid

--if we dont have a materials file for the game, use minetest
if not xcompat.utilities.file_exists(xcompat.modpath .. "/src/materials/" .. filename .. ".lua") then
    filename = "minetest"
end

return dofile(xcompat.modpath .. "/src/materials/" .. filename .. ".lua")
