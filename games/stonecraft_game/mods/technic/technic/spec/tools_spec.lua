require("mineunit")
--[[
	Technic tool regression tests.
	Execute mineunit at technic source directory.
--]]

-- Load complete technic mod
fixture("technic")
sourcefile("init")

describe("Technic power tool", function()

	world.set_default_node("air")

	-- HV battery box and some HV solar arrays for charging
	local BB_Charge_POS = {x=0,y=51,z=0}
	local BB_Discharge_POS = {x=0,y=51,z=2}
	world.layout({
		-- Network with generators for charging tools in battery box
		{BB_Charge_POS, "technic:hv_battery_box0"},
		{{x=1,y=51,z=0}, "technic:switching_station"},
		{{{x=2,y=51,z=0},{x=10,y=51,z=0}}, "technic:solar_array_hv"},
		{{{x=0,y=50,z=0},{x=10,y=50,z=0}}, "technic:hv_cable"},
		-- Network without generators for discharging tools in battery box
		{BB_Discharge_POS, "technic:hv_battery_box0"},
		{{x=1,y=51,z=2}, "technic:switching_station"},
		{{{x=0,y=50,z=2},{x=1,y=50,z=2}}, "technic:hv_cable"},
	})

	-- Some helpers to make stack access simpler
	local player = Player("SX")
	local charge_inv = minetest.get_meta(BB_Charge_POS):get_inventory()
	local discharge_inv = minetest.get_meta(BB_Discharge_POS):get_inventory()
	local function set_charge_stack(stack) charge_inv:set_stack("src", 1, stack) end
	local function get_charge_stack() return charge_inv:get_stack("src", 1) end
	local function set_discharge_stack(stack) discharge_inv:set_stack("dst", 1, stack) end
	local function get_discharge_stack() return discharge_inv:get_stack("dst", 1) end
	local function set_player_stack(stack) return player:get_inventory():set_stack("main", 1, stack) end
	local function get_player_stack() return player:get_inventory():get_stack("main", 1) end

	-- Execute on mods loaded callbacks to finish loading.
	mineunit:mods_loaded()
	-- Tell mods that 1 minute passed already to execute all weird minetest.after hacks.
	mineunit:execute_globalstep(60)

	describe("API", function()

		local TOOLNAME = "mymod:powertool1"

		setup(function()
			set_charge_stack(ItemStack(nil))
			set_discharge_stack(ItemStack(nil))
			mineunit:set_current_modname("mymod")
			mineunit:execute_on_joinplayer(player)
		end)

		teardown(function()
			mineunit:execute_on_leaveplayer(player)
			mineunit:restore_current_modname()
		end)

		local use_RE_charge_result

		it("technic.register_power_tool works", function()
			core.register_item(TOOLNAME, {
				type = "tool",
				description = "My Mod Power Tool",
				inventory_image = "mymod_powertool.png",
				wear_represents = "technic_RE_charge",
				on_use = function(itemstack, player, pointed_thing)
					use_RE_charge_result = technic.use_RE_charge(itemstack, 123)
					return itemstack
				end,
			})
			technic.power_tools[TOOLNAME] = 1234
			local itemdef = minetest.registered_items[TOOLNAME]
			assert.is_hashed(itemdef)
		end)

		it("technic.use_RE_charge works (zero charge)", function()
			local stack = ItemStack(TOOLNAME)
			local use_RE_charge_result = technic.use_RE_charge(stack, 123)
			assert.equals("boolean", type(use_RE_charge_result))
			assert.is_false(use_RE_charge_result)
		end)

		it("technic.get_RE_charge works (zero charge)", function()
			local stack = ItemStack(TOOLNAME)
			local charge, max_charge = technic.get_RE_charge(stack)
			assert.equals(0, charge)
			assert.equals(1234, max_charge)
		end)

		it("technic.set_RE_charge works (zero charge -> 123)", function()
			local stack = ItemStack(TOOLNAME)
			technic.set_RE_charge(stack, 123)
			assert.equals(123, technic.get_RE_charge(stack))
		end)

		it("technic.use_RE_charge works (minimum charge)", function()
			-- Add partially charged tool to player inventory
			local stack = ItemStack(TOOLNAME)
			technic.set_RE_charge(stack, 123)
			set_player_stack(stack)

			-- Use tool and verify results
			spy.on(technic, "use_RE_charge")
			player:do_use(player:get_pos())
			assert.spy(technic.use_RE_charge).called(1)
			assert.equals("boolean", type(use_RE_charge_result))
			assert.is_true(use_RE_charge_result)
			assert.equals(0, technic.get_RE_charge(get_player_stack()))
		end)

		it("technic.use_RE_charge works (minimum charge + 1)", function()
			-- Add partially charged tool to player inventory
			local stack = ItemStack(TOOLNAME)
			technic.set_RE_charge(stack, 124)
			set_player_stack(stack)
			-- Use tool and verify results
			player:do_use(player:get_pos())
			assert.equals(1, technic.get_RE_charge(get_player_stack()))
		end)

	end)

	describe("Flashlight", function()

		local itemname = "technic:flashlight"
		local itemdef = minetest.registered_items[itemname]

		setup(function()
			set_charge_stack(ItemStack(nil))
			set_discharge_stack(ItemStack(nil))
			mineunit:execute_on_joinplayer(player)
		end)

		teardown(function()
			mineunit:execute_on_leaveplayer(player)
		end)

		it("is registered", function()
			assert.is_hashed(itemdef)
			assert.is_function(itemdef.on_refill)
			assert.equals("technic_RE_charge", itemdef.wear_represents)
			assert.is_number(technic.power_tools[itemname])
			assert.gt(technic.power_tools[itemname], 0)
		end)

		it("charge is used", function()
			-- Get fully charged item
			local stack = ItemStack(itemname)
			technic.set_RE_charge(stack, technic.power_tools[itemname])
			set_player_stack(stack)

			-- Use item, flashlight charge is used every globalstep and there's no on_use definition
			for i=1, 100 do
				mineunit:execute_globalstep(1)
			end

			-- Check that item charge was actually used and error is acceptable
			local charge_used = technic.power_tools[itemname] - technic.get_RE_charge(get_player_stack())
			local exact_use = 2 * 100 -- 2 per cycle / 100 cycles
			assert.lt(0.9, charge_used / exact_use)
			assert.gt(1.1, charge_used / exact_use)
		end)

	end)

	describe("battery box", function()

		local TOOLNAME = "mymod:powertool2"
		local count_technic_get_charge
		local count_technic_set_charge

		setup(function()
			mineunit:set_current_modname("mymod")
			core.register_item(TOOLNAME, {
				type = "tool",
				description = "My Mod Power Tool",
				inventory_image = "mymod_powertool.png",
				wear_represents = "technic_RE_charge",
				technic_get_charge = function(itemstack)
					assert.is_ItemStack(itemstack)
					count_technic_get_charge = count_technic_get_charge + 1
					return technic.get_charge(itemstack)
				end,
				technic_set_charge = function(itemstack, charge)
					assert.is_ItemStack(itemstack)
					assert.is_number(charge)
					count_technic_set_charge = count_technic_set_charge + 1
					return technic.set_charge(itemstack, charge)
				end,
				on_use = function(itemstack, player, pointed_thing)
					use_RE_charge_result = technic.use_RE_charge(itemstack, 123)
					return itemstack
				end,
			})
			technic.power_tools[TOOLNAME] = 100000
			mineunit:restore_current_modname()
			mineunit:execute_on_joinplayer(player)
		end)

		teardown(function()
			mineunit:execute_on_leaveplayer(player)
		end)

		before_each(function()
			set_charge_stack(ItemStack(nil))
			set_discharge_stack(ItemStack(nil))
			count_technic_get_charge = 0
			count_technic_set_charge = 0
		end)

		local use_RE_charge_result

		it("registered test tool", function()
			local itemdef = minetest.registered_items[TOOLNAME]
			assert.is_hashed(itemdef)
		end)

		it("discharges tool", function()
			-- Add partially charged tool to player inventory
			local stack = ItemStack(TOOLNAME)
			technic.set_RE_charge(stack, 100000)
			set_discharge_stack(stack)
			-- First discharge step, 60k charge (discharge step is 40k/each)
			mineunit:execute_globalstep(1)
			assert.equals(60000, technic.get_RE_charge(get_discharge_stack()))
			-- Second discharge steps, 20k charge
			mineunit:execute_globalstep(1)
			assert.equals(20000, technic.get_RE_charge(get_discharge_stack()))
			-- Last discharge step, no charge
			mineunit:execute_globalstep(1)
			assert.equals(0, technic.get_RE_charge(get_discharge_stack()))
			-- technic.get_RE_charge does not currently use technic_get_charge
			assert.equals(count_technic_get_charge, 3)
			assert.equals(count_technic_set_charge, 3)
		end)

		it("charges tool", function()
			-- Add partially charged tool to player inventory
			local stack = ItemStack(TOOLNAME)
			set_charge_stack(stack)
			-- First charge step, 10k charge (charge step is 10k/each)
			mineunit:execute_globalstep(1)
			assert.equals(10000, technic.get_RE_charge(get_charge_stack()))
			-- Eight charge steps, 90k charge
			for i = 1, 8 do mineunit:execute_globalstep(1) end
			assert.equals(90000, technic.get_RE_charge(get_charge_stack()))
			-- Last charge step, full charge
			mineunit:execute_globalstep(1)
			assert.equals(100000, technic.get_RE_charge(get_charge_stack()))
			-- technic.get_RE_charge does not currently use technic_get_charge
			assert.equals(count_technic_get_charge, 10)
			assert.equals(count_technic_set_charge, 10)
		end)

	end)

end)
