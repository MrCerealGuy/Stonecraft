dialog --backtitle "Stonecraft Build" --title "Stonecraft Build" --yesno "Start the build process? All previous generated CMake files will be deleted!" 15 60
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

cd ../
cmake . -DBUILD_CLIENT=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LEVELDB=0 -DENABLE_REDIS=0
make -j$(grep -c processor /proc/cpuinfo)
 
