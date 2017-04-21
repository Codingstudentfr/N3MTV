--____   ____     .__.__         .__    .___      
--\   \ /   /____ |__|  |   _____|__| __| _/____  
-- \   Y   // __ \|  |  |  /  ___/  |/ __ |/ __ \ 
--  \     /\  ___/|  |  |__\___ \|  / /_/ \  ___/ 
--   \___/  \___  >__|____/____  >__\____ |\___  >
--              \/             \/        \/    \/  

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "monpasse")

AddEventHandler('chatMessage', function(source, n, message) -- capture 'chatMessage' events
  local args = stringsplit(message, " ") -- Split the message up into an array of words

  if (args[1] == "/inspect") then -- if the first "word" is /inspect
    CancelEvent() -- dont pass this chat message further, we're handling it

    if (args[2] ~= nil) then -- make sure we have an actual second "word"
		local playerID = tonumber(args[2]) -- Store the playerID that was passed, as a number

		-- If this is not a valid player
		if (playerID < 1 or playerID > 32) then
			-- tell the sender they have an invalid target
			TriggerClientEvent('chatMessage', source, "SYSTEM", {200, 0, 0}, "Invalid PlayerID!")
			return -- dont continue any further
		end
	
		local name = "'" .. GetPlayerName(playerID) .. "'"
	
		TriggerClientEvent('chatMessage', source, "SYSTEM", {200, 0, 0}, "Inspecting : " .. name)
		TriggerClientEvent('chatMessage', source, "SYSTEM", {200, 0, 0}, "Inspected by : " .. GetPlayerName(source))
	
		executed_query = MySQL:executeQuery("SELECT * FROM `players` WHERE name = " .. name)
		result = MySQL:getResults(executed_query, {'name', 'age', 'profession', 'permis1', 'permis2', 'permis3'})
	
	
		TriggerClientEvent('CARTE:sendremoteinfos',source,result)
	
    else -- if args[2] does equal nil (doesnt exist)
      local event = 'chatMessage' -- What event are we sending
      local eventTarget = source -- Who do we send the event too (-1 means all)
      local messageSender = "SYSTEM" -- Message sender
      local messageSenderColor = {200, 0, 0} -- Message sender color
      local message = "Usage: /inspect <PlayerID>" -- show a `how-to-use` message
      -- This could be shortened into just one line, it was exanded to show what each parameter does
      TriggerClientEvent(event, eventTarget, messageSender, messageSenderColor, message) -- send the event
      -- NOTE: the variables after "eventTarget" will be passed to the event handlers function
      -- you will see in cl_handcuffs.lua, that the 'mHandCuff' event does not take any arguements
      -- hence why it is sent above with only the event name and target ID
    end
  end
end)


RegisterServerEvent('CARTE:getinfos')
AddEventHandler('CARTE:getinfos', function()

	local name = "'" .. GetPlayerName(source) .. "'"
	
	executed_query = MySQL:executeQuery("SELECT * FROM `players` WHERE name = " .. name)
	result = MySQL:getResults(executed_query, {'name', 'age', 'profession', 'permis1', 'permis2', 'permis3'})
	
	
	TriggerClientEvent('CARTE:sendinfos',source,result)
	
end)

-- utility function to turn a string into an array of words
function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end