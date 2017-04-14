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
#include "mapgen_v5.h"


FlagDesc flagdesc_mapgen_v5[] = {
	{"caverns", MGV5_CAVERNS},
	{NULL,      0}
};


MapgenV5::MapgenV5(int mapgenid, MapgenV5Params *params, EmergeManager *emerge)
	: MapgenBasic(mapgenid, params, emerge)
{
	this->spflags          = params->spflags;
	this->cave_width       = params->cave_width;
	this->cavern_limit     = params->cavern_limit;
	this->cavern_taper     = params->cavern_taper;
	this->cavern_threshold = params->cavern_threshold;

	// Terrain noise
	noise_filler_depth = new Noise(&params->np_filler_depth, seed, csize.X, csize.Z);
	noise_factor       = new Noise(&params->np_factor,       seed, csize.X, csize.Z);
	noise_height       = new Noise(&params->np_height,       seed, csize.X, csize.Z);

	// 3D terrain noise
	// 1-up 1-down overgeneration
	noise_ground = new Noise(&params->np_ground, seed, csize.X, csize.Y + 2, csize.Z);
	// 1 down overgeneration
	MapgenBasic::np_cave1  = params->np_cave1;
	MapgenBasic::np_cave2  = params->np_cave2;
	MapgenBasic::np_cavern = params->np_cavern;
}


MapgenV5::~MapgenV5()
{
	delete noise_filler_depth;
	delete noise_factor;
	delete noise_height;
	delete noise_ground;
}


MapgenV5Params::MapgenV5Params()
{
	spflags          = MGV5_CAVERNS;
	cave_width       = 0.125;
	cavern_limit     = -256;
	cavern_taper     = 256;
	cavern_threshold = 0.7;

	np_filler_depth = NoiseParams(0, 1,  v3f(150, 150, 150), 261,    4, 0.7,  2.0);
	np_factor       = NoiseParams(0, 1,  v3f(250, 250, 250), 920381, 3, 0.45, 2.0);
	np_height       = NoiseParams(0, 10, v3f(250, 250, 250), 84174,  4, 0.5,  2.0);
	np_ground       = NoiseParams(0, 40, v3f(80,  80,  80),  983240, 4, 0.55, 2.0, NOISE_FLAG_EASED);
	np_cave1        = NoiseParams(0, 12, v3f(50,  50,  50),  52534,  4, 0.5,  2.0);
	np_cave2        = NoiseParams(0, 12, v3f(50,  50,  50),  10325,  4, 0.5,  2.0);
	np_cavern       = NoiseParams(0, 1,  v3f(384, 128, 384), 723,    5, 0.63, 2.0);
}


void MapgenV5Params::readParams(const Settings *settings)
{
	settings->getFlagStrNoEx("mgv5_spflags",        spflags, flagdesc_mapgen_v5);
	settings->getFloatNoEx("mgv5_cave_width",       cave_width);
	settings->getS16NoEx("mgv5_cavern_limit",       cavern_limit);
	settings->getS16NoEx("mgv5_cavern_taper",       cavern_taper);
	settings->getFloatNoEx("mgv5_cavern_threshold", cavern_threshold);

	settings->getNoiseParams("mgv5_np_filler_depth", np_filler_depth);
	settings->getNoiseParams("mgv5_np_factor",       np_factor);
	settings->getNoiseParams("mgv5_np_height",       np_height);
	settings->getNoiseParams("mgv5_np_ground",       np_ground);
	settings->getNoiseParams("mgv5_np_cave1",        np_cave1);
	settings->getNoiseParams("mgv5_np_cave2",        np_cave2);
	settings->getNoiseParams("mgv5_np_cavern",       np_cavern);
}


void MapgenV5Params::writeParams(Settings *settings) const
{
	settings->setFlagStr("mgv5_spflags",        spflags, flagdesc_mapgen_v5, U32_MAX);
	settings->setFloat("mgv5_cave_width",       cave_width);
	settings->setS16("mgv5_cavern_limit",       cavern_limit);
	settings->setS16("mgv5_cavern_taper",       cavern_taper);
	settings->setFloat("mgv5_cavern_threshold", cavern_threshold);

	settings->setNoiseParams("mgv5_np_filler_depth", np_filler_depth);
	settings->setNoiseParams("mgv5_np_factor",       np_factor);
	settings->setNoiseParams("mgv5_np_height",       np_height);
	settings->setNoiseParams("mgv5_np_ground",       np_ground);
	settings->setNoiseParams("mgv5_np_cave1",        np_cave1);
	settings->setNoiseParams("mgv5_np_cave2",        np_cave2);
	settings->setNoiseParams("mgv5_np_cavern",       np_cavern);
}


int MapgenV5::getSpawnLevelAtPoint(v2s16 p)
{
	//TimeTaker t("getGroundLevelAtPoint", NULL, PRECISION_MICRO);

	float f = 0.55 + NoisePerlin2D(&noise_factor->np, p.X, p.Y, seed);
	if (f < 0.01)
		f = 0.01;
	else if (f >= 1.0)
		f *= 1.6;
	float h = NoisePerlin2D(&noise_height->np, p.X, p.Y, seed);

	for (s16 y = 128; y >= -128; y--) {
		float n_ground = NoisePerlin3D(&noise_ground->np, p.X, y, p.Y, seed);

		if (n_ground * f > y - h) {  // If solid
			// If either top 2 nodes of search are solid this is inside a
			// mountain or floatland with possibly no space for the player to spawn.
			if (y >= 127) {
				return MAX_MAP_GENERATION_LIMIT;  // Unsuitable spawn point
			} else {  // Ground below at least 2 nodes of empty space
				if (y <= water_level || y > water_level + 16)
					return MAX_MAP_GENERATION_LIMIT;  // Unsuitable spawn point
				else
					return y;
			}
		}
	}

	//printf("getGroundLevelAtPoint: %dus\n", t.stop());
	return MAX_MAP_GENERATION_LIMIT;  // Unsuitable spawn position, no ground found
}


void MapgenV5::makeChunk(BlockMakeData *data)
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

	// Create a block-specific seed
	blockseed = getBlockSeed2(full_node_min, seed);

	// Generate base terrain
	s16 stone_surface_max_y = generateBaseTerrain();

	// Create heightmap
	updateHeightmap(node_min, node_max);

	// Init biome generator, place biome-specific nodes, and build biomemap
	biomegen->calcBiomeNoise(node_min);
	MgStoneType stone_type = generateBiomes();

	// Generate caverns, tunnels and classic caves
	if (flags & MG_CAVES) {
		bool has_cavern = false;
		// Generate caverns
		if (spflags & MGV5_CAVERNS)
			has_cavern = generateCaverns(stone_surface_max_y);
		// Generate tunnels and classic caves
		if (has_cavern)
			// Disable classic caves in this mapchunk by setting
			// 'large cave depth' to world base. Avoids excessive liquid in
			// large caverns and floating blobs of overgenerated liquid.
			generateCaves(stone_surface_max_y, -MAX_MAP_GENERATION_LIMIT);
		else
			generateCaves(stone_surface_max_y, MGV5_LARGE_CAVE_DEPTH);
	}

	// Generate dungeons and desert temples
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

	// Add top and bottom side of water to transforming_liquid queue
	updateLiquid(&data->transforming_liquid, full_node_min, full_node_max);

	// Calculate lighting
	if (flags & MG_LIGHT) {
		calcLighting(node_min - v3s16(0, 1, 0), node_max + v3s16(0, 1, 0),
			full_node_min, full_node_max);
	}

	this->generating = false;
}


int MapgenV5::generateBaseTerrain()
{
	u32 index = 0;
	u32 index2d = 0;
	int stone_surface_max_y = -MAX_MAP_GENERATION_LIMIT;

	noise_factor->perlinMap2D(node_min.X, node_min.Z);
	noise_height->perlinMap2D(node_min.X, node_min.Z);
	noise_ground->perlinMap3D(node_min.X, node_min.Y - 1, node_min.Z);

	for (s16 z=node_min.Z; z<=node_max.Z; z++) {
		for (s16 y=node_min.Y - 1; y<=node_max.Y + 1; y++) {
			u32 vi = vm->m_area.index(node_min.X, y, z);
			for (s16 x=node_min.X; x<=node_max.X; x++, vi++, index++, index2d++) {
				if (vm->m_data[vi].getContent() != CONTENT_IGNORE)
					continue;

				float f = 0.55 + noise_factor->result[index2d];
				if (f < 0.01)
					f = 0.01;
				else if (f >= 1.0)
					f *= 1.6;
				float h = noise_height->result[index2d];

				if (noise_ground->result[index] * f < y - h) {
					if (y <= water_level)
						vm->m_data[vi] = MapNode(c_water_source);
					else
						vm->m_data[vi] = MapNode(CONTENT_AIR);
				} else {
					vm->m_data[vi] = MapNode(c_stone);
					if (y > stone_surface_max_y)
						stone_surface_max_y = y;
				}
			}
			index2d -= ystride;
		}
		index2d += ystride;
	}

	return stone_surface_max_y;
}
