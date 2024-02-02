ESX = exports["es_extended"]:getSharedObject()

local isNearbyWashingMachine = false

function IsNearbyWashingMachine()
    local playerPed = PlayerId()
    local pos = GetEntityCoords(GetPlayerPed(-1), false)
    local washingMachinePos = vector3(-288.34268188477, 6299.8588867188, 31.492238998413)

    local distance = Vdist(pos.x, pos.y, pos.z, washingMachinePos.x, washingMachinePos.y, washingMachinePos.z)

    return distance < 2.0
end

RegisterNUICallback("praniePieniedzy", function(data)
    local amount = tonumber(data.amount)
    if amount then
        TriggerServerEvent('praniePieniedzy:pranie', amount)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        isNearbyWashingMachine = IsNearbyWashingMachine()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isNearbyWashingMachine then
            if IsControlJustReleased(0, 38) then
                SetNuiFocus(true, true)
                SendNUIMessage({openPraniePieniedzy = true})
            end
        end
    end
end)

RegisterNUICallback("close", function(data, cb)
    SetNuiFocus(false, false)
    cb(true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        isNearbyWashingMachine = IsNearbyWashingMachine()

        if isNearbyWashingMachine then
            ESX.ShowHelpNotification("Naciśnij ~INPUT_CONTEXT~ aby otworzyć pralnię")

            if IsControlJustReleased(0, 38) then
                SetNuiFocus(true, true)
                SendNUIMessage({openPraniePieniedzy = true})
            end

            local pos = vector3(-288.34268188477, 6299.8588867188, 31.492238998413)
            DrawMarker(27, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 0, 50, false, true, 2, nil, nil, false)
        end
    end
end)