stonecraftdir="$( cd .. && pwd)"

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

# Generate doc/Manual.html from doc/Manual.md with Pandoc
echo -e "\E[34;47mGenerate Manual.html with Pandoc..."

cd $stonecraftdir/util/
./convert_manual-md2html.sh

echo -e "\E[34;47mdone!"

cd ../
cmake . -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DRUN_IN_PLACE=1 -DENABLE_REDIS=1 -DENABLE_LEVELDB=1
make package -j$(grep -c processor /proc/cpuinfo)
 
