if sumpf.info then
	function sumpf.inform(msg, spam, t)
		if spam <= sumpf.max_spam then
			local info
			if t then
				info = string.format("[sumpf] "..msg.." after ca. %.2fs", os.clock() - t)
			else
				info = "[sumpf] "..msg
			end
			minetest.log("info", info)
			if sumpf.inform_all then
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
	if minetest.get_item_group(minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name, "soil") ~= 1
	or not light then
		return false
	end
	if light < minlight then
		return false
	end
	return true
end
