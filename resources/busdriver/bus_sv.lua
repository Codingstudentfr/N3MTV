RegisterServerEvent("job:bus")
AddEventHandler("job:bus", function()
	TriggerClientEvent("job:startbus", source)
	print(GetPlayerName(soure).."Est chauffeur de bus")
end)

TriggerEvent('es:addCommand', 'busJob', function(source)
	TriggerClientEvent("job:startbus", source)
	print(GetPlayerName(soure).."Est chauffeur de bus")
  	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Player Commands ")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/pv - Get teleported in your personal vehicle")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/rmwanted - Remove your wanted level")
end)

RegisterServerEvent('bus:salary')
AddEventHandler('bus:salary', function(salary)
  	print("Player ID " ..source)

	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(user)
		--if (tonumber(user.money) >= tonumber(salary)) then
	  	-- update player money amount
			user:addMoney((salary + 0.0))
			TriggerClientEvent('bus:paid',source)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_FLEECA", 1, "Fleeca Bank", false, "Votre salaire à été de ".. tonumber(salary).." ~g~$\n Frais de réparations déduits")
		--end
 	end)
end)