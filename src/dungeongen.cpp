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

#include "dungeongen.h"
#include "mapgen.h"
#include "voxel.h"
#include "noise.h"
#include "mapblock.h"
#include "mapnode.h"
#include "map.h"
#include "nodedef.h"
#include "profiler.h"
#include "settings.h"

//#define DGEN_USE_TORCHES

NoiseParams nparams_dungeon_density(0.9, 0.5, v3f(500.0, 500.0, 500.0), 0, 2, 0.8, 2.0);
NoiseParams nparams_dungeon_alt_wall(-0.4, 1.0, v3f(40.0, 40.0, 40.0), 32474, 6, 1.1, 2.0);


///////////////////////////////////////////////////////////////////////////////


DungeonGen::DungeonGen(INodeDefManager *ndef,
	GenerateNotifier *gennotify, DungeonParams *dparams)
{
	assert(ndef);

	this->ndef      = ndef;
	this->gennotify = gennotify;

#ifdef DGEN_USE_TORCHES
	c_torch  = ndef->getId("default:torch");
#endif

	if (dparams) {
		memcpy(&dp, dparams, sizeof(dp));
	} else {
		dp.seed = 0;

		dp.c_water       = ndef->getId("mapgen_water_source");
		dp.c_river_water = ndef->getId("mapgen_river_water_source");
		dp.c_wall        = ndef->getId("mapgen_cobble");
		dp.c_alt_wall    = ndef->getId("mapgen_mossycobble");
		dp.c_stair       = ndef->getId("mapgen_stair_cobble");

		if (dp.c_river_water == CONTENT_IGNORE)
			dp.c_river_water = ndef->getId("mapgen_water_source");

		dp.diagonal_dirs = false;
		dp.holesize      = v3s16(1, 2, 1);
		dp.roomsize      = v3s16(0, 0, 0);
		dp.rooms_min     = 2;
		dp.rooms_max     = 16;
		dp.y_min         = -MAX_MAP_GENERATION_LIMIT;
		dp.y_max         = MAX_MAP_GENERATION_LIMIT;
		dp.notifytype    = GENNOTIFY_DUNGEON;

		dp.np_density  = nparams_dungeon_density;
		dp.np_alt_wall = nparams_dungeon_alt_wall;
	}
}


void DungeonGen::generate(MMVManip *vm, u32 bseed, v3s16 nmin, v3s16 nmax)
{
	assert(vm);

	//TimeTaker t("gen dungeons");
	if (nmin.Y < dp.y_min || nmax.Y > dp.y_max)
		return;

	float nval_density = NoisePerlin3D(&dp.np_density, nmin.X, nmin.Y, nmin.Z, dp.seed);
	if (nval_density < 1.0f)
		return;

	this->vm = vm;
	this->blockseed = bseed;
	random.seed(bseed + 2);

	// Dungeon generator doesn't modify places which have this set
	vm->clearFlag(VMANIP_FLAG_DUNGEON_INSIDE | VMANIP_FLAG_DUNGEON_PRESERVE);

	// Set all air and water to be untouchable
	// to make dungeons open to caves and open air
	for (s16 z = nmin.Z; z <= nmax.Z; z++) {
		for (s16 y = nmin.Y; y <= nmax.Y; y++) {
			u32 i = vm->m_area.index(nmin.X, y, z);
			for (s16 x = nmin.X; x <= nmax.X; x++) {
				content_t c = vm->m_data[i].getContent();
				if (c == CONTENT_AIR || c == dp.c_water || c == dp.c_river_water)
					vm->m_flags[i] |= VMANIP_FLAG_DUNGEON_PRESERVE;
				i++;
			}
		}
	}

	// Add them
	for (u32 i = 0; i < floor(nval_density); i++)
		makeDungeon(v3s16(1, 1, 1) * MAP_BLOCKSIZE);

	// Optionally convert some structure to alternative structure
	if (dp.c_alt_wall == CONTENT_IGNORE)
		return;

	for (s16 z = nmin.Z; z <= nmax.Z; z++)
	for (s16 y = nmin.Y; y <= nmax.Y; y++) {
		u32 i = vm->m_area.index(nmin.X, y, z);
		for (s16 x = nmin.X; x <= nmax.X; x++) {
			if (vm->m_data[i].getContent() == dp.c_wall) {
				if (NoisePerlin3D(&dp.np_alt_wall, x, y, z, blockseed) > 0.0f)
					vm->m_data[i].setContent(dp.c_alt_wall);
			}
			i++;
		}
	}

	//printf("== gen dungeons: %dms\n", t.stop());
}


void DungeonGen::makeDungeon(v3s16 start_padding)
{
	v3s16 areasize = vm->m_area.getExtent();
	v3s16 roomsize;
	v3s16 roomplace;

	/*
		Find place for first room
	*/
	bool fits = false;
	for (u32 i = 0; i < 100 && !fits; i++) {
		bool is_large_room = ((random.next() & 3) == 1);
		if (is_large_room) {
			roomsize.Z = random.range(8, 16);
			roomsize.Y = random.range(8, 16);
			roomsize.X = random.range(8, 16);
		} else {
			roomsize.Z = random.range(4, 8);
			roomsize.Y = random.range(4, 6);
			roomsize.X = random.range(4, 8);
		}
		roomsize += dp.roomsize;

		// start_padding is used to disallow starting the generation of
		// a dungeon in a neighboring generation chunk
		roomplace = vm->m_area.MinEdge + start_padding;
		roomplace.Z += random.range(0, areasize.Z - roomsize.Z - start_padding.Z);
		roomplace.Y += random.range(0, areasize.Y - roomsize.Y - start_padding.Y);
		roomplace.X += random.range(0, areasize.X - roomsize.X - start_padding.X);

		/*
			Check that we're not putting the room to an unknown place,
			otherwise it might end up floating in the air
		*/
		fits = true;
		for (s16 z = 0; z < roomsize.Z; z++)
		for (s16 y = 0; y < roomsize.Y; y++)
		for (s16 x = 0; x < roomsize.X; x++) {
			v3s16 p = roomplace + v3s16(x, y, z);
			u32 vi = vm->m_area.index(p);
			if ((vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE) ||
					vm->m_data[vi].getContent() == CONTENT_IGNORE) {
				fits = false;
				break;
			}
		}
	}
	// No place found
	if (fits == false)
		return;

	/*
		Stores the center position of the last room made, so that
		a new corridor can be started from the last room instead of
		the new room, if chosen so.
	*/
	v3s16 last_room_center = roomplace + v3s16(roomsize.X / 2, 1, roomsize.Z / 2);

	u32 room_count = random.range(dp.rooms_min, dp.rooms_max);
	for (u32 i = 0; i < room_count; i++) {
		// Make a room to the determined place
		makeRoom(roomsize, roomplace);

		v3s16 room_center = roomplace + v3s16(roomsize.X / 2, 1, roomsize.Z / 2);
		if (gennotify)
			gennotify->addEvent(dp.notifytype, room_center);

#ifdef DGEN_USE_TORCHES
		// Place torch at room center (for testing)
		vm->m_data[vm->m_area.index(room_center)] = MapNode(c_torch);
#endif

		// Quit if last room
		if (i == room_count - 1)
			break;

		// Determine walker start position

		bool start_in_last_room = (random.range(0, 2) != 0);

		v3s16 walker_start_place;

		if (start_in_last_room) {
			walker_start_place = last_room_center;
		} else {
			walker_start_place = room_center;
			// Store center of current room as the last one
			last_room_center = room_center;
		}

		// Create walker and find a place for a door
		v3s16 doorplace;
		v3s16 doordir;

		m_pos = walker_start_place;
		if (!findPlaceForDoor(doorplace, doordir))
			return;

		if (random.range(0, 1) == 0)
			// Make the door
			makeDoor(doorplace, doordir);
		else
			// Don't actually make a door
			doorplace -= doordir;

		// Make a random corridor starting from the door
		v3s16 corridor_end;
		v3s16 corridor_end_dir;
		makeCorridor(doorplace, doordir, corridor_end, corridor_end_dir);

		// Find a place for a random sized room
		roomsize.Z = random.range(4, 8);
		roomsize.Y = random.range(4, 6);
		roomsize.X = random.range(4, 8);
		roomsize += dp.roomsize;

		m_pos = corridor_end;
		m_dir = corridor_end_dir;
		if (!findPlaceForRoomDoor(roomsize, doorplace, doordir, roomplace))
			return;

		if (random.range(0, 1) == 0)
			// Make the door
			makeDoor(doorplace, doordir);
		else
			// Don't actually make a door
			roomplace -= doordir;

	}
}


void DungeonGen::makeRoom(v3s16 roomsize, v3s16 roomplace)
{
	MapNode n_wall(dp.c_wall);
	MapNode n_air(CONTENT_AIR);

	// Make +-X walls
	for (s16 z = 0; z < roomsize.Z; z++)
	for (s16 y = 0; y < roomsize.Y; y++) {
		{
			v3s16 p = roomplace + v3s16(0, y, z);
			if (!vm->m_area.contains(p))
				continue;
			u32 vi = vm->m_area.index(p);
			if (vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE)
				continue;
			vm->m_data[vi] = n_wall;
		}
		{
			v3s16 p = roomplace + v3s16(roomsize.X - 1, y, z);
			if (!vm->m_area.contains(p))
				continue;
			u32 vi = vm->m_area.index(p);
			if (vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE)
				continue;
			vm->m_data[vi] = n_wall;
		}
	}

	// Make +-Z walls
	for (s16 x = 0; x < roomsize.X; x++)
	for (s16 y = 0; y < roomsize.Y; y++) {
		{
			v3s16 p = roomplace + v3s16(x, y, 0);
			if (!vm->m_area.contains(p))
				continue;
			u32 vi = vm->m_area.index(p);
			if (vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE)
				continue;
			vm->m_data[vi] = n_wall;
		}
		{
			v3s16 p = roomplace + v3s16(x, y, roomsize.Z - 1);
			if (!vm->m_area.contains(p))
				continue;
			u32 vi = vm->m_area.index(p);
			if (vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE)
				continue;
			vm->m_data[vi] = n_wall;
		}
	}

	// Make +-Y walls (floor and ceiling)
	for (s16 z = 0; z < roomsize.Z; z++)
	for (s16 x = 0; x < roomsize.X; x++) {
		{
			v3s16 p = roomplace + v3s16(x, 0, z);
			if (!vm->m_area.contains(p))
				continue;
			u32 vi = vm->m_area.index(p);
			if (vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE)
				continue;
			vm->m_data[vi] = n_wall;
		}
		{
			v3s16 p = roomplace + v3s16(x,roomsize. Y - 1, z);
			if (!vm->m_area.contains(p))
				continue;
			u32 vi = vm->m_area.index(p);
			if (vm->m_flags[vi] & VMANIP_FLAG_DUNGEON_UNTOUCHABLE)
				continue;
			vm->m_data[vi] = n_wall;
		}
	}

	// Fill with air
	for (s16 z = 1; z < roomsize.Z - 1; z++)
	for (s16 y = 1; y < roomsize.Y - 1; y++)
	for (s16 x = 1; x < roomsize.X - 1; x++) {
		v3s16 p = roomplace + v3s16(x, y, z);
		if (!vm->m_area.contains(p))
			continue;
		u32 vi = vm->m_area.index(p);
		vm->m_flags[vi] |= VMANIP_FLAG_DUNGEON_UNTOUCHABLE;
		vm->m_data[vi] = n_air;
	}
}


void DungeonGen::makeFill(v3s16 place, v3s16 size,
	u8 avoid_flags, MapNode n, u8 or_flags)
{
	for (s16 z = 0; z < size.Z; z++)
	for (s16 y = 0; y < size.Y; y++)
	for (s16 x = 0; x < size.X; x++) {
		v3s16 p = place + v3s16(x, y, z);
		if (!vm->m_area.contains(p))
			continue;
		u32 vi = vm->m_area.index(p);
		if (vm->m_flags[vi] & avoid_flags)
			continue;
		vm->m_flags[vi] |= or_flags;
		vm->m_data[vi] = n;
	}
}


void DungeonGen::makeHole(v3s16 place)
{
	makeFill(place, dp.holesize, 0, MapNode(CONTENT_AIR),
		VMANIP_FLAG_DUNGEON_INSIDE);
}


void DungeonGen::makeDoor(v3s16 doorplace, v3s16 doordir)
{
	makeHole(doorplace);

#ifdef DGEN_USE_TORCHES
	// Place torch (for testing)
	vm->m_data[vm->m_area.index(doorplace)] = MapNode(c_torch);
#endif
}


void DungeonGen::makeCorridor(v3s16 doorplace, v3s16 doordir,
	v3s16 &result_place, v3s16 &result_dir)
{
	makeHole(doorplace);
	v3s16 p0 = doorplace;
	v3s16 dir = doordir;
	u32 length;
	/*if (random.next() % 2)
		length = random.range(1, 13);
	else
		length = random.range(1, 6);*/
	length = random.range(1, 13);
	u32 partlength = random.range(1, 13);
	u32 partcount = 0;
	s16 make_stairs = 0;

	if (random.next() % 2 == 0 && partlength >= 3)
		make_stairs = random.next() % 2 ? 1 : -1;

	for (u32 i = 0; i < length; i++) {
		v3s16 p = p0 + dir;
		if (partcount != 0)
			p.Y += make_stairs;

		if (vm->m_area.contains(p) && vm->m_area.contains(p + v3s16(0, 1, 0)) &&
				vm->m_area.contains(v3s16(p.X - dir.X, p.Y - 1, p.Z - dir.Z))) {
			if (make_stairs) {
				makeFill(p + v3s16(-1, -1, -1),
					dp.holesize + v3s16(2, 3, 2),
					VMANIP_FLAG_DUNGEON_UNTOUCHABLE,
					MapNode(dp.c_wall),
					0);
				makeHole(p);
				makeHole(p - dir);

				// TODO: fix stairs code so it works 100%
				// (quite difficult)

				// exclude stairs from the bottom step
				// exclude stairs from diagonal steps
				if (((dir.X ^ dir.Z) & 1) &&
						(((make_stairs ==  1) && i != 0) ||
						((make_stairs == -1) && i != length - 1))) {
					// rotate face 180 deg if
					// making stairs backwards
					int facedir = dir_to_facedir(dir * make_stairs);

					u32 vi = vm->m_area.index(p.X - dir.X, p.Y - 1, p.Z - dir.Z);
					if (vm->m_data[vi].getContent() == dp.c_wall)
						vm->m_data[vi] = MapNode(dp.c_stair, 0, facedir);

					vi = vm->m_area.index(p.X, p.Y, p.Z);
					if (vm->m_data[vi].getContent() == dp.c_wall)
						vm->m_data[vi] = MapNode(dp.c_stair, 0, facedir);
				}
			} else {
				makeFill(p + v3s16(-1, -1, -1),
					dp.holesize + v3s16(2, 2, 2),
					VMANIP_FLAG_DUNGEON_UNTOUCHABLE,
					MapNode(dp.c_wall),
					0);
				makeHole(p);
			}

			p0 = p;
		} else {
			// Can't go here, turn away
			dir = turn_xz(dir, random.range(0, 1));
			make_stairs = -make_stairs;
			partcount = 0;
			partlength = random.range(1, length);
			continue;
		}

		partcount++;
		if (partcount >= partlength) {
			partcount = 0;

			dir = random_turn(random, dir);

			partlength = random.range(1, length);

			make_stairs = 0;
			if (random.next() % 2 == 0 && partlength >= 3)
				make_stairs = random.next() % 2 ? 1 : -1;
		}
	}
	result_place = p0;
	result_dir = dir;
}


bool DungeonGen::findPlaceForDoor(v3s16 &result_place, v3s16 &result_dir)
{
	for (u32 i = 0; i < 100; i++) {
		v3s16 p = m_pos + m_dir;
		v3s16 p1 = p + v3s16(0, 1, 0);
		if (!vm->m_area.contains(p) || !vm->m_area.contains(p1) || i % 4 == 0) {
			randomizeDir();
			continue;
		}
		if (vm->getNodeNoExNoEmerge(p).getContent() == dp.c_wall &&
				vm->getNodeNoExNoEmerge(p1).getContent() == dp.c_wall) {
			// Found wall, this is a good place!
			result_place = p;
			result_dir = m_dir;
			// Randomize next direction
			randomizeDir();
			return true;
		}
		/*
			Determine where to move next
		*/
		// Jump one up if the actual space is there
		if (vm->getNodeNoExNoEmerge(p +
				v3s16(0, 0, 0)).getContent() == dp.c_wall &&
				vm->getNodeNoExNoEmerge(p +
				v3s16(0, 1, 0)).getContent() == CONTENT_AIR &&
				vm->getNodeNoExNoEmerge(p +
				v3s16(0, 2, 0)).getContent() == CONTENT_AIR)
			p += v3s16(0,1,0);
		// Jump one down if the actual space is there
		if (vm->getNodeNoExNoEmerge(p +
				v3s16(0, 1, 0)).getContent() == dp.c_wall &&
				vm->getNodeNoExNoEmerge(p +
				v3s16(0, 0, 0)).getContent() == CONTENT_AIR &&
				vm->getNodeNoExNoEmerge(p +
				v3s16(0, -1, 0)).getContent() == CONTENT_AIR)
			p += v3s16(0, -1, 0);
		// Check if walking is now possible
		if (vm->getNodeNoExNoEmerge(p).getContent() != CONTENT_AIR ||
				vm->getNodeNoExNoEmerge(p +
				v3s16(0, 1, 0)).getContent() != CONTENT_AIR) {
			// Cannot continue walking here
			randomizeDir();
			continue;
		}
		// Move there
		m_pos = p;
	}
	return false;
}


bool DungeonGen::findPlaceForRoomDoor(v3s16 roomsize, v3s16 &result_doorplace,
	v3s16 &result_doordir, v3s16 &result_roomplace)
{
	for (s16 trycount = 0; trycount < 30; trycount++) {
		v3s16 doorplace;
		v3s16 doordir;
		bool r = findPlaceForDoor(doorplace, doordir);
		if (r == false)
			continue;
		v3s16 roomplace;
		// X east, Z north, Y up
#if 1
		if (doordir == v3s16(1, 0, 0)) // X+
			roomplace = doorplace +
				v3s16(0, -1, random.range(-roomsize.Z + 2, -2));
		if (doordir == v3s16(-1, 0, 0)) // X-
			roomplace = doorplace +
				v3s16(-roomsize.X + 1, -1, random.range(-roomsize.Z + 2, -2));
		if (doordir == v3s16(0, 0, 1)) // Z+
			roomplace = doorplace +
				v3s16(random.range(-roomsize.X + 2, -2), -1, 0);
		if (doordir == v3s16(0, 0, -1)) // Z-
			roomplace = doorplace +
				v3s16(random.range(-roomsize.X + 2, -2), -1, -roomsize.Z + 1);
#endif
#if 0
		if (doordir == v3s16(1, 0, 0)) // X+
			roomplace = doorplace + v3s16(0, -1, -roomsize.Z / 2);
		if (doordir == v3s16(-1, 0, 0)) // X-
			roomplace = doorplace + v3s16(-roomsize.X+1,-1,-roomsize.Z / 2);
		if (doordir == v3s16(0, 0, 1)) // Z+
			roomplace = doorplace + v3s16(-roomsize.X / 2, -1, 0);
		if (doordir == v3s16(0, 0, -1)) // Z-
			roomplace = doorplace + v3s16(-roomsize.X / 2, -1, -roomsize.Z + 1);
#endif

		// Check fit
		bool fits = true;
		for (s16 z = 1; z < roomsize.Z - 1; z++)
		for (s16 y = 1; y < roomsize.Y - 1; y++)
		for (s16 x = 1; x < roomsize.X - 1; x++) {
			v3s16 p = roomplace + v3s16(x, y, z);
			if (!vm->m_area.contains(p)) {
				fits = false;
				break;
			}
			if (vm->m_flags[vm->m_area.index(p)] & VMANIP_FLAG_DUNGEON_INSIDE) {
				fits = false;
				break;
			}
		}
		if (fits == false) {
			// Find new place
			continue;
		}
		result_doorplace = doorplace;
		result_doordir   = doordir;
		result_roomplace = roomplace;
		return true;
	}
	return false;
}


v3s16 rand_ortho_dir(PseudoRandom &random, bool diagonal_dirs)
{
	// Make diagonal directions somewhat rare
	if (diagonal_dirs && (random.next() % 4 == 0)) {
		v3s16 dir;
		int trycount = 0;

		do {
			trycount++;

			dir.Z = random.next() % 3 - 1;
			dir.Y = 0;
			dir.X = random.next() % 3 - 1;
		} while ((dir.X == 0 && dir.Z == 0) && trycount < 10);

		return dir;
	} else {
		if (random.next() % 2 == 0)
			return random.next() % 2 ? v3s16(-1, 0, 0) : v3s16(1, 0, 0);
		else
			return random.next() % 2 ? v3s16(0, 0, -1) : v3s16(0, 0, 1);
	}
}


v3s16 turn_xz(v3s16 olddir, int t)
{
	v3s16 dir;
	if (t == 0) {
		// Turn right
		dir.X = olddir.Z;
		dir.Z = -olddir.X;
		dir.Y = olddir.Y;
	} else {
		// Turn left
		dir.X = -olddir.Z;
		dir.Z = olddir.X;
		dir.Y = olddir.Y;
	}
	return dir;
}


v3s16 random_turn(PseudoRandom &random, v3s16 olddir)
{
	int turn = random.range(0, 2);
	v3s16 dir;
	if (turn == 0)
		// Go straight
		dir = olddir;
	else if (turn == 1)
		// Turn right
		dir = turn_xz(olddir, 0);
	else
		// Turn left
		dir = turn_xz(olddir, 1);
	return dir;
}


int dir_to_facedir(v3s16 d)
{
	if (abs(d.X) > abs(d.Z))
		return d.X < 0 ? 3 : 1;
	else
		return d.Z < 0 ? 2 : 0;
}
