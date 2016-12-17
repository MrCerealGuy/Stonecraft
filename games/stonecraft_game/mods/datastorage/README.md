datastorage
===========

Helper mod to manage players data.
All the mods can acces a single file (container) and easily have the data saved/loaded for them.

Usage
-----

	local data = datastorage.get(id, ...)

Returns a reference to a data container.  The id is normally a player name.
Following arguments are keys to recurse into, normally only one, a string
describing the type of data, is used.  If the container doesn't exist it will
be created, otherwise it will contain all previously stored data.  The table
can store any data.  Player's containers will be saved to disk when the player
leaves, and all references to the player's data should be dropped.  All of the
containers will be saved on server shutdown.  To forcibly save a container's
data use:

	datastorage.save(id)

