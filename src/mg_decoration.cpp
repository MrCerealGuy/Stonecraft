/*
Minetest
Copyright (C) 2014-2016 kwolekr, Ryan Kwolek <kwolekr@minetest.net>
Copyright (C) 2015-2017 paramat

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#include "mg_decoration.h"
#include "mg_schematic.h"
#include "mapgen.h"
#include "noise.h"
#include "map.h"
#include "log.h"
#include "util/numeric.h"
#include <algorithm>


FlagDesc flagdesc_deco[] = {
	{"place_center_x",  DECO_PLACE_CENTER_X},
	{"place_center_y",  DECO_PLACE_CENTER_Y},
	{"place_center_z",  DECO_PLACE_CENTER_Z},
	{"force_placement", DECO_FORCE_PLACEMENT},
	{"liquid_surface",  DECO_LIQUID_SURFACE},
	{NULL,              0}
};


///////////////////////////////////////////////////////////////////////////////


DecorationManager::DecorationManager(IGameDef *gamedef) :
	ObjDefManager(gamedef, OBJDEF_DECORATION)
{
}


size_t DecorationManager::placeAllDecos(Mapgen *mg, u32 blockseed,
	v3s16 nmin, v3s16 nmax)
{
	size_t nplaced = 0;

	for (size_t i = 0; i != m_objects.size(); i++) {
		Decoration *deco = (Decoration *)m_objects[i];
		if (!deco)
			continue;

		nplaced += deco->placeDeco(mg, blockseed, nmin, nmax);
		blockseed++;
	}

	return nplaced;
}


///////////////////////////////////////////////////////////////////////////////


void Decoration::resolveNodeNames()
{
	getIdsFromNrBacklog(&c_place_on);
	getIdsFromNrBacklog(&c_spawnby);
}


bool Decoration::canPlaceDecoration(MMVManip *vm, v3s16 p)
{
	// Check if the decoration can be placed on this node
	u32 vi = vm->m_area.index(p);
	if (!CONTAINS(c_place_on, vm->m_data[vi].getContent()))
		return false;

	// Don't continue if there are no spawnby constraints
	if (nspawnby == -1)
		return true;

	int nneighs = 0;
	static const v3s16 dirs[16] = {
		v3s16( 0, 0,  1),
		v3s16( 0, 0, -1),
		v3s16( 1, 0,  0),
		v3s16(-1, 0,  0),
		v3s16( 1, 0,  1),
		v3s16(-1, 0,  1),
		v3s16(-1, 0, -1),
		v3s16( 1, 0, -1),

		v3s16( 0, 1,  1),
		v3s16( 0, 1, -1),
		v3s16( 1, 1,  0),
		v3s16(-1, 1,  0),
		v3s16( 1, 1,  1),
		v3s16(-1, 1,  1),
		v3s16(-1, 1, -1),
		v3s16( 1, 1, -1)
	};

	// Check these 16 neighbouring nodes for enough spawnby nodes
	for (size_t i = 0; i != ARRLEN(dirs); i++) {
		u32 index = vm->m_area.index(p + dirs[i]);
		if (!vm->m_area.contains(index))
			continue;

		if (CONTAINS(c_spawnby, vm->m_data[index].getContent()))
			nneighs++;
	}

	if (nneighs < nspawnby)
		return false;

	return true;
}


size_t Decoration::placeDeco(Mapgen *mg, u32 blockseed, v3s16 nmin, v3s16 nmax)
{
	PcgRandom ps(blockseed + 53);
	int carea_size = nmax.X - nmin.X + 1;

	// Divide area into parts
	// If chunksize is changed it may no longer be divisable by sidelen
	if (carea_size % sidelen)
		sidelen = carea_size;

	s16 divlen = carea_size / sidelen;
	int area = sidelen * sidelen;

	for (s16 z0 = 0; z0 < divlen; z0++)
	for (s16 x0 = 0; x0 < divlen; x0++) {
		v2s16 p2d_center( // Center position of part of division
			nmin.X + sidelen / 2 + sidelen * x0,
			nmin.Z + sidelen / 2 + sidelen * z0
		);
		v2s16 p2d_min( // Minimum edge of part of division
			nmin.X + sidelen * x0,
			nmin.Z + sidelen * z0
		);
		v2s16 p2d_max( // Maximum edge of part of division
			nmin.X + sidelen + sidelen * x0 - 1,
			nmin.Z + sidelen + sidelen * z0 - 1
		);

		// Amount of decorations
		float nval = (flags & DECO_USE_NOISE) ?
			NoisePerlin2D(&np, p2d_center.X, p2d_center.Y, mapseed) :
			fill_ratio;
		u32 deco_count = 0;
		float deco_count_f = (float)area * nval;
		if (deco_count_f >= 1.f) {
			deco_count = deco_count_f;
		} else if (deco_count_f > 0.f) {
			// For low density decorations calculate a chance for 1 decoration
			if (ps.range(1000) <= deco_count_f * 1000.f)
				deco_count = 1;
		}

		for (u32 i = 0; i < deco_count; i++) {
			s16 x = ps.range(p2d_min.X, p2d_max.X);
			s16 z = ps.range(p2d_min.Y, p2d_max.Y);

			int mapindex = carea_size * (z - nmin.Z) + (x - nmin.X);

			s16 y = -MAX_MAP_GENERATION_LIMIT;
			if (flags & DECO_LIQUID_SURFACE)
				y = mg->findLiquidSurface(v2s16(x, z), nmin.Y, nmax.Y);
			else if (mg->heightmap)
				y = mg->heightmap[mapindex];
			else
				y = mg->findGroundLevel(v2s16(x, z), nmin.Y, nmax.Y);

			if (y < y_min || y > y_max || y < nmin.Y || y > nmax.Y)
				continue;

			if (y + getHeight() > mg->vm->m_area.MaxEdge.Y)
				continue;

			if (mg->biomemap && !biomes.empty()) {
				std::unordered_set<u8>::const_iterator iter =
					biomes.find(mg->biomemap[mapindex]);
				if (iter == biomes.end())
					continue;
			}

			v3s16 pos(x, y, z);
			if (generate(mg->vm, &ps, pos))
				mg->gennotify.addEvent(GENNOTIFY_DECORATION, pos, index);
		}
	}

	return 0;
}


///////////////////////////////////////////////////////////////////////////////


void DecoSimple::resolveNodeNames()
{
	Decoration::resolveNodeNames();
	getIdsFromNrBacklog(&c_decos);
}


size_t DecoSimple::generate(MMVManip *vm, PcgRandom *pr, v3s16 p)
{
	// Don't bother if there aren't any decorations to place
	if (c_decos.empty())
		return 0;

	// Check for a negative place_offset_y causing placement below the voxelmanip
	if (p.Y + 1 + place_offset_y < vm->m_area.MinEdge.Y)
		return 0;

	if (!canPlaceDecoration(vm, p))
		return 0;

	content_t c_place = c_decos[pr->range(0, c_decos.size() - 1)];

	s16 height = (deco_height_max > 0) ?
		pr->range(deco_height, deco_height_max) : deco_height;

	u8 param2 = (deco_param2_max > 0) ?
		pr->range(deco_param2, deco_param2_max) : deco_param2;

	bool force_placement = (flags & DECO_FORCE_PLACEMENT);

	const v3s16 &em = vm->m_area.getExtent();
	u32 vi = vm->m_area.index(p);
	vm->m_area.add_y(em, vi, place_offset_y);

	for (int i = 0; i < height; i++) {
		vm->m_area.add_y(em, vi, 1);
		content_t c = vm->m_data[vi].getContent();
		if (c != CONTENT_AIR && c != CONTENT_IGNORE &&
				!force_placement)
			break;

		vm->m_data[vi] = MapNode(c_place, 0, param2);
	}

	return 1;
}


int DecoSimple::getHeight()
{
	return ((deco_height_max > 0) ? deco_height_max : deco_height)
		+ place_offset_y;
}


///////////////////////////////////////////////////////////////////////////////


size_t DecoSchematic::generate(MMVManip *vm, PcgRandom *pr, v3s16 p)
{
	// Schematic could have been unloaded but not the decoration
	// In this case generate() does nothing (but doesn't *fail*)
	if (schematic == NULL)
		return 0;

	if (!canPlaceDecoration(vm, p))
		return 0;

	if (flags & DECO_PLACE_CENTER_X)
		p.X -= (schematic->size.X - 1) / 2;
	if (flags & DECO_PLACE_CENTER_Z)
		p.Z -= (schematic->size.Z - 1) / 2;

	if (flags & DECO_PLACE_CENTER_Y)
		p.Y -= (schematic->size.Y - 1) / 2;
	else
		p.Y += place_offset_y;
	// Check shifted schematic base is in voxelmanip
	if (p.Y < vm->m_area.MinEdge.Y)
		return 0;

	Rotation rot = (rotation == ROTATE_RAND) ?
		(Rotation)pr->range(ROTATE_0, ROTATE_270) : rotation;

	bool force_placement = (flags & DECO_FORCE_PLACEMENT);

	schematic->blitToVManip(vm, p, rot, force_placement);

	return 1;
}


int DecoSchematic::getHeight()
{
	// Account for a schematic being sunk into the ground by flag.
	// When placed normally account for how a schematic is by default placed
	// sunk 1 node into the ground or is vertically shifted by 'y_offset'.
	return (flags & DECO_PLACE_CENTER_Y) ?
		(schematic->size.Y - 1) / 2 : schematic->size.Y - 1 + place_offset_y;
}
