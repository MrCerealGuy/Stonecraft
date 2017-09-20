--[[

2017-05-18 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--Parameters used by some weapons
local default_dir = {
    x = 1,
    y = 1,
    z = 1,
}

--Function used to shoot:
local function weapons_shot(itemstack, placer, pointed_thing, velocity, name)
    local dir = placer:get_look_dir();
    local playerpos = placer:getpos();
    local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "nssm:"..name)
    local vec = {x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity}
    obj:setvelocity(vec)
    return itemstack
end

local function hit(pos, self)
    local node = node_ok(pos).name
    self.hit_node(self, pos, node)
    self.object:remove()
    return
end

local function activate_balls(pos)
    local radius = 50
    local objects = minetest.env:get_objects_inside_radius(pos, radius)
    for _,obj in ipairs(objects) do
        if (obj:get_luaentity() and obj:get_luaentity().name == "nssm:hellzone_grenade") then
            obj:get_luaentity().move = 1
        end
    end
end

local function search_on_step2(
    self,
    dtime,      --used to count time
    max_time,   --after this amount of time the entity is removec
    radius,     --radius in which look for entities to follow
    vel)        --velocity of the projectile

    local pos = self.object:getpos()

    --Disappear after a certain time
    if self.life_time == 0 then
        self.life_time = os.time()
    end
    if os.time() - self.life_time > max_time then
        self.object:remove()
        return
    end

    --Look for an entity to follow
    local objects = minetest.env:get_objects_inside_radius(pos, radius)
    local min_dist = 100
    local obj_min = nil
    local obj_p = nil
    local vec_min = nil
    for _,obj in ipairs(objects) do
        if (obj:is_player()) then
        elseif (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" and obj:get_luaentity().name ~= self.object:get_luaentity().name) then
            obj_p = obj:getpos()
            local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
            local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
            if (dist<min_dist) then
                min_dist = dist
                obj_min = obj
                vec_min = vec
            end
        end
    end

    --Found an entity to follow:
    if obj_min ~= nil then
        local new_vel = {x=0, y=0, z=0}

        local dir = 0
        local max_diff = 0

        if (max_diff<math.abs(vec_min.x)) then
            dir = 1
            max_diff = math.abs(vec_min.x)
        end
        if (max_diff<math.abs(vec_min.y)) then
            dir = 2
            max_diff = math.abs(vec_min.y)
        end
        if (max_diff<math.abs(vec_min.z)) then
            dir = 3
            max_diff = math.abs(vec_min.z)
        end

        vec_min.x = (vec_min.x/max_diff)*vel
        vec_min.y = (vec_min.y/max_diff)*vel
        vec_min.z = (vec_min.z/max_diff)*vel
        obj_p = obj_min:getpos()
        if min_dist <=8 and self.move==0 then
            self.object:setvelocity({x=0, y=0, z=0})

            --hit(pos,self)
        elseif min_dist<=1 and self.move==1 then
            hit(pos,self)
        else
            self.object:setvelocity(vec_min)
        end
    end

    local n = minetest.env:get_node(pos).name
    if n ~= "air" and n ~= "default:water_source" and n ~= "default:water_flowing" then
        hit(pos,self)
    end
end

--on_step function able to follow the mobs
local function search_on_step(
    self,
    dtime,      --used to count time
    max_time,   --after this amount of time the entity is removec
    radius,     --radius in which look for entities to follow
    vel)        --velocity of the projectile


    local pos = self.object:getpos()

    --Disappear after a certain time
    if self.life_time == 0 then
        self.life_time = os.time()
    end
    if os.time() - self.life_time > max_time then
        self.object:remove()
        return
    end


    --Look for an entity to follow
    local objects = minetest.env:get_objects_inside_radius(pos, radius)
    local min_dist = 100
    local obj_min = nil
    local obj_p = nil
    local vec_min = nil
    for _,obj in ipairs(objects) do
        if (obj:is_player()) then
        elseif (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" and obj:get_luaentity().name ~= self.object:get_luaentity().name) then
            obj_p = obj:getpos()
            local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
            local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
            if (dist<min_dist) then
                min_dist = dist
                obj_min = obj
                vec_min = vec
            end
        end
    end

    --Found an entity to follow:
    if obj_min ~= nil then
        local new_vel = {x=0, y=0, z=0}

        local dir = 0
        local max_diff = 0

        if (max_diff<math.abs(vec_min.x)) then
            dir = 1
            max_diff = math.abs(vec_min.x)
        end
        if (max_diff<math.abs(vec_min.y)) then
            dir = 2
            max_diff = math.abs(vec_min.y)
        end
        if (max_diff<math.abs(vec_min.z)) then
            dir = 3
            max_diff = math.abs(vec_min.z)
        end

        vec_min.x = (vec_min.x/max_diff)*vel
        vec_min.y = (vec_min.y/max_diff)*vel
        vec_min.z = (vec_min.z/max_diff)*vel
        obj_p = obj_min:getpos()
        if min_dist < 1 then
            local node = node_ok(pos).name
            self.hit_node(self, pos, node)
            self.object:remove()
            return
        else
            self.object:setvelocity(vec_min)
        end
    end
    local n = minetest.env:get_node(pos).name
    if n ~= "air" and n ~= "default:water_source" and n ~= "default:water_flowing" then
        local node = node_ok(pos).name
        self.hit_node(self, pos, node)
        self.object:remove()
        return
    end
end

local function default_on_step(
    self,
    dtime,              --used to count time
    max_time,           --after this amount of time the entity is removec
    damage,             --damage dealt to the entity around
    dir,                --vector to specify directions in which remove blocks
    radius,             --radius of blocks removed aroind the projectile
    not_transparent,    --name of a block or of a group: when the projectile hit one of these blocks the function hit_node is called
    vel)                --velocity of the projectile


    local pos = self.object:getpos()

    if self.life_time == 0 then
        self.life_time = os.time()
    end


    if os.time() - self.life_time > max_time then
        local node = node_ok(pos).name
        self.hit_node(self, pos, node)
        self.object:remove()
        return
    end

    self.timer = self.timer + dtime
    --minetest.chat_send_all("Timer: "..self.timer)

    --while going around it damages entities
    local objects = minetest.env:get_objects_inside_radius(pos, 2)
    if self.timer > 0.1 then
        self.timer = 0
        for _,obj in ipairs(objects) do
            if obj:get_luaentity() then
                if (obj:get_entity_name() ~= self.object:get_luaentity().name) and (obj:get_luaentity().name ~= "__builtin:item") then
                    if obj:is_player() then
                        obj:set_hp(obj:get_hp()-damage)
                    elseif obj:get_luaentity().health then
                        obj:get_luaentity().health = obj:get_luaentity().health - damage
                        --minetest.chat_send_all("Danneggiato: "..obj:get_entity_name().." Vita: "..obj:get_luaentity().health)
                        check_for_death(obj:get_luaentity())
                    end
                end
            end
        end
    end

    local n = minetest.env:get_node(pos).name
    if n==not_transparent or minetest.get_item_group(n, not_transparent)==1 then
        local node = node_ok(pos).name
        self.hit_node(self, pos, node)
        self.object:remove()
        return
    else
        local vec = self.object:getvelocity()
        local c=vel/10
        --calculate how many blocks around need to be removed
        local max = 0
        local posmax = 0
        if max<math.abs(vec.x) then
            max = math.abs(vec.x)
            posmax = 1
        end
        if max<math.abs(vec.y) then
            max = math.abs(vec.y)
            posmax = 2
        end
        if max<math.abs(vec.z) then
            max = math.abs(vec.z)
            posmax = 3
        end

        local i = radius
        local j = radius
        local k = radius

        if dir.x == 0 then
            i = 0
        end
        if dir.y == 0 then
            j = 0
        end
        if dir.z == 0 then
            k = 0
        end

        if posmax==1 then
            i = 0
        end

        if posmax==2 then
            j = 0
        end

        if posmax==3 then
            k = 0
        end

        for dx = -i,i do
            for dy= -j,j do
                for dz = -k,k do
                    local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(p, "") or not minetest.get_item_group(n, "unbreakable") == 1 then
                        minetest.env:remove_node(p)
                    end
                end
            end
        end
    end
end

--[[
Function to register new weapons: parameters:
    - name of the weapon
    - on_step function (written by you or taken from the standard one above)
    - hit_node function
    - description of the weapon
    - the velocity of the projectile
    - one material to be used in the receipt
]]
local function nssm_register_weapon(name, def)
    minetest.register_entity("nssm:"..name, {
        textures = {name..".png"},
        on_step = function(self, dtime)
            def.on_step(self, dtime)
        end,
        hit_node = function(self, pos, node)
            def.hit_node(self, pos, node)
        end,
        move = def.move,
        life_time = 0,
        timer = 0,
        custom_timer = 0,
    })

    minetest.register_craftitem("nssm:"..name.."_hand", {
        description = def.description,
        inventory_image = name.."_hand.png",
        on_use = function(itemstack, placer, pointed_thing)
            weapons_shot(itemstack, placer, pointed_thing, def.velocity, name)
            itemstack:take_item()
            return itemstack
        end,
        on_drop = def.on_drop or function(itemstack, user, pointed_thing)
		end,
    })


    minetest.register_craft({
		output = 'nssm:'..name.."_hand 23",
		recipe = {
			{'nssm:great_energy_globe', 'nssm:great_energy_globe', 'nssm:great_energy_globe'},
            {'nssm:great_energy_globe', def.material, 'nssm:great_energy_globe'},
            {'nssm:great_energy_globe', 'nssm:great_energy_globe', 'nssm:great_energy_globe'}
		}
	})

end

--Registered weapons:
nssm_register_weapon("kamehameha", {
    velocity = 25,
    on_step = function(self, dtime)
        default_on_step(self, dtime, 4, 20, default_dir, 1, "stone", 25)
    end,
    hit_node = function(self, pos, node)
        tnt.boom(pos, {damage_radius=10,radius=6,ignore_protection=false})
    end,
    material = "default:diamondblock",
    description = S("Kamehameha from DragonBall"),

})

nssm_register_weapon("kienzan", {
    velocity = 25,
    on_step = function(self, dtime)
        default_on_step(self, dtime, 5, 20, {x=1, y=0, z=1}, 1, nil, 25)
    end,
    hit_node = function(self, pos, node)
    end,
    material = "default:bronzeblock",
    description = S("Kienzan from DragonBall"),
})

nssm_register_weapon("spirit_ball", {
    velocity = 25,
    move = 0,
    on_step = function(self, dtime)
        search_on_step(self, dtime, 5, 30, 25)
    end,
    hit_node = function(self, pos, node)
        tnt.boom(pos, {damage_radius=8,radius=4,ignore_protection=false})
    end,

    material = "default:goldblock",
    description = S("Spirit Ball from DragonBall"),
})

nssm_register_weapon("hellzone_grenade", {
    velocity = 25,
    move = 0,
    on_step = function(self, dtime)
        search_on_step2(self, dtime, 30, 30, 25)
    end,
    hit_node = function(self, pos, node)
        tnt.boom(pos, {damage_radius=8,radius=4,ignore_protection=false})
    end,

    on_drop = function(itemstack, user, pointed_thing)
        local pos = user:getpos()
        activate_balls(pos)
    end,
    material = "default:mese",
    description = S("Hellzone grenade (Press q to activate)"),
})

--[[nssm_register_weapon("particles_ball", {
    velocity = 25,
    move = 0,

    on_step = function(self, dtime)
        local pos = self.object:getpos()
        local vel = 1

        minetest.add_particlespawner({
        	amount = 2,
        	time = 0.01,
        	minpos = pos,
        	maxpos = pos,
        	minvel = {x=3, y=3, z=3},
        	maxvel = {x=-3, y=-3, z=-3},
        	minacc = {x=0, y=0, z=0},
        	maxacc = {x=0, y=0, z=0},
        	minexptime = 0.5,
        	maxexptime = 0.5,
        	minsize = 3,
        	maxsize = 3,
        	collisiondetection = false,
        	vertical = false,
        	texture = "morparticle.png"
        })

        --Disappear after a certain time
        if self.life_time == 0 then
            self.life_time = os.time()
        end
        if os.time() - self.life_time > 60 then
            self.object:remove()
            return
        end

        --Look for an entity to follow
        local objects = minetest.env:get_objects_inside_radius(pos, 20)
        local min_dist = 100
        local obj_min = nil
        local obj_p = nil
        local vec_min = nil
        for _,obj in ipairs(objects) do
            if (obj:is_player()) then
            elseif (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" and obj:get_luaentity().name ~= self.object:get_luaentity().name) then
                obj_p = obj:getpos()
                local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
                local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
                if (dist<min_dist) then
                    min_dist = dist
                    obj_min = obj
                    vec_min = vec
                end
            end
        end

        --Found an entity to follow:
        if obj_min ~= nil then
            local new_vel = {x=0, y=0, z=0}

            local dir = 0
            local max_diff = 0

            if (max_diff<math.abs(vec_min.x)) then
                dir = 1
                max_diff = math.abs(vec_min.x)
            end
            if (max_diff<math.abs(vec_min.y)) then
                dir = 2
                max_diff = math.abs(vec_min.y)
            end
            if (max_diff<math.abs(vec_min.z)) then
                dir = 3
                max_diff = math.abs(vec_min.z)
            end

            vec_min.x = (vec_min.x/max_diff)*vel
            vec_min.y = (vec_min.y/max_diff)*vel
            vec_min.z = (vec_min.z/max_diff)*vel
            obj_p = obj_min:getpos()

            self.object:setvelocity(vec_min)
            if min_dist < 1 then

                local node = nssm:node_ok(pos).name
                self.hit_node(self, pos, node)
                self.object:remove()
                return
            else
                self.object:setvelocity(vec_min)
            end

        end
        local n = minetest.env:get_node(pos).name

        if n ~= "air" and n ~= "default:water_source" and n ~= "default:water_flowing" then
            local node = nssm:node_ok(pos).name
            self.hit_node(self, pos, node)
            self.object:remove()
            return
        end

    end,

    hit_node = function(self, pos, node)
        --nssm:explosion(pos, 4, 0)
    end,

    on_drop = function(itemstack, user, pointed_thing)
        local pos = user:getpos()
        --activate_balls(pos)
    end,
    material = "group:wood",
    description = "Particles ball",
})]]

--[[
nssm_register_weapon("light_ball", {
    velocity = 25,
    move = 0,

    on_step = function(self, dtime, last_pos)
        local pos = self.object:getpos()
        local vel = 1


        --Disappear after a certain time
        if self.life_time == 0 then
            self.life_time = os.time()
        end
        if os.time() - self.life_time > 60 then
            self.object:remove()
            return
        end

        if self.custom_timer == 0 then
            self.custom_timer = os.time()
        end

        if last_pos == nil or (last_pos ~= nil and last_pos ~= pos) then
            minetest.set_node(pos, {name="nssm:invisible_light"})
            if last_pos ~= nil then
                minetest.set_node(last_pos, {name="air"})
            end
            last_pos = pos
        end

        --Look for an entity to follow
        local objects = minetest.env:get_objects_inside_radius(pos, 20)
        local min_dist = 100
        local obj_min = nil
        local obj_p = nil
        local vec_min = nil
        for _,obj in ipairs(objects) do
            if (obj:is_player()) then
            elseif (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" and obj:get_luaentity().name ~= self.object:get_luaentity().name) then
                obj_p = obj:getpos()
                local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
                local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
                if (dist<min_dist) then
                    min_dist = dist
                    obj_min = obj
                    vec_min = vec
                end
            end
        end

        --Found an entity to follow:
        if obj_min ~= nil then
            local new_vel = {x=0, y=0, z=0}

            local dir = 0
            local max_diff = 0

            if (max_diff<math.abs(vec_min.x)) then
                dir = 1
                max_diff = math.abs(vec_min.x)
            end
            if (max_diff<math.abs(vec_min.y)) then
                dir = 2
                max_diff = math.abs(vec_min.y)
            end
            if (max_diff<math.abs(vec_min.z)) then
                dir = 3
                max_diff = math.abs(vec_min.z)
            end

            vec_min.x = (vec_min.x/max_diff)*vel
            vec_min.y = (vec_min.y/max_diff)*vel
            vec_min.z = (vec_min.z/max_diff)*vel
            obj_p = obj_min:getpos()

            self.object:setvelocity(vec_min)
            if min_dist < 1 then

                local node = nssm:node_ok(pos).name
                self.hit_node(self, pos, node)
                self.object:remove()
                return
            else
                self.object:setvelocity(vec_min)
            end

        end
        local n = minetest.env:get_node(pos).name

        if n ~= "air" and n ~= "default:water_source" and n ~= "default:water_flowing" then
            local node = nssm:node_ok(pos).name
            self.hit_node(self, pos, node)
            self.object:remove()
            return
        end

    end,

    hit_node = function(self, pos, node)
        --nssm:explosion(pos, 4, 0)
    end,

    on_drop = function(itemstack, user, pointed_thing)
        local pos = user:getpos()
        --activate_balls(pos)
    end,
    material = "group:sand",
    description = "Light Ball",
})
]]
function nssm_register_throwitem(name, descr, def)

    minetest.register_craftitem("nssm:"..name.."_bomb", {
        description = descr,
        inventory_image = name.."_bomb.png",
        on_use = function(itemstack, placer, pointed_thing)
            --weapons_shot(itemstack, placer, pointed_thing, def.velocity, name)
            local velocity = 15
            local dir = placer:get_look_dir();
            local playerpos = placer:getpos();
			posthrow = playerpos
            local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "nssm:"..name.."_bomb_flying")
            local vec = {x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity}
            local acc = {x=0, y=-9.8, z=0}
            obj:setvelocity(vec)
            obj:setacceleration(acc)
            itemstack:take_item()
            return itemstack
        end,
    })

    minetest.register_entity("nssm:"..name.."_bomb_flying",{
        textures = {name.."_bomb.png"},
		hp_max = 20,
		collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
        on_step = function(self, dtime)
            local pos = self.object:getpos()
            local node = minetest.get_node(pos)
            local n = node.name
            if n ~= "air" then
                def.hit_node(self, pos)
                self.object:remove()
            end
        end,
    })
end

nssm_register_throwitem("cobweb", "Cobweb Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = -1,1 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="nssm:web"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:cobweb_bomb 8',
	recipe = {
		{'nssm:silk_gland', 'nssm:black_powder', 'nssm:silk_gland'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:silk_gland', 'nssm:black_powder', 'nssm:silk_gland'},
	}
})

nssm_register_throwitem("ice", "Ice Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = 1,3 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local pos2 = {x = pos.x, y=pos.y+1, z=pos.z}
					local pos3 = {x = pos.x, y=pos.y+2, z=pos.z}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="default:ice"})
						minetest.set_node(pos2, {name="air"})
						minetest.set_node(pos3, {name="air"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:ice_bomb 8',
	recipe = {
		{'nssm:frosted_amphibian_heart', 'nssm:black_powder', 'nssm:frosted_amphibian_heart'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:frosted_amphibian_heart', 'nssm:black_powder', 'nssm:frosted_amphibian_heart'},
	}
})
if minetest.get_modpath("nssb") then
	nssm_register_throwitem("mantis", "Mantis Clay Bomb", {
		hit_node = function(self,pos)
			for dx = -1,1 do
				for dy = 1,3 do
					for dz = -1,1 do
						local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
						local pos2 = {x = pos.x, y=pos.y+1, z=pos.z}
						local pos3 = {x = pos.x, y=pos.y+2, z=pos.z}
						if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
							minetest.set_node(pos1, {name="nssb:hardened_mantis_clay"})
							minetest.set_node(pos2, {name="air"})
							minetest.set_node(pos3, {name="air"})
						end
					end
				end
			end
		end,
	})

	minetest.register_craft({
		output = 'nssm:mantis_bomb 8',
		recipe = {
			{'nssm:mantis_meat', 'nssm:black_powder', 'nssm:mantis_meat'},
			{'nssm:black_powder', 'nssb:hardened_mantis_clay', 'nssm:black_powder'},
			{'nssm:mantis_meat', 'nssm:black_powder', 'nssm:mantis_meat'},
		}
	})
end

nssm_register_throwitem("lava", "Lava Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = -1,0 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="default:lava_source"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:lava_bomb 12',
	recipe = {
		{'bucket:bucket_lava', 'nssm:black_powder', 'bucket:bucket_lava'},
		{'nssm:black_powder', 'nssm:lava_titan_eye', 'nssm:black_powder'},
		{'bucket:bucket_lava', 'nssm:black_powder', 'bucket:bucket_lava'},
	}
})

nssm_register_throwitem("water", "Water Bomb", {
    hit_node = function(self,pos)
        for dx = -2,2 do
            for dy = -1,0 do
                for dz = -2,2 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="default:water_source"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:water_bomb 10',
	recipe = {
		{'bucket:bucket_water', 'nssm:black_powder', 'bucket:bucket_water'},
		{'nssm:black_powder', 'nssm:tentacle_curly', 'nssm:black_powder'},
		{'bucket:bucket_water', 'nssm:black_powder', 'bucket:bucket_water'},
	}
})

nssm_register_throwitem("fire", "Fire Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = 1,1 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="fire:basic_flame"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:fire_bomb 6',
	recipe = {
		{'fire:flint_and_steel', 'nssm:black_powder', 'fire:flint_and_steel'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'fire:flint_and_steel', 'nssm:black_powder', 'fire:flint_and_steel'},
	}
})

if minetest.get_modpath("nssb") then
	nssm_register_throwitem("mornar", "Mornar Bomb", {
		hit_node = function(self,pos)
			for dx = -1,1 do
				for dy = 1,1 do
					for dz = -1,1 do
						local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
						if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
							minetest.set_node(pos1, {name="nssb:mornar"})
						end
					end
				end
			end
		end,
	})

	minetest.register_craft({
		output = 'nssm:mornar_bomb 6',
		recipe = {
			{'nssm:wrathful_soul_fragment', 'nssm:black_powder', 'nssm:wrathful_soul_fragment'},
			{'nssm:black_powder', 'nssm:wrathful_soul_fragment', 'nssm:black_powder'},
			{'nssm:wrathful_soul_fragment', 'nssm:black_powder', 'nssm:wrathful_soul_fragment'},
		}
	})
end

nssm_register_throwitem("hole", "Hole Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = -10,0 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="air"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:hole_bomb 10',
	recipe = {
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:digested_sand', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
	}
})

nssm_register_throwitem("food", "Food Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = -1,1 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="air"})
						minetest.add_item(pos1, "nssm:roasted_duck_legs")
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:food_bomb 8',
	recipe = {
		{'nssm:gluttonous_soul_fragment', 'nssm:black_powder', 'nssm:gluttonous_soul_fragment'},
		{'nssm:black_powder', 'nssm:gluttonous_soul_fragment', 'nssm:black_powder'},
		{'nssm:gluttonous_soul_fragment', 'nssm:black_powder', 'nssm:gluttonous_soul_fragment'},
	}
})

nssm_register_throwitem("phoenix_fire", "Phoenix Fire Bomb", {
    hit_node = function(self,pos)
        for dx = -2,2 do
            for dy = 0,1 do
                for dz = -2,2 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="nssm:phoenix_fire"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:phoenix_fire_bomb 10',
	recipe = {
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:sun_feather', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
	}
})

nssm_register_throwitem("kaboom", "Explosive Bomb", {
    hit_node = function(self,pos)
                    local pos1 = {x = pos.x, y=pos.y, z=pos.z}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        tnt.boom(pos1, {damage_radius=3,radius=2,ignore_protection=false})
                    end
    end,
})

minetest.register_craft({
	output = 'nssm:kaboom_bomb 3',
	recipe = {
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
	}
})

nssm_register_throwitem("teleport", "Teleport Bomb", {
    hit_node = function(self,pos,placer)
                    local pos1 = {x = pos.x, y=pos.y+1, z=pos.z}
					local pos2 = {x = pos.x, y=pos.y+2, z=pos.z}
						if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
							for _,obj in ipairs(minetest.get_objects_inside_radius(posthrow, 2)) do
								if obj:is_player() then
									obj:setpos(pos1)
									minetest.set_node(pos1, {name="air"})
									minetest.set_node(pos2, {name="air"})
								end
							end
						end
    end,
})

minetest.register_craft({
	output = 'nssm:teleport_bomb 10',
	recipe = {
		{'nssm:slothful_soul_fragment', 'nssm:black_powder', 'nssm:slothful_soul_fragment'},
		{'nssm:black_powder', 'nssm:slothful_soul_fragment', 'nssm:black_powder'},
		{'nssm:slothful_soul_fragment', 'nssm:black_powder', 'nssm:slothful_soul_fragment'},
	}
})

nssm_register_throwitem("boom", "Boom Bomb", {
    hit_node = function(self,pos)
                    local pos1 = {x = pos.x, y=pos.y, z=pos.z}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        tnt.boom(pos1, {damage_radius=4,radius=3,ignore_protection=false})
                    end
    end,
})

minetest.register_craft({
	output = 'nssm:boom_bomb 10',
	recipe = {
		{'nssm:greedy_soul_fragment', 'nssm:black_powder', 'nssm:greedy_soul_fragment'},
		{'nssm:black_powder', 'nssm:greedy_soul_fragment', 'nssm:black_powder'},
		{'nssm:greedy_soul_fragment', 'nssm:black_powder', 'nssm:greedy_soul_fragment'},
	}
})

nssm_register_throwitem("smoke", "Smoke Bomb", {
    hit_node = function(self,pos)
                    local pos1 = {x = pos.x, y=pos.y, z=pos.z}
                    minetest.add_particlespawner({
						amount = 6000,
						time = 20,
						minpos = {x=pos1.x-3, y=pos1.y+0.5, z=pos1.z-3},
						maxpos = {x=pos1.x+3, y=pos1.y+0.5, z=pos1.z+3},
						minvel = {x=0.2, y=0.2, z=0.2},
						maxvel = {x=0.4, y=0.8, z=0.4},
						minacc = {x=-0.2,y=0,z=-0.2},
						maxacc = {x=0.2,y=0.1,z=0.2},
						minexptime = 6,
						maxexptime = 8,
						minsize = 10,
						maxsize = 12,
						collisiondetection = false,
						vertical = false,
						texture = "tnt_smoke.png",})
    end,
})

minetest.register_craft({
	output = 'nssm:smoke_bomb 6',
	recipe = {
		{'nssm:proud_soul_fragment', 'nssm:black_powder', 'nssm:proud_soul_fragment'},
		{'nssm:black_powder', 'nssm:proud_soul_fragment', 'nssm:black_powder'},
		{'nssm:proud_soul_fragment', 'nssm:black_powder', 'nssm:proud_soul_fragment'},
	}
})

nssm_register_throwitem("thick_web", "Thick Web Bomb", {
    hit_node = function(self,pos)
                    local pos1 = {x = pos.x, y=pos.y+1, z=pos.z}
					local pos2 = {x = pos.x, y=pos.y+2, z=pos.z}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
						minetest.set_node(pos1, {name="nssm:thick_web"})
						minetest.set_node(pos2, {name="nssm:thick_web"})
                    end
    end,
})

minetest.register_craft({
	output = 'nssm:thick_web_bomb 12',
	recipe = {
		{'nssm:super_silk_gland', 'nssm:black_powder', 'nssm:super_silk_gland'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:super_silk_gland', 'nssm:black_powder', 'nssm:super_silk_gland'},
	}
})

nssm_register_throwitem("poison", "Poison Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = 1,3 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="nssm:venomous_gas"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:poison_bomb 10',
	recipe = {
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:snake_scute', 'nssm:black_powder'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
	}
})

nssm_register_throwitem("stone", "Cobblestone Bomb", {
    hit_node = function(self,pos)
        for dx = -1,1 do
            for dy = 1,3 do
                for dz = -1,1 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="default:cobble"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:stone_bomb 6',
	recipe = {
		{'default:stone', 'nssm:black_powder', 'default:stone'},
		{'nssm:black_powder', 'nssm:black_powder', 'nssm:black_powder'},
		{'default:stone', 'nssm:black_powder', 'default:stone'},
	}
})

nssm_register_throwitem("fire_ring", "Fire Ring Bomb", {
    hit_node = function(self,pos)
        for dx = -2,2 do
            for dy = 1,2 do
                for dz = -2,2 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="fire:basic_flame"})
						 for dx = -1,1 do
							for dy = 1,2 do
								for dz = -1,1 do
									local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
									minetest.set_node(pos1, {name="air"})
								end
							end
						end
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:fire_ring_bomb 3',
	recipe = {
		{'fire:flint_and_steel', 'fire:flint_and_steel', 'fire:flint_and_steel'},
		{'fire:flint_and_steel', 'nssm:black_powder', 'fire:flint_and_steel'},
		{'fire:flint_and_steel', 'fire:flint_and_steel', 'fire:flint_and_steel'},
	}
})

if minetest.get_modpath("nssb") then
	nssm_register_throwitem("cage", "Cage Bomb", {
		hit_node = function(self,pos)
			for dx = -2,2 do
				for dy = 0,3 do
					for dz = -2,2 do
						local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
						if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
							minetest.set_node(pos1, {name="nssb:morentir"})
							 for dx = -1,1 do
								for dy = 1,2 do
									for dz = -1,1 do
										local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
										minetest.set_node(pos1, {name="air"})
									end
								end
							end
						end
					end
				end
			end
		end,
	})

	minetest.register_craft({
		output = 'nssm:cage_bomb 10',
		recipe = {
			{'nssm:lustful_soul_fragment', 'nssm:black_powder', 'nssm:lustful_soul_fragment'},
			{'nssm:black_powder', 'nssm:lustful_soul_fragment', 'nssm:black_powder'},
			{'nssm:lustful_soul_fragment', 'nssm:black_powder', 'nssm:lustful_soul_fragment'},
		}
	})
end
	
nssm_register_throwitem("water_column", "Water Column Bomb", {
    hit_node = function(self,pos)
        for dx = 0,0 do
            for dy = 1,10 do
                for dz = 0,0 do
                    local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name="default:water_source"})
                    end
                end
            end
        end
    end,
})

minetest.register_craft({
	output = 'nssm:water_column_bomb 6',
	recipe = {
		{'bucket:bucket_water', 'nssm:black_powder', 'bucket:bucket_water'},
		{'bucket:bucket_water', 'nssm:black_powder', 'bucket:bucket_water'},
		{'bucket:bucket_water', 'nssm:black_powder', 'bucket:bucket_water'},
	}
})

minetest.register_craft({
	output = 'nssm:empty_evocation_bomb 10',
	recipe = {
		{'nssm:envious_soul_fragment', 'nssm:black_powder', 'nssm:envious_soul_fragment'},
		{'nssm:black_powder', 'nssm:envious_soul_fragment', 'nssm:black_powder'},
		{'nssm:envious_soul_fragment', 'nssm:black_powder', 'nssm:envious_soul_fragment'},
	}
})

function nssm_register_throwegg(name, descr, def)

    minetest.register_craftitem("nssm:"..name.."_bomb", {
        description = descr,
        inventory_image = "evocation_bomb.png^"..name.."_egg.png",
        on_use = function(itemstack, placer, pointed_thing)
            --weapons_shot(itemstack, placer, pointed_thing, def.velocity, name)
            local velocity = 15
            local dir = placer:get_look_dir();
            local playerpos = placer:getpos();
            local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "nssm:"..name.."_bomb_flying")
            local vec = {x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity}
            local acc = {x=0, y=-9.8, z=0}
            obj:setvelocity(vec)
            obj:setacceleration(acc)
            itemstack:take_item()
            return itemstack
        end,
    })

    minetest.register_entity("nssm:"..name.."_bomb_flying",{
        textures = {"evocation_bomb.png^"..name.."_egg.png"},
        on_step = function(self, dtime)
            local pos = self.object:getpos()
            local node = minetest.get_node(pos)
            local n = node.name
            if n ~= "air" then
                def.hit_node(self, pos)
                self.object:remove()
            end
        end,
    })
end

function nssm_register_evocation (evomob, evodescr, numbe)

nssm_register_throwegg(evomob, evodescr.." Bomb", {
    hit_node = function(self,pos)
                    local pos1 = {x = pos.x, y=pos.y+1, z=pos.z}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                       for n=1,numbe do
							minetest.add_entity(pos1, "nssm:".. evomob)
					   end
                    end
    end,
})

minetest.register_craft({
	output = 'nssm:'..evomob.."_bomb",
	type = "shapeless",
	recipe = {'nssm:empty_evocation_bomb', 'nssm:'..evomob},

})

minetest.register_craft({
	output = 'nssm:duckking_bomb',
	type = "shapeless",
	recipe = {'nssm:empty_evocation_bomb', 'nssm:duckking_egg'},

})
end

nssm_register_evocation ("duck","Duck Evocation", 4)
nssm_register_evocation ("bloco","Bloco Evocation", 3)
nssm_register_evocation ("enderduck","Enderduck Evocation", 2)
nssm_register_evocation ("flying_duck","Flying Duck Evocation", 3)
nssm_register_evocation ("swimming_duck","Swimming Duck Evocation", 3)
nssm_register_evocation ("duckking","Duckking Evocation", 1)
nssm_register_evocation ("spiderduck","Spiderduck Evocation", 2)
