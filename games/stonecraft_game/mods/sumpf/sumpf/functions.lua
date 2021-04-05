if sumpf.log_level > 0 then
	function sumpf.inform(msg, spam, t)
		if spam <= sumpf.log_level then
			local info
			if t then
				info = "[sumpf] " .. msg .. (" after ca. %.3g s"):format(
					(minetest.get_us_time() - t) / 1000000)
			else
				info = "[sumpf] "..msg
			end
			minetest.log("info", info)
			if sumpf.log_to_chat then
				minetest.chat_send_all(info)
			end
		end
	end
else
	function sumpf.inform()
	end
end

function sumpf.tree_allowed(pos, minlight)
	local light = minetest.get_node_light(pos)
	if minetest.get_item_group(
		minetest.get_node{x=pos.x, y=pos.y-1, z=pos.z}.name, "soil") ~= 1
	or not light then
		return false
	end
	if light < minlight then
		return false
	end
	return true
end
