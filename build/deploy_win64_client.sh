#!/bin/bash -e

# Deploys the Stonecraft Windows 64-bit client to itch.io
# https://itch.io/docs/butler/pushing.html
#
# Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

VERSION=1.3.1-6cf357d
CHANNEL=windows-stable

../util/butler/butler push ./win-x86_64/_build/stonecraft-$VERSION-win64.zip mrcerealguy/stonecraft:$CHANNEL --userversion $VERSION

exit 0
