/*
Minetest
Copyright (C) 2010-2013 celeron55, Perttu Ahola <celeron55@gmail.com>

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

#pragma once

#include "nodedef.h"
#include <IMeshManipulator.h>

struct MeshMakeData;
struct MeshCollector;

struct LightFrame
{
	f32 lightsA[8];
	f32 lightsB[8];
};

class MapblockMeshGenerator
{
public:
	MeshMakeData *data;
	MeshCollector *collector;

	INodeDefManager *nodedef;
	scene::IMeshManipulator *meshmanip;

// options
	bool enable_mesh_cache;

// current node
	v3s16 blockpos_nodes;
	v3s16 p;
	v3f origin;
	MapNode n;
	const ContentFeatures *f;
	u16 light;
	LightFrame frame;
	video::SColor color;
	TileSpec tile;
	float scale;

// lighting
	void getSmoothLightFrame();
	u16 blendLight(const v3f &vertex_pos);
	video::SColor blendLightColor(const v3f &vertex_pos);
	video::SColor blendLightColor(const v3f &vertex_pos, const v3f &vertex_normal);

	void useTile(int index = 0, u8 set_flags = MATERIAL_FLAG_CRACK_OVERLAY,
		u8 reset_flags = 0, bool special = false);
	void getTile(v3s16 direction, TileSpec *tile);
	void getSpecialTile(int index, TileSpec *tile, bool apply_crack = false);

// face drawing
	void drawQuad(v3f *vertices, const v3s16 &normal = v3s16(0, 0, 0),
		float vertical_tiling = 1.0);

// cuboid drawing!
	void drawCuboid(const aabb3f &box, TileSpec *tiles, int tilecount,
		const u16 *lights , const f32 *txc);
	void generateCuboidTextureCoords(aabb3f const &box, f32 *coords);
	void drawAutoLightedCuboid(aabb3f box, const f32 *txc = NULL,
		TileSpec *tiles = NULL, int tile_count = 0);

// liquid-specific
	bool top_is_same_liquid;
	TileSpec tile_liquid;
	TileSpec tile_liquid_top;
	content_t c_flowing;
	content_t c_source;
	video::SColor color_liquid_top;
	struct NeighborData {
		f32 level;
		content_t content;
		bool is_same_liquid;
		bool top_is_same_liquid;
	};
	NeighborData liquid_neighbors[3][3];
	f32 corner_levels[2][2];

	void prepareLiquidNodeDrawing();
	void getLiquidNeighborhood();
	void calculateCornerLevels();
	f32 getCornerLevel(int i, int k);
	void drawLiquidSides();
	void drawLiquidTop();

// raillike-specific
	// name of the group that enables connecting to raillike nodes of different kind
	static const std::string raillike_groupname;
	int raillike_group;
	bool isSameRail(v3s16 dir);

// plantlike-specific
	PlantlikeStyle draw_style;
	v3f offset;
	int rotate_degree;
	bool random_offset_Y;
	int face_num;
	float plant_height;

	void drawPlantlikeQuad(float rotation, float quad_offset = 0,
		bool offset_top_only = false);
	void drawPlantlike();

// firelike-specific
	void drawFirelikeQuad(float rotation, float opening_angle,
		float offset_h, float offset_v = 0.0);

// drawtypes
	void drawLiquidNode();
	void drawGlasslikeNode();
	void drawGlasslikeFramedNode();
	void drawAllfacesNode();
	void drawTorchlikeNode();
	void drawSignlikeNode();
	void drawPlantlikeNode();
	void drawPlantlikeRootedNode();
	void drawFirelikeNode();
	void drawFencelikeNode();
	void drawRaillikeNode();
	void drawNodeboxNode();
	void drawMeshNode();

// common
	void errorUnknownDrawtype();
	void drawNode();

public:
	MapblockMeshGenerator(MeshMakeData *input, MeshCollector *output);
	void generate();
};
