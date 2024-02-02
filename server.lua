ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("praniePieniedzy:pranie")
AddEventHandler("praniePieniedzy:pranie", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local brudnaKasa = xPlayer.getAccount('black_money').money

        if brudnaKasa >= amount then
            local czystaKasa = math.floor(amount * 0.83)

            xPlayer.removeAccountMoney('black_money', amount)
            xPlayer.addMoney(czystaKasa)

            TriggerClientEvent('esx:showNotification', source, 'Pomyślnie przeprowadzono pranie pieniędzy. Otrzymałeś ' .. czystaKasa .. '$ czystej gotówki.')

            TriggerClientEvent('praniePieniedzy:praniePotwierdzenie', source, { success = true, message = 'Pomyślnie przeprowadzono pranie pieniędzy.' })
        else
            TriggerClientEvent('esx:showNotification', source, 'Nie masz wystarczającej ilości brudnej gotówki do wyprania.')

            TriggerClientEvent('praniePieniedzy:praniePotwierdzenie', source, { success = false, message = 'Nie masz wystarczającej ilości brudnej gotówki do wyprania.' })
        end
    end
end)