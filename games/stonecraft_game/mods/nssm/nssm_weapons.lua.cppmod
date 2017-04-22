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
    local node = nssm:node_ok(pos).name
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
        local node = nssm:node_ok(pos).name
        self.hit_node(self, pos, node)
        self.object:remove()
        return
    end

    self.timer = self.timer + dtime

    --while going around it damages entities
    local objects = minetest.env:get_objects_inside_radius(pos, 2)
    if self.timer > 0.3 then
        for _,obj in ipairs(objects) do
            obj:set_hp(obj:get_hp()-damage)
            if (obj:get_hp() <= 0) then
                if (not obj:is_player()) and obj:get_entity_name() ~= self.object:get_luaentity().name then
                    obj:remove()
                end
            end
        end
    end

    local n = minetest.env:get_node(pos).name
    if n==not_transparent or minetest.get_item_group(n, not_transparent)==1 then
        local node = nssm:node_ok(pos).name
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
        timer = 0
    })

    minetest.register_tool("nssm:"..name.."_hand", {
        description = def.description,
        inventory_image = name.."_hand.png",
        on_use = function(itemstack, placer, pointed_thing)
            weapons_shot(itemstack, placer, pointed_thing, def.velocity, name)
            return itemstack
        end,
        on_drop = def.on_drop or function(itemstack, user, pointed_thing)
		end,
    })

    minetest.register_craft({
		output = 'nssm:'..name.."_hand",
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
        nssm:explosion(pos, 6, 1)
    end,
    material = "default:diamondblock",
    description = "Kamehameha from DragonBall",

})

nssm_register_weapon("kienzan", {
    velocity = 25,
    on_step = function(self, dtime)
        default_on_step(self, dtime, 5, 20, {x=1, y=0, z=1}, 1, nil, 25)
    end,
    hit_node = function(self, pos, node)
    end,
    material = "nssm:king_duck_crown",
    description = "Kienzan from DragonBall",
})

nssm_register_weapon("spirit_ball", {
    velocity = 25,
    move = 0,
    on_step = function(self, dtime)
        search_on_step(self, dtime, 5, 30, 25)
    end,
    hit_node = function(self, pos, node)
        nssm:explosion(pos, 4, 0)
    end,

    material = "nssm:cursed_pumpkin_seed",
    description = "Spirit Ball from DragonBall",
})

nssm_register_weapon("hellzone_grenade", {
    velocity = 25,
    move = 0,
    on_step = function(self, dtime)
        search_on_step2(self, dtime, 30, 30, 25)
    end,
    hit_node = function(self, pos, node)
        nssm:explosion(pos, 4, 0)
    end,

    on_drop = function(itemstack, user, pointed_thing)
        local pos = user:getpos()
        activate_balls(pos)
    end,
    material = "nssm:snake_scute",
    description = "Hellzone grenade (Press q to activate)",
})
