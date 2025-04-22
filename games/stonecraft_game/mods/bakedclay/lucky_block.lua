
-- helpers

local p = "bakedclay:"
local p2 = "bakedclay:terracotta_"

-- add lucky blocks

lucky_block:add_blocks({
	{"dro", {"bakedclay:"}, 10, true},
	{"fal", {
		p .. "black", p .. "blue", p .. "brown", p .. "cyan", p .. "dark_green",
		p .. "dark_grey", p .. "green", p .. "grey", p .. "magenta", p .. "orange",
		p .. "pink", p .. "red", p .. "violet", p .. "white", p .. "yellow", p .. "natural"
	}, 0},
	{"fal", {
		p .. "black", p .. "blue", p .. "brown", p .. "cyan", p .. "dark_green",
		p .. "dark_grey", p .. "green", p .. "grey", p .. "magenta", p .. "orange",
		p .. "pink", p .. "red", p .. "violet", p .. "white", p .. "yellow", p .. "natural"
	}, 0, true},
	{"dro", {p .. "delphinium"}, 5},
	{"dro", {p .. "lazarus"}, 5},
	{"dro", {p .. "mannagrass"}, 5},
	{"dro", {p .. "thistle"}, 6},
	{"flo", 5, {
		p .. "natural", p .. "black", p .. "blue", p .. "brown", p .. "cyan",
		p .. "dark_green", p .. "dark_grey", p .. "green", p .. "grey", p .. "magenta",
		p .. "orange", p .. "pink", p .. "red", p .. "violet", p .. "white", p .. "yellow"
	}, 2},
	{"nod", "default:chest", 0, {
		{name = p .. "natural", max = 20},
		{name = p .. "black", max = 20},
		{name = p .. "blue", max = 20},
		{name = p .. "brown", max = 20},
		{name = p .. "cyan", max = 20},
		{name = p .. "dark_green", max = 20},
		{name = p .. "dark_grey", max = 20},
		{name = p .. "green", max = 20},
		{name = p .. "grey", max = 20},
		{name = p .. "magenta", max = 20},
		{name = p .. "orange", max = 20},
		{name = p .. "pink", max = 20},
		{name = p .. "red", max = 20},
		{name = p .. "violet", max = 20},
		{name = p .. "white", max = 20},
		{name = p .. "yellow", max = 20}
	}},
	{"nod", "default:chest", 0, {
		{name = p2 .. "black", max = 20},
		{name = p2 .. "blue", max = 20},
		{name = p2 .. "brown", max = 20},
		{name = p2 .. "cyan", max = 20},
		{name = p2 .. "dark_green", max = 20},
		{name = p2 .. "dark_grey", max = 20},
		{name = p2 .. "green", max = 20},
		{name = p2 .. "grey", max = 20},
		{name = p2 .. "magenta", max = 20},
		{name = p2 .. "orange", max = 20},
		{name = p2 .. "pink", max = 20},
		{name = p2 .. "red", max = 20},
		{name = p2 .. "violet", max = 20},
		{name = p2 .. "white", max = 20},
		{name = p2 .. "yellow", max = 20}
	}}
})
