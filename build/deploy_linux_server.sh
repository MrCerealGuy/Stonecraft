#!/bin/bash -e

# Deploys the Stonecraft linux 64-bit server to itch.io
# https://itch.io/docs/butler/pushing.html
#
# Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

VERSION=1.3.1
CHANNEL=linux-server-stable

../util/butler/butler push ../stonecraft-$VERSION-server-linux64.tar.gz mrcerealguy/stonecraft:$CHANNEL --userversion $VERSION

exit 0
