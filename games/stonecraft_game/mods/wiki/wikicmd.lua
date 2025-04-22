minetest.register_chatcommand("wiki", {
        description = "Open the wiki",
        func = function(name)
                local player = minetest.get_player_by_name(name)
                if not player then
                        return false, "This command can only be executed in-game!"
                end
                wikilib.show_wiki_page(name, "Main")
                return true
        end
})
