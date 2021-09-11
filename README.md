# DEPENDANCIES
nh-context Can be replaced with target/menu of your choice

nh-keyboard Can be replaced with input method of your choice

qb-core

# qb-newsjob
News Job For QB-Core

# Items for shared.lua
	["newsmic"] 			 	 	 = {["name"] = "newsmic", 			  			["label"] = "News Microphone", 			["weight"] = 5000, 		["type"] = "item", 		["image"] = "newsmic.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "News Microphone | Property of Weazel News"},
	["newscam"] 			 	 	 = {["name"] = "newscam", 			  			["label"] = "News Camera", 				["weight"] = 5000, 		["type"] = "item", 		["image"] = "newscam.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "News Camera | Property of Weazel News"},
	["newstape"] 			 	 	 = {["name"] = "newstape", 			  			["label"] = "Video Tape", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "videotape.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Empty Video Tape"},

# Target config
    ["weazel01"] = {
        name = "weazel01",
        coords = vector3(-592.364, -929.826, 23.869),
        length = 1.00,
        width = 1.00,
        heading = 92.42,
        debugPoly = true,
        minZ = 23.00,
        maxZ = 25.00,
        options = {
            {
                type = "client",
                event = "qb-newsjob:client:menu",
                parameters = {},
                icon = "fas fa-newspaper",
                label = "Open Job Menu",
                job = {"all"},
            },
        },
        distance = 2.5
    },

# Ped config
    -- News Lady
    {
        model = `a_f_y_business_02`, -- Model name as a hash.
        coords = vector4(-592.364, -929.826, 23.869, 92.42), -- (X, Y, Z, Heading)
        gender = 'female', -- The gender of the ped, used for the CreatePed native.
        scenario = 'WORLD_HUMAN_CLIPBOARD', -- Task Scenario
    },
