/*
Minetest
Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com>

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

#include "collision.h"
#include "mapblock.h"
#include "map.h"
#include "nodedef.h"
#include "gamedef.h"
#ifndef SERVER
#include "clientenvironment.h"
#endif
#include "serverenvironment.h"
#include "serverobject.h"
#include "util/timetaker.h"
#include "profiler.h"

// float error is 10 - 9.96875 = 0.03125
//#define COLL_ZERO 0.032 // broken unit tests
#define COLL_ZERO 0


struct NearbyCollisionInfo {
	NearbyCollisionInfo(bool is_ul, bool is_obj, int bouncy,
			const v3s16 &pos, const aabb3f &box) :
		is_unloaded(is_ul),
		is_step_up(false),
		is_object(is_obj),
		bouncy(bouncy),
		position(pos),
		box(box)
	{}

	bool is_unloaded;
	bool is_step_up;
	bool is_object;
	int bouncy;
	v3s16 position;
	aabb3f box;
};


// Helper function:
// Checks for collision of a moving aabbox with a static aabbox
// Returns -1 if no collision, 0 if X collision, 1 if Y collision, 2 if Z collision
// The time after which the collision occurs is stored in dtime.
int axisAlignedCollision(
		const aabb3f &staticbox, const aabb3f &movingbox,
		const v3f &speed, f32 d, f32 *dtime)
{
	//TimeTaker tt("axisAlignedCollision");

	f32 xsize = (staticbox.MaxEdge.X - staticbox.MinEdge.X) - COLL_ZERO;     // reduce box size for solve collision stuck (flying sand)
	f32 ysize = (staticbox.MaxEdge.Y - staticbox.MinEdge.Y); // - COLL_ZERO; // Y - no sense for falling, but maybe try later
	f32 zsize = (staticbox.MaxEdge.Z - staticbox.MinEdge.Z) - COLL_ZERO;

	aabb3f relbox(
			movingbox.MinEdge.X - staticbox.MinEdge.X,
			movingbox.MinEdge.Y - staticbox.MinEdge.Y,
			movingbox.MinEdge.Z - staticbox.MinEdge.Z,
			movingbox.MaxEdge.X - staticbox.MinEdge.X,
			movingbox.MaxEdge.Y - staticbox.MinEdge.Y,
			movingbox.MaxEdge.Z - staticbox.MinEdge.Z
	);

	if(speed.X > 0) // Check for collision with X- plane
	{
		if (relbox.MaxEdge.X <= d) {
			*dtime = -relbox.MaxEdge.X / speed.X;
			if ((relbox.MinEdge.Y + speed.Y * (*dtime) < ysize) &&
					(relbox.MaxEdge.Y + speed.Y * (*dtime) > COLL_ZERO) &&
					(relbox.MinEdge.Z + speed.Z * (*dtime) < zsize) &&
					(relbox.MaxEdge.Z + speed.Z * (*dtime) > COLL_ZERO))
				return 0;
		}
		else if(relbox.MinEdge.X > xsize)
		{
			return -1;
		}
	}
	else if(speed.X < 0) // Check for collision with X+ plane
	{
		if (relbox.MinEdge.X >= xsize - d) {
			*dtime = (xsize - relbox.MinEdge.X) / speed.X;
			if ((relbox.MinEdge.Y + speed.Y * (*dtime) < ysize) &&
					(relbox.MaxEdge.Y + speed.Y * (*dtime) > COLL_ZERO) &&
					(relbox.MinEdge.Z + speed.Z * (*dtime) < zsize) &&
					(relbox.MaxEdge.Z + speed.Z * (*dtime) > COLL_ZERO))
				return 0;
		}
		else if(relbox.MaxEdge.X < 0)
		{
			return -1;
		}
	}

	// NO else if here

	if(speed.Y > 0) // Check for collision with Y- plane
	{
		if (relbox.MaxEdge.Y <= d) {
			*dtime = -relbox.MaxEdge.Y / speed.Y;
			if ((relbox.MinEdge.X + speed.X * (*dtime) < xsize) &&
					(relbox.MaxEdge.X + speed.X * (*dtime) > COLL_ZERO) &&
					(relbox.MinEdge.Z + speed.Z * (*dtime) < zsize) &&
					(relbox.MaxEdge.Z + speed.Z * (*dtime) > COLL_ZERO))
				return 1;
		}
		else if(relbox.MinEdge.Y > ysize)
		{
			return -1;
		}
	}
	else if(speed.Y < 0) // Check for collision with Y+ plane
	{
		if (relbox.MinEdge.Y >= ysize - d) {
			*dtime = (ysize - relbox.MinEdge.Y) / speed.Y;
			if ((relbox.MinEdge.X + speed.X * (*dtime) < xsize) &&
					(relbox.MaxEdge.X + speed.X * (*dtime) > COLL_ZERO) &&
					(relbox.MinEdge.Z + speed.Z * (*dtime) < zsize) &&
					(relbox.MaxEdge.Z + speed.Z * (*dtime) > COLL_ZERO))
				return 1;
		}
		else if(relbox.MaxEdge.Y < 0)
		{
			return -1;
		}
	}

	// NO else if here

	if(speed.Z > 0) // Check for collision with Z- plane
	{
		if (relbox.MaxEdge.Z <= d) {
			*dtime = -relbox.MaxEdge.Z / speed.Z;
			if ((relbox.MinEdge.X + speed.X * (*dtime) < xsize) &&
					(relbox.MaxEdge.X + speed.X * (*dtime) > COLL_ZERO) &&
					(relbox.MinEdge.Y + speed.Y * (*dtime) < ysize) &&
					(relbox.MaxEdge.Y + speed.Y * (*dtime) > COLL_ZERO))
				return 2;
		}
		//else if(relbox.MinEdge.Z > zsize)
		//{
		//	return -1;
		//}
	}
	else if(speed.Z < 0) // Check for collision with Z+ plane
	{
		if (relbox.MinEdge.Z >= zsize - d) {
			*dtime = (zsize - relbox.MinEdge.Z) / speed.Z;
			if ((relbox.MinEdge.X + speed.X * (*dtime) < xsize) &&
					(relbox.MaxEdge.X + speed.X * (*dtime) > COLL_ZERO) &&
					(relbox.MinEdge.Y + speed.Y * (*dtime) < ysize) &&
					(relbox.MaxEdge.Y + speed.Y * (*dtime) > COLL_ZERO))
				return 2;
		}
		//else if(relbox.MaxEdge.Z < 0)
		//{
		//	return -1;
		//}
	}

	return -1;
}

// Helper function:
// Checks if moving the movingbox up by the given distance would hit a ceiling.
bool wouldCollideWithCeiling(
		const std::vector<NearbyCollisionInfo> &cinfo,
		const aabb3f &movingbox,
		f32 y_increase, f32 d)
{
	//TimeTaker tt("wouldCollideWithCeiling");

	assert(y_increase >= 0);	// pre-condition

	for (std::vector<NearbyCollisionInfo>::const_iterator it = cinfo.begin();
			it != cinfo.end(); ++it) {
		const aabb3f &staticbox = it->box;
		if ((movingbox.MaxEdge.Y - d <= staticbox.MinEdge.Y) &&
				(movingbox.MaxEdge.Y + y_increase > staticbox.MinEdge.Y) &&
				(movingbox.MinEdge.X < staticbox.MaxEdge.X) &&
				(movingbox.MaxEdge.X > staticbox.MinEdge.X) &&
				(movingbox.MinEdge.Z < staticbox.MaxEdge.Z) &&
				(movingbox.MaxEdge.Z > staticbox.MinEdge.Z))
			return true;
	}

	return false;
}

static inline void getNeighborConnectingFace(v3s16 p, INodeDefManager *nodedef,
		Map *map, MapNode n, int v, int *neighbors)
{
	MapNode n2 = map->getNodeNoEx(p);
	if (nodedef->nodeboxConnects(n, n2, v))
		*neighbors |= v;
}

collisionMoveResult collisionMoveSimple(Environment *env, IGameDef *gamedef,
		f32 pos_max_d, const aabb3f &box_0,
		f32 stepheight, f32 dtime,
		v3f *pos_f, v3f *speed_f,
		v3f accel_f, ActiveObject *self,
		bool collideWithObjects)
{
	static bool time_notification_done = false;
	Map *map = &env->getMap();
	//TimeTaker tt("collisionMoveSimple");
	ScopeProfiler sp(g_profiler, "collisionMoveSimple avg", SPT_AVG);

	collisionMoveResult result;

	/*
		Calculate new velocity
	*/
	if (dtime > 0.5) {
		if (!time_notification_done) {
			time_notification_done = true;
			infostream << "collisionMoveSimple: maximum step interval exceeded,"
					" lost movement details!"<<std::endl;
		}
		dtime = 0.5;
	} else {
		time_notification_done = false;
	}
	*speed_f += accel_f * dtime;

	// If there is no speed, there are no collisions
	if (speed_f->getLength() == 0)
		return result;

	// Limit speed for avoiding hangs
	speed_f->Y = rangelim(speed_f->Y, -5000, 5000);
	speed_f->X = rangelim(speed_f->X, -5000, 5000);
	speed_f->Z = rangelim(speed_f->Z, -5000, 5000);

	/*
		Collect node boxes in movement range
	*/
	std::vector<NearbyCollisionInfo> cinfo;
	{
	//TimeTaker tt2("collisionMoveSimple collect boxes");
	ScopeProfiler sp(g_profiler, "collisionMoveSimple collect boxes avg", SPT_AVG);

	v3s16 oldpos_i = floatToInt(*pos_f, BS);
	v3s16 newpos_i = floatToInt(*pos_f + *speed_f * dtime, BS);
	s16 min_x = MYMIN(oldpos_i.X, newpos_i.X) + (box_0.MinEdge.X / BS) - 1;
	s16 min_y = MYMIN(oldpos_i.Y, newpos_i.Y) + (box_0.MinEdge.Y / BS) - 1;
	s16 min_z = MYMIN(oldpos_i.Z, newpos_i.Z) + (box_0.MinEdge.Z / BS) - 1;
	s16 max_x = MYMAX(oldpos_i.X, newpos_i.X) + (box_0.MaxEdge.X / BS) + 1;
	s16 max_y = MYMAX(oldpos_i.Y, newpos_i.Y) + (box_0.MaxEdge.Y / BS) + 1;
	s16 max_z = MYMAX(oldpos_i.Z, newpos_i.Z) + (box_0.MaxEdge.Z / BS) + 1;

	bool any_position_valid = false;

	for(s16 x = min_x; x <= max_x; x++)
	for(s16 y = min_y; y <= max_y; y++)
	for(s16 z = min_z; z <= max_z; z++)
	{
		v3s16 p(x,y,z);

		bool is_position_valid;
		MapNode n = map->getNodeNoEx(p, &is_position_valid);

		if (is_position_valid) {
			// Object collides into walkable nodes

			any_position_valid = true;
			INodeDefManager *nodedef = gamedef->getNodeDefManager();
			const ContentFeatures &f = nodedef->get(n);
			if(f.walkable == false)
				continue;
			int n_bouncy_value = itemgroup_get(f.groups, "bouncy");

			int neighbors = 0;
			if (f.drawtype == NDT_NODEBOX && f.node_box.type == NODEBOX_CONNECTED) {
				v3s16 p2 = p;

				p2.Y++;
				getNeighborConnectingFace(p2, nodedef, map, n, 1, &neighbors);

				p2 = p;
				p2.Y--;
				getNeighborConnectingFace(p2, nodedef, map, n, 2, &neighbors);

				p2 = p;
				p2.Z--;
				getNeighborConnectingFace(p2, nodedef, map, n, 4, &neighbors);

				p2 = p;
				p2.X--;
				getNeighborConnectingFace(p2, nodedef, map, n, 8, &neighbors);

				p2 = p;
				p2.Z++;
				getNeighborConnectingFace(p2, nodedef, map, n, 16, &neighbors);

				p2 = p;
				p2.X++;
				getNeighborConnectingFace(p2, nodedef, map, n, 32, &neighbors);
			}
			std::vector<aabb3f> nodeboxes;
			n.getCollisionBoxes(gamedef->ndef(), &nodeboxes, neighbors);
			for(std::vector<aabb3f>::iterator
					i = nodeboxes.begin();
					i != nodeboxes.end(); ++i)
			{
				aabb3f box = *i;
				box.MinEdge += v3f(x, y, z)*BS;
				box.MaxEdge += v3f(x, y, z)*BS;
				cinfo.push_back(NearbyCollisionInfo(false,
					false, n_bouncy_value, p, box));
			}
		} else {
			// Collide with unloaded nodes
			aabb3f box = getNodeBox(p, BS);
			cinfo.push_back(NearbyCollisionInfo(true, false, 0, p, box));
		}
	}

	// Do not move if world has not loaded yet, since custom node boxes
	// are not available for collision detection.
	if (!any_position_valid) {
		*speed_f = v3f(0, 0, 0);
		return result;
	}

	} // tt2

	if(collideWithObjects)
	{
		ScopeProfiler sp(g_profiler, "collisionMoveSimple objects avg", SPT_AVG);
		//TimeTaker tt3("collisionMoveSimple collect object boxes");

		/* add object boxes to cinfo */

		std::vector<ActiveObject*> objects;
#ifndef SERVER
		ClientEnvironment *c_env = dynamic_cast<ClientEnvironment*>(env);
		if (c_env != 0) {
			f32 distance = speed_f->getLength();
			std::vector<DistanceSortedActiveObject> clientobjects;
			c_env->getActiveObjects(*pos_f, distance * 1.5, clientobjects);
			for (size_t i=0; i < clientobjects.size(); i++) {
				if ((self == 0) || (self != clientobjects[i].obj)) {
					objects.push_back((ActiveObject*)clientobjects[i].obj);
				}
			}
		}
		else
#endif
		{
			ServerEnvironment *s_env = dynamic_cast<ServerEnvironment*>(env);
			if (s_env != NULL) {
				f32 distance = speed_f->getLength();
				std::vector<u16> s_objects;
				s_env->getObjectsInsideRadius(s_objects, *pos_f, distance * 1.5);
				for (std::vector<u16>::iterator iter = s_objects.begin(); iter != s_objects.end(); ++iter) {
					ServerActiveObject *current = s_env->getActiveObject(*iter);
					if ((self == 0) || (self != current)) {
						objects.push_back((ActiveObject*)current);
					}
				}
			}
		}

		for (std::vector<ActiveObject*>::const_iterator iter = objects.begin();
				iter != objects.end(); ++iter) {
			ActiveObject *object = *iter;

			if (object != NULL) {
				aabb3f object_collisionbox;
				if (object->getCollisionBox(&object_collisionbox) &&
						object->collideWithObjects()) {
					cinfo.push_back(NearbyCollisionInfo(false, true, 0, v3s16(), object_collisionbox));
				}
			}
		}
	} //tt3

	/*
		Collision detection
	*/

	/*
		Collision uncertainty radius
		Make it a bit larger than the maximum distance of movement
	*/
	f32 d = pos_max_d * 1.1;
	// A fairly large value in here makes moving smoother
	//f32 d = 0.15*BS;

	// This should always apply, otherwise there are glitches
	assert(d > pos_max_d);	// invariant

	int loopcount = 0;

	while(dtime > BS * 1e-10) {
		//TimeTaker tt3("collisionMoveSimple dtime loop");
        	ScopeProfiler sp(g_profiler, "collisionMoveSimple dtime loop avg", SPT_AVG);

		// Avoid infinite loop
		loopcount++;
		if (loopcount >= 100) {
			warningstream << "collisionMoveSimple: Loop count exceeded, aborting to avoid infiniite loop" << std::endl;
			break;
		}

		aabb3f movingbox = box_0;
		movingbox.MinEdge += *pos_f;
		movingbox.MaxEdge += *pos_f;

		int nearest_collided = -1;
		f32 nearest_dtime = dtime;
		int nearest_boxindex = -1;

		/*
			Go through every nodebox, find nearest collision
		*/
		for (u32 boxindex = 0; boxindex < cinfo.size(); boxindex++) {
			NearbyCollisionInfo box_info = cinfo[boxindex];
			// Ignore if already stepped up this nodebox.
			if (box_info.is_step_up)
				continue;

			// Find nearest collision of the two boxes (raytracing-like)
			f32 dtime_tmp;
			int collided = axisAlignedCollision(box_info.box,
					movingbox, *speed_f, d, &dtime_tmp);

			if (collided == -1 || dtime_tmp >= nearest_dtime)
				continue;

			nearest_dtime = dtime_tmp;
			nearest_collided = collided;
			nearest_boxindex = boxindex;
		}

		if (nearest_collided == -1) {
			// No collision with any collision box.
			*pos_f += *speed_f * dtime;
			dtime = 0;  // Set to 0 to avoid "infinite" loop due to small FP numbers
		} else {
			// Otherwise, a collision occurred.
			NearbyCollisionInfo &nearest_info = cinfo[nearest_boxindex];
			const aabb3f& cbox = nearest_info.box;
			// Check for stairs.
			bool step_up = (nearest_collided != 1) && // must not be Y direction
					(movingbox.MinEdge.Y < cbox.MaxEdge.Y) &&
					(movingbox.MinEdge.Y + stepheight > cbox.MaxEdge.Y) &&
					(!wouldCollideWithCeiling(cinfo, movingbox,
							cbox.MaxEdge.Y - movingbox.MinEdge.Y,
							d));

			// Get bounce multiplier
			bool bouncy = (nearest_info.bouncy >= 1);
			float bounce = -(float)nearest_info.bouncy / 100.0;

			// Move to the point of collision and reduce dtime by nearest_dtime
			if (nearest_dtime < 0) {
				// Handle negative nearest_dtime (can be caused by the d allowance)
				if (!step_up) {
					if (nearest_collided == 0)
						pos_f->X += speed_f->X * nearest_dtime;
					if (nearest_collided == 1)
						pos_f->Y += speed_f->Y * nearest_dtime;
					if (nearest_collided == 2)
						pos_f->Z += speed_f->Z * nearest_dtime;
				}
			} else {
				*pos_f += *speed_f * nearest_dtime;
				dtime -= nearest_dtime;
			}

			bool is_collision = true;
			if (nearest_info.is_unloaded)
				is_collision = false;

			CollisionInfo info;
			if (nearest_info.is_object)
				info.type = COLLISION_OBJECT;
			else
				info.type = COLLISION_NODE;

			info.node_p = nearest_info.position;
			info.bouncy = bouncy;
			info.old_speed = *speed_f;

			// Set the speed component that caused the collision to zero
			if (step_up) {
				// Special case: Handle stairs
				nearest_info.is_step_up = true;
				is_collision = false;
			} else if (nearest_collided == 0) { // X
				if (fabs(speed_f->X) > BS * 3)
					speed_f->X *= bounce;
				else
					speed_f->X = 0;
				result.collides = true;
				result.collides_xz = true;
			} else if (nearest_collided == 1) { // Y
				if(fabs(speed_f->Y) > BS * 3)
					speed_f->Y *= bounce;
				else
					speed_f->Y = 0;
				result.collides = true;
			} else if (nearest_collided == 2) { // Z
				if (fabs(speed_f->Z) > BS * 3)
					speed_f->Z *= bounce;
				else
					speed_f->Z = 0;
				result.collides = true;
				result.collides_xz = true;
			}

			info.new_speed = *speed_f;
			if (info.new_speed.getDistanceFrom(info.old_speed) < 0.1 * BS)
				is_collision = false;

			if (is_collision) {
				result.collisions.push_back(info);
			}
		}
	}

	/*
		Final touches: Check if standing on ground, step up stairs.
	*/
	aabb3f box = box_0;
	box.MinEdge += *pos_f;
	box.MaxEdge += *pos_f;
	for (u32 boxindex = 0; boxindex < cinfo.size(); boxindex++) {
		NearbyCollisionInfo &box_info = cinfo[boxindex];
		const aabb3f &cbox = box_info.box;

		/*
			See if the object is touching ground.

			Object touches ground if object's minimum Y is near node's
			maximum Y and object's X-Z-area overlaps with the node's
			X-Z-area.

			Use 0.15*BS so that it is easier to get on a node.
		*/
		if (cbox.MaxEdge.X - d > box.MinEdge.X && cbox.MinEdge.X + d < box.MaxEdge.X &&
				cbox.MaxEdge.Z - d > box.MinEdge.Z &&
				cbox.MinEdge.Z + d < box.MaxEdge.Z) {
			if (box_info.is_step_up) {
				pos_f->Y += cbox.MaxEdge.Y - box.MinEdge.Y;
				box = box_0;
				box.MinEdge += *pos_f;
				box.MaxEdge += *pos_f;
			}
			if (fabs(cbox.MaxEdge.Y - box.MinEdge.Y) < 0.15 * BS) {
				result.touching_ground = true;

				if (box_info.is_object)
					result.standing_on_object = true;
				if (box_info.is_unloaded)
					result.standing_on_unloaded = true;
			}
		}
	}

	return result;
}
