
Config = {}

Config.UpdateFrequency = 3600 
Config.DeleteStats = true 
Config.MmbershipCardItem = 'gym_membership'
Config.GymBlip = vector3(258.45, -271.44, 53.96)
Config.PedLocations = {{coords = vector4(258.45, -271.44, 53.96, 344.32)}}
Config.ticketPrice = {
    ["gym_membership"] = {
        price = 5000,
        time = 30, -- in minutes
    },
}

Config.Skills = {
    ["Resistance"] = { 
        ["Current"] = 20, ["RemoveAmount"] = -0.3, ["Stat"] = "MP0_STAMINA" 
    },

    ["Strength"] = {
        ["Current"] = 10, ["RemoveAmount"] = -0.3, ["Stat"] = "MP0_STRENGTH"
    },

    ["Diving"] = {
        ["Current"] = 0, ["RemoveAmount"] = -0.3, ["Stat"] = "MP0_LUNG_CAPACITY"
    },

    ["Shooting"] = {
        ["Current"] = 0, ["RemoveAmount"] = -0.1,["Stat"] = "MP0_SHOOTING_ABILITY"
    },

    ["Driving"] = {
        ["Current"] = 0, ["RemoveAmount"] = -0.5, ["Stat"] = "MP0_DRIVING_ABILITY"
    },

    ["Raise front wheel"] = {
        ["Current"] = 0, ["RemoveAmount"] = -0.2, ["Stat"] = "MP0_WHEELIE_ABILITY"
    }
}

Config.Locations = {
    [1] = {
        coords = vector3(251.28, -266.92, 59.92), heading = 66.53,
        animation = "prop_human_muscle_chin_ups", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Pull-ups]", viewDistance = 2.5,
    },
    [3] = {
        coords = vector3(234.4, -267.47, 60.04), heading = 335.78,
        animation = "world_human_yoga", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do yoga]", viewDistance = 3.5,
    },
    [4] = {
        coords = vector3(255.93, -257.85, 59.91), heading = 160.78,
        animation = "world_human_muscle_free_weights", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do weights]", viewDistance = 3.5,
    },
    [5] = {
        coords = vector3(236.5, -261.62, 60.07), heading = 67.92,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [6] = {
        coords = vector3(237.49, -259.19, 60.07), heading = 50.78,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [7] = {
        coords = vector3(239.21, -257.46, 60.07), heading = 46.2,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [8] = {
        coords = vector3(240.64, -256.34, 60.07), heading = 36.78,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [9] = {
        coords = vector3(242.2, -255.57, 60.07), heading = 10.78,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [10] = {
        coords = vector3(244.28, -255.19, 60.06), heading = 2.59,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [11] = {
        coords = vector3(256.45, -259.82, 59.92), heading = 69.78,
        animation = "world_human_muscle_free_weights", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Use weights]", viewDistance = 2.5,
    },
    [12] = {
        coords = vector3(255.38, -262.54, 59.92), heading = 72.77,
        animation = "world_human_muscle_free_weights", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Use weights]", viewDistance = 2.5,
    },
    [13] = {
        coords = vector3(240.37, -262.64, 59.92), heading = 336.53,
        animation = "WORLD_HUMAN_PUSH_UPS", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Push-ups]", viewDistance = 2.5,
    },
    [14] = {
        coords = vector3(251.77, -261.61, 59.92), heading = 130.53,
        animation = "WORLD_HUMAN_PUSH_UPS", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Push-ups]", viewDistance = 2.5,
    },
    [15] = {
        coords = vector3(246.39, -255.39, 60.06), heading = 354.15,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [16] = {
        coords = vector3(248.91, -255.88, 60.07), heading = 340.36,
        animation = "WORLD_HUMAN_JOG_STANDING", skill = "Resistance", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Exercise]", viewDistance = 3.5,
    },
    [17] = {
        coords = vector3(253.18, -256.95, 59.92), heading = 167.78,
        animation = "world_human_muscle_free_weights", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Use weights]", viewDistance = 2.5,
    },
    [18] = {
        coords = vector3(248.73, -268.38, 59.92), heading = 253.53,
        animation = "prop_human_muscle_chin_ups", skill = "Strength", SkillAddQuantity = 1,
        Text3D = "~b~E~w~ - [Do Pull-ups]", viewDistance = 2.5,
    },
}