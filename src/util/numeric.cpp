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

#include "numeric.h"

#include "log.h"
#include "../constants.h" // BS, MAP_BLOCKSIZE
#include "../noise.h" // PseudoRandom, PcgRandom
#include "../threading/mutex_auto_lock.h"
#include <string.h>


// myrand

PcgRandom g_pcgrand;

u32 myrand()
{
	return g_pcgrand.next();
}

void mysrand(unsigned int seed)
{
	g_pcgrand.seed(seed);
}

void myrand_bytes(void *out, size_t len)
{
	g_pcgrand.bytes(out, len);
}

int myrand_range(int min, int max)
{
	return g_pcgrand.range(min, max);
}


/*
	64-bit unaligned version of MurmurHash
*/
u64 murmur_hash_64_ua(const void *key, int len, unsigned int seed)
{
	const u64 m = 0xc6a4a7935bd1e995ULL;
	const int r = 47;
	u64 h = seed ^ (len * m);

	const u64 *data = (const u64 *)key;
	const u64 *end = data + (len / 8);

	while (data != end) {
		u64 k;
		memcpy(&k, data, sizeof(u64));
		data++;

		k *= m;
		k ^= k >> r;
		k *= m;

		h ^= k;
		h *= m;
	}

	const unsigned char *data2 = (const unsigned char *)data;
	switch (len & 7) {
		case 7: h ^= (u64)data2[6] << 48;
		case 6: h ^= (u64)data2[5] << 40;
		case 5: h ^= (u64)data2[4] << 32;
		case 4: h ^= (u64)data2[3] << 24;
		case 3: h ^= (u64)data2[2] << 16;
		case 2: h ^= (u64)data2[1] << 8;
		case 1: h ^= (u64)data2[0];
				h *= m;
	}

	h ^= h >> r;
	h *= m;
	h ^= h >> r;

	return h;
}

/*
	blockpos_b: position of block in block coordinates
	camera_pos: position of camera in nodes
	camera_dir: an unit vector pointing to camera direction
	range: viewing range
	distance_ptr: return location for distance from the camera
*/
bool isBlockInSight(v3s16 blockpos_b, v3f camera_pos, v3f camera_dir,
		f32 camera_fov, f32 range, f32 *distance_ptr)
{
	// Maximum radius of a block.  The magic number is
	// sqrt(3.0) / 2.0 in literal form.
	const f32 block_max_radius = 0.866025403784 * MAP_BLOCKSIZE * BS;

	v3s16 blockpos_nodes = blockpos_b * MAP_BLOCKSIZE;

	// Block center position
	v3f blockpos(
			((float)blockpos_nodes.X + MAP_BLOCKSIZE/2) * BS,
			((float)blockpos_nodes.Y + MAP_BLOCKSIZE/2) * BS,
			((float)blockpos_nodes.Z + MAP_BLOCKSIZE/2) * BS
	);

	// Block position relative to camera
	v3f blockpos_relative = blockpos - camera_pos;

	// Total distance
	f32 d = MYMAX(0, blockpos_relative.getLength() - block_max_radius);

	if(distance_ptr)
		*distance_ptr = d;

	// If block is far away, it's not in sight
	if(d > range)
		return false;

	// If block is (nearly) touching the camera, don't
	// bother validating further (that is, render it anyway)
	if(d == 0)
		return true;

	// Adjust camera position, for purposes of computing the angle,
	// such that a block that has any portion visible with the
	// current camera position will have the center visible at the
	// adjusted postion
	f32 adjdist = block_max_radius / cos((M_PI - camera_fov) / 2);

	// Block position relative to adjusted camera
	v3f blockpos_adj = blockpos - (camera_pos - camera_dir * adjdist);

	// Distance in camera direction (+=front, -=back)
	f32 dforward = blockpos_adj.dotProduct(camera_dir);

	// Cosine of the angle between the camera direction
	// and the block direction (camera_dir is an unit vector)
	f32 cosangle = dforward / blockpos_adj.getLength();

	// If block is not in the field of view, skip it
	// HOTFIX: use sligthly increased angle (+10%) to fix too agressive
	// culling. Somebody have to find out whats wrong with the math here.
	// Previous value: camera_fov / 2
	if(cosangle < cos(camera_fov * 0.55))
		return false;

	return true;
}
