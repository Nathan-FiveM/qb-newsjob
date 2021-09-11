local Bail = {}

-- // COMMANDS FOR TESTING \\ --
QBCore.Commands.Add("newscam", "Grab a news camera", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "reporter" then
        TriggerClientEvent("Cam:ToggleCam", source)
    end
end)

QBCore.Commands.Add("newsmic", "Grab a news microphone", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "reporter" then
        TriggerClientEvent("Mic:ToggleMic", source)
    end
end)
-- // COMMANDS FOR TESTING \\ --

-- // ITEM SHIT \\ --
QBCore.Functions.CreateUseableItem("newscam", function(source, item)
    local src = source
    TriggerClientEvent("Cam:ToggleCam", src)
end)

QBCore.Functions.CreateUseableItem("newsmic", function(source, item)
    local src = source
    TriggerClientEvent("Mic:ToggleMic", src)
end)
-- // ITEM SHIT \\ --

-- // SHOP SHIT \\ --
RegisterServerEvent('qb-newsjob:server:newsmic')
AddEventHandler('qb-newsjob:server:newsmic', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.bank >= 1000 then
        Player.Functions.RemoveMoney('bank', 1000)
        Player.Functions.AddItem("newsmic", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["newsmic"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a news microphone for $1000.", "success", 3000)
        TriggerEvent("qb-banking:server:AddToMoneyLog", source, "personal", -Config.BailPrice, "withdraw", "Weazel News", "News Microphone purchased for $1000.")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money in the bank!", "error", 3000)
    end
end)

RegisterServerEvent('qb-newsjob:server:newscam')
AddEventHandler('qb-newsjob:server:newscam', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.bank >= 1000 then
        Player.Functions.RemoveMoney('bank', 1000)
        Player.Functions.AddItem("newscam", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["newscam"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a news camera for $1000.", "success", 3000)
        TriggerEvent("qb-banking:server:AddToMoneyLog", source, "personal", -Config.BailPrice, "withdraw", "Weazel News", "News Camera purchased for $1000.")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money in the bank!", "error", 3000)
    end
end)

RegisterServerEvent('qb-newsjob:server:video')
AddEventHandler('qb-newsjob:server:video', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.bank >= 100 then
        Player.Functions.RemoveMoney('bank', 100)
        Player.Functions.AddItem("video", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["video"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a blank tape for $100.", "success", 3000)
        TriggerEvent("qb-banking:server:AddToMoneyLog", source, "personal", -Config.BailPrice, "withdraw", "Weazel News", "Blank tape purchased for $100.")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money in the bank!", "error", 3000)
    end
end)
-- // SHOP SHIT \\ --

-- // VEHICLE SHIT \\ --
RegisterServerEvent('qb-newsjob:server:DoBail')
AddEventHandler('qb-newsjob:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if bool then
        if Player.PlayerData.money.bank >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
			TriggerEvent("qb-banking:server:AddToMoneyLog", source, "personal", -Config.BailPrice, "withdraw", "Weazel News", "Vehicle deposit of $" .. tonumber(Config.BailPrice) .. " paid from personal account.")
            Player.Functions.RemoveMoney('bank', Config.BailPrice, "weazel-paid-bail")
            TriggerClientEvent('QBCore:Notify', src, 'You Have Paid The Deposit Of $'..Config.BailPrice, 'success')
            TriggerClientEvent('QBCore:Notify', src, 'The vehicle is outside!', 'success')
            TriggerClientEvent('qb-newsjob:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You Do Not Have Enough Cash, The Deposit Is $'..Config.BailPrice, 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] ~= nil then
			TriggerEvent("qb-banking:server:AddToMoneyLog", source, "personal", Config.BailPrice, "deposit", "Weazel News", ("Received deposit of $"..tonumber(Config.BailPrice).." back from Weazel News paid into personal account."))
            Player.Functions.AddMoney('bank', Bail[Player.PlayerData.citizenid], "weazel-bail-paid")
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('QBCore:Notify', src, 'You Got Back $'..Config.BailPrice..' From The Deposit', 'success')
        end
    end
end)
-- // VEHICLE SHIT \\ --