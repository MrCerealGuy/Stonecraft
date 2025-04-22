
-- emerge a part of the world (basic smoketest)
mtt.emerge_area({ x=0, y=0, z=0 }, { x=10, y=10, z=10 })

-- check nodelist
local mtt_nodelist = minetest.settings:get("mtt_nodelist")
if mtt_nodelist then
    -- nodelist specified, check if all the required nodes are present
    mtt.validate_nodenames(minetest.get_modpath("xcompat") .. "/test/nodelist/" .. mtt_nodelist)
end