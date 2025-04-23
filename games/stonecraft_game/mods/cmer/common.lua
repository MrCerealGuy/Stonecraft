--= Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- common.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--

---
--
--  @module common.lua


-- constants
nullVec = {x = 0, y = 0, z = 0}
DEGTORAD = math.pi / 180.0

-- common functions
function cmer.sumChances(tab)
	local psum = 0
	for s,w in pairs(tab) do
		psum = psum + ((tonumber(w) or w.chance or 0))
	end
	return psum
end

--- Returns a weighted random table element.
--
--  chance_sum of table must be 1.
--
--  Example: cmer.rnd({elem1 = {chance = 0.7}, {elem2 = {chance = 0.3}})
--
--  @function cmer.rnd
--  @param tab
--  @param errval
--  @return Weighted random table element.
function cmer.rnd(tab, errval)
	if not errval then
		errval = false
	end

	local res = 1000000000
	local rn = math.random(0, res - 1)
	local retval = nil

	local psum = 0
	for s,w in pairs(tab) do
		psum = psum + ((tonumber(w) or w.chance or 0) * res)
		if psum > rn then
			retval = s
			break
		end
	end

	return retval
end

function throw_error(msg)
	core.log("error", "#Creatures: ERROR: " .. msg)
end

function throw_warning(msg)
	core.log("warning", "#Creatures: WARNING: " .. msg)
end

--- Compares two positions.
--
--  @function cmer.compare_pos
--  @tparam pos pos1
--  @tparam pos pos2
--  @treturn bool `true` if pos1 == pos2.
function cmer.compare_pos(pos1, pos2)
	if not pos1 or not pos2 then
		return
	end
	if pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z then
		return false
	end
	return true
end

--- Returns table of found objects (as ObjectRef) and boolean player_near.
--
--  @function cmer.findTarget
--  @param search_obj Searching object. Can be `nil`.
--  @tparam pos pos Starting position for search radius.
--  @tparam int radius Radius for searching in blocks/node.
--  @tparam string search_type Specifies returned object requirements(One of ***all***, ***hostile*** (ignores `ignore_mob` if specified), ***nonhostile***, ***player***, ***mates*** (requires `ignore_mob` specifies)).
--  @param ignore_mob Specifies creature that is ignored or searched, depending on `search_type`.
--  @tparam[opt] bool xray Allows searching through blocks/nodes (default: `false`).
--  @param no_count Skips collecting loop and returns just the boolean player_near.
--  @return Table of found objects (as `ObjectRef`) and boolean player_near.
function cmer.findTarget(search_obj, pos, radius, search_type, ignore_mob, xray, no_count)
	local player_near = false
	local mobs = {}
	for  _,obj in ipairs(core.get_objects_inside_radius(pos, radius)) do
		if obj ~= search_obj then
			if xray or core.line_of_sight(pos, obj:get_pos()) == true then
				local is_player = obj:is_player()
				if is_player then
					player_near = true
					if no_count == true then
						return {}, true
					end
				end
				local entity = obj:get_luaentity()
				local isItem = (entity and entity.name == "__builtin:item") or false
				local ignore = (entity and entity.mob_name == ignore_mob and search_type ~= "mates") or false

				if search_type == "all" then
					if not isItem and not ignore then
						table.insert(mobs, obj)
					end
				elseif search_type == "hostile" then
					if not ignore and (entity and entity.hostile == true) or is_player then
						table.insert(mobs, obj)
					end
				elseif search_type == "nonhostile" then
					if entity and not entity.hostile and not isItem and not ignore then
						table.insert(mobs, obj)
					end
				elseif search_type == "player" then
					if is_player then
						table.insert(mobs, obj)
					end
				elseif search_type == "mate" then
					if not isItem and (entity and entity.mob_name == ignore_mob) then
						table.insert(mobs, obj)
					end
				end
			end
		end --for
	end

	return mobs,player_near
end

--- Drops items at position `pos`.
--
--  @function cmer.dropItems
--  @tparam pos pos Where to drop items.
--  @tparam table drops List of item `DropDef`.
function cmer.dropItems(pos, drops)
	if not pos then
		cmer.log("error", "failed to determine entity position")
		core.log(debug.traceback())
		return
	end
	if not drops then
		cmer.log("error", "failed to determine items to drop")
		core.log(debug.traceback())
		return
	end

	-- convert drops table
	local tab = {}
	for _,elem in pairs(drops) do
		local name = tostring(elem[1])
		local v = elem[2]
		local chance = elem.chance
		local amount = ""
		-- check if drops depending on defined chance
		if name and chance then
			local ct = {}
			ct[name] = chance
			ct["_fake"] = 1 - chance
			local res = cmer.rnd(ct)
			if res == "_fake" then
				name = nil
			end
		end
		-- get amount
		if name and v then
			if type(v) == "table" then
				amount = math.random(v.min or 1, v.max or 1) or 1
			elseif type(v) == "number" then
				amount = v
			end
			if amount > 0 then
				amount = " " .. amount
			end
		end
		if name then
			local obj = core.add_item(pos, name .. amount)
			if not obj then
				throw_error("Could not drop item '" .. name .. amount .. "'")
			end
		end
	end
end
