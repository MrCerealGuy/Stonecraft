# Player API

mimic mtg player_api

## NOTE

`xcompat.player.player_attached`

read/write from it is fine, looping over it is not as it is a proxy table. this
would need lua5.2 __pairs/__ipairs metamethods support which i could polyfill
for using https://stackoverflow.com/a/77354254 but didnt feel like doing at 
this time. (luajit supports this via 5.2 extensions). additionally see issue: 
https://github.com/minetest/minetest/issues/15133