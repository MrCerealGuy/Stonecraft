#!/bin/bash -e

# Deploys the Stonecraft linux 64-bit client to itch.io
# https://itch.io/docs/butler/pushing.html
#
# Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

VERSION=1.3.2
CHANNEL=linux-client-stable

../util/butler/butler push ../stonecraft-$VERSION-client-linux64.tar.gz mrcerealguy/stonecraft:$CHANNEL --userversion $VERSION

exit 0
