--
--

--- Creatures Revived Settings
--
--  @module settings.lua


-- cmer specific settings


--- Enables particles when swimming.
--
--  @setting mobs.particles
--  @settype bool
--  @default false
cmer.particles = core.settings:get_bool("mobs.particles", false)

--- Displays nametags above mobs.
--
--  @setting mobs.nametags
--  @settype bool
--  @default false
cmer.nametags = core.settings:get_bool("mobs.nametags", false)

--- Determines if owned entities can be killed by non-owners.
--
--  @setting mobs.grief_owned
--  @settype bool
--  @default false
cmer.grief_owned = core.settings:get_bool("mobs.grief_owned", false)


-- general mobs settings


--- Disables attacking players.
--
--  @setting only_peaceful_mobs
--  @settype bool
--  @default false
cmer.allow_hostile = core.settings:get_bool("only_peaceful_mobs") ~= true


-- general settings


--- Print extra debugging messages.
--
--  @setting debug_mods
--  @settype bool
--  @default false
cmer.debug = core.settings:get_bool("debug_mods", false)

--- Enables creative mode.
--
--  @setting creative_mode
--  @settype bool
--  @default false
cmer.creative = core.settings:get_bool("creative_mode", false)

--- Enables damage.
--
--  @setting enable_damage
--  @settype bool
--  @default false
cmer.enable_damage = core.settings:get_bool("enable_damage", false)
