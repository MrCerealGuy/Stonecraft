#!/bin/bash -e

FILES="
Chat
Crafting
Experienced-players
Farming
First-steps
Home
Mesecons
Mobs
Modding-Stonecraft
Pipeworks
Setting-up-a-server
Technic
"

for f in $FILES
do
	pandoc ../doc/github-wiki/$f.md -f markdown -t html -s -o ../doc/html-wiki/$f.html
	sed -i 's/\/doc\/github-wiki\/images/..\/github-wiki\/images/g' ../doc/html-wiki/$f.html
done
