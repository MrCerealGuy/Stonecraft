#!/bin/bash -e

# Upload doc/Manual.md and doc/wiki-images to my Stonecraft Wiki repository
# https://github.com/MrCerealGuy/Stonecraft/wiki
#
# Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

if [ -d stonecraft-wiki ]; then
	cd stonecraft-wiki && git pull
else
	git clone https://github.com/MrCerealGuy/Stonecraft.wiki.git stonecraft-wiki
	cd stonecraft-wiki
fi

# copy Manual.md
cp ../../doc/Manual.md ./Home.md

# copy images
rsync -r --info=progress2 ../../doc/wiki-images/* ./images/

# adjust url paths
sed -i 's/https:\/\/raw.githubusercontent.com\/wiki\/MrCerealGuy\/Stonecraft\/images/\/images/g' ./Home.md
sed -i 's/!\[](/\[\[/g' ./Home.md
sed -i 's/\.png)/\.png]]/g' ./Home.md
sed -i 's/\.jpg)/\.jpg]]/g' ./Home.md

# upload wiki
git add -f Home.md
git add -f images/

# make commit and upload files to wiki repo
read -p "Enter Git Commit Message: " commitmsg

git commit -m "${commitmsg}"

git push origin master

exit 0
