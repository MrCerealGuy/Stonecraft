local S = minetest.get_translator("basic_materials")

minetest.register_craftitem("basic_materials:plastic_sheet", {
	description = S("Plastic sheet"),
	inventory_image = "basic_materials_plastic_sheet.png",
})

minetest.register_craftitem("basic_materials:plastic_strip", {
	description = S("Plastic strips"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_plastic_strip.png",
})

minetest.register_craftitem("basic_materials:empty_spool", {
	description = S("Empty wire spool"),
	inventory_image = "basic_materials_empty_spool.png"
})

minetest.register_craftitem("basic_materials:oil_extract", {
	description = S("Oil extract"),
	inventory_image = "basic_materials_oil_extract.png",
})

minetest.register_craftitem("basic_materials:paraffin", {
	description = S("Unprocessed paraffin"),
	inventory_image = "basic_materials_paraffin.png",
})

minetest.register_craftitem("basic_materials:terracotta_base", {
	description = S("Uncooked Terracotta Base"),
	inventory_image = "basic_materials_terracotta_base.png",
})

minetest.register_craftitem("basic_materials:wet_cement", {
	description = S("Wet Cement"),
	inventory_image = "basic_materials_wet_cement.png",
})

minetest.register_craftitem("basic_materials:silicon", {
	description = S("Silicon lump"),
	inventory_image = "basic_materials_silicon.png",
})

minetest.register_craftitem("basic_materials:ic", {
	description = S("Simple Integrated Circuit"),
	inventory_image = "basic_materials_ic.png",
})

minetest.register_craftitem("basic_materials:motor", {
	description = S("Simple Motor"),
	inventory_image = "basic_materials_motor.png",
})

minetest.register_craftitem("basic_materials:heating_element", {
	description = S("Heating element"),
	inventory_image = "basic_materials_heating_element.png",
})

minetest.register_craftitem("basic_materials:energy_crystal_simple", {
	description = S("Simple energy crystal"),
	inventory_image = "basic_materials_energy_crystal.png",
})

minetest.register_craftitem("basic_materials:steel_wire", {
	description = S("Spool of steel wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_steel_wire.png"
})

minetest.register_craftitem("basic_materials:copper_wire", {
	description = S("Spool of copper wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_copper_wire.png"
})

minetest.register_craftitem("basic_materials:silver_wire", {
	description = S("Spool of silver wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_silver_wire.png"
})

minetest.register_craftitem("basic_materials:gold_wire", {
	description = S("Spool of gold wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_gold_wire.png"
})

minetest.register_craftitem("basic_materials:stainless_steel_wire", {
	description = S("Spool of stainless steel wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_stainless_steel_wire.png"
})

minetest.register_craftitem("basic_materials:aluminum_wire", {
	description = S("Spool of aluminum wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_aluminum_wire.png"
})

minetest.register_craftitem("basic_materials:steel_strip", {
	description = S("Steel Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_steel_strip.png"
})

minetest.register_craftitem("basic_materials:copper_strip", {
	description = S("Copper Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_copper_strip.png"
})

minetest.register_craftitem("basic_materials:lead_strip", {
	description = S("Lead Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_lead_strip.png"
})

minetest.register_craftitem("basic_materials:gold_strip", {
	description = S("Gold Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_gold_strip.png"
})

minetest.register_craftitem("basic_materials:stainless_steel_strip", {
	description = S("Stainless Steel Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_stainless_steel_strip.png"
})

minetest.register_craftitem("basic_materials:aluminum_strip", {
	description = S("Aluminum Strip"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_aluminum_strip.png"
})

minetest.register_craftitem("basic_materials:steel_bar", {
	description = S("Steel Bar"),
	inventory_image = "basic_materials_steel_bar.png",
})

minetest.register_craftitem("basic_materials:carbon_steel_bar", {
	description = S("Carbon Steel Bar"),
	inventory_image = "basic_materials_carbon_steel_bar.png",
})

minetest.register_craftitem("basic_materials:stainless_steel_bar", {
	description = S("Stainless Steel Bar"),
	inventory_image = "basic_materials_stainless_steel_bar.png",
})

minetest.register_craftitem("basic_materials:aluminum_bar", {
	description = S("Aluminum Bar"),
	inventory_image = "basic_materials_aluminum_bar.png",
})

minetest.register_craftitem("basic_materials:chainlink_brass", {
	description = S("Chainlinks (brass)"),
	groups = { chainlinks = 1 },
	inventory_image = "basic_materials_chainlink_brass.png"
})

minetest.register_craftitem("basic_materials:chainlink_steel", {
	description = S("Chainlinks (steel)"),
	groups = { chainlinks = 1 },
	inventory_image = "basic_materials_chainlink_steel.png"
})

minetest.register_craftitem("basic_materials:brass_ingot", {
	description = S("Brass Ingot"),
	inventory_image = "basic_materials_brass_ingot.png",
})

minetest.register_craftitem("basic_materials:gear_steel", {
	description = S("Steel gear"),
	inventory_image = "basic_materials_gear_steel.png"
})

minetest.register_craftitem("basic_materials:padlock", {
	description = S("Padlock"),
	inventory_image = "basic_materials_padlock.png"
})

if minetest.get_modpath("hades_materials") then
	minetest.register_alias_force("basic_materials:plastic_sheet", "hades_materials:plastic_sheeting")
	minetest.register_alias_force("basic_materials:paraffin", "hades_materials:plastic_base")
	minetest.register_alias_force("basic_materials:silicon", "hades_materials:silicon")
end

