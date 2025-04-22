
-- snow on soil (used by mg_villages mapgen):
if(true) then
	minetest.register_craft({
	        output = 'moresnow:snow_soil',
		recipe = {{'default:dirt', 'default:snow',''}},
	})
end

-- the snow cannon:
if( moresnow.enable_snow_cannon ) then
	minetest.register_craft({
	        output = 'moresnow:snow_cannon',
		recipe = {{'default:steel_ingot', '',                   'default:steel_ingot'},
			  {'default:steel_ingot', 'default:mese',       'default:steel_ingot'},
			  {'default:copper_ingot','default:steelblock', 'default:copper_ingot'}},
	})
end

-- decorative autumn leaves and winter leaves:
if( moresnow.enable_autumnleaves ) then
	-- full leaves blocks for decorative autumn trees
	minetest.register_craft({
			type = "shapeless",
			output = 'moresnow:autumnleaves_tree',
			recipe = {'default:leaves','default:torch'},
			replacements = {{'default:torch','default:torch'}}
	})
	-- 9 layers of autumn leaves
	minetest.register_craft({
			output = 'moresnow:autumnleaves 9',
			recipe = {{'moresnow:autumnleaves_tree'}},
	})
	-- reverse craft
	minetest.register_craft({
			output = 'moresnow:autumnleaves_tree',
			recipe = {{'moresnow:autumnleaves','moresnow:autumnleaves','moresnow:autumnleaves'},
			          {'moresnow:autumnleaves','moresnow:autumnleaves','moresnow:autumnleaves'},
			          {'moresnow:autumnleaves','moresnow:autumnleaves','moresnow:autumnleaves'}}
	})
	-- white/grey leaves for trees in winter
	minetest.register_craft({
			type = "shapeless",
			output = 'moresnow:winterleaves_tree',
			recipe = {'moresnow:autumnleaves_tree','default:snow'},
			replacements = {{'default:snow','default:snow'}}
	})
end


-- the legacy wool covers with one defined for each color (plus craft for the multicolored one):
if( moresnow.wool_dyes and minetest.get_modpath( 'wool' )) then
        for _,v in ipairs( moresnow.wool_dyes ) do
		local wool_color = v
		local add_tool = 'default:cobble'
		-- we need to craft the multicolored wool somehow - while some servers might
		-- still want to use the old white wool cover
		if(v == "multicolor") then
			wool_color = "white"
			add_tool = 'default:stick'
		end
		-- craft one wool block into 9 layers
		minetest.register_craft({
			output = 'moresnow:wool_'..v..' 9',
			recipe = {{'wool:'..wool_color, add_tool}},
			replacements = {{add_tool, add_tool}},
		})
		-- craft the wool layers back to a full wool block
		minetest.register_craft({
			output = 'wool:'..v,
			recipe = {
				{'moresnow:wool_'..v, 'moresnow:wool_'..v, 'moresnow:wool_'..v },
				{'moresnow:wool_'..v, 'moresnow:wool_'..v, 'moresnow:wool_'..v },
				{'moresnow:wool_'..v, 'moresnow:wool_'..v, 'moresnow:wool_'..v },
			}})
	end
end


-- switching color receipes for the multicolored wool layer:
if(moresnow.enable_wool_cover) then
	-- craft receipes for the dyes
	local dyes = {"white", "grey", "dark_grey", "black",
			"violet", "blue", "cyan", "dark_green", "green",
			"yellow", "brown", "orange", "red", "magenta", "pink",
			-- wool has 15 colors - we have to cover 64 hues
			"bonus"}
	for i, dye in ipairs(dyes) do
		local dye_item = "dye:"..dye
		if(dye == "bonus") then
			dye_item = "wool:white"
		end
		-- 64 colors - a standard palette has 256. thus, *4
		local c = (i-1)*4
		minetest.register_craft({
			output = minetest.itemstring_with_palette("moresnow:wool_multicolor", c),
			recipe = {{"moresnow:wool_multicolor", dye_item, ""}},
			replacements = {{dye_item, dye_item}},
		})
		-- get the other four color variants each:
		-- based on darkest color from the respective wool variant:
		minetest.register_craft({
			output = minetest.itemstring_with_palette("moresnow:wool_multicolor", (c+64)),
			recipe = {{"moresnow:wool_multicolor", "", dye_item}},
			replacements = {{dye_item, dye_item}},
		})
		-- based on color by standard name (i.e. "red"):
		minetest.register_craft({
			output = minetest.itemstring_with_palette("moresnow:wool_multicolor", (c+128)),
			recipe = {{"moresnow:wool_multicolor", "",       ""},
			          {"",                         dye_item, ""}},
			replacements = {{dye_item, dye_item}},
		})
		-- pastel colors:
		minetest.register_craft({
			output = minetest.itemstring_with_palette("moresnow:wool_multicolor", (c+192)),
			recipe = {{"moresnow:wool_multicolor", "",       ""},
			          {"",                         "", dye_item}},
			replacements = {{dye_item, dye_item}},
		})
	end
end
