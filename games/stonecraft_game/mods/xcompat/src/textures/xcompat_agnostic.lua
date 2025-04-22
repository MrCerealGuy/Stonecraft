local textures = {
    gravel = "[combine:16x16^[noalpha^[colorize:#3a3b3c",
    brick = "[combine:16x16^[noalpha^[colorize:#AA4A44",

    metal = {
        steel = {
            ore = "[combine:16x16^[noalpha^[colorize:#D3D3D3",
            ingot = "[combine:16x16^[noalpha^[colorize:#D3D3D3",
            block = "[combine:16x16^[noalpha^[colorize:#D3D3D3",
        },
        gold = {
            ore = "[combine:16x16^[noalpha^[colorize:#FFD700",
            ingot = "[combine:16x16^[noalpha^[colorize:#FFD700",
            block = "[combine:16x16^[noalpha^[colorize:#FFD700",
        },
    },
    glass = {
        pane = "[combine:16x16:" ..
            "0,0=\\[combine\\:1x16\\^[noalpha\\^[colorize\\:#ffffff:" ..
            "0,0=\\[combine\\:16x1\\^[noalpha\\^[colorize\\:#ffffff:" ..
            "0,15=\\[combine\\:16x1\\^[noalpha\\^[colorize\\:#ffffff:" ..
            "15,0=\\[combine\\:1x16\\^[noalpha\\^[colorize\\:#ffffff",
        detail = "[combine:16x16:" ..
            "0,0=\\[combine\\:1x16\\^[noalpha\\^[colorize\\:#ffffff:" ..
            "0,0=\\[combine\\:16x1\\^[noalpha\\^[colorize\\:#ffffff:" ..
            "0,15=\\[combine\\:16x1\\^[noalpha\\^[colorize\\:#ffffff:" ..
            "15,0=\\[combine\\:1x16\\^[noalpha\\^[colorize\\:#ffffff",
    },
    wood = {
        apple = {
            sapling = "[combine:16x16^[noalpha^[colorize:#654321",
            planks = "[combine:16x16^[noalpha^[colorize:#654321",
            trunk_side = "[combine:16x16^[noalpha^[colorize:#654321",
            trunk_top = "[combine:16x16^[noalpha^[colorize:#654321",
            leaves = "[combine:16x16^[noalpha^[colorize:#654321",
        },
        jungle = {
            sapling = "[combine:16x16^[noalpha^[colorize:#563d2d",
            planks = "[combine:16x16^[noalpha^[colorize:#563d2d",
            trunk_side = "[combine:16x16^[noalpha^[colorize:#563d2d",
            trunk_top = "[combine:16x16^[noalpha^[colorize:#563d2d",
            leaves = "[combine:16x16^[noalpha^[colorize:#563d2d",
        },
    },
    water = {
        tile = "[combine:16x16^[noalpha^[colorize:#00008b",
        animated = {
            source = "[combine:16x16^[noalpha^[colorize:#00008b",
            flowing = "[combine:16x16^[noalpha^[colorize:#00008b",
        },
    },
    wool = {
        white = "[combine:16x16^[noalpha^[colorize:#ffffff",
        black = "[combine:16x16^[noalpha^[colorize:#000000",
        grey = "[combine:16x16^[noalpha^[colorize:#313b3c",
        dark_grey = "[combine:16x16^[noalpha^[colorize:#313b3c",
    },
    grass = {
        top = "[combine:16x16^[noalpha^[colorize:#006400",
        side = "[combine:16x16^[noalpha^[colorize:#006400",
        dirt = "[combine:16x16^[noalpha^[colorize:#563d2d",
    },
}

return textures