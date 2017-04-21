RegisterServerEvent('cp:spawncheck')
AddEventHandler('cp:spawncheck', function()

  TriggerEvent('es:getPlayerFromId', source, function(user)

  local player = user.identifier
 
  print(player)
  
  if user.permission_level == (2) then
  
  TriggerClientEvent('policespawn', source)
  
  TriggerClientEvent('worked', source)
  
  else
  
  TriggerClientEvent('notworked', source)


  end
 end)
end)


