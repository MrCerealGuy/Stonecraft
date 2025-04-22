local mod_storage = minetest.get_mod_storage()
local S = minetest.get_translator("toolranks")

toolranks = {}

toolranks.colors = {
  grey = minetest.get_color_escape_sequence("#9d9d9d"),
  green = minetest.get_color_escape_sequence("#1eff00"),
  gold = minetest.get_color_escape_sequence("#ffdf00"),
  white = minetest.get_color_escape_sequence("#ffffff")
}

local max_speed = tonumber(minetest.settings:get("toolranks_speed_multiplier")) or 2.0
local max_use = tonumber(minetest.settings:get("toolranks_use_multiplier")) or 2.0
local max_level = tonumber(minetest.settings:get("toolranks_levels")) or 10
local level_digs = tonumber(minetest.settings:get("toolranks_level_digs")) or 500
local level_multiplier = 1 / max_level

function toolranks.get_tool_type(description)
  if not description then
    return "tool"
  else
    local d = string.lower(description)
    if string.find(d, "pickaxe") then
      return "pickaxe"
    elseif string.find(d, "axe") then
      return "axe"
    elseif string.find(d, "shovel") then
      return "shovel"
    elseif string.find(d, "hoe") then
      return "hoe"
    elseif string.find(d, "sword") then
      return "sword"
    else
      return "tool"
    end
  end
end

function toolranks.get_level(uses)
  if type(uses) == "number" and uses > 0 then
    return math.min(max_level, math.floor(uses / level_digs))
  end
  return 0
end

function toolranks.create_description(name, uses)
  local description = name
  local tooltype = toolranks.get_tool_type(description)
  local newdesc = S(
    "@1@2\n@3Level @4 @5\n@6@Node dug: @7",
    toolranks.colors.green,
    description,
    toolranks.colors.gold,
    toolranks.get_level(uses),
    S(tooltype),
    toolranks.colors.grey,
    (type(uses) == "number" and uses or 0)
  )
  return newdesc
end

function toolranks.new_afteruse(itemstack, user, node, digparams)
  local itemmeta = itemstack:get_meta()
  local itemdef = itemstack:get_definition()
  local itemdesc = itemdef.original_description or ""
  local dugnodes = tonumber(itemmeta:get_string("dug")) or 0
  local lastlevel = tonumber(itemmeta:get_string("lastlevel")) or 0
  local most_digs = mod_storage:get_int("most_digs") or 0
  local most_digs_user = mod_storage:get_string("most_digs_user") or 0
  local pname = user:get_player_name()
  if not pname then return itemstack end -- player nil check

  if digparams.wear > 0 then -- Only count nodes that spend the tool
    dugnodes = dugnodes + 1
    itemmeta:set_string("dug", dugnodes)
  end

  if dugnodes > most_digs then
    if most_digs_user ~= pname then -- Avoid spam.
      minetest.chat_send_all(S(
        "Most used tool is now a @1@2@3 owned by @4 with @5 uses.",
        toolranks.colors.green,
        itemdesc,
        toolranks.colors.white,
        pname,
        dugnodes
      ))
    end
    mod_storage:set_int("most_digs", dugnodes)
    mod_storage:set_string("most_digs_user", pname)
  end

  if itemstack:get_wear() > 60135 then
    minetest.chat_send_player(user:get_player_name(), S("Your tool is about to break!"))
    minetest.sound_play("default_tool_breaks", {
      to_player = pname,
      gain = 2.0,
    })
  end

  local level = toolranks.get_level(dugnodes)
  if lastlevel < level then
    local levelup_text = S(
      "Your @1@2@3 just leveled up!",
      toolranks.colors.green,
      itemdesc,
      toolranks.colors.white
    )
    minetest.chat_send_player(user:get_player_name(), levelup_text)
    minetest.sound_play("toolranks_levelup", {
      to_player = pname,
      gain = 2.0,
    })
	-- Make tool better by modifying tool_capabilities (if defined)
    if itemdef.tool_capabilities then
      local speed_multiplier = 1 + (level * level_multiplier * (max_speed - 1))
      local use_multiplier = 1 + (level * level_multiplier * (max_use - 1))
      local caps = table.copy(itemdef.tool_capabilities)

      caps.full_punch_interval = caps.full_punch_interval and (caps.full_punch_interval / speed_multiplier)
      caps.punch_attack_uses = caps.punch_attack_uses and (caps.punch_attack_uses * use_multiplier)

      for _,c in pairs(caps.groupcaps) do
        c.uses = c.uses * use_multiplier
        for i,t in ipairs(c.times) do
          c.times[i] = t / speed_multiplier
        end
      end
      itemmeta:set_tool_capabilities(caps)
	end
  end

  -- Old method for compatibility with tools without tool_capabilities defined
  local wear = digparams.wear
  if level > 0 and not itemdef.tool_capabilities then
    local use_multiplier = 1 + (level * level_multiplier * (max_use - 1))
    wear = wear / use_multiplier
  end

  itemmeta:set_string("lastlevel", level)
  itemmeta:set_string("description", toolranks.create_description(itemdesc, dugnodes))
  itemstack:add_wear(wear)
  return itemstack
end

-- Helper function
function toolranks.add_tool(name)
  local desc = ItemStack(name):get_definition().description
  minetest.override_item(name, {
    original_description = desc,
    description = toolranks.create_description(desc),
    after_use = toolranks.new_afteruse
  })
end

-- Sword
toolranks.add_tool("default:sword_wood")
toolranks.add_tool("default:sword_stone")
toolranks.add_tool("default:sword_steel")
toolranks.add_tool("default:sword_bronze")
toolranks.add_tool("default:sword_mese")
toolranks.add_tool("default:sword_diamond")

-- Pickaxe
toolranks.add_tool("default:pick_wood")
toolranks.add_tool("default:pick_stone")
toolranks.add_tool("default:pick_steel")
toolranks.add_tool("default:pick_bronze")
toolranks.add_tool("default:pick_mese")
toolranks.add_tool("default:pick_diamond")

-- Axe
toolranks.add_tool("default:axe_wood")
toolranks.add_tool("default:axe_stone")
toolranks.add_tool("default:axe_steel")
toolranks.add_tool("default:axe_bronze")
toolranks.add_tool("default:axe_mese")
toolranks.add_tool("default:axe_diamond")

-- Shovel
toolranks.add_tool("default:shovel_wood")
toolranks.add_tool("default:shovel_stone")
toolranks.add_tool("default:shovel_steel")
toolranks.add_tool("default:shovel_bronze")
toolranks.add_tool("default:shovel_mese")
toolranks.add_tool("default:shovel_diamond")
