stonecraftdir="$(cd .. && pwd)"

dialog --backtitle "Stonecraft Client Build" --title "Stonecraft Client Build" --yesno "Start the build process? All previous generated CMake files will be deleted!" 15 60
antwort=${?}

if [ "$antwort" -eq "255" ]
  then
    echo "Aborted"
    exit 255
fi

if [ "$antwort" -eq "1" ]
  then
    exit 1
fi

if [ "$antwort" -eq "0" ]
  then
    ../util/remove_generated_cmakefiles.sh
fi

echo -e "\E[34;47mdone!"

cd ../
cmake . -DRUN_IN_PLACE=TRUE -DBUILD_CLIENT=TRUE
make -j$(nproc)
