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

#ifndef CLIENTMAP_HEADER
#define CLIENTMAP_HEADER

#include "irrlichttypes_extrabloated.h"
#include "map.h"
#include "camera.h"
#include <set>
#include <map>

struct MapDrawControl
{
	MapDrawControl():
		range_all(false),
		wanted_range(0),
		wanted_max_blocks(0),
		show_wireframe(false),
		blocks_drawn(0),
		blocks_would_have_drawn(0),
		farthest_drawn(0)
	{
	}
	// Overrides limits by drawing everything
	bool range_all;
	// Wanted drawing range
	float wanted_range;
	// Maximum number of blocks to draw
	u32 wanted_max_blocks;
	// show a wire frame for debugging
	bool show_wireframe;
	// Number of blocks rendered is written here by the renderer
	u32 blocks_drawn;
	// Number of blocks that would have been drawn in wanted_range
	u32 blocks_would_have_drawn;
	// Distance to the farthest block drawn
	float farthest_drawn;
};

class Client;
class ITextureSource;

/*
	ClientMap

	This is the only map class that is able to render itself on screen.
*/

class ClientMap : public Map, public scene::ISceneNode
{
public:
	ClientMap(
			Client *client,
			MapDrawControl &control,
			scene::ISceneNode* parent,
			scene::ISceneManager* mgr,
			s32 id
	);

	~ClientMap();

	s32 mapType() const
	{
		return MAPTYPE_CLIENT;
	}

	void drop()
	{
		ISceneNode::drop();
	}

	void updateCamera(v3f pos, v3f dir, f32 fov, v3s16 offset)
	{
		m_camera_position = pos;
		m_camera_direction = dir;
		m_camera_fov = fov;
		m_camera_offset = offset;
	}

	/*
		Forcefully get a sector from somewhere
	*/
	MapSector * emergeSector(v2s16 p);

	//void deSerializeSector(v2s16 p2d, std::istream &is);

	/*
		ISceneNode methods
	*/

	virtual void OnRegisterSceneNode();

	virtual void render()
	{
		video::IVideoDriver* driver = SceneManager->getVideoDriver();
		driver->setTransform(video::ETS_WORLD, AbsoluteTransformation);
		renderMap(driver, SceneManager->getSceneNodeRenderPass());
	}

	virtual const aabb3f &getBoundingBox() const
	{
		return m_box;
	}

	void getBlocksInViewRange(v3s16 cam_pos_nodes,
		v3s16 *p_blocks_min, v3s16 *p_blocks_max);
	void updateDrawList(video::IVideoDriver* driver);
	void renderMap(video::IVideoDriver* driver, s32 pass);

	int getBackgroundBrightness(float max_d, u32 daylight_factor,
			int oldvalue, bool *sunlight_seen_result);

	void renderPostFx(CameraMode cam_mode);

	// For debug printing
	virtual void PrintInfo(std::ostream &out);

	const MapDrawControl & getControl() const { return m_control; }
	f32 getCameraFov() const { return m_camera_fov; }
private:
	Client *m_client;

	aabb3f m_box;

	MapDrawControl &m_control;

	v3f m_camera_position;
	v3f m_camera_direction;
	f32 m_camera_fov;
	v3s16 m_camera_offset;

	std::map<v3s16, MapBlock*> m_drawlist;

	std::set<v2s16> m_last_drawn_sectors;

	bool m_cache_trilinear_filter;
	bool m_cache_bilinear_filter;
	bool m_cache_anistropic_filter;
};

#endif

