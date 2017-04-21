local busStopList = {
    {499.589508056641,-757.046813964844,24.3920707702637,178.628662109375},
    {446.602844238281,-1250.9150390625,29.9233322143555,92.2810211181641},
    {261.936706542969,-1216.54968261719,29.0210399627686,263.268280029297},
    {263.836273193359,-1124.23059082031,28.839241027832,87.4407577514648},
    {441.025848388672,-958.524780273438,28.506010055542,271.103851318359},
    {378.4609375,-597.100341796875,28.2459678649902,161.706924438477},
    {307.385894775391,-764.085815429688,28.8314018249512,161.728973388672},
    {245.657836914063,-938.730285644531,28.8384399414063,162.964279174805},
    {81.6478652954102,-1088.97827148438,28.8596649169922,333.54541015625},
    {42.1510124206543,-702.754943847656,43.7404899597168,164.676742553711},
    {-172.771438598633,-819.69775390625,30.6801795959473,154.782073974609},
    {-232.490844726563,-980.649658203125,28.8177375793457,159.58952331543},
    {-72.4485778808594,-613.055908203125,35.8055572509766,338.881591796875},
    }

local busDepot =  {465.710968017578,-607.73974609375,28.1082782745361, 183.372497558594}

local nbStop = 0
local placeStop = false
local modelHash = GetHashKey("coach", _r)
local inBus = false
local charged = false
local pasped = {}
local num = 1
local seatBus = 0
--Un bus sur 100 sera piegé :D

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        for i = 1, #busStopList do
            local busStop = busStopList[i]
            if DecorGetInt(GetPlayerPed(-1),  "job") == 1 then
                if placeStop then
                    busStopBlip = AddBlipForCoord(busStop[1], busStop[2], busStop[3])
                    SetBlipSprite(busStopBlip, 280) --Blip 280 for Bus Stop
                    SetBlipAsShortRange(busStopBlip, true)
                    SetBlipColour(busStopBlip,  3)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString('Bus Stop')
                    EndTextCommandSetBlipName(busStopBlip)
                    SetBlipAsMissionCreatorBlip(busStopBlip, true)
                    if i == #busStopList then
                        placeStop = false
                    end 
                end
                --TriggerEvent('chatMessage', '', { 0, 0, 0 }, '^1 Blips placés' )
                --if IsPedInVehicle(GetPlayerPed(-1),  modelHash,  true) then
                if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), modelHash) and not charged then
                --if inBus then
                    DrawMarker(1, busStop[1], busStop[2], busStop[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 2.0, 0, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
                end
            end
        end  
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    if DecorGetInt(GetPlayerPed(-1),  "job") == 1 then
        if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), modelHash) then
            local lPlyCoords = GetEntityCoords(GetPlayerPed(-1),  true)
                for i = 1, #busStopList do
                    local busStop = busStopList[i]
                    if GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, busStop[1], busStop[2], busStop[3], true ) < 5 and not charged then
                        local pped = GetRandomPedAtCoord(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, 35.001, 35.001, 35.001, -1)
                        pasped[num] = pped
                        if DoesEntityExist(pasped[num]) and num <= 6 then
                            local pasCoords = GetEntityCoords(pasped[num],  true)
                            ClearPedTasksImmediately(pasped[num])
                            SetBlockingOfNonTemporaryEvents(pasped[num], 1)
                            --TaskStandStill(rped, 5000)
                            TaskEnterVehicle(pasped[num], GetVehiclePedIsUsing(GetPlayerPed(-1)), -1, seatBus, 2.0001, 1, 0)
                            TriggerEvent('chatMessage', '', { 0, 0, 0 }, '^1 Siege numero: '..seatBus )
                            num = num + 1
                            seatBus = seatBus + 1
                            if GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, pasCoords.x, pasCoords.y, pasCoords.z, true ) > 50 then
                                ClearPedTasksImmediately(pasped[num])
                                Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(pasped[num]))
                                num = num - 1
                                seatBus = seatBus - 1
                            end
                            if num == 6 then
                                for p = 1, 6 do
                                    TaskLeaveVehicle(pasped[p], GetVehiclePedIsUsing(GetPlayerPed(-1)), 0)
                                    num = 1
                                    seatBus = 0
                                    Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(pasped[num]))
                                end
                            end
                        --end
                            MissionText("Veuillez ~g~Patienter~w~ quelques instants", 5000)
                            Wait(5000)
                            if GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, busStop[1], busStop[2], busStop[3], true ) < 5 then
                                nbStop = nbStop + 1
                                charged = true
                                MissionText("Les passager sont ~g~Montés~w~ vous pouvez repartir", 5000)
                            else
                                charged = true
                                MissionText("Les passager n'ont pas reussit a ~g~Monter~w~ tant pis pour vous", 5000)
                            end
                        end
                    elseif GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, busStop[1], busStop[2], busStop[3], true ) > 5 and charged then
                        Wait(5000)
                        charged = false
                    end
                end
            end
        end
    end
end)


RegisterNetEvent("job:startbus")
AddEventHandler("job:startbus", function()
    DecorRegister("job",  3)
    DecorSetInt(GetPlayerPed(-1),  "job",  1)
    if DecorGetInt(GetPlayerPed(-1),  "job") == 1 then
        blipBusDepot = AddBlipForCoord(busDepot[1],busDepot[2],busDepot[3])
        SetBlipSprite(blipBusDepot,  106) -- 67: "Fourgon" - 106: "B" 
        SetBlipColour(blipBusDepot,  3)
        SetBlipAsShortRange(blipBusDepot,  true)
        SetBlipAlpha(blipBusDepot,  255)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Depot de Bus')
        EndTextCommandSetBlipName(blipBusDepot)
    elseif DecorGetInt(GetPlayerPed(-1),  "job") ~= 1 then
        SetBlipAlpha(blipBusDepot,  0)
    end
end)

RegisterNetEvent("bus:paid")
AddEventHandler("bus:paid", function()
    nbStop = 0
end)



Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        if DecorGetInt(GetPlayerPed(-1),  "job") == 1 then
            local lPlyCoords = GetEntityCoords(GetPlayerPed(-1),  true)
            DrawMarker(1, busDepot[1],busDepot[2],busDepot[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 2.0, 0, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, busDepot[1],busDepot[2],busDepot[3], true ) < 5 then
                --if not IsPedInVehicle(GetPlayerPed(-1),  modelHash,  true) then
                if not IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), modelHash) then
                --if not inBus then
                    DrawRect(0.104, 0.4, 0.185, 0.206, 0, 0, 0, 150)
                    DrawAdvancedText(0.196, 0.316, 0.005, 0.0028, 0.856, "Chauffeur de Bus", 255, 255, 255, 255, 1, 0)
                    DrawAdvancedText(0.194, 0.408, 0.005, 0.0028, 0.4, "Ici, bientot, un menu", 255, 255, 255, 255, 0, 0)
                    MissionText("Appuie sur ~g~Valider~w~ pour devenir chauffeur de bus", 1000)
                    if IsControlJustPressed(1,  201) then
                        if not placeStop then
                            placeStop = true
                            --modelBus = GetHashKey('coach') --The necessary hashkey to create the car
                            RequestModel(modelHash) --Call the car model
                            while not HasModelLoaded(modelHash) do --Wait the model to be loaded
                                Citizen.Wait(0)
                            end
                            --TriggerEvent('chatMessage', '', { 0, 0, 0 }, '^1 Client: Number of player: '..plyInGame )
                            TriggerEvent('chatMessage', '', { 0, 0, 0 }, '^1 Client: Vehicle model loaded' )
                            personalvehicle = CreateVehicle(modelHash ,busDepot[1],busDepot[2],busDepot[3], busDepot[4], true, false) --The first False is for make the car not visible on network
                            Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(personalvehicle)) --The car will be detroyed when nobody look at it
                            TriggerEvent('chatMessage', '', { 0, 0, 0 }, '^1 Client: Car choosen: '..modelHash)
                            SetVehicleOnGroundProperly(personalvehicle) --Be sure the car have 4 wheel on ground
                            SetVehicleHasBeenOwnedByPlayer(personalvehicle,true) --Set car is owned by player
                            local id = NetworkGetNetworkIdFromEntity(personalvehicle) --Don't know what is that, but is necessary
                            SetNetworkIdCanMigrate(id, true) --Don't know what is that, but is necessary
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), personalvehicle ,-1)
                            --MissionText("Un bus ~r~apparaitra~w~ comme par magie", 1000)
                            --inBus = true
                        end
                    end
                --elseif IsPedInVehicle(GetPlayerPed(-1),  modelHash,  true) then
                elseif IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), modelHash) then
                --elseif inBus then
                    if nbStop == 0 then
                        MissionText("Fais une tournée et reviens au ~g~depot~w~ quand tu as ~r~terminé", 10000)
                    elseif nbStop >= 1 then
                        MissionText("Des que la technique à verifié le bus, tu sera ~r~payé", 10000)
                        local damageCost = 2000 - GetVehicleBodyHealth(GetVehiclePedIsIn(GetPlayerPed(-1),  false))
                        local salary = (nbStop * 150) - damageCost
                        for p = 1, 6 do
                            TaskLeaveVehicle(pasped[p], GetVehiclePedIsUsing(GetPlayerPed(-1)), 0)
                            num = 1
                            seatBus = 0
                            Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(pasped[num]))
                            Wait(300)
                        end
                        Wait(10000)
                        if GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, busDepot[1],busDepot[2],busDepot[3], true ) < 5 then
                            if salary <= 0 then
                                salary = 0
                            end
                            TriggerServerEvent('bus:salary', math.ceil(salary))
                            nbStop = 0
                        end
                    end
                end
            end
        end
    end
end)



