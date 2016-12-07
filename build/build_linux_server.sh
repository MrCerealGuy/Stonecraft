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
cmake . -DBUILD_CLIENT=0 -DRUN_IN_PLACE=1 -DIRRLICHT_SOURCE_DIR=./libs/msvc2013-win-i686/irrlicht-1.8.3/source/Irrlicht/ -DIRRLICHT_INCLUDE_DIR=./libs/msvc2013-win-i686/irrlicht-1.8.3/include/
make -j$(grep -c processor /proc/cpuinfo)
 
