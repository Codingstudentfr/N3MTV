-- Show notifications when the player has joined the session.
  AddEventHandler("playerSpawned", function(spawn)
    while true do
      Wait(0)
      SetNotificationTextEntry("STRING");
      AddTextComponentString("We have marked the stores on your map");
      SetNotificationMessage("CHAR_SOCIAL_CLUB", "CHAR_SOCIAL_CLUB", true, 1, "FiveM Stores", "v0.1.2");
      DrawNotification(false, true);
      Citizen.Wait(900000)
    end
  end)
