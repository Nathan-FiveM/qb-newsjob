isLoggedIn = false
local PlayerJob = {}
local selectedVeh = nil

-- // CORE SHIT \\ --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)
-- // CORE SHIT \\ --

-- // MENU SHIT \\ --
RegisterNetEvent('qb-newsjob:client:menu')
AddEventHandler('qb-newsjob:client:menu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = "Weazel News",
            txt = "Store",
            params = {
                event = "qb-newsjob:shop"
            }
        },
        {
            id = 1,
            header = "Vehicles",
            txt = "Grab a Vehicle",
            params = {
                event = "qb-newsjob:vehiclelist"
            }
        },
        {
            id = 2,
            header = "Begin Work",
            txt = "[WIP]",
            params = {
                event = "qb-newsjob:client:startwork"
            }
        },
        {
            id = 3,
            header = "Collect Paycheck",
            txt = "[WIP]",
            params = {
                event = "qb-newsjob:client:finishwork"
            }
        },
    })
end)

RegisterNetEvent("qb-newsjob:vehiclelist")
AddEventHandler("qb-newsjob:vehiclelist", function()
      if QBCore ~= nil then
        if isLoggedIn then
            QBCore.Functions.GetPlayerData(function(PlayerData)
                if PlayerData.job.name == "reporter" then
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)

                    local vehDist = #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z))

                    if vehDist < 30 then
                        for k, v in pairs(Config.Vehicles) do
                            if k == 1 then
                            TriggerEvent('nh-context:sendMenu', {
                                    {
                                        id = 0,
                                        header = "Close Menu",
                                        txt = "",
                                        params = {
                                            event = "nh-context:closeMenu",
                                        }
                                    },
                                })
                            end
                            TriggerEvent('nh-context:sendMenu', {
                                {
                                    id = k,
                                    header = "<h8>"..v.label.."</h>",
                                    txt = "$250 Deposit",
                                    params = {
                                        event = "qb-newsjob:client:checkvehicle",
                                        args = v.name
                                    }
                                },
                            })
                        end
                    end
                else
                    QBCore.Functions.Notify('You are not a Reporter!', 'error')
                end
            end)
        end
    end
end)
-- // MENU SHIT \\ --

-- // SHOP SHIT \\ --
RegisterNetEvent('qb-newsjob:shop')
AddEventHandler('qb-newsjob:shop',function() 
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "News Microphone",
            txt = "$1000",
            params = {
                event = "qb-newsjob:client:newsmic",
                args = {
                    number = 1,
                    id = 1
                }
            },
        },
        {
            id = 2,
            header = "News Camera",
            txt = "$1000",
            params = {
                event = "qb-newsjob:client:newscam",
                args = {
                    number = 1,
                    id = 1
                }
            },
        },
        {
            id = 3,
            header = "Video Tape",
            txt = "$100",
            params = {
                event = "qb-newsjob:client:video",
                args = {
                    number = 1,
                    id = 1
                }
            },
        },
    })
end)

RegisterNetEvent('qb-newsjob:client:newsmic')
AddEventHandler('qb-newsjob:client:newsmic', function()
    TriggerServerEvent('qb-newsjob:server:newsmic')
end)

RegisterNetEvent('qb-newsjob:client:newscam')
AddEventHandler('qb-newsjob:client:newscam', function()
    TriggerServerEvent('qb-newsjob:server:newscam')
end)

RegisterNetEvent('qb-newsjob:client:video')
AddEventHandler('qb-newsjob:client:video', function()
    TriggerServerEvent('qb-newsjob:server:video')
end)

-- // SHOP SHIT \\ --

-- // VEHICLE SHIT \\ --
RegisterNetEvent('qb-newsjob:client:checkvehicle')
AddEventHandler('qb-newsjob:client:checkvehicle', function(vehicleInfo)
    TriggerServerEvent('qb-newsjob:server:DoBail', true, vehicleInfo)
    selectedVeh = vehicleInfo
end)

RegisterNetEvent("qb-newsjob:client:SpawnVehicle")
AddEventHandler("qb-newsjob:client:SpawnVehicle", function()
    local coords = Config.Locations["vehicle"].coords
    local vehicleInfo = selectedVeh
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "WEAZ"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        -- TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
        SetVehicleLivery(veh, 2)
    end, coords, true)
end)
-- // VEHICLE SHIT \\ --

-- // ICKY A THREAD \\ --
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
    SetBlipSprite(blip, 459)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
    EndTextCommandSetBlipName(blip)
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            if PlayerJob.name == "reporter" then
                if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 10.0 then
                    DrawMarker(2, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 1.5 then
                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                TriggerServerEvent('qb-newsjob:server:DoBail', false)
                            end
                        end
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)
-- // ICKY A THREAD \\ --