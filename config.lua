Config = {}

Config.Locations = {
    ["main"] = {
        label = "Weazle News HQ",
        coords = vector4(-597.89, -929.95, 24.0, 271.5),
    },
    ["inside"] = {
        label = "Weazle News HQ Inside",
        coords = vector4(-77.46, -833.77, 243.38, 67.5),
    },
    ["outside"] = {
        label = "Weazle News HQ Outside",
        coords = vector4(-598.25, -929.86, 23.86, 86.5),
    },
    ["vehicle"] = {
        label = "Vehicle Storage",
        coords = vector4(-616.515, -933.423, 22.293, 105.5),
    },
}

Config.Vehicles = {
	["1"] = {
        name = "rumpo",
        label = "News Van",
    },
}

Config.Items = {
    label = "Weazel News",
    slots = 20,
    items = {
        [1] = {
            name = 'advancedrepairkit',
            price = 1000,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'lockpick',
            price = 1000,
            amount = 50,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'advancedlockpick',
            price = 100,
            amount = 50,
            info = {},
            type = 'item',
            slot = 3,
        },
    },
}

Config.BailPrice = 250