--Minetest
--Copyright (C) 2013 sapier
--
--This program is free software; you can redistribute it and/or modify
--it under the terms of the GNU Lesser General Public License as published by
--the Free Software Foundation; either version 2.1 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU Lesser General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public License along
--with this program; if not, write to the Free Software Foundation, Inc.,
--51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

--------------------------------------------------------------------------------

--[[

2016-12-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added credits

--]]

local stonecraft_developers = {
	"Andreas Zahnleiter (MrCerealGuy) <mrcerealguy@gmx.de>",
	"Web: https://mrcerealguy.itch.io/stonecraft",
	"Github: https://github.com/MrCerealGuy/Stonecraft",
}

local core_developers = {
	"Perttu Ahola (celeron55) <celeron55@gmail.com>",
	"sfan5 <sfan5@live.de>",
	"Nathanaël Courant (Nore/Ekdohibs) <nore@mesecons.net>",
	"Loic Blot (nerzhul/nrz) <loic.blot@unix-experience.fr>",
	"paramat",
	"Andrew Ward (rubenwardy) <rw@rubenwardy.com>",
	"Krock/SmallJoker <mk939@ymail.com>",
	"Lars Hofhansl <larsh@apache.org>",
	"Pierre-Yves Rollo <dev@pyrollo.com>",
	"v-rob <robinsonvincent89@gmail.com>",
}

-- For updating active/previous contributors, see the script in ./util/gather_git_credits.py

local active_contributors = {
	"Wuzzy [devtest game, visual corrections]",
	"Zughy [Visual improvements, various fixes]",
	"Maksim (MoNTE48) [Android]",
	"numzero [Graphics and rendering]",
	"appgurueu [Various internal fixes]",
	"Desour [Formspec and vector API changes]",
	"HybridDog [Rendering fixes and documentation]",
	"Hugues Ross [Graphics-related improvements]",
	"ANAND (ClobberXD) [Mouse buttons rebinding]",
	"luk3yx [Fixes]",
	"hecks [Audiovisuals, Lua API]",
	"LoneWolfHT [Object crosshair, documentation fixes]",
	"Lejo [Server-related improvements]",
	"EvidenceB [Compass HUD element]",
	"Paul Ouellette (pauloue) [Lua API, documentation]",
	"TheTermos [Collision detection, physics]",
	"David CARLIER [Unix & Haiku build fixes]",
	"dcbrwn [Object shading]",
	"Elias Fleckenstein [API features/fixes]",
	"Jean-Patrick Guerrero (kilbith) [model element, visual fixes]",
	"k.h.lai [Memory leak fixes, documentation]",
}

local previous_core_developers = {
	"BlockMen",
	"Maciej Kasatkin (RealBadAngel) [RIP]",
	"Lisa Milne (darkrose) <lisa@ltmnet.com>",
	"proller",
	"Ilya Zhuravlev (xyz) <xyz@minetest.net>",
	"PilzAdam <pilzadam@minetest.net>",
	"est31 <MTest31@outlook.com>",
	"kahrl <kahrl@gmx.net>",
	"Ryan Kwolek (kwolekr) <kwolekr@minetest.net>",
	"sapier",
	"Zeno",
	"ShadowNinja <shadowninja@minetest.net>",
	"Auke Kok (sofar) <sofar@foo-projects.org>",
}

local previous_contributors = {
	"Nils Dagsson Moskopp (erlehmann) <nils@dieweltistgarnichtso.net> [Minetest Logo]",
	"red-001 <red-001@outlook.ie>",
	"Giuseppe Bilotta",
	"Dániel Juhász (juhdanad) <juhdanad@gmail.com>",
	"MirceaKitsune <mirceakitsune@gmail.com>",
	"Constantin Wenger (SpeedProg)",
	"Ciaran Gultnieks (CiaranG)",
	"stujones11 [Android UX improvements]",
	"Rogier <rogier777@gmail.com> [Fixes]",
	"Gregory Currie (gregorycu) [optimisation]",
	"srifqi [Fixes]",
	"JacobF",
	"Jeija <jeija@mesecons.net> [HTTP, particles]",
}

local function buildCreditList(source)
	local ret = {}
	for i = 1, #source do
		ret[i] = core.formspec_escape(source[i])
	end
	return table.concat(ret, ",,")
end

return {
	name = "credits",
	caption = fgettext("Credits"),
	cbf_formspec = function(tabview, name, tabdata)
		local logofile = defaulttexturedir .. "logo.png"
		local version = core.get_version()
		local fs = "image[0.75,0.5;2.2,2.2;" .. core.formspec_escape(logofile) .. "]" ..
			"style[label_button;border=false]" ..
			"button[0.5,2;2.5,2;label_button;" .. version.project .. " " .. version.string .. "]" ..
			"button[0.75,2.75;2,2;homepage;Homepage]" ..
			"tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[3.5,-0.25;8.5,6.05;list_credits;" ..
			"#FFFF00," .. fgettext("Stonecraft Developers") .. ",," ..
			table.concat(stonecraft_developers, ",,") .. ",," ..
			fgettext("Thanks a lot to the Minetest community.") .. ",,," ..
			"#FFFF00," .. fgettext("Minetest Engine Core Developers") .. ",," ..
			buildCreditList(core_developers) .. ",,," ..
			"#FFFF00," .. fgettext("Minetest Engine Active Contributors") .. ",," ..
			buildCreditList(active_contributors) .. ",,," ..
			"#FFFF00," .. fgettext("Minetest Engine Previous Core Developers") ..",," ..
			buildCreditList(previous_core_developers) .. ",,," ..
			"#FFFF00," .. fgettext("Minetest Engine Previous Contributors") .. ",," ..
			buildCreditList(previous_contributors) .. "," ..
			";1]"

		if PLATFORM ~= "Android" then
			fs = fs .. "tooltip[userdata;" ..
					fgettext("Opens the directory that contains user-provided worlds, games, mods,\n" ..
							"and texture packs in a file manager / explorer.") .. "]"
			fs = fs .. "button[0,4.75;3.5,1;userdata;" .. fgettext("Open User Data Directory") .. "]"
		end

		return fs
	end,
	cbf_button_handler = function(this, fields, name, tabdata)
		if fields.homepage then
			core.open_url("https://mrcerealguy.itch.io/stonecraft")
		end

		if fields.userdata then
			core.open_dir(core.get_user_path())
		end
	end,
}
