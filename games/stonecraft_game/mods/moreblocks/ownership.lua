--[[
More Blocks: ownership handling

Copyright © 2011-2019 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

--[[

2018-08-21 added intllib support

--]]

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

function moreblocks.node_is_owned(pos, placer)
	local ownername = false
	if type(IsPlayerNodeOwner) == "function" then					-- node_ownership mod
		if HasOwner(pos, placer) then						-- returns true if the node is owned
			if not IsPlayerNodeOwner(pos, placer:get_player_name()) then
				if type(getLastOwner) == "function" then		-- ...is an old version
					ownername = getLastOwner(pos)
				elseif type(GetNodeOwnerName) == "function" then	-- ...is a recent version
					ownername = GetNodeOwnerName(pos)
				else
					ownername = S("someone")
				end
			end
		end

	elseif type(isprotect)=="function" then						-- glomie's protection mod
		if not isprotect(5, pos, placer) then
			ownername = S("someone")
		end
	elseif type(protector)=="table" and type(protector.can_dig)=="function" then					-- Zeg9's protection mod
		if not protector.can_dig(5, pos, placer) then
			ownername = S("someone")
		end
	end

	if ownername ~= false then
		minetest.chat_send_player( placer:get_player_name(), S("Sorry, @1 owns that spot.", ownername) )
		return true
	else
		return false
	end
end
