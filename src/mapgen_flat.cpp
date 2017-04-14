/*
Minetest
Copyright (C) 2010-2015 kwolekr, Ryan Kwolek <kwolekr@minetest.net>
Copyright (C) 2010-2015 paramat, Matt Gregory

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


#include "mapgen.h"
#include "voxel.h"
#include "noise.h"
#include "mapblock.h"
#include "mapnode.h"
#include "map.h"
#include "content_sao.h"
#include "nodedef.h"
#include "voxelalgorithms.h"
//#include "profiler.h" // For TimeTaker
#include "settings.h" // For g_settings
#include "emerge.h"
#include "dungeongen.h"
#include "cavegen.h"
#include "mg_biome.h"
#include "mg_ore.h"
#include "mg_decoration.h"
#include "mapgen_flat.h"


FlagDesc flagdesc_mapgen_flat[] = {
	{"lakes", MGFLAT_LAKES},
	{"hills", MGFLAT_HILLS},
	{NULL,    0}
};

///////////////////////////////////////////////////////////////////////////////////////


MapgenFlat::MapgenFlat(int mapgenid, MapgenFlatParams *params, EmergeManager *emerge)
	: MapgenBasic(mapgenid, params, emerge)
{
	this->spflags          = params->spflags;
	this->ground_level     = params->ground_level;
	this->large_cave_depth = params->large_cave_depth;
	this->cave_width       = params->cave_width;
	this->lake_threshold   = params->lake_threshold;
	this->lake_steepness   = params->lake_steepness;
	this->hill_threshold   = params->hill_threshold;
	this->hill_steepness   = params->hill_steepness;

	//// 2D noise
	noise_terrain      = new Noise(&params->np_terrain,      seed, csize.X, csize.Z);
	noise_filler_depth = new Noise(&params->np_filler_depth, seed, csize.X, csize.Z);

	MapgenBasic::np_cave1 = params->np_cave1;
	MapgenBasic::np_cave2 = params->np_cave2;
}


MapgenFlat::~MapgenFlat()
{
	delete noise_terrain;
	delete noise_filler_depth;
}


MapgenFlatParams::MapgenFlatParams()
{
	spflags          = 0;
	ground_level     = 8;
	large_cave_depth = -33;
	cave_width       = 0.09;
	lake_threshold   = -0.45;
	lake_steepness   = 48.0;
	hill_threshold   = 0.45;
	hill_steepness   = 64.0;

	np_terrain      = NoiseParams(0, 1,   v3f(600, 600, 600), 7244,  5, 0.6, 2.0);
	np_filler_depth = NoiseParams(0, 1.2, v3f(150, 150, 150), 261,   3, 0.7, 2.0);
	np_cave1        = NoiseParams(0, 12,  v3f(61,  61,  61),  52534, 3, 0.5, 2.0);
	np_cave2        = NoiseParams(0, 12,  v3f(67,  67,  67),  10325, 3, 0.5, 2.0);
}


void MapgenFlatParams::readParams(const Settings *settings)
{
	settings->getFlagStrNoEx("mgflat_spflags",      spflags, flagdesc_mapgen_flat);
	settings->getS16NoEx("mgflat_ground_level",     ground_level);
	settings->getS16NoEx("mgflat_large_cave_depth", large_cave_depth);
	settings->getFloatNoEx("mgflat_cave_width",     cave_width);
	settings->getFloatNoEx("mgflat_lake_threshold", lake_threshold);
	settings->getFloatNoEx("mgflat_lake_steepness", lake_steepness);
	settings->getFloatNoEx("mgflat_hill_threshold", hill_threshold);
	settings->getFloatNoEx("mgflat_hill_steepness", hill_steepness);

	settings->getNoiseParams("mgflat_np_terrain",      np_terrain);
	settings->getNoiseParams("mgflat_np_filler_depth", np_filler_depth);
	settings->getNoiseParams("mgflat_np_cave1",        np_cave1);
	settings->getNoiseParams("mgflat_np_cave2",        np_cave2);
}


void MapgenFlatParams::writeParams(Settings *settings) const
{
	settings->setFlagStr("mgflat_spflags",      spflags, flagdesc_mapgen_flat, U32_MAX);
	settings->setS16("mgflat_ground_level",     ground_level);
	settings->setS16("mgflat_large_cave_depth", large_cave_depth);
	settings->setFloat("mgflat_cave_width",     cave_width);
	settings->setFloat("mgflat_lake_threshold", lake_threshold);
	settings->setFloat("mgflat_lake_steepness", lake_steepness);
	settings->setFloat("mgflat_hill_threshold", hill_threshold);
	settings->setFloat("mgflat_hill_steepness", hill_steepness);

	settings->setNoiseParams("mgflat_np_terrain",      np_terrain);
	settings->setNoiseParams("mgflat_np_filler_depth", np_filler_depth);
	settings->setNoiseParams("mgflat_np_cave1",        np_cave1);
	settings->setNoiseParams("mgflat_np_cave2",        np_cave2);
}


/////////////////////////////////////////////////////////////////


int MapgenFlat::getSpawnLevelAtPoint(v2s16 p)
{
	s16 level_at_point = ground_level;
	float n_terrain = NoisePerlin2D(&noise_terrain->np, p.X, p.Y, seed);

	if ((spflags & MGFLAT_LAKES) && n_terrain < lake_threshold) {
		level_at_point = ground_level -
			(lake_threshold - n_terrain) * lake_steepness;
	} else if ((spflags & MGFLAT_HILLS) && n_terrain > hill_threshold) {
		level_at_point = ground_level +
			(n_terrain - hill_threshold) * hill_steepness;
	}

	if (ground_level < water_level)  // Ocean world, allow spawn in water
		return MYMAX(level_at_point, water_level);
	else if (level_at_point > water_level)
		return level_at_point;  // Spawn on land
	else
		return MAX_MAP_GENERATION_LIMIT;  // Unsuitable spawn point
}


void MapgenFlat::makeChunk(BlockMakeData *data)
{
	// Pre-conditions
	assert(data->vmanip);
	assert(data->nodedef);
	assert(data->blockpos_requested.X >= data->blockpos_min.X &&
		data->blockpos_requested.Y >= data->blockpos_min.Y &&
		data->blockpos_requested.Z >= data->blockpos_min.Z);
	assert(data->blockpos_requested.X <= data->blockpos_max.X &&
		data->blockpos_requested.Y <= data->blockpos_max.Y &&
		data->blockpos_requested.Z <= data->blockpos_max.Z);

	this->generating = true;
	this->vm   = data->vmanip;
	this->ndef = data->nodedef;
	//TimeTaker t("makeChunk");

	v3s16 blockpos_min = data->blockpos_min;
	v3s16 blockpos_max = data->blockpos_max;
	node_min = blockpos_min * MAP_BLOCKSIZE;
	node_max = (blockpos_max + v3s16(1, 1, 1)) * MAP_BLOCKSIZE - v3s16(1, 1, 1);
	full_node_min = (blockpos_min - 1) * MAP_BLOCKSIZE;
	full_node_max = (blockpos_max + 2) * MAP_BLOCKSIZE - v3s16(1, 1, 1);

	blockseed = getBlockSeed2(full_node_min, seed);

	// Generate base terrain, mountains, and ridges with initial heightmaps
	s16 stone_surface_max_y = generateTerrain();

	// Create heightmap
	updateHeightmap(node_min, node_max);

	// Init biome generator, place biome-specific nodes, and build biomemap
	biomegen->calcBiomeNoise(node_min);
	MgStoneType stone_type = generateBiomes();

	if (flags & MG_CAVES)
		generateCaves(stone_surface_max_y, large_cave_depth);

	if (flags & MG_DUNGEONS)
		generateDungeons(stone_surface_max_y, stone_type);

	// Generate the registered decorations
	if (flags & MG_DECORATIONS)
		m_emerge->decomgr->placeAllDecos(this, blockseed, node_min, node_max);

	// Generate the registered ores
	m_emerge->oremgr->placeAllOres(this, blockseed, node_min, node_max);

	// Sprinkle some dust on top after everything else was generated
	dustTopNodes();

	//printf("makeChunk: %dms\n", t.stop());

	updateLiquid(&data->transforming_liquid, full_node_min, full_node_max);

	if (flags & MG_LIGHT)
		calcLighting(node_min - v3s16(0, 1, 0), node_max + v3s16(0, 1, 0),
			full_node_min, full_node_max);

	//setLighting(node_min - v3s16(1, 0, 1) * MAP_BLOCKSIZE,
	//			node_max + v3s16(1, 0, 1) * MAP_BLOCKSIZE, 0xFF);

	this->generating = false;
}


s16 MapgenFlat::generateTerrain()
{
	MapNode n_air(CONTENT_AIR);
	MapNode n_stone(c_stone);
	MapNode n_water(c_water_source);

	v3s16 em = vm->m_area.getExtent();
	s16 stone_surface_max_y = -MAX_MAP_GENERATION_LIMIT;
	u32 ni2d = 0;

	bool use_noise = (spflags & MGFLAT_LAKES) || (spflags & MGFLAT_HILLS);
	if (use_noise)
		noise_terrain->perlinMap2D(node_min.X, node_min.Z);

	for (s16 z = node_min.Z; z <= node_max.Z; z++)
	for (s16 x = node_min.X; x <= node_max.X; x++, ni2d++) {
		s16 stone_level = ground_level;
		float n_terrain = use_noise ? noise_terrain->result[ni2d] : 0.0f;

		if ((spflags & MGFLAT_LAKES) && n_terrain < lake_threshold) {
			s16 depress = (lake_threshold - n_terrain) * lake_steepness;
			stone_level = ground_level - depress;
		} else if ((spflags & MGFLAT_HILLS) && n_terrain > hill_threshold) {
			s16 rise = (n_terrain - hill_threshold) * hill_steepness;
		 	stone_level = ground_level + rise;
		}

		u32 vi = vm->m_area.index(x, node_min.Y - 1, z);
		for (s16 y = node_min.Y - 1; y <= node_max.Y + 1; y++) {
			if (vm->m_data[vi].getContent() == CONTENT_IGNORE) {
				if (y <= stone_level) {
					vm->m_data[vi] = n_stone;
					if (y > stone_surface_max_y)
						stone_surface_max_y = y;
				} else if (y <= water_level) {
					vm->m_data[vi] = n_water;
				} else {
					vm->m_data[vi] = n_air;
				}
			}
			vm->m_area.add_y(em, vi, 1);
		}
	}

	return stone_surface_max_y;
}
