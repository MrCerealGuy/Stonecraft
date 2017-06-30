local MOD_NAME = minetest.get_current_modname();
local MOD_PATH = minetest.get_modpath(MOD_NAME);

local PlayerEnv = dofile(MOD_PATH.."/PlayerEnv.lua");

local playerEnvs = {};
minetest.register_on_leaveplayer(
   function(player)
      playerEnvs[player:get_player_name()] = nil;
   end);

local function runLuaCmd(playerName, paramStr)
   local cmdFunc, errMsg = loadstring(paramStr, "/lua command");
   if not cmdFunc then
      error(errMsg);
   end

   local playerEnv = playerEnvs[playerName];
   if not playerEnv then
      local player = minetest.get_player_by_name(playerName);
      playerEnv = PlayerEnv:new(player);
      playerEnvs[playerName] = playerEnv;
   end

   setfenv(cmdFunc, playerEnv);
   cmdFunc();
end

minetest.register_privilege(
   "lua",
   {
      description = "Allows use of the /lua chat command for debugging.",
      give_to_singleplayer = false
   });

minetest.register_chatcommand(
   "lua",
   {
      params = "<luaStatement>",
      description = "Executes a lua statement (chunk), for debugging.",
      privs = { lua = true },
      func =
         function(playerName, paramStr)
            local success, errMsg = pcall(runLuaCmd, playerName, paramStr);
            if not success then
               minetest.chat_send_player(playerName, "ERROR: "..errMsg);
            end
         end
   });

minetest.register_chatcommand(
   "luaclear",
   {
      params = "",
      description = "Clears all variables in your /lua player context",
      privs = { lua = true },
      func =
         function(playerName, paramStr)
            playerEnvs[playerName] = nil;
         end
   });
