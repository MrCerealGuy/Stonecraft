
local S = minetest.get_translator("mobs")

-- add lucky blocks

lucky_block:add_blocks({
	{"dro", {"mobs:meat_raw"}, 5},
	{"dro", {"mobs:meat"}, 5},
	{"dro", {"mobs:nametag"}, 1},
	{"dro", {"mobs:leather"}, 5},
	{"dro", {"default:stick"}, 10},
	{"dro", {"mobs:net"}, 1},
	{"dro", {"mobs:lasso"}, 1},
	{"dro", {"mobs:shears"}, 1},
	{"dro", {"mobs:protector"}, 1},
	{"dro", {"mobs:fence_wood"}, 10},
	{"dro", {"mobs:fence_top"}, 12},
	{"lig"},
	{"dro", {"mobs:mob_repellent"}, 1}
})

-- pint sized rune, use on tamed mob to shrink to half-size

minetest.register_craftitem(":mobs:pint_sized_rune", {
	description = S("Pint Sized Rune"),
	inventory_image = "mobs_pint_sized_rune.png",
	groups = {flammable = 2},

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "object" then return end

		local name = user and user:get_player_name() or ""
		local tool = user and user:get_wielded_item()
		local tool_name = tool:get_name()

		if tool_name ~= "mobs:pint_sized_rune" then return end

		local self = pointed_thing.ref:get_luaentity()

		if not self._cmi_is_mob then
			minetest.chat_send_player(name, S("Not a Mobs Redo mob!"))
			return
		end

		if not self.tamed then
			minetest.chat_send_player(name, S("Not tamed!"))
			return
		end

		if self.pint_size_potion then
			minetest.chat_send_player(name, S("Potion already applied!"))
			return
		end

		if not mobs.is_creative(user:get_player_name()) then
			tool:take_item() -- take 1 rune
			user:set_wielded_item(tool)
		end

		local pos = self.object:get_pos()
		local prop = self.object:get_properties()

		vis_size = {x = self.base_size.x * .5, y = self.base_size.y * .5}

		self.base_size = vis_size

		colbox = {
			self.base_colbox[1] * .5, self.base_colbox[2] * .5,
			self.base_colbox[3] * .5, self.base_colbox[4] * .5,
			self.base_colbox[5] * .5, self.base_colbox[6] * .5}

		self.base_colbox = colbox

		selbox = {
			self.base_selbox[1] * .5, self.base_selbox[2] * .5,
			self.base_selbox[3] * .5, self.base_selbox[4] * .5,
			self.base_selbox[5] * .5, self.base_selbox[6] * .5}

		self.base_selbox = selbox

		self.object:set_properties(
				{visual_size = vis_size, collisionbox = colbox, selectionbox = selbox})

		self.pint_size_potion = true

		pos.y = pos.y + prop.collisionbox[5]

		mobs:effect(pos, 25, "mobs_protect_particle.png", 0.5, 4, 2, 15)

		self:mob_sound("mobs_spell")
	end
})

minetest.register_craft({
	output = "lucky_block:pint_sized_rune",
	recipe = {{"lucky_block:pint_sized_potion", "mobs:protector"}}
})
