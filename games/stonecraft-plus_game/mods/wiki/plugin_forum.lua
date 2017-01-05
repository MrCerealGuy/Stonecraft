
local private = ...

local BASEPATH = wikilib.paths.plugins.."/ml"

private.mkdir(BASEPATH)

local ML_DB_FILE = BASEPATH.."/posts.dat"

local posts = { }

local function load_posts()
	local f = private.open(ML_DB_FILE, "r")
	if not f then return false end
	local list = { }
	local post = { text="" }
	for line in f:lines() do
		if line:len() == 0 then
			if post.who and post.date then
				table.insert(list, post)
				post = { text="" }
			end
		elseif line:sub(1, 5) == "From:" then
			post.who = line:sub(6):trim()
		elseif line:sub(1, 5) == "Date:" then
			post.date = line:sub(6):trim()
		else
			post.text = post.text..line.."\n"
		end
	end
	if post.who and post.date then
		table.insert(list, post)
		post = { text="" }
	end
	f:close()
	posts = list
	return true
end

local function save_posts()
	local f = private.open(ML_DB_FILE, "w")
	if not f then return false end
	for _, post in ipairs(posts) do
		f:write("From: "..post.who.."\n")
		f:write("Date: "..post.date.."\n")
		for _, line in ipairs(post.text:split("\n")) do
			if line:len() == 0 then
				f:write(" \n")
			elseif (line:sub(1, 5) == "From:")
			    or (line:sub(1, 5) == "Date:") then
				f:write(" "..line.."\n")
			else
				f:write(line.."\n")
			end
		end
		f:write("\n")
	end
	f:close()
	return true
end

local player_states = { }

local BACKLOG = 5

local function get_player_state(name)
	if not player_states[name] then
		player_states[name] = { }
	end
	return player_states[name]
end

local SEP = ("-"):rep(64)

wikilib.register_plugin({
	regex = "^/ml/.*",
	description = "Mailing List [/ml/recent]",
	load_page = function(entry, player) --> text, allow_save
		local state = get_player_state(player)
		local what = entry:match("^/ml/(.*)")
		if not what then
			what = "recent"
		end
		what = what:lower()
		if what == "recent" then
			local text = "Recent Posts:\n\n"..SEP.."\n"
			for i = #posts - BACKLOG, #posts do
				local p = posts[i]
				if p then
					local nl = ((p.text:sub(-1) == "\n") and "" or "\n")
					text = (text
						.. "[/ml/"..i.."] \n"
						.. "From: "..p.who.."\n"
						.. "Date: "..p.date.."\n"
						.. p.text..nl
						.. SEP.."\n"
					)
				end
			end
			text = text.."\n  * [/ml/Post] a new message"
			text = text.."\n  * Back to [Main]"
			return text, false
		elseif what:match("[0-9]+") then
			local n = tonumber(what)
			local text
			if posts[n] then
				local nl = ((posts[n].text:sub(-1) == "\n") and "" or "\n")
				text = ("Post #"..n.."\n"
					.. "From: "..posts[n].who.." [:"..posts[n].who..":profile]\n"
					.. "Date: "..posts[n].date.."\n"
					.. posts[n].text..nl
					.. "\n"
				)
			else
				text = "No such post.\n\n"
			end
			text = text.."\n  * [/ml/Post] a new message"
			text = text.."\n  * View [/ml/Recent] messages"
			text = text.."\n  * Back to [Main]"
			return text, false
		elseif what == "post" then
			return "Subject:\n\n<Edit this message and save to post>", true
		end
		return "Wrong request.", false
	end,
	save_page = function(entry, player, text) --> bool
		local state = get_player_state(player)
		local what = entry:match("^/ml/(.*)")
		if not what then
			what = "post"
		end
		what = what:lower()
		if what == "post" then
			posts[#posts + 1] = {
				who = player,
				date = os.date("%Y-%m-%d %H:%M:%S"),
				text = text,
			}
			save_posts()
			return "/ml/recent"
		end
		return true
	end,
})


load_posts()
