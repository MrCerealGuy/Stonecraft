# abm_allowed

Small Stonecraft/Minetest mod that prevents ABM execution when the server is lagging.

Author: MrCerealGuy <mrcerealguy@gmx.de>

Usage:


```
minetest.register_abm({

	[..]

	action = function(..)
		if not abm_allowed.yes then
				return
		end
	end

	[..]

})
```
