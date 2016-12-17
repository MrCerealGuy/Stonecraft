local load_time_start = os.clock()


if minetest.register_fence then
	error("[fence_registration] minetest.register_fence already exists")
end

local to_copy = {"tiles", "use_texture_alpha", "post_effect_color",
	"is_ground_content", "walkable", "pointable", "diggable", "climbable",
	"buildable_to", "light_source", "damage_per_second", "sounds", "groups"}

function minetest.register_fence(fencedata, extradef)
	local origname = fencedata.fence_of
	local origdef = minetest.registered_nodes[origname]
	if not origdef then
		error("[fence_registration] "..origname.." must exist before adding a fence for it")
	end

	local def = {}
	for _,i in pairs(to_copy) do
		def[i] = rawget(origdef, i)
	end

	def.drawtype = "fencelike"
	def.paramtype = "light"
	def.sunlight_propagates = true
	--[[ a fitting selection box gets added automatically at builtin
	def.selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	}--]]
	if origdef.description then
		def.description = origdef.description.." fence"
	end
	local texture = "default_fence_overlay.png^"..
		(fencedata.texture or def.tiles[1])..
		"^default_fence_overlay.png^[makealpha:255,126,126"
	def.inventory_image = texture
	def.wield_image = texture

	if extradef then
		for i,v in pairs(extradef) do
			def[i] = v
		end
	end

	local modname, nodename = unpack(string.split(origname, ":"))
	local name = modname..":fence_"..nodename
	minetest.register_node(":"..name, def)

	if fencedata.add_crafting == false then
		return
	end

	local input = fencedata.recipe or origname
	minetest.register_craft({
		output = name.." 3",
		recipe = {
			{input, input, input},
			{input, input, input}
		}
	})
end


local time = math.floor(tonumber(os.clock()-load_time_start)*100+0.5)/100
local msg = "[fence_registration] loaded after ca. "..time
if time > 0.05 then
	print(msg)
else
	minetest.log("info", msg)
end
