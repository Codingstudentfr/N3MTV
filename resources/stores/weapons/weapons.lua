-- Configure gun stores Locations
local ammunationblips = {
    {id=110, x=1701.292, y=3750.450, z=34.365},
    {id=110, x=237.428, y=-43.655, z=69.698},
    {id=110, x=843.604, y=-1017.784, z=27.546},
    {id=110, x=-321.524, y=6072.479, z=31.299},
    {id=110, x=-664.218, y=-950.097, z=21.509},
    {id=110, x=-1320.983, y=-389.260, z=36.483},
    {id=110, x=-1109.053, y=2686.300, z=18.775},
    {id=110, x=2568.379, y=309.629, z=108.461},
    {id=110, x=-3157.450, y=1079.633, z=20.692},
  }

  -- Configure the coordinates for the store owners.
  local peds = {
    {type=4, hash=0x9e08633d, x=1692.733, y=3761.895, z=34.705, a=218.535},
    {type=4, hash=0x9e08633d, x=253.629, y=-51.305, z=69.941, a=59.656},
    {type=4, hash=0x9e08633d, x=841.363, y=-1035.350, z=28.195, a=328.528},
    {type=4, hash=0x9e08633d, x=-330.933, y=6085.677, z=31.455, a=207.323},
    {type=4, hash=0x9e08633d, x=-661.317, y=-933.515, z=21.829, a=152.798},
    {type=4, hash=0x9e08633d, x=-1304.413, y=-395.902, z=36.696, a=44.440},
    {type=4, hash=0x9e08633d, x=-1118.037, y=2700.568, z=18.554, a=196.070},
    {type=4, hash=0x9e08633d, x=2566.596, y=292.286, z=108.735, a=337.291},
    {type=4, hash=0x9e08633d, x=-3173.182, y=1089.176, z=20.839, a=223.930},
  }

  function DrawSpecialText(m_text, showtime)
   ClearPrints()
   SetTextEntry_2("STRING")
   AddTextComponentString(m_text)
   DrawSubtitleTimed(showtime, 1)
 end

  Citizen.CreateThread(function()
    -- Load the ped modal (s_m_y_ammucity_01)
    RequestModel(0x9e08633d)
    while not HasModelLoaded(0x9e08633d) do
      Wait(1)
    end

    -- Create blips on the map for all the gun stores
    for _, item in pairs(ammunationblips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
    end

    -- Spawn the peds in the gun stores
    for _, item in pairs(peds) do
      ped = CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, true, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      SetPedCombatAttributes(ped, 17, true)
      SetPedFleeAttributes(ped, 0, 0)

      Citizen.CreateThread(function()
        while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed, true)
        local doordist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, item.x, item.y, item.z, true)
        local playerInV = IsPedInAnyVehicle(playerPed, false)

        if doordist < 2 then
           DrawSpecialText("Press E to buy something", 500)
        end
      end
     end)

    end
  end)
