#!/bin/bash -e

# Upload doc/github-wiki to my Stonecraft Wiki repository
# https://github.com/MrCerealGuy/Stonecraft/wiki
#
# Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

# clone wiki repo
if [ -d stonecraft-wiki ]; then
	cd stonecraft-wiki && git pull
else
	git clone https://github.com/MrCerealGuy/Stonecraft.wiki.git stonecraft-wiki
	cd stonecraft-wiki
fi

# copy markdown files
cp ../../doc/github-wiki/*.md ./

# copy images
rsync -r --info=progress2 ../../doc/github-wiki/images/* ./images/

# adjust image url paths
sed -i 's/\/doc\/github-wiki\/images/\/images/g' ./*.md
sed -i 's/!\[](/\[\[/g' ./*.md
sed -i 's/\.png)/\.png]]/g' ./*.md
sed -i 's/\.jpg)/\.jpg]]/g' ./*.md

# upload wiki content
git add -f *.md
git add -f images/

# make commit and upload files to wiki repo
read -p "Enter Git Commit Message: " commitmsg

git commit -m "${commitmsg}"

git push origin master

exit 0
