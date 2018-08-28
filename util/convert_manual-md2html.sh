#!/bin/bash -e

pandoc ../doc/Manual.md -f markdown -t html -s -o ../doc/Manual.html

sed -i 's/https:\/\/raw.githubusercontent.com\/wiki\/MrCerealGuy\/Stonecraft\/images/wiki-images/g' ../doc/Manual.html
