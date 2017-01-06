
Wiki Mod
========

Another random mod by me.

This mod provides a "Wiki" block. You can create and edit wiki pages with it.

The pages are saved as `<worldpath>/wiki/<pagename>`. All spaces in the page
name are converted to underscores, and all other characters not in
`[A-Za-z0-9-]` are converted to hex notation `%XX`.

The text can contain hyperlinks in the form of `[link text]` to other pages.
Such links are added at the right of the form.

You can craft a "Wiki block" by putting 9 bookshelves in the crafting grid.

Only players with the `wiki` priv can create/edit pages.


## Installing

Install by following the instructions in the [Installing mods][install]
article on the Minetest wiki, then add `wiki` to the `secure.trusted_mods`
setting in `minetest.conf`.

[install]: https://wiki.minetest.net/Installing_mods
