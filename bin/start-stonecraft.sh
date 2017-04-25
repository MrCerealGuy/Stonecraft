#!/bin/bash -e

until ./stonecraftserver ../worlds/Stonecraft; do
    echo "Server 'stonecraftserver' crashed with exit code $?. Respawning.." >&2
    sleep 1
done
