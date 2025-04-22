local filename = xcompat.gameid

--if we dont have a materials file for the game, use minetest
if not xcompat.utilities.file_exists(xcompat.modpath .. "/src/sounds/" .. filename .. ".lua") then
    filename = "xcompat_agnostic"
end

return dofile(xcompat.modpath .. "/src/sounds/" .. filename .. ".lua")