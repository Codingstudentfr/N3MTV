--____   ____     .__.__         .__    .___      
--\   \ /   /____ |__|  |   _____|__| __| _/____  
-- \   Y   // __ \|  |  |  /  ___/  |/ __ |/ __ \ 
--  \     /\  ___/|  |  |__\___ \|  / /_/ \  ___/ 
--   \___/  \___  >__|____/____  >__\____ |\___  >
--              \/             \/        \/    \/  


Keys = {
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


COND = false
COND1 = false
age = ""
profession = ""
nom = ""
permis1 = ""
permis2 = ""
permis3 = ""

AddEventHandler("playerSpawned", function(spawn)
    
	TriggerEvent("chatMessage","", { 0, 0, 0 }, "Bienvenue a " .. tostring(GetPlayerName(GetPlayerServerId(source))))
end)

RegisterNetEvent('CARTE:sendinfos')
AddEventHandler('CARTE:sendinfos', function(result)
    
	age = result[1].age
	profession = result[1].profession
	nom = result[1].name
	permis1 = result[1].permis1
	permis2 = result[1].permis2
	permis3 = result[1].permis3
	
end)

RegisterNetEvent('CARTE:sendremoteinfos')
AddEventHandler('CARTE:sendremoteinfos', function(result)

	print("GOT IT")
    
	age = result[1].age
	profession = result[1].profession
	nom = result[1].name
	permis1 = result[1].permis1
	permis2 = result[1].permis2
	permis3 = result[1].permis3
	
	COND1 = not COND1
	
end)



function RenderCarte()

		local id = GetPlayerServerId()
		local player = GetPlayerFromServerId(id)
		local name = GetPlayerName(player)
		
		

		DrawRect(0.91,0.40,0.175,0.50,0,0,0,150)

		SetTextFont( 4 )
		SetTextScale( 1.0, 1.0 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Carte d'identité" )
		DrawText( 0.85, 0.10 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Nom : " ..  nom)
		DrawText( 0.825, 0.20 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Age : " .. age)
		DrawText( 0.825, 0.25 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Profession : " .. profession)
		DrawText( 0.825, 0.30 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Permis B : " .. permis1)
		DrawText( 0.825, 0.35 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Permis C : " .. permis2)
		DrawText( 0.825, 0.40 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Permis arme : " .. permis3)
		DrawText( 0.825, 0.45 )
		
		SetTextFont( 2 )
		SetTextScale( 0.50, 0.50 )
		SetTextColour( 255, 100, 100, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "H to close")
		DrawText( 0.825, 0.50 )
		
		 

end

function RenderRemoteCarte()

		local id = GetPlayerServerId()
		local player = GetPlayerFromServerId(id)
		local name = GetPlayerName(player)
		

		DrawRect(0.91,0.40,0.175,0.50,0,0,0,150)

		SetTextFont( 4 )
		SetTextScale( 1.0, 1.0 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "INSPECTION" )
		DrawText( 0.85, 0.10 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Nom :" ..  nom)
		DrawText( 0.825, 0.20 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Age : " .. age)
		DrawText( 0.825, 0.25 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Profession : " .. profession)
		DrawText( 0.825, 0.30 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Permis B : " .. permis1)
		DrawText( 0.825, 0.35 )
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Permis C : " .. permis2)
		DrawText( 0.825, 0.40 )
		
		
		
		SetTextFont( 0 )
		SetTextScale( 0.35, 0.35 )
		SetTextColour( 255, 255, 255, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Permis arme : " .. permis3)
		DrawText( 0.825, 0.45 )
		
		SetTextFont( 2 )
		SetTextScale( 0.50, 0.50 )
		SetTextColour( 255, 100, 100, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "G to close")
		DrawText( 0.825, 0.50 )
		
		 

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,Keys["H"]) then
		
			TriggerServerEvent('CARTE:getinfos')
			COND = not COND

		end
		if IsControlJustPressed(1,Keys["G"]) then
		
			COND1 = not COND1
			
		end
		
		if COND then
			
			RenderCarte()
		
		end
		
		if COND1 then
			
			RenderRemoteCarte()
		
		end
	end
end)





