#!/usr/bin/env python

# This script will parse source files for docstring.

import os, codecs


path = os.path.realpath(__file__)
script = os.path.basename(path)
d_root = os.path.dirname(os.path.dirname(path))
d_ldoc = os.path.join(d_root, ".ldoc")


armor_types = {
	"armor": {"topic": "Armors", "values": []},
	"helmet": {"topic": "Helmets", "values": []},
	"chestplate": {"topic": "Chestplates", "values": []},
	"leggings": {"topic": "Leggings", "values": []},
	"boots": {"topic": "Boots", "values": []},
	#"shield": {"topic": "Shields", "values": []},
}

def parse_file(f):
	buffer = codecs.open(f, "r", "utf-8")
	if not buffer:
		print("ERROR: could not open file for reading: {}".format(f))
		return

	data_in = buffer.read()
	buffer.close()

	# format to LF (Unix)
	data_in = data_in.replace("\r\n", "\n").replace("\r", "\n")

	current_item = []
	item_type = None
	new_item = False
	for li in data_in.split("\n"):
		li = li.strip()
		if li.startswith("---"):
			new_item = True
		elif not li.startswith("--"):
			new_item = False

		if new_item:
			current_item.append(li)
			if not item_type:
				for a_type in armor_types:
					if "@{} ".format(a_type) in li:
						item_type = a_type
						break
		elif item_type and len(current_item):
			armor_types[item_type]["values"].append("\n".join(current_item))
			item_type = None
			current_item = []
		else:
			current_item = []

to_parse = []

for obj in os.listdir(d_root):
	fullpath = os.path.join(d_root, obj)
	if not obj.startswith(".") and os.path.isdir(fullpath):
		for root, dirs, files in os.walk(fullpath):
			for f in files:
				if f.endswith(".lua"):
					to_parse.append(os.path.join(root, f))

for p in to_parse:
	if not os.path.isfile(p):
		print("ERROR: {} is not a file".format(p))
	else:
		parse_file(p)

for t in armor_types:
	topic = armor_types[t]["topic"]
	items = armor_types[t]["values"]

	if len(items):
		outfile = os.path.join(d_ldoc, "{}.luadoc".format(topic.lower()))

		buffer = codecs.open(outfile, "w", "utf-8")
		if not buffer:
			print("ERROR: could not open file for writing: {}".format(outfile))
			continue

		buffer.write("\n--- 3D Armor {}\n--\n--  @topic {}\n\n\n{}\n".format(topic, topic.lower(), "\n\n".join(items)))
		buffer.close()

		print("{} exported to\t{}".format(topic.lower(), outfile))
