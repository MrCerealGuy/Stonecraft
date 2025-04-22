local game_alias = {
    mineclone2 = "mineclonia",
}

local game_modnames = {
    mineclonia = "mcl_core",
    farlands_reloaded = "fl_core",
    minetest = "default",
    hades = "hades_core",
    exile = "exile_env_sounds",
    ksurvive2 = "ks_metals",
}

local gameid = "xcompat_unknown_gameid"

if type(minetest.get_game_info) == "function" then
    gameid = minetest.get_game_info().id
else
    for game, modname in pairs(game_modnames) do
        if minetest.get_modpath(modname) then
            gameid = game
            break
        end
    end
end

--for games that are similar/derviatives of other games
if game_alias[gameid] then gameid = game_alias[gameid] end

--while minetest game derviates are not supported, we can still try to detect them
if minetest.get_modpath("default") then gameid = "minetest" end

return gameid