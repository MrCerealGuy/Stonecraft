local f = string.format

local node_tiles = minetest.settings:get_bool("wieldview_node_tiles")
if not node_tiles then
	node_tiles = false
	minetest.settings:set("wieldview_node_tiles", "false")
end

-- https://github.com/minetest/minetest/blob/9fc018ded10225589d2559d24a5db739e891fb31/doc/lua_api.txt#L453-L462
local function escape_texture(texturestring)
	-- store in a variable so we don't return both rvs of gsub
	local v = texturestring:gsub("%^", "\\^"):gsub(":", "\\:")
	return v
end

local function memoize(func)
	local memo = {}
	return function(arg)
		if arg == nil then
			return func(arg)
		end
		local rv = memo[arg]

		if not rv then
			rv = func(arg)
			memo[arg] = rv
		end

		return rv
	end
end

local function is_vertical_frames(animation)
	return (
		animation.type == "vertical_frames" and
		animation.aspect_w and
		animation.aspect_h
	)
end

local function get_single_frame(animation, image_name)
	return ("[combine:%ix%i^[noalpha^[colorize:#FFF:255^[mask:%s"):format(
		animation.aspect_w,
		animation.aspect_h,
		image_name
	)
end

local function is_sheet_2d(animation)
	return (
		animation.type == "sheet_2d" and
		animation.frames_w and
		animation.frames_h
	)
end

local function get_sheet_2d(animation, image_name)
	return ("%s^[sheet:%ix%i:0,0"):format(
		image_name,
		animation.frames_w,
		animation.frames_h
	)
end

local get_image_from_tile = memoize(function(tile)
	if type(tile) == "string" then
		return tile

	elseif type(tile) == "table" then
		local image_name

		if type(tile.image) == "string" then
			image_name = tile.image

		elseif type(tile.name) == "string" then
			image_name = tile.name

		end

		if image_name then
			local animation = tile.animation
			if animation then
				if is_vertical_frames(animation) then
					return get_single_frame(animation, image_name)

				elseif is_sheet_2d(animation) then
					return get_sheet_2d(animation, image_name)
				end
			end

			return image_name
		end
	end

	return "blank.png"
end)

local function get_image_cube(tiles)
	if #tiles >= 6 then
		return minetest.inventorycube(
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[6] or "no_texture.png"),
			get_image_from_tile(tiles[3] or "no_texture.png")
		)

	elseif #tiles == 5 then
		return minetest.inventorycube(
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[5] or "no_texture.png"),
			get_image_from_tile(tiles[3] or "no_texture.png")
		)

	elseif #tiles == 4 then
		return minetest.inventorycube(
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[4] or "no_texture.png"),
			get_image_from_tile(tiles[3] or "no_texture.png")
		)

	elseif #tiles == 3 then
		return minetest.inventorycube(
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[3] or "no_texture.png"),
			get_image_from_tile(tiles[3] or "no_texture.png")
		)

	elseif #tiles == 2 then
		return minetest.inventorycube(
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[2] or "no_texture.png"),
			get_image_from_tile(tiles[2] or "no_texture.png")
		)

	elseif #tiles == 1 then
		return minetest.inventorycube(
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[1] or "no_texture.png"),
			get_image_from_tile(tiles[1] or "no_texture.png")
		)
	end

	return "blank.png"
end

local function is_normal_node(drawtype)
	return (
		drawtype == "normal" or
		drawtype == "allfaces" or
		drawtype == "allfaces_optional" or
		drawtype == "glasslike" or
		drawtype == "glasslike_framed" or
		drawtype == "glasslike_framed_optional" or
		drawtype == "liquid"
	)
end

armor.get_wield_image = memoize(function(item)
	item = ItemStack(item)

	if item:is_empty() then
		return "blank.png"
	end

	local def = item:get_definition()
	if not def then
		return "unknown_item.png"
	end

	local meta = item:get_meta()
	local color = meta:get("color") or def.color

	local image = "blank.png"

	if def.wield_image and def.wield_image ~= "" then
		local parts = {def.wield_image}
		if color then
			parts[#parts + 1] = f("[colorize:%s:alpha", escape_texture(color))
		end
		if def.wield_overlay then
			parts[#parts + 1] = def.wield_overlay
		end
		image = table.concat(parts, "^")

	elseif def.inventory_image and def.inventory_image ~= "" then
		local parts = {def.inventory_image}
		if color then
			parts[#parts + 1] = f("[colorize:%s:alpha", escape_texture(color))
		end
		if def.inventory_overlay then
			parts[#parts + 1] = def.inventory_overlay
		end
		image = table.concat(parts, "^")

	elseif def.type == "node" then
		if def.drawtype == "nodebox" or def.drawtype == "mesh" then
			image = "blank.png"

		else
			local tiles = def.tiles
			if type(tiles) == "string" then
				image = get_image_from_tile(tiles)

			elseif type(tiles) == "table" then
				if is_normal_node(def.drawtype) and node_tiles then
					image = get_image_cube(tiles)

				else
					image = get_image_from_tile(tiles[1])
				end
			end
		end
	end

	return image
end)
