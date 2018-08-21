local snow_nodes = {
	snow    = { "ice_brick", "snow_brick", "snow_cobble" },
	default = { "ice", "snowblock" }
}

if minetest.get_modpath("moreblocks") and
	 minetest.global_exists("stairsplus") then

	-- For users converting from MTG stairs to stairsplus, these nodes are aliased
	-- from the stairs namespace to their source mod.
	local was_in_stairs = {
		ice_brick   = true,
		snow_brick  = true,
		snow_cobble = true,
		ice = false,        -- moreblocks will take care of this one, and
		snowblock = false,  -- this one, because they are in the default namespace.
	}

	-- Some nodes were incorrectly placed into the snow namespace.  Alias these to
	-- their proper namespace (default).
	local was_in_snow = {
		ice_brick   = false,
		snow_brick  = false,
		snow_cobble = false,
		ice = true,
		snowblock = true,
	}

	-- Some nodes were incorrectly placed into the moreblocks namespace.  Alias
	-- these to their proper namespace (either snow or default).
	local was_in_moreblocks = {
		ice_brick   = false,
		snow_brick  = true,
		snow_cobble = true,
		ice = true,
		snowblock = true,
	}

	for mod, nodes in pairs(snow_nodes) do
		for _, name in pairs(nodes) do
			local nodename = mod .. ":" .. name
			local ndef = table.copy(minetest.registered_nodes[nodename])
			ndef.sunlight_propagates = true
			ndef.groups.melts = 2
			ndef.groups.icemaker = nil
			ndef.groups.cooks_into_ice = nil
			ndef.after_place_node = nil

			stairsplus:register_all(mod, name, nodename, ndef)

			if was_in_stairs[name] then
				minetest.register_alias("stairs:stair_" .. name, mod .. ":stair_" .. name)
				minetest.register_alias("stairs:slab_"  .. name, mod .. ":slab_"  .. name)
			end

			if was_in_snow[name] then
				minetest.register_alias("snow:stair_" .. name, mod .. ":stair_" .. name)
				minetest.register_alias("snow:slab_"  .. name, mod .. ":slab_"  .. name)
			end

			if was_in_moreblocks[name] then
				stairsplus:register_alias_all("moreblocks", name, mod, name)
			end
		end
	end

elseif minetest.global_exists("stairs") then -- simple stairs and slabs only
	for mod, nodes in pairs(snow_nodes) do
		for _, name in pairs(nodes) do
			local nodename   = mod .. ":" .. name
			local ndef = table.copy(minetest.registered_nodes[nodename])

			local desc_stair = ndef.description .. " Stair"
			local desc_slab  = ndef.description .. " Slab"
			local images = ndef.tiles
			local sounds = ndef.sounds

			local groups = ndef.groups
			groups.melts = 2
			groups.icemaker = nil
			groups.cooks_into_ice = nil

			stairs.register_stair_and_slab(name, nodename,
				groups, images, desc_stair, desc_slab, sounds)

			-- Add transparency if used (e.g. ice and ice_brick).
			minetest.override_item("stairs:stair_" .. name,
				{use_texture_alpha = ndef.use_texture_alpha})
			minetest.override_item("stairs:slab_"  .. name,
				{use_texture_alpha = ndef.use_texture_alpha})

			-- Alias all stairs and slabs from snow to the stairs namespace.
			minetest.register_alias("snow:stair_" .. name, "stairs:stair_" .. name)
			minetest.register_alias("snow:slab_"  .. name, "stairs:slab_"  .. name)
		end
	end
end
