
-- Old multi-load method compatibility
if rawget(_G, "intllib") then return end

intllib = {
	getters = {},
	strings = {},
}


local MP = minetest.get_modpath("intllib")

dofile(MP.."/lib.lua")


local LANG = minetest.settings:get("language")
if not (LANG and (LANG ~= "")) then LANG = os.getenv("LANG") end
if not (LANG and (LANG ~= "")) then LANG = "en" end


local INS_CHAR = intllib.INSERTION_CHAR
local insertion_pattern = "("..INS_CHAR.."?)"..INS_CHAR.."(%(?)(%d+)(%)?)"

local function do_replacements(str, ...)
	local args = {...}
	-- Outer parens discard extra return values
	return (str:gsub(insertion_pattern, function(escape, open, num, close)
		if escape == "" then
			local replacement = tostring(args[tonumber(num)])
			if open == "" then
				replacement = replacement..close
			end
			return replacement
		else
			return INS_CHAR..open..num..close
		end
	end))
end

local function make_getter(msgstrs)
	return function(s, ...)
		local str
		if msgstrs then
			str = msgstrs[s]
		end
		if not str or str == "" then
			str = s
		end
		if select("#", ...) == 0 then
			return str
		end
		return do_replacements(str, ...)
	end
end


local function Getter(modname)
	modname = modname or minetest.get_current_modname()
	if not intllib.getters[modname] then
		local msgstr = intllib.get_strings(modname)
		intllib.getters[modname] = make_getter(msgstr)
	end
	return intllib.getters[modname]
end


function intllib.Getter(modname)
	local info = debug and debug.getinfo and debug.getinfo(2)
	local loc = info and info.short_src..":"..info.currentline
	minetest.log("deprecated", "intllib.Getter is deprecated."
			.." Please use intllib.make_gettext_pair instead."
			..(info and " (called from "..loc..")" or ""))
	return Getter(modname)
end


local strfind, strsub = string.find, string.sub
local langs

local function split(str, sep)
	local pos, endp = 1, #str+1
	return function()
		if (not pos) or pos > endp then return end
		local s, e = strfind(str, sep, pos, true)
		local part = strsub(str, pos, s and s-1)
		pos = e and e + 1
		return part
	end
end

function intllib.get_detected_languages()
	if langs then return langs end

	langs = { }

	local function addlang(l)
		local sep
		langs[#langs+1] = l
		sep = strfind(l, ".", 1, true)
		if sep then
			l = strsub(l, 1, sep-1)
			langs[#langs+1] = l
		end
		sep = strfind(l, "_", 1, true)
		if sep then
			langs[#langs+1] = strsub(l, 1, sep-1)
		end
	end

	local v

	v = minetest.settings:get("language")
	if v and v~="" then
		addlang(v)
	end

	v = os.getenv("LANGUAGE")
	if v then
		for item in split(v, ":") do
			langs[#langs+1] = item
		end
	end

	v = os.getenv("LANG")
	if v then
		addlang(v)
	end

	langs[#langs+1] = "en"

	return langs
end


local gettext = dofile(minetest.get_modpath("intllib").."/gettext.lua")


local function catgettext(catalogs, msgid)
	for _, cat in ipairs(catalogs) do
		local msgstr = cat and cat[msgid]
		if msgstr and msgstr~="" then
			local msg = msgstr[0]
			return msg~="" and msg or nil
		end
	end
end

local function catngettext(catalogs, msgid, msgid_plural, n)
	n = math.floor(n)
	for _, cat in ipairs(catalogs) do
		local msgstr = cat and cat[msgid]
		if msgstr then
			local index = cat.plural_index(n)
			local msg = msgstr[index]
			return msg~="" and msg or nil
		end
	end
	return n==1 and msgid or msgid_plural
end


local gettext_getters = { }
function intllib.make_gettext_pair(modname)
	modname = modname or minetest.get_current_modname()
	if gettext_getters[modname] then
		return unpack(gettext_getters[modname])
	end
	local localedir = minetest.get_modpath(modname).."/locale"
	local catalogs = gettext.load_catalogs(localedir)
	local getter = Getter(modname)
	local function gettext_func(msgid, ...)
		local msgstr = (catgettext(catalogs, msgid)
				or getter(msgid))
		return do_replacements(msgstr, ...)
	end
	local function ngettext_func(msgid, msgid_plural, n, ...)
		local msgstr = (catngettext(catalogs, msgid, msgid_plural, n)
				or getter(msgid))
		return do_replacements(msgstr, ...)
	end
	gettext_getters[modname] = { gettext_func, ngettext_func }
	return gettext_func, ngettext_func
end


local function get_locales(code)
	local ll, cc = code:match("^(..)_(..)")
	if ll then
		return { ll.."_"..cc, ll, ll~="en" and "en" or nil }
	else
		return { code, code~="en" and "en" or nil }
	end
end


function intllib.get_strings(modname, langcode)
	langcode = langcode or LANG
	modname = modname or minetest.get_current_modname()
	local msgstr = intllib.strings[modname]
	if not msgstr then
		local modpath = minetest.get_modpath(modname)
		msgstr = { }
		for _, l in ipairs(get_locales(langcode)) do
			local t = intllib.load_strings(modpath.."/locale/"..l..".txt") or { }
			for k, v in pairs(t) do
				msgstr[k] = msgstr[k] or v
			end
		end
		intllib.strings[modname] = msgstr
	end
	return msgstr
end

