#!/usr/bin/env bash

# Place this file in mod ".ldoc" directory.
#
# To change output directory set the `d_export` environment variable.
# Example:
#   $ d_export=/custom/path ./gendoc.sh


d_ldoc="$(dirname $(readlink -f $0))"
f_config="${d_ldoc}/config.ld"

cd "${d_ldoc}/.."

d_root="$(pwd)"
d_export="${d_export:-${d_root}/3d_armor/docs/reference}"
d_data="${d_export}/data"

cmd_ldoc="${d_ldoc}/ldoc/ldoc.lua"
if test -f "${cmd_ldoc}"; then
	if test ! -x "${cmd_ldoc}"; then
		chmod +x "${cmd_ldoc}"
	fi
else
	cmd_ldoc="ldoc"
fi


# clean old files
rm -rf "${d_export}"

# generate items, settings, & crafts topics temp files
echo -e "\ngenerating temp files ..."
for script in src settings; do
	script="${d_ldoc}/parse_${script}.py"
	if test ! -f "${script}"; then
		echo "ERROR: script doesn't exist: ${script}"
	else
		# check script's executable bit
		if test ! -x "${script}"; then
			chmod +x "${script}"
		fi
		# execute script
		"${script}"
	fi
done

echo

# generate new doc files
"${cmd_ldoc}" --unsafe_no_sandbox -c "${f_config}" -d "${d_export}" "${d_root}"; retval=$?

# check exit status
if test ${retval} -ne 0; then
	echo -e "\nan error occurred (ldoc return code: ${retval})"
	exit ${retval}
fi

echo -e "\ncleaning temp files ..."
find "${d_ldoc}" -type f -name "*.luadoc" ! -name "crafting.luadoc" -exec rm -vf {} +

# HACK: ldoc does not seem to like the "shields:" prefix
echo -e "\ncompensating for LDoc's issue with \"shields:\" prefix ..."
sed -i \
	-e 's/<strong>shield_/<strong>shields:shield_/' \
	-e 's/<td class="name\(.*\)>shield_/<td class="name\1>shields:shield_/' \
	-e 's/<a href="#shield_/<a href="#shields:shield_/' \
	-e 's/<a name.*"shield_/<a name="shields:shield_/' \
	"${d_export}/topics/shields.html"

# copy textures to data directory
printf "\ncopying textures ..."
mkdir -p "${d_data}"
texture_count=0
for d_mod in armor_* shields; do
	printf "\rcopying textures from ${d_mod} ...\n"
	for png in $(find "${d_root}/${d_mod}/textures" -maxdepth 1 -type f -name "*.png"); do
		if test -f "${d_data}/$(basename ${png})"; then
			echo "WARNING: not overwriting existing file: ${png}"
		else
			cp "${png}" "${d_data}"
			texture_count=$((texture_count + 1))
			printf "\rcopied ${texture_count} textures"
		fi
	done
done

echo -e "\n\nDone!"
