Config = {
    FirstSpawnCoords = vector4(-256.63, -970.49, 31.22, 210.81),
    SpawnAlwaysInLastLocation = true, -- If False set coords for auto spawn
    AutoSpawnCoords = vector4(0,0,0,0), -- Coords if last location is false

    -- Same as in refreshchar, if you want to customize the function make sure to change its call aswell in Client-Lua/client.lua:16
    ClothingLoad = function() 
        TriggerServerEvent('qb-clothing:client:get_character_current')
        TriggerServerEvent("raid_clothes:get_character_face")
    end,
}