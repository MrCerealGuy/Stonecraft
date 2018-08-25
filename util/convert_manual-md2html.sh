#!/bin/bash -e

pandoc ../doc/Manual.md -f markdown -t html -s -o ../doc/Manual.html
