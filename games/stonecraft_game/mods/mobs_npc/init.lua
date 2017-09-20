if core.skip_mod("mobs_npc") then return end

local path = minetest.get_modpath("mobs_npc")

-- Intllib
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s, a, ...)
		if a == nil then
			return s
		end
		a = {a, ...}
		return s:gsub("(@?)@(%(?)(%d+)(%)?)",
			function(e, o, n, c)
				if e == ""then
					return a[tonumber(n)] .. (o == "" and c or "")
				else
					return "@" .. o .. n .. c
				end
			end)
	end
end
mobs.intllib = S

-- NPC
if core.get_mod_setting("enable_mobs_npc_npc") 		~= "false" then dofile(path .. "/npc.lua")	end -- TenPlus1
if core.get_mod_setting("enable_mobs_npc_trader") 	~= "false" then dofile(path .. "/trader.lua") end
if core.get_mod_setting("enable_mobs_npc_igor") 	~= "false" then dofile(path .. "/igor.lua")	end

dofile(path .. "/lucky_block.lua")

print (S("[MOD] Mobs Redo 'NPCs' loaded"))
