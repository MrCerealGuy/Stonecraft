--! @class vombie_flame
--! @ingroup weapons
--! @brief a plasmaball weapon entity
vombie_flame = {
	physical = false,
	textures = {"animal_vombie_flames.png"},
	visual          = "sprite",
	collisionbox = {0,0,0,0,0,0},
	spritediv = {x=1,y=16},
	--vizual_size = {x=0.1,y=0.1},

	velocity = 1.0,
	gravity = -0.1,

	damage = 8,

	leveltime = 2.5,
	created = -1,
	leveldtime = 0,
	level = 0,
}

-------------------------------------------------------------------------------
-- name: vombie_flame.on_activate = function(self, staticdata)
--
--! @brief onactivate callback for plasmaball
--! @memberof vombie_flame
--! @private
--
--! @param self fireball itself
--! @param staticdata 
-------------------------------------------------------------------------------
function vombie_flame.on_activate(self,staticdata)
	self.created = mobf_get_current_time()
	self.object:setsprite({x=0,y=self.level}, 1, 0, true)
	self.object:setvelocity({x=0,y=self.velocity,z=0})
end

-------------------------------------------------------------------------------
-- name: vombie_flame.on_step = function(self, dtime)
--
--! @brief onstep callback for vombie flame
--! @memberof vombie_flame
--! @private
--
--! @param vombie_flame itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
function vombie_flame.on_step(self, dtime)
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)
	
	self.leveldtime = self.leveldtime + dtime
	
	if (self.leveldtime *10) > math.random()*self.leveltime then
		self.level = self.level +1
		
		if (self.level < 16) then
			self.object:setsprite({x=0,y=self.level}, 1, 0, true)
		else
			self.object:remove()
		end
		self.leveldtime = 0
	end
end

minetest.register_entity(":animal_vombie:vombie_flame", vombie_flame)