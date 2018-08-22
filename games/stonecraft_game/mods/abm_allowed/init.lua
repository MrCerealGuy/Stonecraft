
--[[

Small mod that prevents ABM execution when the server is lagging.

Author: MrCerealGuy <mrcerealguy@gmx.de>

Usage:

	minetest.register_abm({
		
		action = function(..)
			if not abm_allowed.yes then
   				return
			end
		end
	})

--]]


abm_allowed = {}
abm_allowed.yes = true

-- disallow abms when the server is lagging
minetest.register_globalstep(function(dtime)
   if dtime > 0.5 and abm_allowed.yes then
      abm_allowed.yes = false
      minetest.after(2, function() abm_allowed.yes = true end)
   end
end)
