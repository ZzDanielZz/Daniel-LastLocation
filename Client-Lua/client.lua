RegisterNetEvent('Daniel-LastLocation:Client:SpawnAtLastLocation')
AddEventHandler('Daniel-LastLocation:Client:SpawnAtLastLocation', function(x, y, z, heading)
    local ped = PlayerPedId()

    if ped and ped ~= 0 then
        DoScreenFadeOut(500)
        Citizen.Wait(500)

        SetEntityCoords(ped, x, y, z, true, true, true)
        SetEntityHeading(ped, heading)
        FreezeEntityPosition(ped, false)
        
        Citizen.Wait(500)
        DoScreenFadeIn(1000)

        Config.ClothingLoad()
        
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        ExecuteCommand("e c")
    else
        print("Player ped is not valid!")
    end
end)