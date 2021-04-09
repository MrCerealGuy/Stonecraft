--[[
	TSM: Surprise blocks
	
	This mod adds surprise blocks to Minetest.
	When destroyed, they drop one or more random items.

	The item is selected with the “treasurer” mod.
	Therefore, this is a treasure spawning mod.
	You also need to install at least one treasure registraton mod,
	otherwise, the questinon mark blocks stay empty.
	Refer to the documentation of the “treasurer” mod to learn more.
]]
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
	S = function ( s ) return s end
end

--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("surprise") then return end


--[[ here are some configuration variables ]]
local blocks_per_chunk = 1	-- number of blocks per chunk.
local height_min = -30000		-- minimum spawning height 
local height_max = 30000		-- maximum spawning height
local height_above_ground = 4

-- generation code
minetest.register_on_generated(function(minp, maxp, seed)
	-- get the water level and convert it to a number
	local water_level = minetest.setting_get("water_level")
	if water_level == nil or type(water_level) ~= "number" then
		water_level = 1
	else
		water_level = tonumber(water_level)
	end

	if(maxp.y < height_min or minp.y > height_max) then
		return
	end	
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	for i=1, blocks_per_chunk do
		local pos = {x=math.random(minp.x,maxp.x),z=math.random(minp.z,maxp.z), y=minp.y}
		local env = minetest.env

		 -- Find ground level
		local ground = nil
		local top = y_max	
		if env:get_node({x=pos.x,y=y_max,z=pos.z}).name ~= "air" then
			for y=y_max,y_min,-1 do
				local p = {x=pos.x,y=y,z=pos.z}
				if env:get_node(p).name == "air" then
					top = y
					break
				end
			end
		end
		for y=top,y_min,-1 do
			local p = {x=pos.x,y=y,z=pos.z}
			if env:get_node(p).name ~= "air" then
				ground = y
				break
			end
		end

		if(ground~=nil) then
			local block_pos = {x=pos.x,y=ground+height_above_ground, z=pos.z}
			local nn = minetest.get_node(block_pos).name	
			if nn == "air" then
				-- Place the question mark block
				local block = {}
				block.name = "tsm_surprise:question"

				minetest.set_node(block_pos, block)

			end
		end
	end
end)

--[[
	Register the question mark node
]]

do
	local nodedef = {
		description = S("Surprise block"),
		_doc_items_longdesc = S("If this block is mined, a few surprise items may drop out of it."),
		tiles = { { name = "tsm_surprise_question_anim.png", animation = {
			type = "vertical_frames", aspect_w=16, aspect_h=16, length=3.0 } } },
		drop = "",
		is_ground_content = false,
		groups = { dig_immediate=2, },
		sounds = {
			place = { name = "tsm_surprise_question_dig", gain = 1 },
			dug = { name = "tsm_surprise_question_break", gain = 0.8 },
			dig = { name = "tsm_surprise_question_dig", gain = 0.4 },
			footstep = { name = "tsm_surprise_question_dig", gain = 0.1 },
		},
		after_destruct = function (pos, oldnode)
			local drops = treasurer.select_random_treasures(1,0,3)
			for _,item in ipairs(drops) do
				local count, name
				if type(item) == "string" then
					name, count = item:match("^([a-zA-Z0-9_:]*) ([0-9]*)$")
					if not name then
						name = item
					end
					if not count then
						count = 1
					end
				else
					count = item:get_count()
					name = item:get_name()
				end
				if not inv or not inv:contains_item("main", ItemStack(name)) then
					for i=1,count do
						local obj = minetest.env:add_item(pos, name)
						if obj ~= nil then
							obj:get_luaentity().collect = true
							local x = math.random(1, 5)
							if math.random(1,2) == 1 then
								x = -x
							end
							local z = math.random(1, 5)
							if math.random(1,2) == 1 then
								z = -z
							end
							obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})
						end
					end
				end
			end
		end,
	}
	minetest.register_node("tsm_surprise:question",nodedef)
end
