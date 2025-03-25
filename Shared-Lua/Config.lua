Config = {
    FirstSpawnCoords = vector4(239.53787, -1381.014, 33.735454, 139.60998),
    SpawnAlwaysInLastLocation = false, -- If False set coords for auto spawn
    AutoSpawnCoords = vector4(239.53787, -1381.014, 33.735454, 139.60998), -- Coords if last location is false

    -- Same as in refreshchar, if you want to customize the function make sure to change its call aswell in Client-Lua/client.lua:16
    ClothingLoad = function() 
        TriggerServerEvent('qb-clothing:client:get_character_current')
        -- TriggerServerEvent("raid_clothes:get_character_face")
    end,
}