
function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

RegisterNetEvent("notworked")
AddEventHandler("notworked", function()

  
		SetNotificationTextEntry("STRING");
        AddTextComponentString("~r~You are not allowed" );
        DrawNotification(false, true);
  
end)

RegisterNetEvent("worked")
AddEventHandler("worked", function()

  
		SetNotificationTextEntry("STRING");
        AddTextComponentString("~g~Car spawned" );
        DrawNotification(false, true);
  
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

      DrawMarker(1,454.03,-1020.87,27.30,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)

		if GetDistanceBetweenCoords(454.03,-1020.87,27.30,GetEntityCoords(LocalPed())) < 1 then

       drawTxt('Press ~g~ENTER~s~ to spawn your ~b~Car',2,1,0.5,0.8,0.6,255,255,255,255)

		if IsControlJustPressed(1,201) then
		
        TriggerServerEvent("cp:spawncheck")
		

		    end
	    end
	end
end)

RegisterNetEvent('policespawn')
AddEventHandler('policespawn', function()
  local myPed = GetPlayerPed(-1)
  local player = PlayerId()
  local vehicle = GetHashKey('police3')
  RequestModel(vehicle)
  while not HasModelLoaded(vehicle) do
    Wait(1)
  end
  local plate = math.random(100, 900)
  local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
  local spawned_car = CreateVehicle(vehicle, coords, 431.436, -996.786, 25.1887, true, false)
  SetVehicleOnGroundProperly(spawned_car)
  SetVehicleNumberPlateText(spawned_car, "LSPD "..plate.." ")
  SetPedIntoVehicle(myPed, spawned_car, -1)
  SetModelAsNoLongerNeeded(vehicle)
  Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(spawned_car))

end)
