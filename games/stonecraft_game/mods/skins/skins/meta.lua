skins.meta = {}
for _, i in ipairs(skins.list) do
	skins.meta[i] = {}
	local f = io.open(skins.modpath.."/meta/"..i..".txt")
	local data = nil
	if f then
		data = minetest.deserialize("return {"..f:read('*all').."}")
		f:close()
	end
	data = data or {}
	skins.meta[i].name = data.name or ""
	skins.meta[i].author = data.author or ""
	skins.meta[i].description = data.description or nil
	skins.meta[i].comment = data.comment or nil
end
