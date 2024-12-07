local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('playerDropped', function(reason)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        local citizenid = xPlayer.PlayerData.citizenid
        local ped = GetPlayerPed(src)
        local pos = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)

        local last_location = string.format('%f,%f,%f,%f', pos.x, pos.y, pos.z, heading)

        MySQL.Async.execute('REPLACE INTO player_locations (citizenid, last_location) VALUES (@citizenid, @last_location)', {
            ['@citizenid'] = citizenid,
            ['@last_location'] = last_location
        })
    end
end)

RegisterServerEvent('Daniel-LastLocation:Server:SpawnPlayerAtLastLocation')
AddEventHandler('Daniel-LastLocation:Server:SpawnPlayerAtLastLocation', function(citizenid)
    local src = source

    MySQL.Async.fetchScalar('SELECT last_location FROM player_locations WHERE citizenid = @citizenid', {
        ['@citizenid'] = citizenid
    }, function(result)
        if result and Config.SpawnAlwaysInLastLocation then
            local location = {}
            for value in string.gmatch(result, "([^,]+)") do
                table.insert(location, value)
            end

            local x, y, z, heading = tonumber(location[1]), tonumber(location[2]), tonumber(location[3]), tonumber(location[4])

            if x and y and z and heading then
                TriggerClientEvent('Daniel-LastLocation:Client:SpawnAtLastLocation', src, x, y, z, heading)
            else
                TriggerClientEvent('Daniel-LastLocation:Client:SpawnAtLastLocation', src, Config.FirstSpawnCoords.x, Config.FirstSpawnCoords.y, Config.FirstSpawnCoords.z, Config.FirstSpawnCoords.w)
            end
        else
            TriggerClientEvent('Daniel-LastLocation:Client:SpawnAtLastLocation', src, Config.FirstSpawnCoords.x, Config.FirstSpawnCoords.y, Config.FirstSpawnCoords.z, Config.FirstSpawnCoords.w)
        end
    end)
end)

RegisterServerEvent('Daniel-LastLocation:Server:SpawnAtAutoCoords')
AddEventHandler('Daniel-LastLocation:Server:SpawnAtAutoCoords', function()
    local src = source
    local autoCoords = Config.AutoSpawnCoords

    TriggerClientEvent('Daniel-LastLocation:Client:SpawnAtLastLocation', src, autoCoords.x, autoCoords.y, autoCoords.z, autoCoords.w)
end)