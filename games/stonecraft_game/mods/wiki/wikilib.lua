
local private = ...

local WP = minetest.get_worldpath().."/wiki"

wikilib.paths = { }
wikilib.paths.root = WP
wikilib.paths.pages = WP.."/pages"
wikilib.paths.plugins = WP.."/plugins"
wikilib.paths.users = WP.."/users"

local WIKI_FORMNAME = "wiki:wiki"

private.mkdir(WP)
private.mkdir(wikilib.paths.pages)
private.mkdir(wikilib.paths.plugins)
private.mkdir(wikilib.paths.users)

local function name_to_filename(name)

	name = name:gsub("[^A-Za-z0-9-]", function(c)
		if c == " " then
			return "_"
		else
			return ("%%%02X"):format(c:byte(1))
		end
	end)
	return name:lower()

end
wikilib.name_to_filename = name_to_filename

local function get_page_path(name, player) --> path, is_file, allow_save
	local path
	local allow_save = minetest.check_player_privs(player, {wiki=true})

	if name:sub(1, 1) == "." then
		local text = wikilib.internal_pages[name] or wikilib.internal_pages[".NotFound_Internal"]
		if type(text) == "function" then
			text = text(player)
		end
		return text, false, false
	elseif name:sub(1, 1) == ":" then
		if name:match("^:[0-9]?$") then
			local n = tonumber(name:sub(2,2)) or 0
			path = "users/"..player.."/page"..n
			private.mkdir(wikilib.paths.users.."/"..player)
		elseif name == ":profile" then
			path = "users/"..player.."/profile"
			private.mkdir(wikilib.paths.users.."/"..player)
		elseif name:match("^:.-:[0-9]$") then
			local user, n = name:match("^:(.-):([0-9])$")
			if user:find("..[/\\]") then
				return wikilib.internal_pages[".BadPageName"], false, false
			end
			if (n == "0") and (not minetest.check_player_privs(player, {wiki_admin=true})) then
				return wikilib.internal_pages[".Forbidden"], false, false
			end
			path = "users/"..user.."/page"..n
			private.mkdir(WP.."/users/"..user)
			allow_save = false
		elseif name:match("^:.-:profile$") then
			local user = name:match("^:(.-):.*$")
			if user:find("..[/\\]") then
				return wikilib.internal_pages[".BadPageName"], false, false
			end
			path = "users/"..user.."/profile"
			private.mkdir(WP.."/users/"..user)
			allow_save = false
		else
			return wikilib.internal_pages[".BadPageName"], false, false
		end
	else
		path = "pages/"..name_to_filename(name)
	end

	return WP.."/"..path, true, allow_save

end

local function find_links(lines) --> links
	local links = { }
	local links_n = 0
	for _,line in ipairs(lines) do
		for link in line:gmatch("%[(.-)%]") do
			links_n = links_n + 1
			links[links_n] = link
		end
	end
	return links
end

local function load_page(name, player) --> text, links, allow_save
	local text, allow_save = wikilib.plugin_handle_load(name, player)
	if text then
		return text, find_links(text:split("\n")), allow_save
	end
	local path, is_file, allow_save = get_page_path(name, player)
	local f
	if is_file then
		f = private.open(path)
		if not f then
			f = strfile.open(wikilib.internal_pages[".NotFound"])
		end
	else
		f = strfile.open(path)
	end
	local lines = { }
	local lines_n = 0
	for line in f:lines() do
		lines_n = lines_n + 1
		lines[lines_n] = line
	end
	f:close()
	local text = table.concat(lines, "\n")
	local links = find_links(lines)
	return text, links, allow_save
end

local function save_page(name, player, text)

	local ok = wikilib.plugin_handle_save(name, player, text)
	if ok then return ok end

	local path, is_file, allow_save = get_page_path(name, player)

	if (not is_file) or (not allow_save) then return end

	local f = private.open(path, "w")
	if not f then return end

	f:write(text)

	f:close()

end

local esc = minetest.formspec_escape

function wikilib.get_wiki_page_formspec(player, name)

	if name == "" then name = "Main" end

	local text, links, allow_save = load_page(name, player)

	local buttons, nbuttons = { }, 0
	local bx, by = 12, 1.1

	for i, link in ipairs(links) do
		if i%15 == 0 then
			bx = bx + 2
			by = 1.1
		end
		link = esc(link)
		nbuttons = nbuttons + 1
		buttons[nbuttons] = (("button[%f,%f;2.1,0.5;page_%s;%s]")
				:format(bx, by, link, link))
		by = by + 0.65
	end
	buttons = table.concat(buttons)

	local toolbar = (allow_save
			and "button[-.1,9.2;2.4,1;save;Save]"
			or "label[0,9;You are not authorized to edit this page.]")

	return ("size[16,10]"
		.. "label[-0.1,0;Page]"
		.. "field[1.5,0.1;13,1;page;;"..esc(name).."]"
		.. "button[14,0;1,0.5;go;Go]"
		.. "button_exit[15,0;1,0.5;close;X]"
		.. "textarea[0.2,1.1;12,9;text;"..esc(name)..";"..esc(text).."]"
		.. buttons
		.. toolbar
	)

end

function wikilib.show_wiki_page(player, name)
	local fs = wikilib.get_wiki_page_formspec(player, name)
	minetest.show_formspec(player, WIKI_FORMNAME, fs)
end

minetest.register_node("wiki:wiki", {
	description = "Wiki",
	tiles = {
		"default_wood.png", "default_wood.png",
		"[combine:16x16:0,0=default_bookshelf.png:0,0=wiki_wiki_front.png"
	},
	groups = { choppy=3, oddly_breakable_by_hand=2, flammable=3 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Wiki")
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		if clicker then
			wikilib.show_wiki_page(clicker:get_player_name(), "Main")
		end
	end,
})

minetest.register_privilege("wiki", {
	description = "Allow editing wiki pages in the global space",
	give_to_singleplayer = false,
})

minetest.register_privilege("wiki_admin", {
	description = "Allow editing wiki pages in any space",
	give_to_singleplayer = false,
})

local BS = "default:bookshelf"
local BSL = { BS, BS, BS }
minetest.register_craft({
	output = "wiki:wiki",
	recipe = { BSL, BSL, BSL },
})

function wikilib.handle_formspec(player, formname, fields)
	if (not formname) or (formname ~= WIKI_FORMNAME) then return end
	if fields.quit or fields.close then return end
	local plname = player:get_player_name()
	if fields.save then
		local r = save_page(fields.page, plname, fields.text)
		if type(r) == "string" then
			wikilib.show_wiki_page(plname, r)
		else
			wikilib.show_wiki_page(plname, fields.page)
		end
		return true
	elseif fields.go then
		wikilib.show_wiki_page(plname, fields.page)
		return true
	else
		for k in pairs(fields) do
			if type(k) == "string" then
				local name = k:match("^page_(.*)")
				if name then
					wikilib.show_wiki_page(plname, name)
					return true
				end
			end
		end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	wikilib.handle_formspec(player, formname, fields)
end)
