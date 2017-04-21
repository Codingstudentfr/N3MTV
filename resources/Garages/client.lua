RegisterNetEvent('garages:FinishCheckForVeh')
RegisterNetEvent('garages:SpawnVehicle')
RegisterNetEvent('garages:StoreVehicle')

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local garage = {
	opened = false,
	title = "garage",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Rentrer ton véhicule", description = "", action = "rentrer"},
				{name = "Sortir ton véhicule", description = "", action = "sortir"},
			}
    	},
  	}
}

local fakecar = {model = '', car = nil}
local garage_locations = {{
entering = {213.769,-808.965,29.914}, 
outside = {215.124, -791.377,29.936}
}}


local garage_blips ={}
local inrangeofgarage = false
local currentlocation = nil
local boughtcar = false

local function LocalPed()
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

function IsPlayerInRangeOfGarage()
	return inrangeofgarage
end

function ShowGarageBlips(bool)
	if bool and #garage_blips == 0 then
		for station,pos in pairs(garage_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			SetBlipSprite(blip,357)
			SetBlipColour(blip, 3)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Garage')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(garage_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #garage_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(garage_blips) do
					DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 2 then
						drawTxt('Appuie sur ~g~Entrée~s~ ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofgarage = inrange
			end
		end)
		Citizen.CreateThread(function()
			while #garage_blips > 0 do
				Citizen.Wait(0)
				local inrange = true
				for i,b in ipairs(garage_blips) do
					DrawMarker(1,b.pos.outside[1],b.pos.outside[2],b.pos.outside[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if GetDistanceBetweenCoords(b.pos.outside[1],b.pos.outside[2],b.pos.outside[3],GetEntityCoords(LocalPed())) < 4 then
						drawTxt('Entrée et Sortie des véhicules, ne pas encombrer inutilement.',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofgarage = inrange
			end
		end)
		Citizen.CreateThread(function()
			while #garage_blips > 0 do
				Citizen.Wait(0)
				local inrange = true
				for i,b in ipairs(garage_blips) do
					DrawMarker(1,b.pos.outside[1],b.pos.outside[2],b.pos.outside[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if GetDistanceBetweenCoords(b.pos.outside[1],b.pos.outside[2],b.pos.outside[3],GetEntityCoords(LocalPed())) < 5 then
						drawTxt('',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofgarage = inrange
			end
		end)
	elseif bool == false and #garage_blips > 0 then
		for i,b in ipairs(garage_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		garage_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function LocalPed()
	return GetPlayerPed(-1)
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	local ped = LocalPed()
	local pos = currentlocation.pos.outside
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	garage.currentmenu = "main"
	garage.opened = true
	garage.selectedbutton = 0
end

local vehicle_price = 0

function CloseCreator()
	Citizen.CreateThread(function()
		garage.opened = false
		garage.menu.from = 1
		garage.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = garage.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
		end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = garage.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function drawMenuRight(txt,x,y,selected)
	local menu = garage.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
	local menu = garage.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do 
		count = count + 1 
	end
	return count
end

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DoesPlayerHaveVehicle(model,button,y,selected)
	local t = false
		if t then
		drawMenuRight("OWNED",garage.menu.x,y,selected)
	else
		drawMenuRight(button.costs.."$",garage.menu.x,y,selected)
	end
end

local backlock = false
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if IsControlJustPressed(1,201) and IsPlayerInRangeOfGarage() then
				if garage.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end   
		if garage.opened then
			local ped = LocalPed()
			local menu = garage.menu[garage.currentmenu]
			drawTxt(garage.title,1,1,garage.menu.x,garage.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, garage.menu.x,garage.menu.y + 0.08)
			drawTxt(garage.selectedbutton.."/"..tablelength(menu.buttons),0,0,garage.menu.x + garage.menu.width/2 - 0.0385,garage.menu.y + 0.067,0.4, 255,255,255,255)
			local y = garage.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				if i >= garage.menu.from and i <= garage.menu.to then
					if i == garage.selectedbutton then
						selected = true
					else
						selected = false
					end
				drawMenuButton(button,garage.menu.x,y,selected)
				y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if garage.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if garage.selectedbutton > 1 then
					garage.selectedbutton = garage.selectedbutton -1
					if buttoncount > 10 and garage.selectedbutton < garage.menu.from then
						garage.menu.from = garage.menu.from -1
						garage.menu.to = garage.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if garage.selectedbutton < buttoncount then
					garage.selectedbutton = garage.selectedbutton +1
					if buttoncount > 10 and garage.selectedbutton > garage.menu.to then
						garage.menu.to = garage.menu.to + 1
						garage.menu.from = garage.menu.from + 1
					end
				end
			end
		end
	end
end)


function round(num, idp)
	if idp and idp>0 then
		local mult = 10^idp
		return math.floor(num * mult + 0.5) / mult
	end
	return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = garage.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Rentrer ton véhicule" then
			TriggerServerEvent('garages:CheckForVeh',source)
		elseif btn == "Sortir ton véhicule" then
			TriggerServerEvent('garages:CheckForSpawnVeh',source)
		end
	end
end

AddEventHandler("playerSpawned", function(spawn)
    TriggerServerEvent("garages:PutVehInGarages",source)
end)

AddEventHandler('FinishCheckForVeh', function(vehicle)
	boughtcar = true
	CloseCreator(vehicle)
end)

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	garage.lastmenu = garage.currentmenu
	if menu == "vehicles" then
		garage.lastmenu = "main"
	elseif menu == "bikes"  then
		garage.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		garage.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		garage.lastmenu = "race_create_objects"
	end
	garage.menu.from = 1
	garage.menu.to = 10
	garage.selectedbutton = 0
	garage.currentmenu = menu
end


function Back()
	if backlock then
		return
	end
	backlock = true
	if garage.currentmenu == "main" then
		CloseCreator()
	end
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local firstspawn = 0
	AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		ShowGarageBlips(true)
		firstspawn = 1
	end
end)


AddEventHandler('garages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor)
	local car = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = primarycolor
	local secondarycolor = secondarycolor
	Citizen.CreateThread(function()			
		Citizen.Wait(3000)
		local caisseo = GetClosestVehicle(215.124, -791.377, 30.836, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("La zone est encombrée") 
		else
			if state == "out" then
				drawNotification("Ce véhicule n'est pas dans le garage")
			else			
				RequestModel(car)
				while not HasModelLoaded(car) do
					Citizen.Wait(0)
				end
				veh = CreateVehicle(car, 215.124, -791.377, 30.836, 0.0, true, false)
				SetVehicleNumberPlateText(veh, plate)
				SetVehicleOnGroundProperly(veh)
				SetVehicleColours(veh, primarycolor, secondarycolor)
				SetEntityInvincible(veh, false) 
				drawNotification("Véhicule sorti, bonne route")				
				TriggerServerEvent('garages:SetVehOut', vehicle)
			end   
			CloseCreator()
		end
	end)
end)

AddEventHandler('garages:StoreVehicle', function(vehicle, plate)
	local car = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(215.124, -791.377, 30.836, 3.000, 0, 70)
		SetEntityAsMissionEntity(caissei, true, true)		
		local platecaissei = GetVehicleNumberPlateText(caissei)
		if DoesEntityExist(caissei) then	
			if plate ~= platecaissei then					
				drawNotification("Ce n'est pas ton véhicule")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
				drawNotification("Véhicule rentré")
				TriggerServerEvent('garages:SetVehIn', plate)
			end
		else
			drawNotification("Aucun véhicule n'est sur la zone.")
		end   
		CloseCreator()
	end)
end)
