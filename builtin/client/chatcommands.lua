-- Minetest: builtin/client/chatcommands.lua


core.register_on_sending_chat_messages(function(message)
	if message:sub(1,2) == ".." then
		return false
	end

	local first_char = message:sub(1,1)
	if first_char == "/" or first_char == "." then
		core.display_chat_message(core.gettext("issued command: ") .. message)
	end

	if first_char ~= "." then
		return false
	end

	local cmd, param = string.match(message, "^%.([^ ]+) *(.*)")
 	param = param or ""

	if not cmd then
		core.display_chat_message(core.gettext("-!- Empty command"))
		return true
	end

	local cmd_def = core.registered_chatcommands[cmd]
	if cmd_def then
		core.set_last_run_mod(cmd_def.mod_origin)
		local _, message = cmd_def.func(param)
		if message then
			core.display_chat_message(message)
		end
	else
		core.display_chat_message(core.gettext("-!- Invalid command: ") .. cmd)
	end

	return true
end)

core.register_chatcommand("list_players", {
	description = core.gettext("List online players"),
	func = function(param)
		local players = table.concat(core.get_player_names(), ", ")
		core.display_chat_message(core.gettext("Online players: ") .. players)
	end
})

core.register_chatcommand("disconnect", {
	description = core.gettext("Exit to main menu"),
	func = function(param)
		core.disconnect()
	end,
})
