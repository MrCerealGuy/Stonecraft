#!/bin/bash
# This script can use pngcrush to reduce the size of your skins.
# You can disable it below.
# Settings:
PNGCRUSH=true
OUT=skins/textures/
#-------------------

USAGE="Usage: $0 <-2d|-3d> <files...>"

if [ "$1" = '-2d' ]
then texture_type="player"
elif [ "$1" = '-3d' ]
then texture_type="character"
fi

if [ "$texture_type" = "player" ] || [ "$texture_type" = "character" ]
then
	lastid=0
	for i in $OUT/${texture_type}_*.png
	do
		id=$(basename $i | sed "s/[^0-9]//g") # remove everything non-number from it
		if [ "$id" -gt "$lastid" ]
		then lastid=$id
		fi
	done
	nextid=$lastid
	for i in $@
	do
		if [ $i != $0 ] && [ $i != $1 ] && [ -f $i ]
		then
			extension="${i##*.}"
			filename="${i%.*}"
			if [ $extension = "png" ]
			then
				if [ $texture_type = "character" ] || [ -f "${filename}_back.png" ]
				then
					(( nextid=(nextid+1) ))
					OUTPUT="$OUT/${texture_type}_$nextid.png"
					echo "$i => $OUTPUT"
					if $PNGCRUSH
					then pngcrush $i $OUTPUT
					else cp $i $OUTPUT
					fi
					if [ $texture_type = "player" ]
					then
						OUTPUT_BACK="$OUT/${texture_type}_${nextid}_back.png"
						if $PNGCRUSH
						then pngcrush "${filename}_back.png" $OUTPUT_BACK
						else cp "${filename}_back.png" $OUTPUT_BACK
						fi
					fi
				else
					echo "Couldn't find back texture for $i."
				fi
			else
				echo "Please use png extension for $i."
			fi
		fi
	done
else
	echo $USAGE
fi
