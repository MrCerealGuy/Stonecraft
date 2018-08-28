#!/bin/bash -e

pandoc ../doc/Manual.md -f markdown -t html -s -o ../doc/Manual.html

sed -i 's/\/doc\/wiki-images/wiki-images/g' ../doc/Manual.html
