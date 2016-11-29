--(c) Celeron55

if minetest.world_setting_get("mobf_vault_spawner_spawnpos") == nil then
	local array = {}
	minetest.world_setting_set("mobf_vault_spawner_spawnpos",minetest.serialize(array))
end


local vault = {}

vault.spawnpositions = minetest.deserialize(mobf_get_world_setting("mobf_vault_spawner_spawnpos"))

if vault.spawnpositions == nil then
	vault.spawnpositions = {}
end

function vault.cmp(v, w)
    return (
        v.x == w.x and
        v.y == w.y and
        v.z == w.z
    )
end

function vault.add(v, w)
    return {
        x = v.x + w.x,
        y = v.y + w.y,
        z = v.z + w.z,
    }
end

function vault.sub(v, w)
    return {
        x = v.x - w.x,
        y = v.y - w.y,
        z = v.z - w.z,
    }
end

vault.make_vault_part = function(p, part, seed)
    local ns = nil
    local top_y = 2
    local mob = nil

    --choose what to do at position
    if part == 'w' then
        ns = {
            {name='default:cobble'},
            {name='default:cobble'},
            {name='default:cobble'},
            {name='default:cobble'},
        }
    elseif part == 'W' then
        top_y = 3
        ns = {
            {name='default:cobble'},
            {name='default:cobble'},
            {name='default:cobble'},
            {name='default:cobble'},
            {name='default:cobble'},
            {name='default:cobble'},
        }
    elseif part == 'c' then
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='air'},
            {name='default:cobble'},
        }
    elseif part == 'T' then
        ns = {
            {name='default:cobble'},
            {name='default:torch'},
            {name='air'},
            {name='default:cobble'},
        }
    elseif part == 'f' then
        ns = {
            {name='air'},
            {name='air'},
            {name='air'},
            {name='default:cobble'},
        }
    elseif part == 'l' then
        top_y = 3
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='air'},
            {name='air'},
            {name='air'},
            {name='default:lava_source'},
        }
    elseif part == 'm' then
        top_y = 3
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='air'},
            {name='air'},
            {name='default:cobble'},
        }
        mob = "animal_dm:dm"
    elseif part == 'C' then
        top_y = 3
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='air'},
            {name='air'},
            {name='default:cobble'},
        }
    elseif part == 'S' then
        top_y = 3
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='default:bookshelf'},
            {name='default:bookshelf'},
            {name='default:cobble'},
        }
    elseif part == 'd' then
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='air'},
            {name='default:cobble'},
        }
    elseif part == 'a' then
        ns = {
            nil,
            {name='air'},
            {name='air'},
            nil,
        }
    elseif part == 'A' then
        ns = {
            nil,
            {name='air'},
            {name='air'},
            {name='air'},
            {name='default:cobble'},
        }
    elseif part == 't' then
        local invcontent = {}
        local pr = PseudoRandom(seed)
        if pr:next(1,4) == 1 then
            table.insert(invcontent, 'default:apple '..tostring(pr:next(1,5)))
        end
        if pr:next(1,3) == 1 then
            table.insert(invcontent, 'bucket:bucket_empty 1')
        end
        if pr:next(1,4) == 1 then
            table.insert(invcontent, 'bucket:bucket_lava 1')
        end
        if pr:next(1,20) == 1 then
            table.insert(invcontent, 'bucket:bucket_water 1')
        end
        if pr:next(1,34) == 1 then
            table.insert(invcontent, 'default:nyancat 1')
            table.insert(invcontent, 'default:nyancat_rainbow '..tostring(pr:next(1,6)))
        end
        if pr:next(1,2) == 1 then
            table.insert(invcontent, 'default:gravel '..tostring(pr:next(1,10)))
        end
        if pr:next(1,3) == 1 then
            table.insert(invcontent, 'default:bookshelf '..tostring(pr:next(1,2)))
        end
        if pr:next(1,8) == 1 then
            table.insert(invcontent, 'default:cactus '..tostring(pr:next(1,2)))
        end
        if pr:next(1,4) == 1 then
            table.insert(invcontent, 'default:rail '..tostring(pr:next(1,10)))
        end
        if pr:next(1,5) == 1 then
            table.insert(invcontent, 'default:ladder '..tostring(pr:next(1,9)))
        end
        if pr:next(1,3) == 1 then
            table.insert(invcontent, 'default:sign_wall 1')
        end
        if pr:next(1,6) == 1 then
            table.insert(invcontent, 'default:steelblock '..tostring(pr:next(1,6)))
        end
        ns = {
            {name='default:cobble'},
            {name='air'},
            {name='default:chest', inv=invcontent},
            {name='default:cobble'},
        }
    else
        return
    end

    --for all nodes in definition
    for i=1,#ns do
        local dy = top_y + 1 - i
        local p2 = {x=p.x,y=p.y+dy,z=p.z}

        --get node at position
        local oldn = minetest.get_node(p2)
        local n = ns[i]

        --don't do anything if no new node is specified or
        --old node is air
        if n and oldn.name ~= "air" then
            --possibly add mossy if it's a cobble node
            if n.name == 'default:cobble' then
                local perlin = minetest.get_perlin(123, 2, 0.8, 2.0)
                if perlin:get3d(p2) >= 0.0 then
                    n.name = 'default:mossycobble'
                end
            end

            --set node
            --dm_debug("pos: " .. minetest.pos_to_string(p2) .. " replacing " .. oldn.name .. " by " .. n.name)
            minetest.set_node(p2, ns[i])

            --special handling for chests
            if n.inv then
                dm_debug("adding chest at " .. minetest.pos_to_string(p2) )
                local meta = minetest.get_meta(p2)
                local inv = meta:get_inventory()
                for _,itemstring in ipairs(n.inv) do
                    inv:add_item('main', itemstring)
                end
            end
        else
            --dm_debug("pos: " .. minetest.pos_to_string(p) .. " not replacing " .. oldn.name)
        end

    end
    if mob then
        --dm_debug("adding dm at " .. minetest.pos_to_string({x=p.x,y=p.y+1,z=p.z}) )
        local newobject = minetest.add_entity({x=p.x,y=p.y+1,z=p.z}, mob)
        local newentity = mobf_find_entity(newobject)

        if newentity and
            newentity.dynamic_data and
            newentity.dynamic_data.spawning then
            newentity.dynamic_data.spawning.player_spawned = playerspawned
            newentity.dynamic_data.spawning.spawner = "vault"
        end
    end
end


vault.checkdistance = function(pos,mindistance)

	for i=1,#vault.spawnpositions,1 do
		local distance = mobf_calc_distance(pos,vault.spawnpositions[i])
		dm_debug("Distance to vault: " .. i .. " at " ..minetest.pos_to_string(vault.spawnpositions[i]) .. " is : " .. distance)
		if distance < mindistance then
			return false
		end
	end

	return true
end

vault.addvaultpos = function(pos)
	table.insert(vault.spawnpositions,pos)
	mobf_set_world_setting("mobf_vault_spawner_spawnpos",minetest.serialize(vault.spawnpositions))
end

vault.generate_vault = function(vault_def, p, dir, seed)
    local dim_z = #vault_def
    assert(dim_z > 0)
    local dim_x = #vault_def[1]

    --don't generate vault if entrance dir not z +1
    if not vault.cmp(dir, {x=0,y=0,z=1}) then
        --dm_debug("entrance direction wrong: " .. minetest.pos_to_string(p))
        return
    end

	--make sure minimum distance between vault entrances is at least 200 nodes
    if not vault.checkdistance(p,200) then
    	return
    end

    dm_debug("generating vault at: " .. minetest.pos_to_string(p))
    vault.addvaultpos(p)

    --print("Making vault at "..minetest.pos_to_string(p))
    if dim_x >= 14 then
        --dm_debug("Making large vault at "..minetest.pos_to_string(p))
    else
        --dm_debug("Making vault at "..minetest.pos_to_string(p))
    end

    -- Find door in definition
    local def_door_p = nil
    for dx=1,dim_x do
    for dz=1,dim_z do
        if vault_def[dim_z+1-dz][dx] == 'd' then
            def_door_p = {x=dx,y=0,z=dz}
        end
        if def_door_p then break end
    end
        if def_door_p then break end
    end
    --print("Vault door found at "..minetest.pos_to_string(def_door_p).." in definition")
    assert(def_door_p)
    local randseed = seed
    for dx=1,dim_x do
    for dz=1,dim_z do
        local p2 = vault.add(vault.sub(p, def_door_p), {x=dx, y=0, z=dz})
        local part = vault_def[dim_z+1-dz][dx]
        --dm_debug("Making vault part "..dump(part).." at "..minetest.pos_to_string(p2))
        vault.make_vault_part(p2, part, randseed)
        randseed = randseed + 1
    end
    end
end

-- Definition is for Z=up, X=right, dir={x=0,y=0,z=1}
vault.vault_defs = {
---[[
    {
        {'w','w','w','w','w','w','w','w','w','w'},
        {'w','c','c','c','c','c','C','C','c','w'},
        {'w','c','C','c','c','c','C','C','m','w'},
        {'w','C','C','C','w','w','C','C','c','w'},
        {'w','C','C','C','w','w','C','C','c','w'},
        {'w','T','C','c','w','w','C','w','w','w'},
        {'w','c','t','c','w','w','C','w','n','n'},
        {'w','w','w','w','w','w','C','w','n','n'},
        {'n','n','n','n','n','w','d','w','n','n'},
        {'n','n','n','n','n','n','A','n','n','n'},
    },
--]]
---[[
    {
        {'w','w','w','w','w','w','w','w'},
        {'w','c','c','c','m','C','c','w'},
        {'w','C','c','c','C','C','c','w'},
        {'w','C','w','w','C','C','c','w'},
        {'w','C','t','w','C','C','c','w'},
        {'w','C','t','w','C','w','d','w'},
        {'w','T','w','w','C','w','A','n'},
        {'w','c','C','C','C','w','n','n'},
        {'n','n','n','w','w','w','n','n'},
    },
--]]
---[[
    {
        {'W','W','W','W','W','W','W','W','W','W','W','W','W','W','W','W'},
        {'W','l','l','l','l','l','l','t','t','l','l','l','l','l','l','W'},
        {'W','l','l','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','l','l','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','m','l','l','l','l','l','f','f','l','l','l','l','l','m','W'},
        {'W','c','l','l','l','l','l','f','f','l','l','l','l','l','c','W'},
        {'W','c','l','l','l','l','l','f','f','l','l','l','l','l','c','W'},
        {'W','c','l','l','l','l','l','f','f','l','l','l','l','l','c','W'},
        {'W','m','l','l','l','l','l','f','f','l','l','l','l','l','m','W'},
        {'W','l','l','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','l','l','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','l','l','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','W','W','W','W','W','W','W','d','W','W','W','W','W','W','W'},
        {'n','n','n','n','n','n','n','n','A','n','n','n','n','n','n','n'},
    },
--]]
---[[
    {
        {'W','W','W','W','W','W','W','W','W','W','W','W','W','W','W','W'},
        {'W','f','f','f','f','l','l','t','l','l','l','l','l','l','l','W'},
        {'W','f','l','l','l','l','l','f','l','l','l','l','l','l','l','W'},
        {'W','f','l','l','f','l','l','l','l','l','l','l','l','l','l','W'},
        {'W','f','l','l','l','l','l','l','f','l','f','f','l','l','m','W'},
        {'W','f','l','l','l','l','f','l','l','l','l','l','f','l','c','W'},
        {'W','f','f','l','l','l','l','l','l','l','l','l','f','l','c','W'},
        {'W','c','f','l','l','l','l','l','l','l','l','l','f','l','c','W'},
        {'W','m','f','l','l','l','l','l','l','l','l','l','f','l','m','W'},
        {'W','l','f','l','l','l','l','f','f','l','f','f','f','l','l','W'},
        {'W','l','t','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','l','l','l','l','l','l','f','f','l','l','l','l','l','l','W'},
        {'W','W','W','W','W','W','W','W','d','W','W','W','W','W','W','W'},
        {'n','n','n','n','n','n','n','n','A','n','n','n','n','n','n','n'},
    },
--]]
---[[
    {
        {'n','n','n','n','n','n','n','n','n','n','n','n','w','w','w','w','n','n','n','n'},
        {'n','n','n','n','n','n','n','n','w','w','w','w','w','c','c','w','w','w','w','n'},
        {'n','n','n','n','n','n','n','w','w','c','c','c','c','c','c','c','c','w','w','n'},
        {'n','n','n','n','n','n','w','w','c','c','c','c','c','c','c','c','c','c','W','W'},
        {'n','n','n','n','n','n','w','t','c','C','C','m','c','c','C','C','m','c','c','W'},
        {'n','n','n','n','n','n','w','t','c','C','C','c','c','c','C','C','c','c','c','W'},
        {'n','n','n','n','n','n','w','w','c','c','c','c','c','c','c','c','c','c','c','W'},
        {'n','n','n','n','n','n','n','w','w','c','c','c','C','C','C','C','C','C','C','W'},
        {'n','n','n','n','n','n','n','n','w','w','c','c','l','l','l','l','l','l','l','W'},
        {'n','n','n','n','n','n','n','n','W','W','l','l','l','l','l','l','l','l','l','W'},
        {'w','w','w','w','W','W','W','W','W','l','l','l','l','l','l','l','l','l','l','W'},
        {'w','w','c','c','C','S','S','C','C','l','l','l','l','l','l','l','l','l','l','W'},
        {'w','c','c','c','C','C','C','C','l','l','l','l','l','l','l','l','l','l','l','W'},
        {'w','c','c','C','C','C','C','C','l','l','l','l','m','C','l','l','l','l','l','W'},
        {'w','c','c','C','C','C','C','C','l','l','l','l','C','t','l','l','l','l','l','W'},
        {'w','c','c','C','C','l','l','l','l','l','l','l','l','l','l','l','l','l','l','W'},
        {'w','c','C','C','l','l','l','l','l','l','l','l','l','l','l','l','l','l','l','W'},
        {'w','W','C','C','l','l','l','l','l','l','l','l','l','l','l','l','l','l','W','W'},
        {'n','W','d','W','W','W','W','W','W','W','W','W','W','W','W','W','W','W','W','n'},
        {'n','n','A','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n'},
    },
--]]
}

function vault.node_is_solid(n)
    return (n and n.name and minetest.registered_nodes[n.name] and
            minetest.registered_nodes[n.name].walkable)
end

vault.generate_random_vault = function(p, dir, seed)

    --random select of vault template
    local pr = PseudoRandom(seed+9322)
    local vault_def = vault.vault_defs[pr:next(1, #vault.vault_defs)]

    --generate vault by template
    vault.generate_vault(vault_def, p, dir, seed)
end

minetest.register_on_generated(function(minp, maxp, seed)

	--abort in case of dm disabled
	if minetest.registered_entities["animal_dm:dm"] == nil then
		return
	end

    --abort in case of above sea level
    if maxp.y > -10 then
        return
    end

    --calculate area of generated chunk
    local area = (maxp.x-minp.x+1)*(maxp.z-minp.z+1)

    --initialize dungeon level with 2
    local dungeon_level_y = 2

    --get random dungeon level within generated chunk
    if maxp.y < 2 then
        local pr = PseudoRandom(seed+932)
        dungeon_level_y = pr:next(minp.y, maxp.y)
    end


    --initialize check values
    local is_empty = false
    local light = nil
    local last_empty = false
    local last_light = nil
    local possible_entrances = {}
    local d = 4


    --loop through chunk using d frames in x direction
    for x=minp.x/d+1,maxp.x/d-1 do
        --set to unknown on start of x-loop (why?)
        local last_node_known = false

    --loop through cunk in z direction
    for z=minp.z+1,maxp.z-1 do

        --get information of current node to check
        local p = {x=x*d, y=dungeon_level_y, z=z}
        local n = minetest.get_node(p)

        --save values from last loop
        last_empty = is_empty
        last_light = light

        --get new values
        is_empty = not vault.node_is_solid(n)
        light = minetest.get_node_light(p, 0.5)

        --if last node was known
        if last_node_known then

            --initialize values
            local useful_light = nil

            --save values
            if is_empty then
                useful_light = light
            else
                useful_light = last_light
            end

            --if current node isn't solid,
            --last was solid and we're not at daylight
            if is_empty and not last_empty and useful_light < 15 then

                --calculate ??? positions next to current pos
                local p1 = vault.add(p,  {x=0,  y=0, z=-1})
                local p2 = vault.add(p1, {x=0,  y=2, z=-1})
                local p3 = vault.add(p1, {x=0,  y=2, z=-8})
                local p4 = vault.add(p1, {x=-3, y=1, z=-2})
                local p5 = vault.add(p1, {x=3,  y=1, z=-2})

                --if all nodes are solid
                if  vault.node_is_solid(minetest.get_node(p2)) and
                    vault.node_is_solid(minetest.get_node(p3)) and
                    vault.node_is_solid(minetest.get_node(p4)) and
                    vault.node_is_solid(minetest.get_node(p5))
                then
                    local entrance = {
                        p = p1,
                        dir = {x=0, y=0, z=-1},
                    }
                    --add to entrance table with direction z = -1
                    table.insert(possible_entrances, entrance)
                end
            end

            --if current node isn't solid,
            --last was solid and we're not at daylight
            if last_empty and not is_empty and useful_light < 15 then
                local p1 = vault.add(p,  {x=0,  y=0, z=0})
                local p2 = vault.add(p1, {x=0,  y=2, z=1})
                local p3 = vault.add(p1, {x=0,  y=2, z=8})
                local p4 = vault.add(p1, {x=-3, y=1, z=2})
                local p5 = vault.add(p1, {x=3,  y=1, z=2})

                --if all nodes are solid
                if vault.node_is_solid(minetest.get_node(p2)) and
                    vault.node_is_solid(minetest.get_node(p3)) and
                    vault.node_is_solid(minetest.get_node(p4)) and
                    vault.node_is_solid(minetest.get_node(p5))
                then
                    local entrance = {
                        p = p1,
                        dir = {x=0, y=0, z=1},
                    }
                    --add to entrance table with direction z = 1
                    table.insert(possible_entrances, entrance)
                end
            end
        end
        last_node_known = true
    end
    end

    --for _,entrance in ipairs(possible_entrances) do
    --  dm_debug("Possible entrance: "..dump(entrance))
    --end
    --calculate number of entrances to generate per area
    local num_entrances_to_generate = area/200

    --check if there are enough possible entrances
    if num_entrances_to_generate > #possible_entrances then
        num_entrances_to_generate = #possible_entrances
    end

    local pr = PseudoRandom(seed+9452)

    --generate vault for max number of entraces to generate at random
    --selected possible entrances
    for entrances_generate_i=1,num_entrances_to_generate do
        local entrance_i = pr:next(1, #possible_entrances)
        local entrance = possible_entrances[entrance_i]
        --dm_debug("Entrance: "..dump(entrance))
        vault.generate_random_vault(entrance.p, entrance.dir, seed)
    end
end)