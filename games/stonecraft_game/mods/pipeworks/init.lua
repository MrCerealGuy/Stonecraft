-- Pipeworks mod by Vanessa Ezekowitz - 2013-07-13
--
-- This mod supplies various steel pipes and plastic pneumatic tubes
-- and devices that they can connect to.
--

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("pipeworks") then return end

pipeworks = {}

pipeworks.worldpath = minetest.get_worldpath()
pipeworks.modpath = minetest.get_modpath("pipeworks")
local S = minetest.get_translator("pipeworks")

dofile(pipeworks.modpath.."/default_settings.lua")
-- Read the external config file if it exists.
local worldsettingspath = pipeworks.worldpath.."/pipeworks_settings.txt"
local worldsettingsfile = io.open(worldsettingspath, "r")
if worldsettingsfile then
	worldsettingsfile:close()
	dofile(worldsettingspath)
end
if pipeworks.toggles.pipe_mode == "pressure" then
	minetest.log("warning", "pipeworks pressure logic mode comes with caveats and differences in behaviour, you have been warned!")
end

-- Random variables

pipeworks.expect_infinite_stacks = true
if minetest.get_modpath("unified_inventory") or not minetest.settings:get_bool("creative_mode") then
	pipeworks.expect_infinite_stacks = false
end

pipeworks.meseadjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}}

pipeworks.rules_all = {{x=0, y=0, z=1},{x=0, y=0, z=-1},{x=1, y=0, z=0},{x=-1, y=0, z=0},
		{x=0, y=1, z=1},{x=0, y=1, z=-1},{x=1, y=1, z=0},{x=-1, y=1, z=0},
		{x=0, y=-1, z=1},{x=0, y=-1, z=-1},{x=1, y=-1, z=0},{x=-1, y=-1, z=0},
		{x=0, y=1, z=0}, {x=0, y=-1, z=0}}

pipeworks.mesecons_rules={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=1,y=0,z=0},{x=-1,y=0,z=0},{x=0,y=1,z=0},{x=0,y=-1,z=0}}
pipeworks.digilines_rules={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=1,y=0,z=0},{x=-1,y=0,z=0},{x=0,y=1,z=0},{x=0,y=-1,z=0}}

pipeworks.liquid_texture = "default_water.png"

pipeworks.button_off   = {text="", texture="pipeworks_button_off.png", addopts="false;false;pipeworks_button_interm.png"}
pipeworks.button_on    = {text="", texture="pipeworks_button_on.png",  addopts="false;false;pipeworks_button_interm.png"}
pipeworks.button_base  = "image_button[0,4.3;1,0.6"
pipeworks.button_label = "label[0.9,4.31;"..S("Allow splitting incoming stacks from tubes").."]"

-- Helper functions

function pipeworks.fix_image_names(table, replacement)
	local outtable={}
	for i in ipairs(table) do
		outtable[i]=string.gsub(table[i], "_XXXXX", replacement)
	end

	return outtable
end

function pipeworks.add_node_box(t, b)
	if not t or not b then return end
	for i in ipairs(b)
		do table.insert(t, b[i])
	end
end

function pipeworks.may_configure(pos, player)
	local name = player:get_player_name()
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if owner ~= "" and owner == name then -- wielders and filters
		return true
	end
	return not minetest.is_protected(pos, name)
end

function pipeworks.replace_name(tbl,tr,name)
	local ntbl={}
	for key,i in pairs(tbl) do
		if type(i)=="string" then
			ntbl[key]=string.gsub(i,tr,name)
		elseif type(i)=="table" then
			ntbl[key]=pipeworks.replace_name(i,tr,name)
		else
			ntbl[key]=i
		end
	end
	return ntbl
end

pipeworks.logger = function(msg)
	print("[pipeworks] "..msg)
end

-------------------------------------------
-- Load the various other parts of the mod

-- early auto-detection for finite water mode if not explicitly disabled
if pipeworks.toggles.finite_water == nil then
	dofile(pipeworks.modpath.."/autodetect-finite-water.lua")
end

if minetest.get_modpath("signs_lib") then
	dofile(pipeworks.modpath.."/signs_compat.lua")
end

dofile(pipeworks.modpath.."/common.lua")
dofile(pipeworks.modpath.."/models.lua")
dofile(pipeworks.modpath.."/autoplace_pipes.lua")
dofile(pipeworks.modpath.."/autoplace_tubes.lua")
dofile(pipeworks.modpath.."/luaentity.lua")
dofile(pipeworks.modpath.."/item_transport.lua")
dofile(pipeworks.modpath.."/flowing_logic.lua")
dofile(pipeworks.modpath.."/crafts.lua")
dofile(pipeworks.modpath.."/tube_registration.lua")
dofile(pipeworks.modpath.."/routing_tubes.lua")
dofile(pipeworks.modpath.."/sorting_tubes.lua")
dofile(pipeworks.modpath.."/vacuum_tubes.lua")
dofile(pipeworks.modpath.."/signal_tubes.lua")
dofile(pipeworks.modpath.."/decorative_tubes.lua")
dofile(pipeworks.modpath.."/filter-injector.lua")
dofile(pipeworks.modpath.."/trashcan.lua")
dofile(pipeworks.modpath.."/wielder.lua")

local logicdir = "/pressure_logic/"

-- note that even with these files the new flow logic is not yet default.
-- registration will take place but no actual ABMs/node logic will be installed,
-- unless the toggle flag is specifically enabled in the per-world settings flag.
dofile(pipeworks.modpath..logicdir.."flowable_node_registry.lua")
dofile(pipeworks.modpath..logicdir.."abms.lua")
dofile(pipeworks.modpath..logicdir.."abm_register.lua")
dofile(pipeworks.modpath..logicdir.."flowable_node_registry_install.lua")

if pipeworks.enable_pipes then dofile(pipeworks.modpath.."/pipes.lua") end
if pipeworks.enable_teleport_tube then dofile(pipeworks.modpath.."/teleport_tube.lua") end
if pipeworks.enable_pipe_devices then dofile(pipeworks.modpath.."/devices.lua") end
if pipeworks.enable_redefines then
	dofile(pipeworks.modpath.."/compat-chests.lua")
	dofile(pipeworks.modpath.."/compat-furnaces.lua")
end
if pipeworks.enable_autocrafter then dofile(pipeworks.modpath.."/autocrafter.lua") end
if pipeworks.enable_lua_tube and
		(minetest.get_modpath("mesecons") and not core.skip_mod("mesecons") 
			or minetest.get_modpath("digilines") and not core.skip_mod("digilines")) then
	dofile(pipeworks.modpath.."/lua_tube.lua")
end

minetest.register_alias("pipeworks:pipe", "pipeworks:pipe_110000_empty")

minetest.log("info", "Pipeworks loaded!")
