#!/usr/bin/env python

# This script will format "settingtypes.txt" file found at the root
# of 3d_armor modpack into a format readable by LDoc.

import sys, os, errno, codecs


path = os.path.realpath(__file__)
script = os.path.basename(path)
d_root = os.path.dirname(os.path.dirname(path))
d_ldoc = os.path.join(d_root, ".ldoc")
f_settings = os.path.join(d_root, "settingtypes.txt")

if not os.path.isfile(f_settings):
	print("settingtypes.txt does not exist")
	sys.exit(errno.ENOENT)

i_stream = codecs.open(f_settings, "r", "utf-8")
data_in = i_stream.read()
i_stream.close()

data_in = data_in.replace("\r", "")

sets = data_in.split("\n\n")

for idx in reversed(range(len(sets))):
	set = sets[idx]
	lines = set.split("\n")
	for idx2 in reversed(range(len(lines))):
		li = lines[idx2].strip(" \t")
		if li == "" or li[0] == "[":
			lines.pop(idx2)

	if len(lines) == 0:
		sets.pop(idx)
	else:
		sets[idx] = "\n".join(lines)

filtered = []

for set in sets:
	comment = False
	lines = set.split("\n")
	new_lines = []
	for li in lines:
		if li[0] == "#":
			new_lines.append(li)
		else:
			new_lines.append(li)
			filtered.append("\n".join(new_lines))
			new_lines = []

settings = []

def parse_setting(set):
	desc = []
	setting = summary = stype = sdefault = soptions = None

	for li in set.split("\n"):
		if li[0] == "#":
			desc.append("--  {}".format(li.lstrip(" #")))
		else:
			setting = li.split(" ")[0]
			summary = li.split(")")[0].split("(")[-1]
			li = li.split(")")[-1].strip()
			rem = li.split(" ")
			stype = rem[0]
			rem.pop(0)

			if len(rem) > 0:
				sdefault = rem[0]
				rem.pop(0)

			if len(rem) > 0:
				soptions = " ".join(rem)

	if not setting:
		return

	st = "---"
	if summary:
		if summary[-1] != ".":
			summary = "{}.".format(summary)
		st = "{} {}".format(st, summary)

	st = "{}\n--".format(st)

	if len(desc) > 0:
		st = "{}\n{}\n--".format(st, "\n".join(desc))

	st = "{}\n--  @setting {}".format(st, setting)

	if stype:
		st = "{}\n--  @settype {}".format(st, stype)

	if sdefault:
		st = "{}\n--  @default {}".format(st, sdefault)

	# TODO: add options

	settings.append(st)

for f in filtered:
	parse_setting(f)

outfile = os.path.join(d_ldoc, "settings.luadoc")
data_out = "\n--- 3D Armor Settings\n--\n--  @topic settings\n\n\n{}\n".format("\n\n".join(settings))

o_stream = codecs.open(outfile, "w", "utf-8")
if not o_stream:
	print("ERROR: could not open file for writing: {}".format(outfile))
	sys.exit(errno.EIO)

o_stream.write(data_out)
o_stream.close()

print("settings exported to\t{}".format(outfile))
